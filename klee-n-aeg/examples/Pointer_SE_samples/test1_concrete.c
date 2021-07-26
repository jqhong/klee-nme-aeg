#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "klee/klee.h"

typedef struct name {
    char *myname;
    void (*func)(char *str);
} NAME;

void myprint(char *str) { printf("%s\n", str); }
void printmyname() { printf("call print my name\n"); }

int main() {
    NAME *a;
    NAME *b;
    NAME *c, *d, *e;
    printf ("sizeof NAME: %lx. \n", sizeof(NAME));

    a = (NAME *)malloc(sizeof(struct name));  // a new malloc in each run has some randomness;

    a->func = myprint;  // a->func should be concrete, while a is symbolic and may be anything
        // KLEE: ERROR: test1.c:23: memory error: object read only
        // KLEE: ERROR: test1.c:23: memory error: out of bound pointer
    a->myname = "I can also use it";  // a->myname is concrete
        // KLEE: ERROR: test1.c:26: memory error: out of bound pointer
    a->func("this is called from a");
    // free 
    free(a);

    e = (NAME *)malloc(sizeof(struct name)*4);
    d = (NAME *)malloc(sizeof(struct name)*2);  // a malloc after a free using more space than or 'not aligned with' the freed one, then its address doesn't overlap with the freed space, but is still deterministic following the first malloc address.
    c = (NAME *)malloc(sizeof(struct name));
    b = (NAME *)malloc(sizeof(struct name));  // but a malloc after a free is deterministic: if its size 'aligns' (according to the memory allocation algorithm, not necessary smaller) with the freed one, and it reuses the freed space.

    // modify by b
    b->func = printmyname;  // b->func become concrete, while b is symbolic
        // KLEE: ERROR: test1.c:42: memory error: object read only
        // KLEE: ERROR: test1.c:42: memory error: out of bound pointer
    // b->func("this is my function");

    // "illegal" use of a after free
    printf ("a: %p, b: %p. b-a = %ld\n", a, b, b-a);
        // KLEE: ERROR: test1.c:48: external call with symbolic argument: printf
        // -> concretize a, b with concrete execution for each test case
    assert(a!=b && a!=c && a!=d && a!=e);
        // KLEE: ERROR: test1.c:51: ASSERTION FAIL: a!=b && a!=c && a!=d && a!=e

    a->myname = "this change b->myname too";
        // KLEE: ERROR: test1.c:54: memory error: out of bound pointer -> KLEE tracks 'free' and checks if a pointer dereference is valid.
    a->func("this is called from a");  // it calls printmyname, instead of myprint.
        // KLEE: ERROR: test1.c:56: invalid function pointer

    // set NULL
    // a = NULL;
    // printf("this pogram will crash...\n");
    // a->func("can not be printed...");
}

