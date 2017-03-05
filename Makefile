PREFIX = $(PWD)/prefix

.PHONY: all
all: binutils/Makefile
	$(MAKE) -C binutils

.PHONY: install
install: binutils-install

.PHONY: binutils-install
binutils-install: binutils/Makefile
	$(MAKE) -C binutils all && $(MAKE) -C binutils install

binutils/Makefile: binutils/configure .git/modules/binutils/HEAD
	cd binutils && ./configure --prefix=$(PREFIX)
