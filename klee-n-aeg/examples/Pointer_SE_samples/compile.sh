rm -f -r klee-*
clang-7 -I ../../include -emit-llvm -c -g -O0 -Xclang -disable-O0-optnone tt.c
llvm-dis-7 tt.bc
