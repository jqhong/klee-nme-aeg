$(common-objpfx)support/resolv_test.oS: \
 resolv_test.c ../include/stdc-predef.h \
 $(common-objpfx)libc-modules.h \
 ../include/libc-symbols.h \
 $(common-objpfx)config.h \
 ../sysdeps/generic/symbol-hacks.h ../support/resolv_test.h \
 ../include/arpa/nameser.h ../resolv/arpa/nameser.h \
 ../include/sys/param.h ../misc/sys/param.h \
 /usr/lib/gcc/x86_64-linux-gnu/7/include/stddef.h ../include/sys/types.h \
 ../posix/sys/types.h ../include/features.h ../include/sys/cdefs.h \
 ../misc/sys/cdefs.h ../sysdeps/x86/bits/wordsize.h \
 ../sysdeps/ieee754/ldbl-96/bits/long-double.h ../include/gnu/stubs.h \
 ../include/bits/types.h ../posix/bits/types.h \
 ../sysdeps/unix/sysv/linux/x86/bits/typesizes.h \
 ../include/bits/types/clock_t.h ../time/bits/types/clock_t.h \
 ../include/bits/types/clockid_t.h ../time/bits/types/clockid_t.h \
 ../include/bits/types/time_t.h ../time/bits/types/time_t.h \
 ../include/bits/types/timer_t.h ../time/bits/types/timer_t.h \
 ../bits/stdint-intn.h ../include/endian.h ../string/endian.h \
 ../sysdeps/x86/bits/endian.h ../sysdeps/x86/bits/byteswap.h \
 ../sysdeps/x86/bits/byteswap-16.h ../bits/uintn-identity.h \
 ../include/sys/select.h ../misc/sys/select.h \
 ../sysdeps/x86/bits/select.h ../include/bits/types/sigset_t.h \
 ../signal/bits/types/sigset_t.h \
 ../sysdeps/unix/sysv/linux/bits/types/__sigset_t.h \
 ../include/bits/types/struct_timeval.h \
 ../time/bits/types/struct_timeval.h \
 ../include/bits/types/struct_timespec.h \
 ../time/bits/types/struct_timespec.h ../include/sys/sysmacros.h \
 ../misc/sys/sysmacros.h ../bits/sysmacros.h \
 ../sysdeps/nptl/bits/pthreadtypes.h \
 ../sysdeps/nptl/bits/thread-shared-types.h \
 ../sysdeps/x86/nptl/bits/pthreadtypes-arch.h ../include/limits.h \
 ../bits/libc-header-start.h \
 /usr/lib/gcc/x86_64-linux-gnu/7/include-fixed/limits.h \
 ../include/bits/posix1_lim.h ../posix/bits/posix1_lim.h \
 ../sysdeps/unix/sysv/linux/bits/local_lim.h /usr/include/linux/limits.h \
 ../include/bits/posix2_lim.h ../posix/bits/posix2_lim.h \
 ../include/bits/xopen_lim.h ../sysdeps/unix/sysv/linux/bits/uio_lim.h \
 ../include/signal.h ../signal/signal.h \
 ../sysdeps/unix/sysv/linux/bits/signum.h ../bits/signum-generic.h \
 ../include/bits/types/sig_atomic_t.h ../signal/bits/types/sig_atomic_t.h \
 ../sysdeps/unix/sysv/linux/bits/types/siginfo_t.h \
 ../include/bits/types/__sigval_t.h ../signal/bits/types/__sigval_t.h \
 ../sysdeps/unix/sysv/linux/x86/bits/siginfo-arch.h \
 ../sysdeps/unix/sysv/linux/bits/siginfo-consts.h \
 ../sysdeps/unix/sysv/linux/bits/siginfo-consts-arch.h \
 ../include/bits/types/sigval_t.h ../signal/bits/types/sigval_t.h \
 ../sysdeps/unix/sysv/linux/bits/types/sigevent_t.h \
 ../sysdeps/unix/sysv/linux/bits/sigevent-consts.h \
 ../sysdeps/unix/sysv/linux/bits/sigaction.h \
 ../sysdeps/unix/sysv/linux/x86/bits/sigcontext.h \
 ../sysdeps/unix/sysv/linux/bits/types/stack_t.h \
 ../sysdeps/unix/sysv/linux/x86/sys/ucontext.h \
 ../sysdeps/unix/sysv/linux/bits/sigstack.h \
 ../sysdeps/unix/sysv/linux/bits/ss_flags.h \
 ../include/bits/types/struct_sigstack.h \
 ../signal/bits/types/struct_sigstack.h \
 ../sysdeps/pthread/bits/sigthread.h \
 ../sysdeps/unix/sysv/linux/bits/param.h /usr/include/linux/param.h \
 /usr/include/x86_64-linux-gnu/asm/param.h \
 /usr/include/asm-generic/param.h ../sysdeps/generic/stdint.h \
 ../bits/wchar.h ../bits/stdint-uintn.h ../include/arpa/nameser_compat.h \
 ../resolv/arpa/nameser_compat.h ../include/string.h \
 ../sysdeps/x86/string_private.h ../string/string.h \
 ../include/bits/types/locale_t.h ../locale/bits/types/locale_t.h \
 ../include/bits/types/__locale_t.h ../locale/bits/types/__locale_t.h \
 ../include/strings.h ../string/strings.h ../include/netinet/in.h \
 ../inet/netinet/in.h ../include/sys/socket.h ../socket/sys/socket.h \
 ../include/bits/types/struct_iovec.h ../misc/bits/types/struct_iovec.h \
 ../sysdeps/unix/sysv/linux/bits/socket.h \
 ../sysdeps/unix/sysv/linux/bits/socket_type.h ../bits/sockaddr.h \
 /usr/include/x86_64-linux-gnu/asm/socket.h \
 /usr/include/asm-generic/socket.h /usr/include/linux/posix_types.h \
 /usr/include/linux/stddef.h \
 /usr/include/x86_64-linux-gnu/asm/posix_types.h \
 /usr/include/x86_64-linux-gnu/asm/posix_types_64.h \
 /usr/include/asm-generic/posix_types.h \
 /usr/include/x86_64-linux-gnu/asm/bitsperlong.h \
 /usr/include/asm-generic/bitsperlong.h \
 /usr/include/x86_64-linux-gnu/asm/sockios.h \
 /usr/include/asm-generic/sockios.h \
 ../include/bits/types/struct_osockaddr.h \
 ../socket/bits/types/struct_osockaddr.h \
 ../sysdeps/unix/sysv/linux/bits/in.h \
 /usr/lib/gcc/x86_64-linux-gnu/7/include/stdbool.h ../include/arpa/inet.h \
 ../inet/arpa/inet.h ../include/errno.h ../stdlib/errno.h \
 ../sysdeps/unix/sysv/linux/bits/errno.h /usr/include/linux/errno.h \
 /usr/include/x86_64-linux-gnu/asm/errno.h \
 /usr/include/asm-generic/errno.h /usr/include/asm-generic/errno-base.h \
 ../include/fcntl.h ../io/fcntl.h \
 ../sysdeps/unix/sysv/linux/x86/bits/fcntl.h \
 ../sysdeps/unix/sysv/linux/bits/fcntl-linux.h \
 /usr/include/linux/falloc.h ../sysdeps/unix/sysv/linux/x86/bits/stat.h \
 ../include/nss.h ../nss/nss.h ../include/resolv.h ../resolv/resolv.h \
 ../include/stdio.h ../libio/stdio.h ../include/bits/types/__FILE.h \
 ../libio/bits/types/__FILE.h ../include/bits/types/FILE.h \
 ../libio/bits/types/FILE.h ../include/bits/libio.h ../libio/bits/libio.h \
 ../sysdeps/unix/sysv/linux/bits/_G_config.h \
 ../include/bits/types/__mbstate_t.h ../wcsmbs/bits/types/__mbstate_t.h \
 ../include/bits/types/wint_t.h ../wcsmbs/bits/types/wint_t.h \
 ../include/gconv.h ../iconv/gconv.h \
 /usr/lib/gcc/x86_64-linux-gnu/7/include/stdarg.h \
 $(common-objpfx)bits/stdio_lim.h \
 ../sysdeps/unix/sysv/linux/bits/sys_errlist.h ../libio/bits/stdio.h \
 ../include/bits/types/res_state.h ../resolv/bits/types/res_state.h \
 ../include/search.h ../misc/search.h ../include/stdlib.h \
 ../stdlib/stdlib.h ../sysdeps/unix/sysv/linux/bits/waitflags.h \
 ../bits/waitstatus.h ../sysdeps/x86/bits/floatn.h \
 ../bits/floatn-common.h ../include/alloca.h ../stdlib/alloca.h \
 ../include/stackinfo.h ../sysdeps/x86_64/stackinfo.h ../include/elf.h \
 ../elf/elf.h ../include/libc-pointer-arith.h \
 ../sysdeps/generic/dl-dtprocnum.h ../sysdeps/pthread/allocalim.h \
 ../bits/stdlib-bsearch.h ../include/bits/stdlib-float.h \
 ../stdlib/bits/stdlib-float.h ../include/sys/stat.h ../io/sys/stat.h \
 ../support/check.h ../support/namespace.h ../support/support.h \
 ../support/test-driver.h ../support/xsocket.h ../include/poll.h \
 ../include/sys/poll.h ../io/sys/poll.h \
 ../sysdeps/unix/sysv/linux/bits/poll.h ../support/xthread.h \
 ../include/pthread.h ../sysdeps/nptl/pthread.h ../include/sched.h \
 ../posix/sched.h ../sysdeps/unix/sysv/linux/bits/sched.h \
 ../include/bits/cpu-set.h ../posix/bits/cpu-set.h ../include/time.h \
 ../time/time.h ../sysdeps/unix/sysv/linux/bits/time.h \
 ../sysdeps/unix/sysv/linux/bits/timex.h \
 ../include/bits/types/struct_tm.h ../time/bits/types/struct_tm.h \
 ../include/bits/types/struct_itimerspec.h \
 ../time/bits/types/struct_itimerspec.h ../sysdeps/x86/bits/setjmp.h \
 ../support/xunistd.h ../include/unistd.h ../posix/unistd.h \
 ../sysdeps/unix/sysv/linux/bits/posix_opt.h \
 ../sysdeps/unix/sysv/linux/x86/bits/environments.h ../bits/confname.h \
 ../include/bits/getopt_posix.h ../posix/bits/getopt_posix.h \
 ../include/bits/getopt_core.h ../posix/bits/getopt_core.h \
 ../include/sys/uio.h ../misc/sys/uio.h \
 ../sysdeps/unix/sysv/linux/bits/uio-ext.h

../include/stdc-predef.h:

$(common-objpfx)libc-modules.h:

../include/libc-symbols.h:

$(common-objpfx)config.h:

../sysdeps/generic/symbol-hacks.h:

../support/resolv_test.h:

../include/arpa/nameser.h:

../resolv/arpa/nameser.h:

../include/sys/param.h:

../misc/sys/param.h:

/usr/lib/gcc/x86_64-linux-gnu/7/include/stddef.h:

../include/sys/types.h:

../posix/sys/types.h:

../include/features.h:

../include/sys/cdefs.h:

../misc/sys/cdefs.h:

../sysdeps/x86/bits/wordsize.h:

../sysdeps/ieee754/ldbl-96/bits/long-double.h:

../include/gnu/stubs.h:

../include/bits/types.h:

../posix/bits/types.h:

../sysdeps/unix/sysv/linux/x86/bits/typesizes.h:

../include/bits/types/clock_t.h:

../time/bits/types/clock_t.h:

../include/bits/types/clockid_t.h:

../time/bits/types/clockid_t.h:

../include/bits/types/time_t.h:

../time/bits/types/time_t.h:

../include/bits/types/timer_t.h:

../time/bits/types/timer_t.h:

../bits/stdint-intn.h:

../include/endian.h:

../string/endian.h:

../sysdeps/x86/bits/endian.h:

../sysdeps/x86/bits/byteswap.h:

../sysdeps/x86/bits/byteswap-16.h:

../bits/uintn-identity.h:

../include/sys/select.h:

../misc/sys/select.h:

../sysdeps/x86/bits/select.h:

../include/bits/types/sigset_t.h:

../signal/bits/types/sigset_t.h:

../sysdeps/unix/sysv/linux/bits/types/__sigset_t.h:

../include/bits/types/struct_timeval.h:

../time/bits/types/struct_timeval.h:

../include/bits/types/struct_timespec.h:

../time/bits/types/struct_timespec.h:

../include/sys/sysmacros.h:

../misc/sys/sysmacros.h:

../bits/sysmacros.h:

../sysdeps/nptl/bits/pthreadtypes.h:

../sysdeps/nptl/bits/thread-shared-types.h:

../sysdeps/x86/nptl/bits/pthreadtypes-arch.h:

../include/limits.h:

../bits/libc-header-start.h:

/usr/lib/gcc/x86_64-linux-gnu/7/include-fixed/limits.h:

../include/bits/posix1_lim.h:

../posix/bits/posix1_lim.h:

../sysdeps/unix/sysv/linux/bits/local_lim.h:

/usr/include/linux/limits.h:

../include/bits/posix2_lim.h:

../posix/bits/posix2_lim.h:

../include/bits/xopen_lim.h:

../sysdeps/unix/sysv/linux/bits/uio_lim.h:

../include/signal.h:

../signal/signal.h:

../sysdeps/unix/sysv/linux/bits/signum.h:

../bits/signum-generic.h:

../include/bits/types/sig_atomic_t.h:

../signal/bits/types/sig_atomic_t.h:

../sysdeps/unix/sysv/linux/bits/types/siginfo_t.h:

../include/bits/types/__sigval_t.h:

../signal/bits/types/__sigval_t.h:

../sysdeps/unix/sysv/linux/x86/bits/siginfo-arch.h:

../sysdeps/unix/sysv/linux/bits/siginfo-consts.h:

../sysdeps/unix/sysv/linux/bits/siginfo-consts-arch.h:

../include/bits/types/sigval_t.h:

../signal/bits/types/sigval_t.h:

../sysdeps/unix/sysv/linux/bits/types/sigevent_t.h:

../sysdeps/unix/sysv/linux/bits/sigevent-consts.h:

../sysdeps/unix/sysv/linux/bits/sigaction.h:

../sysdeps/unix/sysv/linux/x86/bits/sigcontext.h:

../sysdeps/unix/sysv/linux/bits/types/stack_t.h:

../sysdeps/unix/sysv/linux/x86/sys/ucontext.h:

../sysdeps/unix/sysv/linux/bits/sigstack.h:

../sysdeps/unix/sysv/linux/bits/ss_flags.h:

../include/bits/types/struct_sigstack.h:

../signal/bits/types/struct_sigstack.h:

../sysdeps/pthread/bits/sigthread.h:

../sysdeps/unix/sysv/linux/bits/param.h:

/usr/include/linux/param.h:

/usr/include/x86_64-linux-gnu/asm/param.h:

/usr/include/asm-generic/param.h:

../sysdeps/generic/stdint.h:

../bits/wchar.h:

../bits/stdint-uintn.h:

../include/arpa/nameser_compat.h:

../resolv/arpa/nameser_compat.h:

../include/string.h:

../sysdeps/x86/string_private.h:

../string/string.h:

../include/bits/types/locale_t.h:

../locale/bits/types/locale_t.h:

../include/bits/types/__locale_t.h:

../locale/bits/types/__locale_t.h:

../include/strings.h:

../string/strings.h:

../include/netinet/in.h:

../inet/netinet/in.h:

../include/sys/socket.h:

../socket/sys/socket.h:

../include/bits/types/struct_iovec.h:

../misc/bits/types/struct_iovec.h:

../sysdeps/unix/sysv/linux/bits/socket.h:

../sysdeps/unix/sysv/linux/bits/socket_type.h:

../bits/sockaddr.h:

/usr/include/x86_64-linux-gnu/asm/socket.h:

/usr/include/asm-generic/socket.h:

/usr/include/linux/posix_types.h:

/usr/include/linux/stddef.h:

/usr/include/x86_64-linux-gnu/asm/posix_types.h:

/usr/include/x86_64-linux-gnu/asm/posix_types_64.h:

/usr/include/asm-generic/posix_types.h:

/usr/include/x86_64-linux-gnu/asm/bitsperlong.h:

/usr/include/asm-generic/bitsperlong.h:

/usr/include/x86_64-linux-gnu/asm/sockios.h:

/usr/include/asm-generic/sockios.h:

../include/bits/types/struct_osockaddr.h:

../socket/bits/types/struct_osockaddr.h:

../sysdeps/unix/sysv/linux/bits/in.h:

/usr/lib/gcc/x86_64-linux-gnu/7/include/stdbool.h:

../include/arpa/inet.h:

../inet/arpa/inet.h:

../include/errno.h:

../stdlib/errno.h:

../sysdeps/unix/sysv/linux/bits/errno.h:

/usr/include/linux/errno.h:

/usr/include/x86_64-linux-gnu/asm/errno.h:

/usr/include/asm-generic/errno.h:

/usr/include/asm-generic/errno-base.h:

../include/fcntl.h:

../io/fcntl.h:

../sysdeps/unix/sysv/linux/x86/bits/fcntl.h:

../sysdeps/unix/sysv/linux/bits/fcntl-linux.h:

/usr/include/linux/falloc.h:

../sysdeps/unix/sysv/linux/x86/bits/stat.h:

../include/nss.h:

../nss/nss.h:

../include/resolv.h:

../resolv/resolv.h:

../include/stdio.h:

../libio/stdio.h:

../include/bits/types/__FILE.h:

../libio/bits/types/__FILE.h:

../include/bits/types/FILE.h:

../libio/bits/types/FILE.h:

../include/bits/libio.h:

../libio/bits/libio.h:

../sysdeps/unix/sysv/linux/bits/_G_config.h:

../include/bits/types/__mbstate_t.h:

../wcsmbs/bits/types/__mbstate_t.h:

../include/bits/types/wint_t.h:

../wcsmbs/bits/types/wint_t.h:

../include/gconv.h:

../iconv/gconv.h:

/usr/lib/gcc/x86_64-linux-gnu/7/include/stdarg.h:

$(common-objpfx)bits/stdio_lim.h:

../sysdeps/unix/sysv/linux/bits/sys_errlist.h:

../libio/bits/stdio.h:

../include/bits/types/res_state.h:

../resolv/bits/types/res_state.h:

../include/search.h:

../misc/search.h:

../include/stdlib.h:

../stdlib/stdlib.h:

../sysdeps/unix/sysv/linux/bits/waitflags.h:

../bits/waitstatus.h:

../sysdeps/x86/bits/floatn.h:

../bits/floatn-common.h:

../include/alloca.h:

../stdlib/alloca.h:

../include/stackinfo.h:

../sysdeps/x86_64/stackinfo.h:

../include/elf.h:

../elf/elf.h:

../include/libc-pointer-arith.h:

../sysdeps/generic/dl-dtprocnum.h:

../sysdeps/pthread/allocalim.h:

../bits/stdlib-bsearch.h:

../include/bits/stdlib-float.h:

../stdlib/bits/stdlib-float.h:

../include/sys/stat.h:

../io/sys/stat.h:

../support/check.h:

../support/namespace.h:

../support/support.h:

../support/test-driver.h:

../support/xsocket.h:

../include/poll.h:

../include/sys/poll.h:

../io/sys/poll.h:

../sysdeps/unix/sysv/linux/bits/poll.h:

../support/xthread.h:

../include/pthread.h:

../sysdeps/nptl/pthread.h:

../include/sched.h:

../posix/sched.h:

../sysdeps/unix/sysv/linux/bits/sched.h:

../include/bits/cpu-set.h:

../posix/bits/cpu-set.h:

../include/time.h:

../time/time.h:

../sysdeps/unix/sysv/linux/bits/time.h:

../sysdeps/unix/sysv/linux/bits/timex.h:

../include/bits/types/struct_tm.h:

../time/bits/types/struct_tm.h:

../include/bits/types/struct_itimerspec.h:

../time/bits/types/struct_itimerspec.h:

../sysdeps/x86/bits/setjmp.h:

../support/xunistd.h:

../include/unistd.h:

../posix/unistd.h:

../sysdeps/unix/sysv/linux/bits/posix_opt.h:

../sysdeps/unix/sysv/linux/x86/bits/environments.h:

../bits/confname.h:

../include/bits/getopt_posix.h:

../posix/bits/getopt_posix.h:

../include/bits/getopt_core.h:

../posix/bits/getopt_core.h:

../include/sys/uio.h:

../misc/sys/uio.h:

../sysdeps/unix/sysv/linux/bits/uio-ext.h:
