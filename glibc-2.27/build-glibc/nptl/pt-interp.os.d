$(common-objpfx)nptl/pt-interp.os: \
 pt-interp.c ../include/stdc-predef.h \
 $(common-objpfx)libc-modules.h \
 ../include/libc-symbols.h \
 $(common-objpfx)config.h \
 ../sysdeps/generic/symbol-hacks.h ../elf/interp.c \
 $(common-objpfx)runtime-linker.h

../include/stdc-predef.h:

$(common-objpfx)libc-modules.h:

../include/libc-symbols.h:

$(common-objpfx)config.h:

../sysdeps/generic/symbol-hacks.h:

../elf/interp.c:

$(common-objpfx)runtime-linker.h:
