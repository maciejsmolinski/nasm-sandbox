.PHONY: run watch

run:
	nasm -f elf64 -g -F dwarf -l fun.lst fun.asm
	gcc fun.o -o fun -no-pie
	./fun

watch:
	find . -name "*.asm" | entr sh -c 'make run'

