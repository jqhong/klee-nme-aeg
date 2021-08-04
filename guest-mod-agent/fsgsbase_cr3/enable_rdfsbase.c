/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
/*
 * A kernel module to enable RDFSBASE family instructions on x86.
 *
 * Copyright (c) 2018-2019 Intel Corp. All rights reserved.
 * Author: Hongliang Tian <tatetian@gmail.com>
 */

#include <linux/compiler.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/version.h>
#include <asm/tlbflush.h>
#include <asm/smp.h>
#include <linux/kallsyms.h>

#define LOG(...)            printk(KERN_INFO "enable_rdfsbase: " __VA_ARGS__)

#define CR4_FSGSBASE_BIT    (16)
#define CR4_FSGSBASE_MASK   (1UL << CR4_FSGSBASE_BIT)

void* old_loader_start;
unsigned char inst_stub[5];
unsigned char old_bytes[5];

// void print_bytes (void* p, int len)
// {
//     int i = 0;
//     for ( ; i < len; i ++)
//     {
//         unsigned char* pp = (unsigned char*) p;
//         printk ("%02x ", pp[i]);
//     }
//     printk ("\n");
// 
// }

void clear_WP_bit (void)
{
    unsigned long cr0;

    asm volatile ("movq %%cr0, %0;":"=r"(cr0)::);
    // printk (KERN_ERR "changing CR0 from %X\n", cr0);
    cr0 &= ~(1 << 16);
    // printk (KERN_ERR "to %X, WP_bit cleared.\n", cr0);
    asm volatile ("movq %0, %%cr0;"::"r"(cr0):);
}

void set_WP_bit (void)
{
    unsigned long cr0;

    asm volatile ("movq %%cr0, %0;":"=r"(cr0)::);
    // printk (KERN_ERR "changing CR0 from %X\n", cr0);
    cr0 |= (1 << 16);
    // printk (KERN_ERR "to %X, WP_bit set\n", cr0);
    asm volatile ("movq %0, %%cr0;"::"r"(cr0):);
}

void proc_filter (struct linux_binprm *bprm)
{
    // printk ("invoked. comm : %s. \n", current->comm);
    if (strstr(current->comm, "nme_target"))
    {
        unsigned long target_cr3;
        asm volatile ("movq %%cr3, %%rax; \n\t"
                "movq %%rax, %0; \n\t"
                :"=m"(target_cr3)::"%rax");
        printk ("target process's cr3: 0x%lx. \n", target_cr3);
        asm volatile ("movq $0xabababababababab, %%rax; \n\t"
                "vmcall; \n\t"
                :::"%rax");
    }
    return;
}

static void my_load_elf_binary(void);
asm (" .text");
asm (" .type    my_load_elf_binary, @function");
asm ("my_load_elf_binary: \n");
asm ("pushfq \n");
asm ("pushq %rax \n");
asm ("pushq %rbx \n");
asm ("pushq %rcx \n");
asm ("pushq %rdx \n");
asm ("pushq %rdi \n");
asm ("pushq %rsi \n");
asm ("pushq %r8 \n");
asm ("pushq %r9 \n");
asm ("pushq %r10 \n");
asm ("pushq %r11 \n");
asm ("pushq %r12 \n");
asm ("pushq %r13 \n");
asm ("pushq %r14 \n");
asm ("pushq %r15 \n");
asm ("pushfq \n");
asm ("callq proc_filter \n");
asm ("popfq \n");
asm ("popq %r15 \n");
asm ("popq %r14 \n");
asm ("popq %r13 \n");
asm ("popq %r12 \n");
asm ("popq %r11 \n");
asm ("popq %r10 \n");
asm ("popq %r9 \n");
asm ("popq %r8 \n");
asm ("popq %rsi \n");
asm ("popq %rdi \n");
asm ("popq %rdx \n");
asm ("popq %rcx \n");
asm ("popq %rbx \n");
asm ("popq %rax \n");
asm ("popfq \n");
asm ("retq \n");

static void set_cr4_fsgsbase(void *_unused)
{
    unsigned long cr4_val;
    asm volatile ("movq %%cr4, %%rax; \n\t"
            "movq %%rax, %0; \n\t"
            :"=m"(cr4_val)::"%rax");
	if ((cr4_val | CR4_FSGSBASE_MASK) != cr4_val) {
		cr4_val |= CR4_FSGSBASE_MASK;
		asm volatile ("movq %0, %%rax; \n\t"
                "movq %%rax, %%cr4; \n\t"
                ::"m"(cr4_val):"%rax");
    }
}

static void clear_cr4_fsgsbase(void *_unused)
{
    unsigned long cr4_val;
    asm volatile ("movq %%cr4, %%rax; \n\t"
            "movq %%rax, %0; \n\t"
            :"=m"(cr4_val)::"%rax");
	if ((cr4_val & ~CR4_FSGSBASE_MASK) != cr4_val) {
		cr4_val &= ~CR4_FSGSBASE_MASK;
		asm volatile ("movq %0, %%rax; \n\t"
                "movq %%rax, %%cr4; \n\t"
                ::"m"(cr4_val):"%rax");
	}
}

int __init enable_rdfsbase_init(void)
{
	int cpu;
	int err;

	LOG("Loaded\n");

	if (!boot_cpu_has(X86_FEATURE_FSGSBASE)) {
		LOG("FSGSBASE feature is not supported by this CPU!\n");
		return -ENODEV;
	}

	for_each_online_cpu(cpu) {
		err = smp_call_function_single(cpu, set_cr4_fsgsbase, NULL, 1);

		if (err)
			LOG("Fail to set CR4.FSGSBASE on CPU %d\n", cpu);
		else
			LOG("RDFSBASE and its friends are now enabled on CPU %d\n", cpu);
	}

    /* intercept start_thread to dump cr3 of target process(comm: hello) */
    old_loader_start = (void*) kallsyms_lookup_name("start_thread");//start_thread
    unsigned long offset = ((char*) my_load_elf_binary) - ((char*) old_loader_start + 5);
    inst_stub[0] = 0xe8;
    inst_stub[1] = (offset >> 0) & 0xFF;
    inst_stub[2] = (offset >> 8) & 0xFF;
    inst_stub[3] = (offset >> 16) & 0xFF;
    inst_stub[4] = (offset >> 24) & 0xFF;

    memcpy (old_bytes, old_loader_start, 5);
    clear_WP_bit ();
    memcpy (old_loader_start, inst_stub, 5);
    set_WP_bit ();
    LOG("start_thread has been intercepted. \n");

	return 0;
}

void __exit enable_rdfsbase_exit(void)
{
	int cpu;
	int err;

	for_each_online_cpu(cpu) {
		err = smp_call_function_single(cpu, clear_cr4_fsgsbase, NULL, 1);

		if (err)
			LOG("Fail to clear CR4.FSGSBASE on CPU %d\n", cpu);
		else
			LOG("RDFSBASE and its friends are now disabled on CPU %d\n", cpu);
	}

    /* restore orignal bytes at start_thread */
    clear_WP_bit ();
    memcpy (old_loader_start, old_bytes, 5);
    set_WP_bit ();

	LOG("Unloaded\n");
}

module_init(enable_rdfsbase_init);
module_exit(enable_rdfsbase_exit);

MODULE_LICENSE("Dual BSD/GPL");
MODULE_AUTHOR("Hongliang Tian, Intel Corp.");
MODULE_DESCRIPTION("Enable RDFSBASE family instructions on x86");
