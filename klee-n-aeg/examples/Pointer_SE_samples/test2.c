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
        // KLEE: WARNING: undefined reference to function: printf
        // KLEE: WARNING ONCE: calling external: printf(94651607980736, 16) at test2.c:22 17

    a = (NAME *)malloc(sizeof(struct name));  // a new malloc in each run has some randomness;
    klee_make_symbolic(&a, sizeof(a), "a");

    a->func = myprint;  // a->func should be concrete, while a is symbolic and KLEE assumes it can be anything
        // KLEE: ERROR: test2.c:25: memory error: object read only
        // KLEE: ERROR: test2.c:25: memory error: out of bound pointer
        // <- may be considered as false positives, as a can't really point to anything
    a->myname = "I can also use it";  // a->myname is concrete
        // KLEE: ERROR: test2.c:29: memory error: out of bound pointer
        // <- may be considered as false positives, as a can't really point to anything
    a->func("this is called from a");
    // free 
    free(a);
        // KLEE: ERROR: test2.c:34: memory error: invalid pointer: free <- KLEE checks if a == NULL when running with --libc=uclibc 
        // KLEE: ERROR: test2.c:34: free of alloca <- because a is assumed to be anything

    e = (NAME *)malloc(sizeof(struct name)*4);
    d = (NAME *)malloc(sizeof(struct name)*2);  // a malloc after a free using more space than or 'not aligned with' the freed one, then its address doesn't overlap with the freed space, but is still deterministic following the first malloc address.
    b = (NAME *)malloc(sizeof(struct name));  // but a malloc after a free is deterministic: if its size 'aligns' (according to the memory allocation algorithm, not necessary smaller) with the freed one, and it reuses the freed space.
    c = (NAME *)malloc(sizeof(struct name));
    klee_make_symbolic(&b, sizeof(b), "b");
    klee_make_symbolic(&c, sizeof(c), "c");
    klee_make_symbolic(&d, sizeof(d), "d");
    klee_make_symbolic(&e, sizeof(e), "e");
    e = a;

    // modify by b
    b->func = printmyname;  // b->func become concrete, while b is symbolic
        // KLEE: ERROR: test2.c:49: memory error: object read only
        // KLEE: ERROR: test2.c:49: memory error: out of bound pointer
    // b->func("this is my function");

    // "illegal" use of a after free
    printf ("a: %p, b: %p. b-a = %ld\n", a, b, b-a);
        // KLEE: ERROR: test2.c:55: external call with symbolic argument: printf
        // -> concretize a, b with concrete execution for each test case
    // printf ("c: %p, d: %p, e: %p, c-a = %ld, d-a = %ld, e-a = %ld\n", c, d, e, c-a, d-a, e-a);
        // KLEE: ERROR: test2.c:58: external call with symbolic argument: printf
        // TODO: why KLEE stops running at this point? It doesn't report the following errors when this printf is used
    assert(a!=b & a!=c & a!=d & a!=e);
        // KLEE: ERROR: test2.c:61: ASSERTION FAIL: a!=b & a!=c & a!=d & a!=e

    // b->myname = "this change b->myname";
        // KLEE: ERROR: test2.c:64: memory error: out of bound pointer
        // TODO: why KLEE stops running at this point? why have to comment out the code to make KLEE detect the following errors?
    b->func("this is called from b");  // it calls printmyname.
        // KLEE: WARNING ONCE: calling printmyname with extra arguments.
    // a->myname = "this change b->myname too";
        // KLEE: ERROR: test2.c:69: memory error: out of bound pointer -> KLEE tracks 'free' and checks if a pointer dereference is valid.
    // a->func("this is called from a");  // it calls printmyname, instead of myprint.
        // KLEE: ERROR: test2.c:71: invalid function pointer
        // TODO: why KLEE stops running at this point? why have to comment out the code to make KLEE detect the following errors?
    // e->func("this is called from e");  // it calls printmyname, instead of myprint.
        // KLEE: ERROR: test2.c:74: invalid function pointer
        // KLEE: ERROR: test2.c:74: memory error: out of bound pointer
    // c->func("this is called from c");  // it's invalid call.
        // KLEE: ERROR: test2.c:77: memory error: out of bound pointer
        // KLEE: ERROR: test2.c:77: invalid function pointer
    d -= 7;  // d == a in native run, but not in KLEE
    d->func("this is called from shifted d");
        // KLEE: ERROR: test2.c:81: memory error: out of bound pointer
        // KLEE: ERROR: test2.c:81: invalid function pointer
        // KLEE hangs here for hours; maybe it explores the many possibility for d-a?
        // but this code runs in native mode (may be considered as a false positive of KLEE), as the native run will succeed. KLEE's own malloc allocate d to a different address

    // set NULL
    // a = NULL;
    // printf("this pogram will crash...\n");
    // a->func("can not be printed...");
}

