#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include "heap.h"

//used to pass target's register context between hyp and analyzer. 
struct shar_arg
{
    volatile unsigned long flag;
    unsigned long rdi;
    unsigned long rsi;
    unsigned long rdx;
    unsigned long rcx;
    unsigned long r8;
    unsigned long r9;
    unsigned long r11;
    unsigned long r10;
    unsigned long rax;
    unsigned long eflags;
    unsigned long rip;
    unsigned long rsp;
    unsigned long rbx;
    unsigned long rbp;
    unsigned long r12;
    unsigned long r13;
    unsigned long r14;
    unsigned long r15;
    // unsigned long long xmm0;
    // unsigned long long xmm1;
    // unsigned long long xmm2;
    // unsigned long long xmm3;
    // unsigned long long xmm4;
    // unsigned long long xmm5;
    // unsigned long long xmm6;
    // unsigned long long xmm7;
    unsigned long fs_base;
    unsigned long gs_base;
    unsigned long msr_kernel_gs_base;
    unsigned long gdt;
    unsigned long idt;
    unsigned long tss_base;
    unsigned long tss_pg_off;
    unsigned long g_syscall_entry;
    unsigned long pf_entry;
    unsigned long int3_entry;
    unsigned long cr0;
    unsigned long cr2;
    unsigned long cr3;
    unsigned long cr4;
    unsigned long efer;
    unsigned long apic_base_addr;
    unsigned long apic_access_addr;
    unsigned long io_bitmap_a_addr;
    unsigned long io_bitmap_b_addr;
    unsigned long msr_bitmap_addr;
    unsigned long tsc_offset;
    unsigned long exit_reason;
    unsigned long exit_qualification;
    unsigned long inst_len;
    unsigned long event_flag;
    unsigned long entry_intr_info;
    unsigned long user_flag;
    volatile unsigned long guest_timeout_flag;
    volatile unsigned long exit_wrong_flag;
    volatile unsigned long cross_page_flag;
};
struct shar_arg* ei_shar_args;

//shared data structure between klee and nes1
struct kn_indicator {
    int flag; // 0 = no request; 1 = have requests
    int num; // total number of requests
};
struct kn_indicator* kn_indicator;

struct HeapAlloc {
    int req; // 1 = malloc; 0 = free. 
    unsigned long *mo;
    unsigned long size;
    unsigned long alignment;
    unsigned long nativeAddress;
};
struct HeapAlloc* klee_req;//a batched reqs in klee_shar_mem
int nme_idx;//indicate the current klee_req that nme is handling

//shared data structure between nes-o and nes-g
struct nt_ctx {
    int flag;// 0 = request handling complete/no request; 1 = syscall; 2 = exception; 
    int sys_num;
    unsigned long err_code;
    unsigned long cr2;
    unsigned long rdi;
    unsigned long rsi;
    unsigned long rdx;
    unsigned long r10;
    unsigned long r8;
    unsigned long r9;
    // unsigned long rflags;
    unsigned long rip;
    unsigned long rsp;
    unsigned long rbp;
    unsigned long ret_value;
    unsigned long fs_base;
    unsigned long malloc_ip;
    unsigned long free_ip;
    // unsigned long rax;
    // unsigned long rbx;
    // unsigned long rcx;
    // unsigned long r11;
    // unsigned long r12;
    // unsigned long r13;
    // unsigned long r14;
    // unsigned long r15;
    // unsigned long nes_fs_base;
};

//the region to temporaly store target's rax & rcx
struct board_context {
    unsigned long entry_gate;                               //fb0
    unsigned long pf_handler;                               //fb8
    unsigned long syscall_handler;                          //fc0
    unsigned long ret_handler;//normal ret from malloc/free //fc8
    unsigned long reserved1;
    // unsigned long reserved2;
    // unsigned long rdi;//since malloc&free only have one arg
    unsigned long rcx;                                      //fd8
    unsigned long rax;                                      //fe0
    // unsigned long rsp;
    unsigned long rip;                                      //fe8
};
volatile struct board_context* board_ctx;

// used by nes1 to save target's user space context when syscall/exception
// happends, rax & rcx are saved on board_ctx
struct pt_regs {
    /* C ABI says these regs are caller-preserved. They aren't saved on kernel
     * entry unless syscall needs a complete, full filled struct pt_regs. */
    unsigned long r15;
    unsigned long r14;
    unsigned long r13;
    unsigned long r12;
    unsigned long rbp;
    unsigned long rbx;
    /* These regs are caller-collbbered. always saved on kernel entry. */
    unsigned long r11;
    unsigned long r9;
    unsigned long r8;
    unsigned long r10;
    // unsigned long rax;
    // unsigned long rcx;
    unsigned long rdx;
    unsigned long rsi;
    unsigned long rdi;
    // unsigned long orig_ax;
    // /* return frame for iretq */
    // unsigned long rip;
    // unsigned long cs;
    // unsigned long rflags;
    // unsigned long rsp;
    // unsigned long ss;
    // /* top of stack page */
};

struct nt_ctx* nt_ctx;//located at fixed addr 0x801000;
// struct pt_regs* t_ctx; //when syscall/exp happens, this data structure saves the target's user space context

unsigned long exit_gate_va;
unsigned long idt_va;
unsigned long gdt_va;
unsigned long tss_va;
unsigned long data_page;
unsigned long root_pt_va;
unsigned long hyp_shar_mem;
unsigned long klee_shar_mem;
unsigned long ana_t_tss;
unsigned long ana_t_gdt;
unsigned long ana_t_idt;
unsigned long ana_stack;
unsigned long t_pf_stack;
unsigned long entry_gate;
unsigned long exit_gate;
unsigned long t_fsbase;
unsigned long nme_fsbase;
unsigned long uk_offset;

void write_fs (unsigned long base)
{
    asm volatile ("movq %0, %%rax; \n\t"
            "wrfsbase %%rax; \n\t"
            ::"m"(base):"%rax");
    return;
}

unsigned long read_fs (void)
{
    unsigned long base;
    asm volatile (
            "rdfsbase %%rax; \n\t"
            "movq %%rax, %0; \n\t"
            ::"m"(base):"%rax");
    return base;
}

void write_gs (unsigned long base)
{
    asm volatile ("movq %0, %%rax; \n\t"
            "wrgsbase %%rax; \n\t"
            ::"m"(base):"%rax");
    return;
}

unsigned long read_gs (void)
{
    unsigned long base;
    asm volatile (
            "rdgsbase %%rax; \n\t"
            "movq %%rax, %0; \n\t"
            ::"m"(base):"%rax");
    return base;
}
unsigned long rdmsr (unsigned long idx)
{
    unsigned long value;
    unsigned long high, low;
    asm volatile ("mov %2, %%ecx; \n\t"
            "rdmsr; \n\t"
            "mov %%edx, %0; \n\t"
            "mov %%eax, %1; \n\t"
            :"=m"(high), "=m"(low):"m"(idx):"%eax","%edx","%ecx");
    value = ((high << 32) & 0xffffffff00000000) | (low & 0xffffffff);
    return value;
}
void wrmsr (unsigned long idx, unsigned long value)
{
    unsigned long high, low;
    high = (value >> 32) & 0xffffffff;
    low = value & 0xffffffff;
    asm volatile ("mov %2, %%ecx; \n\t"
            "mov %0, %%edx; \n\t"
            "mov %1, %%eax; \n\t"
            "wrmsr; \n\t"
            ::"m"(high), "m"(low), "m"(idx):"%eax","%edx","%ecx");
    return;
}
unsigned long rd_cr0 (void)
{
    unsigned long cr0;
    asm volatile ("mov %%cr0, %%rax; \n\t"
            "mov %%rax, %0; \n\t"
            :"=m"(cr0)::"%rax");
    return cr0;
}
unsigned long rd_cr2 (void)
{
    unsigned long cr2;
    asm volatile ("mov %%cr2, %%rax; \n\t"
            "mov %%rax, %0; \n\t"
            :"=m"(cr2)::"%rax");
    return cr2;
}
unsigned long rd_cr4 (void)
{
    unsigned long cr4;
    asm volatile ("mov %%cr4, %%rax; \n\t"
            "mov %%rax, %0; \n\t"
            :"=m"(cr4)::"%rax");
    return cr4;
}
void wr_cr0 (unsigned long cr0)
{
    asm volatile (
            "mov %0, %%rax; \n\t"
            "mov %%rax, %%cr0; \n\t"
            ::"m"(cr0):"%rax");
    return;
}
void wr_cr2 (unsigned long cr2)
{
    asm volatile (
            "mov %0, %%rax; \n\t"
            "mov %%rax, %%cr2; \n\t"
            ::"m"(cr2):"%rax");
    return;
}
void wr_cr4 (unsigned long cr4)
{
    asm volatile (
            "mov %0, %%rax; \n\t"
            "mov %%rax, %%cr4; \n\t"
            ::"m"(cr4):"%rax");
    return;
}

/* inform the NES-K for syscall req. sys_handler should update the rax in board_ctx. */ 
void nme_syscall_dispatcher (struct pt_regs* pt_regs)
{
    // asm volatile ("mov $0xabcdabcd, %rax; \n\t"
    //         "vmcall; \n\t");
    nt_ctx->sys_num = board_ctx->rax;
    nt_ctx->rdi = pt_regs->rdi;
    nt_ctx->rsi = pt_regs->rsi;
    nt_ctx->rdx = pt_regs->rdx;
    nt_ctx->r10 = pt_regs->r10;
    nt_ctx->r8 = pt_regs->r8;
    nt_ctx->r9 = pt_regs->r9;
    // nt_ctx->rsp = board_ctx->rsp;
    // nt_ctx->rflags = pt_regs->rflags;
    // nt_ctx->rax = pt_regs->rax;
    nt_ctx->flag = 1;
    
    do {
    } while (nt_ctx->flag != 0);

    board_ctx->rax = nt_ctx->ret_value;
    board_ctx->rip = board_ctx->rcx;
    
    asm volatile ("movq $0x9843211, %%rax; \n\t"
            "vmcall; \n\t"
            :::"%rax");
    
    return;
}

// extern "C" void store_context (void);
void syscall_store_context (void);
asm (" .text");
asm (" .type    syscall_store_context, @function");
asm ("syscall_store_context: \n");
// asm ("movq $0xabcdabcd, %rax \n");
// asm ("vmcall \n");
// // asm ("movq %rsp, %gs: 0xff0 \n");//gs_base contains the lower addr of the stack page used by syscall handler
// // asm ("movq %gs: 0xff8, %rsp \n");// the last element in the stack page is the stack addr used by syscall handler, +0xff0
asm ("movq %rsp, %rax \n"); 
asm ("movq $0xfffffeffffffecc0, %rsp \n");//switch to analyser's secure stack
asm ("pushq %rax \n");// save target rsp in nme stack
asm ("pushq %rdi \n");// 6 syscall args
asm ("pushq %rsi \n");
asm ("pushq %rdx \n");
asm ("pushq %r10 \n");
asm ("pushq %r8 \n");
asm ("pushq %r9 \n");
// asm ("pushq %r10 \n");
asm ("pushq %r11 \n");
asm ("pushq %rbx \n");//the rest of user context
asm ("pushq %rbp \n");
asm ("pushq %r12 \n");
asm ("pushq %r13 \n");
asm ("pushq %r14 \n");
asm ("pushq %r15 \n");
asm ("movq %rsp, %rdi \n");//pass the address of pt_regs as an arg to sys_handler.

asm ("movsd %xmm0, -0x10(%rsp) \n");
asm ("movsd %xmm1, -0x20(%rsp) \n");
asm ("movsd %xmm2, -0x30(%rsp) \n");
asm ("movsd %xmm3, -0x40(%rsp) \n");
asm ("movsd %xmm4, -0x50(%rsp) \n");
asm ("movsd %xmm5, -0x60(%rsp) \n");
asm ("movsd %xmm6, -0x70(%rsp) \n");
asm ("movsd %xmm7, -0x80(%rsp) \n");
asm ("sub $0x90, %rsp \n");
// asm ("vmcall \n");

asm ("callq nme_syscall_dispatcher \n");

asm ("add $0x90, %rsp \n");
asm ("movsd -0x10(%rsp), %xmm0 \n");
asm ("movsd -0x20(%rsp), %xmm1 \n");
asm ("movsd -0x30(%rsp), %xmm2 \n");
asm ("movsd -0x40(%rsp), %xmm3 \n");
asm ("movsd -0x50(%rsp), %xmm4 \n");
asm ("movsd -0x60(%rsp), %xmm5 \n");
asm ("movsd -0x70(%rsp), %xmm6 \n");
asm ("movsd -0x80(%rsp), %xmm7 \n");

// asm ("vmcall \n");
asm ("popq %r15 \n");
asm ("popq %r14 \n");
asm ("popq %r13 \n");
asm ("popq %r12 \n");
asm ("popq %rbp \n");
asm ("popq %rbx \n");
asm ("popq %r11 \n");
// asm ("popq %r10 \n");
asm ("popq %r9 \n");
asm ("popq %r8 \n");
asm ("popq %r10 \n");
asm ("popq %rdx \n");
asm ("popq %rsi \n");
asm ("popq %rdi \n");
asm ("popq %rax \n");//restore target rsp into rax
asm ("pushq $0x2b \n");//pt_regs->ss
asm ("pushq %rax \n");//rsp stored in board_ctx
asm ("pushq %r11 \n");//pt_regs->rflags
asm ("pushq $0x33 \n");//pt_regs->cs
asm ("movq $0xfffffe9000905fb0, %rax \n");//the address of board_ctx
asm ("pushq (%rax) \n");//addr of entry_gate
// asm ("pushq 0x28(%rax) \n");//syscall #; pt_regs->orig_rax, rax stored in board_ctx
asm ("iretq \n");

void nme_ret_handler (void);

void trans_target (void)
{
    if (nme_idx < kn_indicator->num)
    {
        if (klee_req[nme_idx].req == 1)//malloc req
        {
            if (klee_req[nme_idx].nativeAddress)
            {
                int size = klee_req[nme_idx].size;
                void* ptr = klee_req[nme_idx].nativeAddress;
                nme_malloc (size, ptr);
            }
            else
            {
                // board_ctx->rdi = klee_req[nme_idx].size;
                // board_ctx->rsp = nt_ctx->rsp;
                board_ctx->rip = nt_ctx->malloc_ip;
                asm volatile (
                        /* switch to target fs */
                        "movq %0, %%rax; \n\t"
                        "movq %1, %%rbx; \n\t"
                        "movq %%rbx, (%%rax); \n\t"
                        "movq %2, %%rbx; \n\t"
                        "wrfsbase %%rbx; \n\t"
                        "movq %3, %%rbx; \n\t"
                        "movq %4, %%rdi; \n\t"
                        "movq %%rax, %%rsp; \n\t"
                        "jmpq *%%rbx; \n\t"
                        // "pushq %%rax; \n\t"
                        // "movq $0x0, %%rax; \n\t"
                        // "movq $0x1, %%rcx; \n\t"
                        // "retq; \n\t"
                        // ::"m"(t_fsbase), "m"(board_ctx->rdi): "%rcx","%rax");
                        ::"m"(nt_ctx->rsp), "m"(exit_gate), "m"(t_fsbase), "m"(entry_gate), "m"(klee_req[nme_idx].size): "%rbx","%rax", "%rdi");
            }
        }
        else if (klee_req[nme_idx].req == 2)//free req
        {
            int i;
            if (!klee_req[nme_idx].nativeAddress)
            {
                for (i = 0; i < nme_idx; i ++)
                {
                    if (klee_req[i].req == 1 && klee_req[i].mo == klee_req[nme_idx].mo)
                    {
                        klee_req[nme_idx].nativeAddress = klee_req[i].nativeAddress;
                        break;
                    }
                }
            }
            if (i == nme_idx)
            {
                printf ("no corresponding malloc found in prev handled req. \n");
                asm volatile ("mov $0xabcdabcd, %rax; \n\t"
                        "vmcall; \n\t");
            }
            // board_ctx->rdi = klee_req[nme_idx].nativeAddress;
            // board_ctx->rsp = nt_ctx->rsp;
            board_ctx->rip = nt_ctx->free_ip;
            asm volatile (
                    /* switch to target fs */
                    "movq %0, %%rax; \n\t"
                    "movq %1, %%rbx; \n\t"
                    "movq %%rbx, (%%rax); \n\t"
                    "movq %2, %%rbx; \n\t"
                    "wrfsbase %%rbx; \n\t"
                    "movq %3, %%rbx; \n\t"
                    "movq %4, %%rdi; \n\t"
                    "movq %%rax, %%rsp; \n\t"
                    "jmpq *%%rbx; \n\t"
                    // "pushq %%rax; \n\t"
                    // "movq $0x0, %%rax; \n\t"
                    // "movq $0x1, %%rcx; \n\t"
                    // "retq; \n\t"
                    // ::"m"(t_fsbase), "m"(board_ctx->rdi): "%rcx","%rax");
                    ::"m"(nt_ctx->rsp), "m"(exit_gate), "m"(t_fsbase), "m"(entry_gate), "m"(klee_req[nme_idx].nativeAddress): "%rbx","%rax", "%rdi");
        }
        else
        {
            printf ("not a malloc/free req; \n");
            asm volatile ("movq $0xabcdabcd, %%rax; \n\t"
                    "vmcall; \n\t"
                    :::"%rax");
        }
    }
        // /* store nme_ret_handler into target stack before jmp to target */
        // unsigned long* nme_writer = (unsigned long*) board_ctx->rsp;
        // // *nme_writer = (unsigned long) nme_ret_handler;//the addr of first exit
        // *nme_writer = (unsigned long) exit_gate;//the addr of first exit
        // asm volatile (
        //         /* switch to target fs */
        //         "movq %0, %%rax; \n\t"
        //         "wrfsbase %%rax; \n\t"
        //         "movq %1, %%rax; \n\t"
        //         "pushq %%rax; \n\t"
        //         "movq %2, %%rdi; \n\t"
        //         // "movq $0x0, %%rax; \n\t"
        //         // "movq $0x1, %%rcx; \n\t"
        //         "retq; \n\t"
        //         // ::"m"(t_fsbase), "m"(board_ctx->rdi): "%rcx","%rax");
        //         ::"m"(t_fsbase), "m"(entry_gate), "m"(board_ctx->rdi): "%rcx","%rax", "%rdi");
        // }
    else
    {
        /* inform klee the batched req handling done */
        nme_idx = 0;
        kn_indicator->num = 0;
        kn_indicator->flag = 0;
        do {
        } while (kn_indicator->flag == 0);
        trans_target();
    }
    return;
}

/* get ret value from the target and wait for the next klee native memory
 * request */
void nme_handler (void)
{
    asm volatile ("movq $0xfff, %rax; \n\t"
            "vmcall; \n\t");
 
    write_fs (nme_fsbase);
    /* update ret value value only for malloc, free does not return anything */
    if (klee_req[nme_idx].req == 1)
    {
        if (board_ctx->rax == NULL)
        {
            printf ("target malloc failed. \n");
        }
        else
        {
            klee_req[nme_idx].nativeAddress = board_ctx->rax;
        }
    }

    nme_idx ++;

    trans_target();

    return;
}

void nme_ret_handler (void);
asm (" .text");
asm (" .type    nme_ret_handler, @function");
asm ("nme_ret_handler: \n");
asm ("movq $0xabcdabcd, %rax \n");
asm ("vmcall \n");
asm ("movq %rsp, %rax \n");
asm ("movq $0xfffffeffffffecc0, %rsp \n");//ana_stack, switch to analyser's secure stack
asm ("pushq %rax \n"); //save target rsp on nme stack
asm ("callq nme_handler \n");
asm ("popq %rax \n");
asm ("movq %rax, %rsp \n");
asm ("movq $0xfffffe9000905fb0, %rax \n");//addr of entry_gate
asm ("jmpq *(%rax) \n");
asm ("movq $0xabcdabcd, %rax \n");
asm ("vmcall \n");
// asm ("movq $0xfffffef020900279, %rax \n");//addr of re-enter
// asm ("pushq %rax \n");
// asm ("movq $0x0, %rax \n");
// asm ("movq $0x1, %rcx \n");
// asm ("retq \n");

void nme_pf_handler (unsigned long cr2, unsigned long* pf_stack)
{
    int err_code = *pf_stack;
    printf ("cr2: %lx, err_code: %lx. \n", cr2, err_code);

    // asm volatile ("mov $0xabcdabcd, %rax; \n\t"
    //         "vmcall; \n\t");

    if (err_code & 0x10)
    {
        printf ("unhandled target #PF, error_code: %x, cr2: %lx. \n", err_code, cr2);
        asm volatile ("mov $0xabcdabcd, %rax; \n\t"
                "vmcall; \n\t");
    }
    else
    {
        nt_ctx->err_code = err_code;
        nt_ctx->cr2 = cr2;
        nt_ctx->flag = 2;
        
        do {
        } while (nt_ctx->flag != 0);

        board_ctx->rip = *(pf_stack + 1);
        
    }
   
    asm volatile ("movq %0, %%rax; \n\t"
            "movq (%%rax), %%rax; \n\t"
            ::"m"(cr2):"%rax");

    asm volatile ("movq $0x9843211, %%rax; \n\t"
            "vmcall; \n\t"
            :::"%rax");
    return;
}

void pf_store_context (void);
asm (" .text");
asm (" .type    pf_store_context, @function");
asm ("pf_store_context: \n");
// asm ("movq $0xabcdabcd, %rax \n");
// asm ("vmcall \n");
asm ("movq %rsp, %rax \n");
asm ("movq $0xfffffeffffffecc0, %rsp \n");//switch to analyser's secure stack
asm ("pushq %rax \n"); // save pf handler rsp in nme stack
asm ("pushq %rdi \n");// 6 syscall args
asm ("pushq %rsi \n");
asm ("pushq %rdx \n");
asm ("pushq %r10 \n");
asm ("pushq %r8 \n");
asm ("pushq %r9 \n");
//asm ("pushq %r10 \n");
asm ("pushq %r11 \n");
asm ("pushq %rbx \n");//the rest of user context
asm ("pushq %rbp \n");
asm ("pushq %r12 \n");
asm ("pushq %r13 \n");
asm ("pushq %r14 \n");
asm ("pushq %r15 \n");
asm ("movq %cr2, %rdi \n");//pass cr2 as 1st arg 
asm ("movq %rax, %rsi \n");// pass pf rsp as 2rd arg

asm ("movsd %xmm0, -0x10(%rsp) \n");
asm ("movsd %xmm1, -0x20(%rsp) \n");
asm ("movsd %xmm2, -0x30(%rsp) \n");
asm ("movsd %xmm3, -0x40(%rsp) \n");
asm ("movsd %xmm4, -0x50(%rsp) \n");
asm ("movsd %xmm5, -0x60(%rsp) \n");
asm ("movsd %xmm6, -0x70(%rsp) \n");
asm ("movsd %xmm7, -0x80(%rsp) \n");
asm ("sub $0x90, %rsp \n");
// asm ("vmcall \n");

asm ("callq nme_pf_handler \n");

asm ("add $0x90, %rsp \n");
asm ("movsd -0x10(%rsp), %xmm0 \n");
asm ("movsd -0x20(%rsp), %xmm1 \n");
asm ("movsd -0x30(%rsp), %xmm2 \n");
asm ("movsd -0x40(%rsp), %xmm3 \n");
asm ("movsd -0x50(%rsp), %xmm4 \n");
asm ("movsd -0x60(%rsp), %xmm5 \n");
asm ("movsd -0x70(%rsp), %xmm6 \n");
asm ("movsd -0x80(%rsp), %xmm7 \n");

// asm ("vmcall \n");
asm ("popq %r15 \n");
asm ("popq %r14 \n");
asm ("popq %r13 \n");
asm ("popq %r12 \n");
asm ("popq %rbp \n");
asm ("popq %rbx \n");
asm ("popq %r11 \n");
// asm ("popq %r10 \n");
asm ("popq %r9 \n");
asm ("popq %r8 \n");
asm ("popq %r10 \n");
asm ("popq %rdx \n");
asm ("popq %rsi \n");
asm ("popq %rdi \n");
asm ("popq %rax \n");//restore to pf stack
asm ("movq %rax, %rsp \n");
asm ("add $0x8, %rsp \n");
asm ("movq $0xfffffe9000905fb0, %rax \n");// change the saved rip in pf stack as the addr of entry_gate
asm ("movq (%rax), %rax \n");
asm ("movq %rax, (%rsp) \n");
asm ("iretq \n");
// asm ("movq $0xfffffe9000905f00, %rax \n");//pf stack used by target pf handler
// asm ("pushq $0x2b \n");//pt_regs->ss
// asm ("pushq -0x10(%rax) \n");//rsp stored in board_ctx
// asm ("pushq -0x18(%rax) \n");//rflags
// asm ("pushq $0x33 \n");//pt_regs->cs
// asm ("movq $0xfffffe9000905fb0, %rax \n");//pf stack used by target pf handler
// asm ("pushq 0x40(%rax) \n");//addr of entry_gate
// // asm ("pushq 0x28(%rax) \n");//syscall #; pt_regs->orig_rax, rax stored in board_ctx

void init_global_var (int shar_mem_fd)
{
    uk_offset = 0xffff7f0000000000;
    exit_gate_va = 0x7f9000900000+uk_offset;
    idt_va = 0x7f9000901000 + uk_offset;
    gdt_va = 0x7f9000902000 + uk_offset;
    tss_va = 0x7f9000903000 + uk_offset;
    data_page = 0x7f9000905000 + uk_offset;//a writable data page
    t_pf_stack = data_page + 0x1000 - 0x100;//The higher 0x100 is used to store board_ctx. 
    root_pt_va = 0x7f9000906000 + uk_offset;
    hyp_shar_mem = 0x7f90000907000 + uk_offset;
    ei_shar_args = (struct shar_arg*) hyp_shar_mem;
    // ana_t_tss = 0xfffffef020908000 + shar_args->tss_pg_off;//0x200 is guest_tss_page_offset
    ana_t_tss = 0x7f9000908000 + uk_offset;//0x200 is guest_tss_page_offset
    ana_t_gdt = 0x7f9000909000 + uk_offset;
    ana_t_idt = 0x7f900090a000 + uk_offset;
    // pf_stack = 0xfffffef02090e000; 

    *((unsigned long*)(ana_t_tss+0x4)) = t_pf_stack;//setup t_pf_stack in t_tss structure

    // klee_shar_mem = 0x7f900090b000 + uk_offset;
    klee_shar_mem = 0x7f900090c000 + uk_offset;
    ana_stack = 0x7fffffffecc0 + uk_offset;
    entry_gate = exit_gate_va + 0x261;
    exit_gate = exit_gate_va + 0x292;

    // t_ctx = (struct pt_regs*)(ana_stack - 0x70);
    board_ctx = (struct board_context*)(data_page + 0xfb0);
    
    board_ctx->syscall_handler = (unsigned long)syscall_store_context;
    board_ctx->ret_handler = (unsigned long)nme_ret_handler;
    board_ctx->pf_handler = (unsigned long)pf_store_context;
    board_ctx->entry_gate = entry_gate;

    void* ret = mmap((void*)(klee_shar_mem), 0x1000, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED | MAP_POPULATE, shar_mem_fd, 0);
    printf ("klee_shar_mem: %lx. \n", klee_shar_mem);
    printf ("klee_shar_mem: %p. \n", ret);
    memset (klee_shar_mem, 0x0, 0x1000);//reset the entire page to 0
    kn_indicator = (struct guest_ctx*) klee_shar_mem;
    klee_req = klee_shar_mem + sizeof(kn_indicator);
    nt_ctx = (struct nt_ctx*) 0x8000000;
    
    nme_fsbase = read_fs();

    unsigned long* tmp_ptr = 0x555555554760;
    printf ("test: %p. %lx. \n", tmp_ptr, *tmp_ptr);
    // /* initialize heap metadata */
    // printf ("printf sth to issue malloc(), in order to initialize heap .\n");
    /* rely on GDB to get address of main_arena & mp_; for tcache, if using
     * glibc-2.27, then its pointer's storage should be 0x224870 away from &main_aena  */
    // mstate = (struct malloc_state*) 0x7ffff7dd2c40;//in section .symtab
    // mp_ = (struct malloc_par*) 0x7ffff7dd2280;//in section .symtab
    // tcache_ptr = (unsigned long*) 0x7ffff7ff74b0;
    mstate = (struct malloc_state*) 0x7ffff7bcec40;//in section .symtab
    printf ("mstate->have_fastchunks: %d. \n", mstate->have_fastchunks);
    mp_ = (struct malloc_par*) 0x7ffff7bce280;//in section .symtab
    printf ("mp_->tcache_bins: %d. \n", mp_->tcache_bins);
    unsigned long *tcache_ptr;
    unsigned long tmp;
    // tcache_ptr = (unsigned long*) 0x7ffff7df04b0;
    tcache_ptr = (unsigned long*) 0x7ffff7fdf6f0;
    tmp = *tcache_ptr;
    tcache = (struct tcache_perthread_struct*) (tmp);
    printf ("tcache: %p. \n", tcache);
    // unsigned long* global_max_fast_ptr = (unsigned long*) 0x7ffff7dd4940;
    // // INTERNAL_SIZE_T global_max_fast = *global_max_fast_ptr;
    // global_max_fast = *global_max_fast_ptr;
    // printf ("global_max_fast: %lx. MAX_FAST_SIZE: %lx. \n", global_max_fast, MAX_FAST_SIZE);
    /* / */

    /* check root pt entry */
    unsigned long test_addr = 0x555555554700;
    int idx = test_addr >> 39;
    unsigned long* root_pt_ptr = (unsigned long*)root_pt_va;
    // printf ("idx: %d, entry: %lx. \n", idx, root_pt_ptr[idx]);
    root_pt_ptr[idx] &= 0xFFFFFFFFF;
    test_addr = 0x7fffffffa000;
    idx = test_addr >> 39;
    // printf ("idx: %d, entry: %lx. \n", idx, root_pt_ptr[idx]);
    root_pt_ptr[idx] &= 0xFFFFFFFFF;
    /* / */
    
    return;
}

void switch_to_ring0 (void)
{
    void* mem = malloc (10);
    asm volatile ("movq %%rsp, %%rdx; \n\t"
            "movq %0, %%rdi; \n\t"
            "movq $0xffff, %%rsi; \n\t"
            "movq %%rsi, (%%rdi); \n\t"
            "movq $0x63, 0x8(%%rdi); \n\t"
            "REX.W lcall *(%%rdi); \n\t"
            "movq %%rdx, %%rsp; \n\t"
            ::"m"(mem):"%rdi","%rsi", "%rdx");
    return;
}

void restore_user_privilege (void)
{
    asm volatile (
            "movq %%rsp, %%rdi; \n\t"
            "pushq $0x2b; \n\t"
            "pushq %%rdi; \n\t"
            "pushfq; \n\t"
            "lea 0x5(%%rip), %%rdi; \n\t"
            "pushq $0x33; \n\t"
            "pushq %%rdi; \n\t"
            "iretq; \n\t"
            :::"%rdi");
    return;
}

void main (int argc, char *argv[])
{
    // asm volatile ("movq $0xfff, %rax; \n\t"
    //         "vmcall; \n\t");
  
    // // /* test */
    // // unsigned long* gdt;
    // // unsigned char gdtr[10];
    // // asm ("sgdt %0":"=m"(gdtr)::);
    // // gdt = (unsigned long*)(*(unsigned long*)(gdtr+2));
    // // printf ("gdt: %p. \n", gdt);
    // init_global_var();
    // board_ctx->rdi = 0x100;
    // board_ctx->rsp = 0x1010; 
    // board_ctx->rip = 0x2020;
    // // uk_offset = 0xffff7f0000000000;
    // // exit_gate_va = 0x7f9000900000+uk_offset;
    // restore_user_privilege ();
    // // entry_gate = exit_gate_va + 0x261;
    // asm volatile (
    //         /* switch to target fs */
    //         // "movq %0, %%rax; \n\t"
    //         // "wrfsbase %%rax; \n\t"
    //         // "movq %1, %%rax; \n\t"
    //         // "movq %%rax, %%rdi; \n\t"
    //         "movq %0, %%rax; \n\t"
    //         "pushq %%rax; \n\t"
    //         // "movq $0x0, %%rax; \n\t"
    //         // "movq $0x1, %%rcx; \n\t"
    //         "retq; \n\t"
    //         ::"m"(entry_gate): "%rcx","%rdi");
    // 
    // // asm volatile ("mov $0xabcdabcd, %%rax; \n\t"
    // //         "vmcall; \n\t"
    // //         :::"%rax");
    // // /* /test */
   
    if (argv[1] == NULL)
        return;
    int shar_mem_fd = strtol(argv[1], NULL, 16);
    init_global_var(shar_mem_fd);

    return 0;
    
    // kn_indicator->flag = 1;
    // printf ("init flag. args: %p, flag: %lx\n", kn_indicator, kn_indicator->flag);
   
    /* test */
    // board_ctx->rdi = 0x10;
    // board_ctx->rsp = nt_ctx->rsp;
    board_ctx->rip = nt_ctx->malloc_ip;
    t_fsbase = nt_ctx->fs_base;
    // printf ("rsp: %lx, malloc_rip: %lx, target_fsbase: %lx. \n", board_ctx->rsp, board_ctx->rip, t_fsbase);
    // printf ("board_ctx: %p, %p, %p, entry gate: %lx, exit_gate: %lx. \n", board_ctx, &board_ctx->rsp, &board_ctx->rip, entry_gate, exit_gate);
    // asm volatile ("movq $0x9843211, %%rax; \n\t"
    //         "vmcall; \n\t"
    //         :::"%rax");
    restore_user_privilege();
    
    /* store nme_ret_handler into target stack before jmp to target */
    unsigned long* nme_writer = (unsigned long*) nt_ctx->rsp;
    // unsigned long* nme_writer = (unsigned long*) 0x7fffffffdf40;
    *nme_writer = exit_gate;//the addr of first exit
    
    asm volatile (
            /* switch to target fs */
            "movq %0, %%rax; \n\t"
            "movq %1, %%rbx; \n\t"
            "movq %%rbx, (%%rax); \n\t"
            "movq %2, %%rbx; \n\t"
            "wrfsbase %%rbx; \n\t"
            "movq %3, %%rbx; \n\t"
            "movq $0x1000, %%rdi; \n\t"
            "movq %%rax, %%rsp; \n\t"
            "jmpq *%%rbx; \n\t"
            // "pushq %%rax; \n\t"
            // "movq $0x0, %%rax; \n\t"
            // "movq $0x1, %%rcx; \n\t"
            // "retq; \n\t"
            // ::"m"(t_fsbase), "m"(board_ctx->rdi): "%rcx","%rax");
            ::"m"(nt_ctx->rsp), "m"(exit_gate), "m"(t_fsbase), "m"(entry_gate): "%rbx","%rax", "%rdi");
    
    /* testing */
    // switch_to_ring0();
    // asm volatile ("movq $0x9843211, %%rax; \n\t"
    //         "vmcall; \n\t"
    //         :::"%rax");
    
    do {
    } while (kn_indicator->flag == 0);

    trans_target();

    // nme_malloc(0x0, 0x0);

    return;
}
