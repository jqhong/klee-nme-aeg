# rm -r klee-out
clang-7 -I ../../include -emit-llvm -c -g jq.c -o jq.bc
../../build/bin/klee jq.bc
