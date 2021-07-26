/*
 * First KLEE tutorial: testing a small function
 */

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <klee/klee.h>

#define MAX 30

int main() {
  
    int n;
    klee_make_symbolic(&n, sizeof(n), "n");
    int *x, *y;
    x = malloc (sizeof(int));
    *x = n;
    for (int i = 0; i < MAX; i++)
    {
        // if (n+i > 20)
        if (*x)
        {
            y = malloc(sizeof(int));
            *y = *x+1;
        }
        else
        {
            y = malloc(sizeof(int));
            *y = *x+1;
            // *y = *x+2;
        }
        x = y;
    }
    assert(*y >= MAX +n);
    return 0;
} 
