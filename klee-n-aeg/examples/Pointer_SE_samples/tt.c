#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <assert.h>
// #include "klee/klee.h"

// typedef struct name {
//     char *myname;
//     void (*func)(char *str);
// } NAME;
// 
// void myprint(char *str) { printf("%s\n", str); }
// void printmyname() { printf("call print my name\n"); }

int main(int argc, char** argv) {
    // // NAME *a;
    // // NAME *b;
    // // NAME *c, *d, *e;
    // // printf ("sizeof NAME: %lx. \n", sizeof(NAME));

    // // klee_make_symbolic(&argv[0], sizeof(argv[0]), "input");
    // klee_make_symbolic(&argv[0], 0x8, "input");
    // // printf ("sizeof argv[0]: %lx. \n", sizeof(argv[0]));
    // NAME* a = malloc(sizeof(struct name));
    // memcpy (((void*)a-0x8), &argv[0], sizeof(struct name) + 0x8);
    // a->func("this is called by input");

    void* p = mmap(NULL, 0x1000, PROT_READ | PROT_WRITE, MAP_ANON | MAP_SHARED, 0, 0);
    printf ("p: %p, \n", p);
    // int *p, *q, *k;
    // p = malloc(0x8);
    // q = malloc(0x8);
    // k = malloc(0x8);
    // // printf ("p: %p, q: %p, k: %p. addr of p[32]: %p. \n", p, q, k, &p[8]);
    // // free(q);
    // // free(k);
    // p[8] = 0xff;
    // p[9] = p;
    // q = malloc(0x10);
    // printf ("q: %p. \n", q);
    // k = malloc(0x10);
    // printf ("k: %p. \n", k);
    // p = malloc(0x10);
    // printf ("p: %p. \n", p);
    // printf ("p[2]: %lx. p[3]: %lx. \n", p[2], p[3]);
    // printf ("q[0]: %lx. q[1]: %lx. \n", q[0], q[1]);
    // printf ("q[2]: %lx. q[3]: %lx. \n", q[2], q[3]);
    // printf ("q[4]: %lx. q[6]: %lx. \n", q[4], q[5]);
    // // p[0x8] = 0xff;
    // // k[20] = 0xff;
    // printf ("p: %p, q: %p, k: %p. addr of p[32]: %p. \n", p, q, k, &p[8]);
    
    // int *p = malloc(0x10);
    // printf ("p: %p. \n", p);
    // 
    // int* q = p;
    // int* k = malloc(0x8);
    // k = malloc(0x100);
    // k = malloc(0x8);
    // k = malloc(0x10);
    // free(p);
    // // k = malloc(0x8);
    // // k = malloc(0x8);
    // // k = malloc(0x100);

    // int* m = malloc(0x10);
    // *q = 0xff;
    // printf ("m: %p. \n", m);
    // int n = 5;
    // int a[n];
    // a[2] = 0xeeeeffff;
    // printf ("&a: %lx, &a[2]: %lx. \n", &a, &a[2]);
   
    // unsigned long a;
    // // int *p = &a;
    // // p[1] = 0xaabbccdd;
    // unsigned long b;
    // // unsigned long c;
    // klee_make_symbolic (&a, sizeof(a), "a");
    // // assert(klee_is_symbolic(a));
    // // assert(klee_is_symbolic(b));

    // if (a == 100)
    // {
    //     // printf ("+++++. \n");
    //     b = a;
    //     // if (b == 100)
    //     //     printf ("~~~~~. \n");
    //     // else
    //     //     printf ("?????. \n");

    //     // assert(klee_is_symbolic(a));
    //     // assert(klee_is_symbolic(b));
    // }
    // else
    // {
    //     // printf ("-----. \n");
    //     b = a + 0xff;
    //     // c = b + 100;
    //     // assert(klee_is_symbolic(a));
    //     // assert(klee_is_symbolic(b));
    //     // assert(klee_is_symbolic(c));
    // }
    // a = 100;
    // 
    // unsigned long c = b + 100;
    // assert(klee_is_symbolic(a));
    // assert(klee_is_symbolic(b));
    // assert(klee_is_symbolic(c));
    // int b = ;
    // int a[] = {1, 2, 3};
    
    // // int a;
    // // int b;
    // // int c;
    // // // int d;
    // // klee_make_symbolic(&a, sizeof(a), "a");
    // // // klee_make_symbolic(&b, sizeof(b), "b");
    // unsigned long* a = malloc(0x8);
    // // free(a);
    // unsigned long* b = malloc(0x8);
    // unsigned long* c = malloc(0x8);
    // // printf ("b[2] addr: %lx. \n", &b[2]);
    // // // int d = a[4];
    // printf ("a: %p. b: %p. c: %p. \n", a, b, c);
    // printf ("addr a: %p. b: %p. c: %p. \n", &a, &b, &c);
    // unsigned long d = b[2];
    // b = a;
    // c = b + 100;
    // assert(a+100 == c);
    // d = b; 
    // assert(klee_is_symbolic(a));
    // assert(klee_is_symbolic(b));

    // int b, c;
    // switch (a)
    // {
    //     case 0: 
    //         b = 1;
    //         printf (".... \n");
    //         break;
    //     case 1:
    //         b = 2;
    //         break;
    //     defaut:
    //         b = 3;
    //         break;
    // }

    // if (b == 2)
    //     c = 0xff;
    // else
    //     c = 0xbb;
    // return 0;
    // unsigned long* aa = malloc (0x14);
    // unsigned long* bb = malloc (0x4);
    // unsigned long* cc = malloc (0x14);
    // unsigned long* dd = malloc (0x4);
    // printf ("aa: %p, bb: %p. \n", aa, bb);
    // printf ("addr aa: %p, bb: %p. \n", &aa, &bb);
    // printf ("cc: %p, dd: %p. \n", cc, dd);
    // printf ("addr cc: %p, dd: %p. \n", &cc, &dd);

    // unsigned long a = 0xffffffff99999999;
    // printf ("a: %lx. \n", a);
    // aa[2] = 0xffffffff88888888;
    
    // klee_make_symbolic(&aa, sizeof(aa), "aa");

    // int a = 0x8;
    // a = 0xffffffff88888888;
    // int* bb = malloc (0x4);
    // int* cc = malloc (0x4);
    // int* dd = malloc (0x4);
    // printf ("aa: %p, bb: %p. \n", aa, bb);
    // printf ("cc: %p, dd: %p. \n", cc, dd);
    // memset (aa, 0xff, 0x8);
    // free (aa);
    // free (aa);
    // *aa = 0x4;
    // if (aa)
    //     aa[2] = 0x9;
    // else
    //     printf ("aa: %p. \n", aa);
    // printf ("test. \n");
    // printf ("aa: %p. \n", aa);

    // a = (NAME *)malloc(sizeof(struct name));  // a new malloc in each run has some randomness;
    // // free (a);
    // b = (NAME *)malloc(sizeof(struct name));  // a new malloc in each run has some randomness;
    // // free (a);
    // a->func = myprint;  // a->func should be concrete, while a is symbolic and may be anything
    // // memset (a, 0x0, sizeof(struct name)*2);
    // 
    // c = (NAME *)malloc(sizeof(struct name));  // a new malloc in each run has some randomness;
    // 
    // klee_make_symbolic(&c, sizeof(c), "c");

    // c->func = myprint;  // a->func should be concrete, while a is symbolic and may be anything
    //     // KLEE: ERROR: test1.c:23: memory error: object read only
    //     // KLEE: ERROR: test1.c:23: memory error: out of bound pointer
    // c->myname = "I can also use it";  // a->myname is concrete
    //     // KLEE: ERROR: test1.c:26: memory error: out of bound pointer
    // c->func("this is called from a");
    // // free 
    // free(c);

    // e = (NAME *)malloc(sizeof(struct name)*4);
    // d = (NAME *)malloc(sizeof(struct name)*2);  // a malloc after a free using more space than or 'not aligned with' the freed one, then its address doesn't overlap with the freed space, but is still deterministic following the first malloc address.
    // c = (NAME *)malloc(sizeof(struct name));
    // b = (NAME *)malloc(sizeof(struct name));  // but a malloc after a free is deterministic: if its size 'aligns' (according to the memory allocation algorithm, not necessary smaller) with the freed one, and it reuses the freed space.
    // klee_make_symbolic(&b, sizeof(b), "b");
    // klee_make_symbolic(&c, sizeof(c), "c");
    // klee_make_symbolic(&d, sizeof(d), "d");
    // klee_make_symbolic(&e, sizeof(e), "e");

    // // modify by b
    // b->func = printmyname;  // b->func become concrete, while b is symbolic
    //     // KLEE: ERROR: test1.c:42: memory error: object read only
    //     // KLEE: ERROR: test1.c:42: memory error: out of bound pointer
    // // b->func("this is my function");

    // // // "illegal" use of a after free
    // printf ("a: %p, b: %p. b-a = %ld\n", a, b, b-a);
    //     // KLEE: ERROR: test1.c:48: external call with symbolic argument: printf
    //  // -> concretize a, b with concrete execution for each test case
    // assert(a!=b && a!=c && a!=d && a!=e);
        // KLEE: ERROR: test1.c:51: ASSERTION FAIL: a!=b && a!=c && a!=d && a!=e

    // a->myname = "this change b->myname too";
    //     // KLEE: ERROR: test1.c:54: memory error: out of bound pointer -> KLEE tracks 'free' and checks if a pointer dereference is valid.
    // a->func("this is called from a");  // it calls printmyname, instead of myprint.
        // KLEE: ERROR: test1.c:56: invalid function pointer

    // set NULL
    // a = NULL;
    // printf("this pogram will crash...\n");
    // a->func("can not be printed...");
}

