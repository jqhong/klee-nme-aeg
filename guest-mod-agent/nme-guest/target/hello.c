#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <dlfcn.h>
// #include <errno.h>

int main (void)
{
    // void* nme_handle = dlopen ("~/Documents/nme-syscall/nme.so", RTLD_NOW);
    void* nme_handle = dlopen ("../nme-syscall/nme.so", RTLD_NOW);
    if (!nme_handle)
    {
        // printf ("open nme.so failed. errno: %x. \n", errno);
        char *error = dlerror();
        printf ("open nme.so failed. \n");
        if (error != NULL)
            printf ("%s. \n", error);
        return 0;
    }
    void* nme = dlsym(nme_handle, "nme_g");
    printf ("nme: %p. \n", nme);

    void* ptr = malloc (0x10);
    int i;
    unsigned long tt = 0;
    for (i = 0; i < 10; i ++)
    {
        // tt = *((unsigned long*) ptr);
        *((unsigned long*) ptr) = tt;
        ptr += 0x1000;
        printf ("init mapping for heap page %p. tt: %lx. \n", ptr, tt);
    }
    // ptr = sbrk(0);
    // printf ("orig heap break: %p. \n", ptr);
    // ptr = sbrk(0x8000);
    // printf ("new heap break: %p. \n", ptr);
    // void* a = malloc (0x10);
    // void* b = malloc (0x10);
    // void* c = malloc (0x10);
    // free(ptr);
    // free(a);
    // free(b);
    // free(c);

    // printf ("pid: %d. \n", getpid());

    // sleep (0x100);

    unsigned long ret;
    asm volatile ("movq %1, %%rax; \n\t"
            "callq *%%rax; \n\t"
            "movq %%rax, %0; \n\t"
            :"=m"(ret):"m"(nme):"%rax");
    if (ret == -1)
    {
        printf ("return from nme with -1. \n");
        return -1;
    }
    else
    {
        printf ("brk: %lx. \n", ret);
        return 1;
    }

    /* real t-program starts here */
    void* p = malloc (0x10);
    memset(p, 0xff, 0x10);
    void* q = malloc (0x100);
    asm volatile ("movq $0xff, %%rax; \n\t"
            "vmcall; \n\t":::"%rax");
    printf ("p: %p. \n", p);

    // asm volatile ("vmcall; \n\t");
    return 1;
}
