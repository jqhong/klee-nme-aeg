#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <new>
#include <iostream>
// #include "klee/klee.h"
struct Type1 {char data [8];};
// struct Type1 {unsigned long data;};
struct Type2 {
    int status; 
    int* ptr; 
    void init() {};
};
int (*handler)(const int*);
struct {Type1* obj1; Type2* obj2;} gvar = {};
int main(int argc, char* argv[]){
    int res;
    // if (argc < 2)
    // {
    //     printf ("------------------------provide more args, argc: %d \n", argc);
    // }
    // printf ("///////////////////argc: %d \n", argc);
    gvar.obj1 = new Type1;
    gvar.obj2 = new Type2;
    printf ("obj1->data: %s. \n", gvar.obj1->data);
    printf ("status: %d. \n", gvar.obj2->status);
    printf ("addr of gvar.obj1: %p, addr of obj2: %p. \n", &gvar.obj1, &gvar.obj2);
    printf ("addr of gvar.obj1: %p, addr of obj2: %p. %p. \n", &gvar.obj1->data, &gvar.obj2->status, &gvar.obj2->ptr);
    char* buf = argv[1];
    printf ("argv[1]: %s. \n", argv[1]);
    printf ("buf: %s. \n", buf);
    printf ("argv[1]: %p. buf: %p. \n", argv[1], buf);
    memcpy (&gvar.obj1->data, buf, 0x28);
    // memcpy (&gvar.obj1->data, argv[1], 0x28);
    // scanf("%s.", &gvar.obj1->data);
    printf ("obj1->data: %s. \n", gvar.obj1->data);
    printf ("status: 0x%x. \n", gvar.obj2->status);
    // memcpy (&gvar.obj2->status, buf, 12);
    // gvar.obj2->status = (int)buf[1];
    // gvar.obj2->ptr = (int*)0xffffffff;
    // gvar.obj2->ptr = (int*)(&gvar.obj2->status);
    // klee_make_symbolic(&gvar.obj2->status, sizeof(gvar.obj2->status), "aa");
    // klee_make_symbolic(&gvar.obj2, 8, "aa");
    // gvar.obj2->init();
    // // if(vul)
    //     scanf("%s", &gvar.obj1->data);
    // std::cout << argv[1] << std::endl;
    // res = klee_is_symbolic(gvar.obj2->status);
    // printf ("+++++++++++++++++++++res: %d. \n", res);
    // char a = *argv[1];
    // res = klee_is_symbolic(a);
    // printf ("res: %d. \n", res);
    if(gvar.obj2->status)
    {
        printf ("crashing path is taken. \n");
        res = *gvar.obj2->ptr;
        // printf ("\\\\\\\\\\\\\\\res: %d. \n", res);
    }
    else
    {
        printf ("..........exploiting path is taken. \n");
        // *gvar.obj2->ptr = read_int();
        *gvar.obj2->ptr = 0x1234;//obj2->ptr is overflow by obj1->data, and points to arbitrary memory, including the global function pointer handler. 
        // memcpy (&gvar.obj2->ptr, buf, 4);
        // printf ("obj2->ptr is symbolic: %d. \n", klee_is_symbolic((unsigned long)gvar.obj2->ptr));
        // scanf("%s", gvar.obj2->ptr);
    }
    // printf ("\\\\\\\\\\\\\\obj2->ptr is symbolic: %d. \n", klee_is_symbolic((unsigned long)gvar.obj2->ptr));
    handler(gvar.obj2->ptr);//handler may be modified by *gvar.obj2->ptr = 0x1234 
    // printf ("ending path. \n");
    return res;
}
