/*
 * First KLEE tutorial: testing a small function
 */

#include "klee/klee.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int get_sign(int x) {
  if (x == 0)
     return 0;
  
  if (x < 0)
     return -1;
  else 
     return 1;
} 

void test(int *array, unsigned nelem) {
  int *temp1 = malloc(sizeof(*array) * nelem);
  int *temp2 = malloc(sizeof(*array) * nelem);

  printf("input: [%d, %d, %d, %d]\n",
         array[0], array[1], array[2], array[3]);

  memcpy(temp1, array, sizeof(*array) * 4);
  memcpy(temp2, array, sizeof(*array) * 4);

  free(temp1);
  free(temp2);
}


int main() {
  int a;
  
  int input[4] = { 4, 3, 2, 1};
  test(input, 4);

  return 0;
  // klee_make_symbolic(&a, sizeof(a), "a");
  // return get_sign(a);
} 
