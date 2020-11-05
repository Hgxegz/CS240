
nasm -f elf64 -o circle.o  circle.asm

gcc -c -Wall -m64 -std=c11 -no-pie -o driver.o driver.c

gcc -m64 -no-pie -std=c11 -o exec.out driver.o circle.o

./exec.out