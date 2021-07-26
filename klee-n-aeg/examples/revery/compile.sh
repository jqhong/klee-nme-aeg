# clang++ -I ../../include -emit-llvm -c -g -O0 -Xclang -disable-O0-optnone hello.c
# llvm-dis-9 hello.bc
# clang++ -I ../../include -emit-llvm -c -g -O0 -Xclang -disable-O0-optnone test.c
clang++ -I ../../include -emit-llvm -c -g -O0 -Xclang -disable-O0-optnone aaw.c
