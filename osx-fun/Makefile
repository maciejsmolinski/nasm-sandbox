.PHONY: run watch

run:
	nasm -fmacho64 fun.asm
	ld -L/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem  fun.o -o fun
	./fun

watch:
	find . -name "*.asm" | entr sh -c 'make run'

