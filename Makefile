kill.o: kill.asm
	nasm -f elf64 -g -F dwarf -l kill.lst kill.asm

kill: kill.o
	gcc kill.o -o kill -no-pie
