run:
	nasm -f elf64 tso.s -o tso.o
	ld tso.o -o tso