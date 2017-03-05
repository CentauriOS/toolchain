PREFIX = $(PWD)/prefix

.PHONY: all
all:

binutils/Makefile: binutils/configure .git/modules/binutils/HEAD
	cd binutils && ./configure --prefix=$(PREFIX)
