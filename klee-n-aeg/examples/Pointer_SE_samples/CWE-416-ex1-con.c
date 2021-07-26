#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <assert.h>
#include "klee/klee.h"

#define BUFSIZER1 512
#define BUFSIZER2 ((BUFSIZER1 / 2) - 8)
int main(int argc, char **argv)
{
    char *buf1R1;
    char *buf2R1;
    char *buf2R2;
    char *buf3R2;
    buf1R1 = (char *)malloc(BUFSIZER1);
    buf2R1 = (char *)malloc(BUFSIZER1);  // the bug doesn't appear when using BUFSIZER1; but it doesn't matter to KLEE
    free(buf2R1);
    buf2R2 = (char *)malloc(BUFSIZER2);
    buf3R2 = (char *)malloc(BUFSIZER2);
    klee_make_symbolic(&buf2R2, sizeof(buf2R2), "buf2R2");
    klee_make_symbolic(&buf3R2, sizeof(buf3R2), "buf3R2");
    // *buf2R1 = 'b';
        // KLEE: ERROR: CWE-416-ex1-sym.c:23: memory error: out of bound pointer
    assert(buf2R1!=buf2R2 && buf2R1!=buf3R2);
        // KLEE: ERROR: CWE-416-ex1-con.c:25: ASSERTION FAIL: buf2R1!=buf2R2 && buf2R1!=buf3R2
        // but the test case generated doesn't trigger the assert, since the buf2R1 has a new address so that buf2R2 and buf3R2 from the previous no longer equal to buf2R1.
    // free(buf1R1);
    // free(buf2R2);
    // free(buf3R2);
}