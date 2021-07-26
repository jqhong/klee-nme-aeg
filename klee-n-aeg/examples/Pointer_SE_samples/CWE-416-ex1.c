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
    klee_make_symbolic(&buf1R1, sizeof(buf1R1), "buf1R1");
    klee_make_symbolic(&buf2R1, sizeof(buf2R1), "buf2R1");
    free(buf2R1);
    buf2R2 = (char *)malloc(BUFSIZER2);
    buf3R2 = (char *)malloc(BUFSIZER2);
    klee_make_symbolic(&buf2R2, sizeof(buf2R2), "buf2R2");
    klee_make_symbolic(&buf3R2, sizeof(buf3R2), "buf3R2");
    strncpy(buf2R1, argv[1], BUFSIZER1 - 1); // To model the constraints for buf2R1 for UAF
    assert(buf2R1!=buf2R2 && buf2R1!=buf3R2);
        // KLEE: WARNING ONCE: calling external: strncpy((ReadLSB w64 0 buf2R1), 94427609940568, 247) at CWE-416-ex1.c:26 5
        // KLEE: ERROR: CWE-416-ex1.c:26: ASSERTION FAIL: buf2R1!=buf2R2 && buf2R1!=buf3R2
        // Although KLEE reports the error, its generated test case can't run (it segfaults), because the pointer values from the test case aren't really valid.
    free(buf1R1);
    free(buf2R2);
    free(buf3R2);
}