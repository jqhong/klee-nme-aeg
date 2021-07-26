// RUN: %clang %s -emit-llvm %O0opt -c -o %t.bc
// RUN: rm -rf %t.klee-out
// RUN: %klee --write-kqueries --output-dir=%t.klee-out --optimize-array=index %t.bc > %t.log 2>&1
// RUN: FileCheck %s -input-file=%t.log -check-prefix=CHECK-OPT_I
// RUN: test -f %t.klee-out/test000001.kquery
// RUN: test -f %t.klee-out/test000002.kquery
// RUN: not FileCheck %s -input-file=%t.klee-out/test000001.kquery -check-prefix=CHECK-CONST_ARR
// RUN: not FileCheck %s -input-file=%t.klee-out/test000002.kquery -check-prefix=CHECK-CONST_ARR
// RUN: rm -rf %t.klee-out
// RUN: %klee --write-kqueries --output-dir=%t.klee-out --optimize-array=value %t.bc > %t.log 2>&1
// RUN: FileCheck %s -input-file=%t.log -check-prefix=CHECK-OPT_V
// RUN: test -f %t.klee-out/test000001.kquery
// RUN: test -f %t.klee-out/test000002.kquery
// RUN: not FileCheck %s -input-file=%t.klee-out/test000001.kquery -check-prefix=CHECK-CONST_ARR
// RUN: not FileCheck %s -input-file=%t.klee-out/test000002.kquery -check-prefix=CHECK-CONST_ARR
// RUN: rm -rf %t.klee-out
// RUN: %klee --write-kqueries --output-dir=%t.klee-out --optimize-array=all %t.bc > %t.log 2>&1
// RUN: FileCheck %s -input-file=%t.log -check-prefix=CHECK-OPT_V
// RUN: test -f %t.klee-out/test000001.kquery
// RUN: test -f %t.klee-out/test000002.kquery
// RUN: not FileCheck %s -input-file=%t.klee-out/test000001.kquery -check-prefix=CHECK-CONST_ARR
// RUN: not FileCheck %s -input-file=%t.klee-out/test000002.kquery -check-prefix=CHECK-CONST_ARR

// CHECK-OPT_I: KLEE: WARNING: OPT_I: successful
// CHECK-OPT_V: KLEE: WARNING: OPT_V: successful
// CHECK-CONST_ARR: const_arr

#include <stdio.h>
#include "klee/klee.h"

char array[5] = {1,2,7,-4,5};
char array2[5] = {0,3,4,1,2};

int main() {
  unsigned char k;

  klee_make_symbolic(&k, sizeof(k), "k");
  klee_assume(k < 5);

  // CHECK: Yes
  // CHECK-NEXT: No
  if (array[array2[k]] == 7)
    printf("Yes\n");
  else
    printf("No\n");

  // CHECK: KLEE: done: completed paths = 2

  return 0;
}
