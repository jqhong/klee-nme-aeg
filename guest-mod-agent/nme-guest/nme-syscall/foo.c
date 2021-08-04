#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/mman.h>
#include <errno.h>

//shared data structure between nes1 and nes2
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
    unsigned long rsp;//if only brk syscall, no need to switch rsp before issuing syscall?
    unsigned long rbp;
    unsigned long ret_value;
    unsigned long fs_base;
    unsigned long malloc_ip;
    unsigned long free_ip;
    // unsigned long rax;
    // unsigned long nes_fs_base;
    // unsigned long rbx;
    // unsigned long rcx;
    // unsigned long r11;
    // unsigned long r12;
    // unsigned long r13;
    // unsigned long r14;
    // unsigned long r15;
};

struct nt_ctx* nt_ctx;
void* t_stack;
void* nme_stack;

/* since this funcion changes stack, so be careful when using local variables which are addressed by rbp */
int nme_g (void)
{
    // /* Jiaqi */
    // void* p = &malloc;
    // // nt_ctx->malloc_ip = (unsigned long)p;
    // printf ("malloc_ip: %p. \n", p);
    // printf ("pid: %d. \n", getpid());
    // sleep(0x10000);
    // /* /Jiaqi */

    // void* shar_mem_nt = mmap ((void*)0x8000000, 0x1000, PROT_READ | PROT_WRITE, MAP_ANON | MAP_SHARED | MAP_FIXED, -1, 0);
    void* shar_mem_nt = mmap ((void*)0x8000000, 0x1000, PROT_READ | PROT_WRITE, MAP_ANON | MAP_FIXED | MAP_PRIVATE, -1, 0);
    if (shar_mem_nt == (void*)-1)
    {
        printf ("shared mem mmap errno: %x. \n", errno);
        return -1;
    }
    nt_ctx = (struct nt_ctx*) shar_mem_nt;
    printf ("nt_ctx: %p. \n", nt_ctx);
    
    // nme_stack = mmap ((void*)0x8001000, 0x1000, PROT_READ | PROT_WRITE, MAP_ANON | MAP_SHARED | MAP_FIXED, -1, 0);
    nme_stack = mmap ((void*)0x8001000, 0x1000, PROT_READ | PROT_WRITE, MAP_ANON | MAP_FIXED | MAP_PRIVATE, -1, 0);
    if (nme_stack == (void*)-1)
    {
        printf ("stack mmap errno: %x. \n", errno);
        return -1;
    }
    nme_stack += 0xff8;
    // printf ("nme_stack: %p. \n", nme_stack);

    /* initialize malloc_ip & free_ip */
    nt_ctx->malloc_ip = (unsigned long)(&malloc);
    nt_ctx->free_ip = (unsigned long)(&free);
    printf ("target malloc_ip: %lx. \n", nt_ctx->malloc_ip);
    printf ("target free_ip: %lx. \n", nt_ctx->free_ip);
    // return 0;

    /* put fsbase into nt_ctx */
    asm volatile ("rdfsbase %%rax; \n\t"
            "movq %%rax, %0; \n\t"
            :"=m"(nt_ctx->fs_base)::"%rax");
    printf ("target fs base: %lx. \n", nt_ctx->fs_base);

    /* save t-rsp and rbp, then switch to nme-G stack */
    asm volatile ("movq %%rsp, %%rax; \n\t"
            "movq %%rax, %0; \n\t"
            "movq %%rax, %1; \n\t"
            "movq %%rbp, %2; \n\t"
            "movq %3, %%rax; \n\t"
            "movq %%rax, %%rsp; \n\t"
            :"=m"(t_stack), "=m"(nt_ctx->rsp), "=m"(nt_ctx->rbp):"m"(nme_stack):"%rax");

    // nt_ctx->malloc_ip = 0x555555554000+0x760;
    // nt_ctx->malloc_ip = 0x555555554000+0x7a0;
    // do {
    // } while(1);

    // // nt_ctx->flag = 1;
    // nt_ctx->flag = 0;//no request
    

check_req:
    printf ("brk ret: %lx. \n", nt_ctx->ret_value);
    /* check if new request from onsite */
    do {
        // nt_ctx->flag = 2;
    } while (nt_ctx->flag == 0);

    /* new syscall request, load rdi, rsi, rdx, r10, r8, r9, rflags,
     * rax(syscall#), rsp(may pass arg through stack), rbp */
    if (nt_ctx->flag == 1)
    {
        unsigned long ret;
        printf ("syscall %d with arg %lx. \n", nt_ctx->sys_num, nt_ctx->rdi);
        asm volatile (
                // "movq %1, %%rbx; \n\t"
                // // "movq %%rbp; %%r12; \n\t"
                // // "movq %%rsp; %%r13; \n\t"
                // "movq 0x8(%%rbx), %%rdi; \n\t"
                // "movq 0x10(%%rbx), %%rsi; \n\t"
                // "movq 0x18(%%rbx), %%rdx; \n\t"
                // "movq 0x20(%%rbx), %%r10; \n\t"
                // "movq 0x28(%%rbx), %%r8; \n\t"
                // "movq 0x30(%%rbx), %%r9; \n\t"
                // "pushf; \n\t"
                // "popq %%r12; \n\t"//temporally save nme-rflags into r12
                // "movq 0x38(%%rbx), %%rcx; \n\t"
                // "pushq %%rcx; \n\t"
                // "popf; \n\t"
                // "movq 0x4(%%rbx), %%rax; \n\t"
                "movq %1, %%rax; \n\t"
                "movq %2, %%rdi; \n\t"
                // "movq $0, %%rdi; \n\t"
                // "movq $12, %%rax; \n\t"
                "syscall; \n\t"
                "movq %%rax, %0; \n\t"//put ret value into nt_ctx->ret_value
                // "pushq %%r12; \n\t"
                // "popf; \n\t"
                :"=m"(ret):"m"(nt_ctx->sys_num),"m"(nt_ctx->rdi):"%rax","%rbx","%rdi","%rsi","%rdx","%r10","%r8","%r9","%r12");
        nt_ctx->ret_value = ret;
        nt_ctx->flag = 0;
        // nt_ctx->flag = 2;
        goto check_req;
    }
    else if (nt_ctx->flag == 2)
    {
        // unsigned long ret_value;
        if (nt_ctx->err_code & 0x2)//write access
        {
            asm volatile ("movq %0, %%rbx; \n\t"
                    "movq $0x0, (%%rbx); \n\t"
                    ::"m"(nt_ctx->cr2):"%rbx");
        }
        else//read access
        {
            asm volatile ("movq %0, %%rbx; \n\t"
                    "movq (%%rbx), %%rbx; \n\t"
                    ::"m"(nt_ctx->cr2):"%rbx");
            
        }
        nt_ctx->flag = 0;
        // nt_ctx->flag = 2;
        goto check_req;
    }
    else//end of nme cycle
    {
        asm volatile ("movq %0, %%rax; \n\t"
                "movq %%rax, %%rsp; \n\t"
                ::"m"(t_stack):);
        printf ("restore t_stack successfully. \n");
        return 0;
    }
}
