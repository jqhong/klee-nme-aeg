#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "klee/klee.h"

#define SIZE 512

int main(int argc, char **argv)
{
    char *ptr;
    int err;
    int abrt = 0;

    ptr = (char *)malloc(SIZE);
    klee_make_symbolic(&ptr, sizeof(ptr), "ptr");

    klee_make_symbolic(&err, sizeof(err), "err");
    if (err)
    {
        abrt = 1;
        if (ptr!=NULL)
            free(ptr);
        // KLEE would detect potentially false errors, as klee_make_symbolic assumes the ptr can be anything:
            // KLEE: ERROR: CWE-416-ex2.c:21: memory error: invalid pointer: free -> KLEE considers if ptr==NULL from malloc
            // KLEE: ERROR: CWE-416-ex2.c:21: free of global -> ? 
            // KLEE: ERROR: CWE-416-ex2.c:21: free of alloca -> ?
    }

    if (abrt)
    {
        fprintf(stderr, "operation aborted before commit: %p\n", ptr); // model the constraint of UAF
            // KLEE: WARNING ONCE: calling external: fprintf(23363100817024, 94731939975008, (ReadLSB w64 0 ptr)) at CWE-416-ex2.c:30 10
            // operation aborted before commit: (nil) -> concrete execution
            // operation aborted before commit: 0x56287f969000 -> concrete execution
        // assert(V(ptr) \in allocated memory because ptr is used); how to write it in C assert? 
        assert(ptr==NULL);  // No other pointer in this code; so the assert is ptr==NULL after free. TODO: how to express the constraint "better"?

        // *ptr = '!';  // still no segfault, why?  Q: where is freed memory kept?
            // KLEE: ERROR: CWE-416-ex2.c:37: memory error: out of bound pointer -> KLEE considers the range of a pointer for both write/read operations
        // printf("after: *ptr == 0x%x \n", *ptr);
            // KLEE: ERROR: CWE-416-ex2.c:39: memory error: out of bound pointer
    }
}
