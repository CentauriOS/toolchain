PREFIX = $(PWD)/prefix

.PHONY: all
all: binutils.build/Makefile gcc.build/Makefile
	$(MAKE) -C binutils.build
	$(MAKE) -C gcc.biuld

.PHONY: install
install: binutils-install gcc-install

.PHONY: binutils-install
binutils-install: binutils.build/Makefile
	$(MAKE) -C binutils.build all && $(MAKE) -C binutils.build install

.PHONY: gcc-install
gcc-install: gcc.build/Makefile
	$(MAKE) -C gcc.build all && $(MAKE) -C gcc.build install

binutils.build/Makefile: binutils/configure .git/modules/binutils/HEAD
	mkdir -p binutils.build
	cd binutils.build && ../binutils/configure --prefix=$(PREFIX)

gcc/gmp/configure gcc/isl/configure gcc/mpc/configure gcc/mpfr/configure: gcc/contrib/download_prerequisites
	cd gcc && contrib/download_prerequisites

gcc.build/Makefile: gcc/gmp/configure gcc/isl/configure gcc/mpc/configure gcc/mpfr/configure gcc/configure .git/modules/gcc/HEAD Makefile
	mkdir -p gcc.build
	cd gcc.build && ../gcc/configure --prefix=$(PREFIX) --with-sysroot=$(PREFIX) --with-local-prefix=$(PREFIX) --with-native-system-header-dir=$(PREFIX)/include --disable-multilib --with-newlib --without-headers --disable-nls --disable-shared --disable-decimal-float --disable-threads --disable-libatomic --disable-libgomp --disable-libmpx --disable-libquadmath --disable-libssp --disable-libvtv --disable-libstdcxx --enable-languages=c,c++
