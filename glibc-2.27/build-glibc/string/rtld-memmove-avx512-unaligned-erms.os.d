$(common-objpfx)string/rtld-memmove-avx512-unaligned-erms.os: \
 ../sysdeps/x86_64/multiarch/memmove-avx512-unaligned-erms.S \
 ../include/stdc-predef.h \
 $(common-objpfx)libc-modules.h \
 ../include/libc-symbols.h \
 $(common-objpfx)config.h \
 ../sysdeps/generic/symbol-hacks.h

../include/stdc-predef.h:

$(common-objpfx)libc-modules.h:

../include/libc-symbols.h:

$(common-objpfx)config.h:

../sysdeps/generic/symbol-hacks.h:
