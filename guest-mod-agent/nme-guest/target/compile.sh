# gcc -fpic -pie mem_access.c -o hello -Wl,--rpath=/home/beverly/eglibc/build-eglibc/ -Wl,--dynamic-linker=/home/beverly/eglibc/build-eglibc/elf/ld.so
gcc hello.c -ldl -o nme_target -Wl,--rpath=/home/beverly/Documents/glibc-2.27-klee/build-glibc/ -Wl,--dynamic-linker=/home/beverly/Documents/glibc-2.27-klee/build-glibc/elf/ld.so
