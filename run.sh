nasm -f elf64 -l manager.lis -o manager.o manager.asm
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm
nasm -f elf64 -l atol.lis -o atol.o atol.asm
nasm -f elf64 -l sum.lis -o sum.o sum.asm
g++ -c -Wall -m64 -std=c++14 -no-pie -o isinteger.o isinteger.cpp
g++ -c -Wall -m64 -std=c++14 -no-pie -o Display_Array.o Display_Array.cpp
gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c11
gcc -m64 -no-pie -o array.out -std=c11 manager.o main.o input_array.o Display_Array.o sum.o isinteger.o atol.o
./array.out
