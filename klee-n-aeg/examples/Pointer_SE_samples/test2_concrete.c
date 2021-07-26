#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

typedef struct name {
    char *myname;
    void (*func)(char *str);
} NAME;

void myprint(char *str) { printf("%s\n", str); }
void printmyname(char *str) { printf("call print my name\n"); }

int main() {
    NAME *a;
    NAME *b;
    NAME *c, *d, *e;
    printf ("sizeof NAME: %lx. \n", sizeof(NAME));



    a = (NAME *)malloc(sizeof(struct name));  // a new malloc in each run has some randomness;

    a->func = myprint;  // a->func should be concrete


    a->myname = "I can also use it";  // a->myname is concrete

    a->func("this is called from a");
    // free 
    free(a);

    e = (NAME *)malloc(sizeof(struct name)*4);
    d = (NAME *)malloc(sizeof(struct name)*2);  // a malloc after a free using more space than or 'not aligned with' the freed one, then its address doesn't overlap with the freed space, but is still deterministic following the first malloc address.
    b = (NAME *)malloc(sizeof(struct name));  // but a malloc after a free is deterministic: if its size 'aligns' (according to the memory allocation algorithm, not necessary smaller) with the freed one, and it reuses the freed space.
    c = (NAME *)malloc(sizeof(struct name));
    e = a;

    // modify by b
    b->func = printmyname;  // b->func become concrete, while b is symbolic


    // b->func("this is my function");

    // "illegal" use of a after free
    printf ("a: %p, b: %p. b-a = %ld\n", a, b, b-a);


    printf ("c: %p, d: %p, e: %p, c-a = %ld, d-a = %ld, e-a = %ld\n", c, d, e, c-a, d-a, e-a);

    // assert(a!=b && a!=c && a!=d && a!=e);
        // KLEE: ERROR: test2_concrete.c:50: ASSERTION FAIL: a!=b && a!=c && a!=d && a!=e

    b->myname = "this change b->myname";
    b->func("this is called from b");  // it calls printmyname.
        // KLEE: WARNING ONCE: calling printmyname with extra arguments.
    a->myname = "this change b->myname too";

    a->func("this is called from a");  // it calls printmyname, instead of myprint.

    e->func("this is called from e");  // it calls printmyname, instead of myprint.
        // KLEE doesn't report error for a/e->func here; so, very likely the memory map is based on pointer value (address), not pointer name
    // c->func("this is called from c");  // it's invalid call.
        // KLEE: ERROR: test2_concrete.c:62: invalid function pointer -> the previous calls via a/e are ok; so, very likely KLEE tracks memory map using addresses
    d -= 7;  // d == a in native run, but not in KLEE
    d->func("this is called from shifted d");
        // KLEE: ERROR: test2_concrete.c:65: memory error: out of bound pointer -> invalid pointer in KLEE's recorded memory map
        // but this code runs in native mode (may be considered as a false positive of KLEE), as the native run will succeed. KLEE's own malloc allocate d to a different address
        // KLEE's malloc addresses are much different from native ones:
        //      a: 0x55bcb6b162c0, b: 0x55bcb6b162c0. b-a = 0
        //      c: 0x55bcb6b16b00, d: 0x55bcb6c393c0, e: 0x55bcb6b162c0, c-a = 132, d-a = 74512, e-a = 0
        // vs.  a: 0x556360a88670, b: 0x556360a88670. b-a = 0
        //      c: 0x556360a88710, d: 0x556360a886e0, e: 0x556360a88670, c-a = 10, d-a = 7, e-a = 0

    // set NULL
    // a = NULL;
    // printf("this pogram will crash...\n");
    // a->func("can not be printed...");
}

