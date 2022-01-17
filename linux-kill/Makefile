.PHONY: run watch

run:
	nasm -f elf64 -g -F dwarf -l kill.lst kill.asm
	gcc kill.o -o kill -no-pie
	./kill

watch:
	find . -name "*.asm" | entr sh -c 'make run'
