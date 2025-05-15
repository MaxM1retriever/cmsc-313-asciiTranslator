# cmsc-313-asciiTranslator

My program, asciiTranlator.asm translates bytes of data into ASCII values that are printed out. 
It does this by moving data, copying it, and translating 4-bits at a time. Once it has translated an entire byte, it moves onto the next byte.
This convert_loop loops until there it translates all the stored input bytes.
After all the bytes have been translated into ASCII, outbuff is printed.
Each value (translated byte) is separated by commas.

How to Compile:
Using a terminal, type the following commands to build, link, and run the file.

(build) nasm -f elf32 asciiTranslator.asm -o asciiTranslator.o
(link) ld -m elf_i386 asciiTranslator.o -o asciiTranslator
(run) ./asciiTranslator
