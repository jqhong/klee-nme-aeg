/*
 * First KLEE tutorial: testing a small function
 */

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <klee/klee.h>

int main() {
  
    int x;
    char *buf1, *buf2, *buf3;
    
    klee_make_symbolic(&x, sizeof(x), "x");
    // x = 200;

    if (x > 100)
    {
        buf1 = malloc(16);
    }
    else
    {
        buf2 = malloc(16);
    }

    buf3 = malloc(64);
    
    // assert(klee_is_symbolic(buf1));
    // assert(klee_is_symbolic(buf2));
    // assert(klee_is_symbolic(buf3));
    
    printf ("buf1: %p. \n", buf1);
    printf ("buf2: %p. \n", buf2);
    printf ("buf3: %p. \n", buf3);
    

    // if (buf3 == buf1 + 16) {
    if (buf3 == buf2 + 16) {
        buf3[32] = 0xaa;
        printf ("+++++. \n");
    }
    else
    {
        buf3[32] = 0xbb;
        printf ("--------. \n");
    }

    // assert(buf3 == buf1+16 && buf3[32] == 0xbb);
    assert(buf3 == buf1+16);

    return 0;
} 
