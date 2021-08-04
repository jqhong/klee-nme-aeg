#define _GNU_SOURCE
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <err.h>
// #include <ctype.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <sched.h>
#include <linux/kvm.h>

// struct arg_blk
// {
//     unsigned long vcpu_fd;
//     unsigned long syscall_flag;
//     unsigned long rip;
//     unsigned long rsp;
//     unsigned long rax;
//     unsigned long rdi;
//     unsigned long rsi;
//     unsigned long rdx;
//     unsigned long r10;
//     unsigned long r8;
//     unsigned long r9;
//     unsigned long r11;
//     unsigned long rcx;
//     unsigned long ret_rax;
//     unsigned long sstub_entry;
//     unsigned long hard_cr3;
// };

struct arg_blk
{
    int instrum_flag;
    int pl_switch;
    unsigned long exit_gate_addr;
    unsigned long syscall_gate_addr;
    unsigned long syscall_gate_pa;
    unsigned long t_idt_va;
    unsigned long t_gdt_va;
    unsigned long t_tss_va;
    unsigned long t_idt_pa;
    unsigned long t_gdt_pa;
    unsigned long t_tss_pa;
    unsigned long t_tss1_pa;
    unsigned long t_tss2_pa;
    unsigned long stack_addr;
    unsigned long root_pt_addr;
    unsigned long shar_va;
    unsigned long shar_pa;
    unsigned long ana_t_tss_va;
    unsigned long ana_t_tss_pa;
    unsigned long ana_t_gdt_va;
    unsigned long ana_t_gdt_pa;
    unsigned long ana_t_idt_va;
    unsigned long ana_t_idt_pa;
    unsigned long ana_pf_c_code;
    unsigned long ana_pf_stack;
    unsigned long vcpu_fd;
    unsigned long syscall_flag;
    unsigned long rip;
    unsigned long rsp;
    unsigned long rax;
    unsigned long rdi;
    unsigned long rsi;
    unsigned long rdx;
    unsigned long r10;
    unsigned long r8;
    unsigned long r9;
    unsigned long r11;
    unsigned long rcx;
    unsigned long ret_rax;
    unsigned long sstub_entry;
    unsigned long hard_cr3;
};

struct arg_blk args;

int kvm, vmfd, vcpufd;
struct kvm_run *run;
size_t mmap_size;

int main(int argc, char *argv[])
{

    const u_int8_t code[] = {
        0xf4,
    };
    int ret;
        
    cpu_set_t cpuset;
    CPU_ZERO (&cpuset);
    CPU_SET (2, &cpuset);
    sched_setaffinity (0, sizeof (cpuset), &cpuset);

    kvm = open("/dev/kvm", O_RDWR);
    printf ("kvm: %d\n", kvm);
    if (kvm == -1)
        err(1, "/dev/kvm");
    ret = ioctl (kvm, KVM_GET_API_VERSION, NULL);
    
    vmfd = ioctl (kvm, KVM_CREATE_VM, (unsigned long)0);
    
    /* change FD_CLOEXEC flag */
    int flags = fcntl (vmfd, F_GETFD);
    // printf ("vmfd: %d, flags: %lx\n", vmfd, flags);
    fcntl (vmfd, F_SETFD, 0);
    // flags = fcntl(vmfd, F_GETFD);
    // printf ("after reset, vmfd: %d, flags: %lx\n", vmfd, flags);
    /* / */

    u_int8_t* memory;
    memory = mmap (NULL, 0x1000, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
    if (!memory)
        err (1, "allocating guest memory");
    // printf ("address of user memory: %p\n", memory);

    memcpy (memory, code, sizeof (code));

    struct kvm_userspace_memory_region region = {
        .slot = 0,
        .guest_phys_addr = 0x1000,
        .memory_size = 0x1000,
        .userspace_addr = (u_int64_t)memory,
    };
    ret = ioctl (vmfd, KVM_SET_USER_MEMORY_REGION, &region);
    // printf ("ret of vm user memory set: %d\n", ret);

    // // void* dl_h = dlopen ("../nes1/nes1.so", RTLD_NOW);
    // // if (!dl_h)
    // // {
    // //     printf ("%s\n", dlerror());
    // //     exit(1);
    // // }

    // // void* p1 = dlsym (dl_h, "entry");
    // // args.rip = (unsigned long) p1;
    // //
    // int nesfd = open ("../nes1/nes1.so", O_RDWR);
    // void* nes1_va = mmap (0x7f0000000000, 0x1000, PROT_READ | PROT_EXEC, MAP_PRIVATE | MAP_FIXED | MAP_POPULATE, nesfd, 0);
    // if (nes1_va == NULL) 
    //     err(1, "mmap nes1");
    // printf ("nesfd: %d, nes1_va: %p. \n", nesfd, nes1_va);

    // printf ("pid: %d. \n", getpid());

    // sleep (0x1000);

    vcpufd = ioctl(vmfd, KVM_CREATE_VCPU, (unsigned long)0);
    if (vcpufd == -1)
        err(1, "KVM_CREATE_VCPU");
    /* change FD_CLOEXEC flag */
    flags = fcntl (vcpufd, F_GETFD);
    fcntl(vcpufd, F_SETFD, 0);
    printf ("vmfd: %d, vcpufd: %d. \n", vmfd, vcpufd);

    /* Map the shared kvm_run structure and following data.  */
    ret = ioctl(kvm, KVM_GET_VCPU_MMAP_SIZE, NULL);
    if (ret == -1)
        err(1, "KVM_GET_VCPU_MMAP_SIZE");
    mmap_size = ret;
    printf ("vcpu size: %x\n", ret);
    if (mmap_size < sizeof(*run))
        err(1, "KVM_GET_VCPU_MMAP_SIZE unexpectedly small");
    run = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_SHARED, vcpufd, 0);
    if (!run)
        err(1, "mmap vcpu");

    /* pass the vcpufd to run_imee */
    args.instrum_flag = 1;
    args.vcpu_fd = vcpufd;
    args.hard_cr3 = strtol(argv[1], NULL, 16);
    printf ("ready to run, hard_cr3: %lx. \n", args.hard_cr3);

    ret = ioctl(vcpufd, 0xAEB0, &args);
    if (ret == -1)
    {
        printf ("ret of 0xAEB0: %d. \n", ret);
        err(1, "KVM_OASIS_SETUP");
    }
    printf ("get guest context done !!!, sizeof arg_blk: %lx\n", sizeof(args));
   
    // // DBG
    // ret = ioctl(vcpufd, 0xAEB2);
    // printf ("OASIS stop: %d, exit reason: %d. \n", ret, run->exit_reason);
    // 
    // if (ret != 0)
    //     printf ("OASIS stop: %d, exit reason: %d. \n", ret, run->exit_reason);
    // return ret;

    // ret = ioctl(vcpufd, 0xAEB1);

    // if (ret != 0)
    //     printf ("OASIS return code: %d, exit reason: %d. \n", ret, run->exit_reason);
   
    // int shar_mem_fd = open("./file", O_RDWR);
    int shar_mem_fd = strtol(argv[2], NULL, 16);
    if (shar_mem_fd == -1)
        err(1, "CREATE shar mem failed");
    void* shar_mem = mmap (NULL, 0x1000, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_POPULATE, shar_mem_fd, 0);
    // memset (shar_mem, 0xfa, 0x1000);
    printf ("in launcher, shar_mem fd: %d, addr: %p. \n", shar_mem_fd, shar_mem);
    // flags = fcntl (vcpufd, F_GETFD);
    // // // fcntl(vcpufd, F_SETFD, 0);
    // printf ("file flags: %d. \n", flags);
    // return 0;

    char new_buf[4];
    sprintf (new_buf, "%x", shar_mem_fd);
    // printf ("new_buf: %s. \n", new_buf);

    // goto out;

    pid_t fpid = fork();
    if (!fpid) /* this is child process */
    {
        printf ("this is child process\n");
        cpu_set_t cpuset;
        CPU_ZERO (&cpuset);
        CPU_SET (2, &cpuset);
        sched_setaffinity (0, sizeof (cpuset), &cpuset);
       
        printf ("path to nme agent: %s. \n", argv[3]);
        // char agent_p[100];
        // strcpy(agent_p, argv[3]);
        // printf ("path to nme agent: %s. \n", agent_p);
        // char *ex_args[] = {agent_p, new_buf, 0};
        char *ex_args[] = {argv[3], new_buf, 0};
        // char *ex_args[] = {"/home/beverly/Documents/test_user/nes1/testtest", new_buf, 0};
        // char *ex_args[] = {"../nes1/testtest", new_buf, 0};//does not work
        // char *ex_args[] = {"/home/beverly/Documents/test_performance/testtest", "/home/beverly/klee-2.0/klee-2.0/examples/get_sign/get_sign.bc", 0};
        // char *ex_args[] = {"/home/beverly/Documents/test_performance/testtest", "10.4.16.37", 0};
        execve(ex_args[0], ex_args, NULL);
        printf ("execute failed. \n");
    }
    else
    {
        wait (NULL); /* wait till the child terminates */
    }
    
out:  
    ret = ioctl(vcpufd, 0xAEB2);
    printf ("OASIS stop: %d, exit reason: %d. \n", ret, run->exit_reason);
    
    // if (ret != 0)
    //     printf ("OASIS stop: %d, exit reason: %d. \n", ret, run->exit_reason);
    return ret;
}
