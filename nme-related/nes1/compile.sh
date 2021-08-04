# gcc -shared -nostdlib -o nes1.so nes1.c
# gcc hello.c -o hello
# gcc -fpic -pie hello.c heap.c -o hello -Wl,--rpath=/home/beverly/Documents/glibc-2.27/build-glibc/ -Wl,--dynamic-linker=/home/beverly/Documents/glibc-2.27/build-glibc/elf/ld.so
## exploit.c has a shared mem page with KLEE
gcc -fpic -pie exploit.c heap.c -o hello -Wl,--rpath=/home/beverly/Documents/glibc-2.27/build-glibc/ -Wl,--dynamic-linker=/home/beverly/Documents/glibc-2.27/build-glibc/elf/ld.so
## exploit-test.c does not have a shared mem page with KLEE, just to test malloc & free run well
## gcc -fpic -pie exploit-test.c heap.c -o hello -Wl,--rpath=/home/beverly/Documents/glibc-2.27/build-glibc/ -Wl,--dynamic-linker=/home/beverly/Documents/glibc-2.27/build-glibc/elf/ld.so
