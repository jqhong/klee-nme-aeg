```
git clone https://github.com/jqhong/klee-nme-aeg.git
```
./glibc-2.27/: customized linker  
./guest-mod-agent/: guest vm kernel module and an agent  
./klee-n-aeg/: klee   
./nme-related: nme host agent, it will be loaded to execute in onsite mode  

# Compile the customized linker
```
cd glibc-2.27
mkdir build-glibc
cd build-glibc/
../glibc-2.27/configure --prefix=/usr/local/lib/glibc-testing
make -j6 CFLAGS="-O2 -U_FORTIFY_SOURCE -fno-stack-protector"
```
# Deploy guest VM kernel module and nme guest agent
copy guest-mod-agent/* into your guest VM
```
cd ../
scp -r guest-mod-agent/ yourname@yourVM:...
```
in your guest VM, compile and install kernel module
```
cd fsgsbase_cr3
make && ./install.sh
```

# re-compile nme host agent
```
cd nme-related/nes1/
```
modify the customized linker path in compile.sh, *-Wl,--rpath=/path/to/your/customized/build-glibc/ -Wl,--dynamic-linker=/path/to/your/customized/build-glibc/elf/ld.so
*, then re-compile
```
./compile.sh
```
change line 1154 in klee-n-aeg/tool/klee/main.cpp 
```
char nme_path[] = "path/to/nme-related"
```

# Test Klee-nme
in your guest VM
```
cd guest-mod-agent/nme-guest
./run.sh
```
in host
```
 ~/Documents/klee-n-aeg/build/bin/klee    -link-llvm-lib=/home/beverly/Documents/cb-multios-heap-of/build64/include/libcgc.so.bc         -link-llvm-lib=/home/beverly/Documents/cb-multios-heap-of/build64/include/tiny-AES128-C/libtiny-AES128-C.so.bc         --simplify-sym-indices --write-cvcs --write-cov --output-module --disable-inlining --optimize --use-forked-solver --use-cex-cache         --only-output-states-covering-new --max-sym-array-size=4096   --max-time=3600 --watchdog --max-memory-inhibit=false --max-static-fork-pct=1         --max-static-solve-pct=1 --max-static-cpfork-pct=1 --switch-type=internal --search=random-path --search=nurs:covnew --use-batching-search         --batch-instructions=10000    --libc=uclibc     --posix-runtime --seed-file=/home/beverly/Documents/cgc-prgs-for-klee-seed-mode/selected-cgc-prgs/AIS-Lite/ktests/AIS-Lite.ktest  --only-seed AIS-Lite.bc   --sym-stdin 117 

```
