.PHONY: run watch

run:
	nasm -fmacho64 -g -F dwarf -l fun.lst fun.asm
	ld -L/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem -no_pie fun.o -o fun
	./fun

watch:
	find . -name "*.asm" | entr sh -c 'make run'

