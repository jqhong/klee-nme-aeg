/*
 * First KLEE tutorial: testing a small function
 */

#include "klee/klee.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// void test(int *array, unsigned nelem) {
//   int *temp1 = malloc(sizeof(*array) * nelem);
//   int *temp2 = malloc(sizeof(*array) * nelem);
// 
//   printf("input: [%d, %d, %d, %d]\n",
//          array[0], array[1], array[2], array[3]);
// 
//   memcpy(temp1, array, sizeof(*array) * 4);
//   memcpy(temp2, array, sizeof(*array) * 4);
// 
//   free(temp1);
//   free(temp2);
// }
// int b = 4;
// int d;

// // void* b;
// unsigned long a = 0x88;
// const int b = 0x10;
// const unsigned long c = 0xff;

int main() {
  void* a;
  a = malloc (0x10);
  // int* b;
  // unsigned long *b;
  // b = (unsigned long*) malloc (0x8);
  klee_make_symbolic(&a, sizeof(a), "a");
  a += 4;
  memset (a, 0xff, 0x8);
  // malloc (b);
  // unsigned long* c = (unsigned long*) b;
  // *b = 0xff;
  // b = malloc (0x8);
  // a = c;
  // *b = 8;
  // *((unsigned long*)b) = c;
  // d = 4;
  // printf ("a: %d. b: %p. \n", a, b);
  
  // int input[4] = { 4, 3, 2, 1};
  // test(input, a);

  return 0 ;
  // klee_make_symbolic(&a, sizeof(a), "a");
  // return get_sign(a);
} 
