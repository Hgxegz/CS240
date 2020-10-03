extern printf
extern scanf
extern input_array
extern print_array
extern array_sum
global manager

section .data
welcomeMessage db "Welcome to Arrays of Integers",10,0
authorIntro db "Brought to you by Devin Heng",10,0
progExplanation db "This program will sum your array of integers",10,0
longIntFormat db "%ld",0
backIn db "Back in manager.", 10, 0
arrayDisplay db "These numbers were received and placed into the array:",10,0
resultSum db 10,"The sum of the %ld numbers in this array is %ld.",10,0
returnToMain db "The sum will now be returned to the main function",10,0

stringFormat db "%s", 0

section .bss
  array: resq 100

section .text

manager:
  ;All the pushes and pops
  push rbp
  mov rbp, rsp        ;now the base pointer(rbp) points to the top of the stack
  push rdi
  push rsi
  push rdx
  push rcx
  push r8
  push r9
  push r10
  push r11
  push r12
  push r13
  push r14
  push r15
  push rbx
  pushf               ;backup rflags

  ;registers rax, rip, and rsp are usually not backed up
  ;push qword -1

  ;push rbp
  ;push rdi
  ;push r13

  mov rdi, array
  call input_array

  mov r13, rax  ;gets the size
  mov rsi, rax  ;gets the size
  call array_sum
  mov r12, rax  ;gets the sum and holds it in rsi

  ;==================================
  ;display array function

  mov rbp, rsp
  ;Print the welcome message
  mov rdi, stringFormat
  mov rsi, welcomeMessage
  mov rax, 0
  call printf
  ;===============================;
  ;Author introduction
  mov rdi, stringFormat
  mov rsi, authorIntro
  mov rax, 0
  call printf
  ;===============================;
  ;Program explanation
  mov rdi, stringFormat
  mov rsi, progExplanation
  mov rax, 0
  call printf
  ;================================;
  ;MOVE INTO INPUT_ARRAY.ASM FILE
  mov rdi, array ;puts array into rdi to get access in other files
  call input_array
  mov r13, rax ;holds the size of the array in r13
  ;================================;
  ;summing up the array in SUM.ASM FILE
  mov rsi, rax ;holds the size of the array in rsi as well
  call array_sum
  ;=================================;
  ;PRINT ARRAY FUNCTION FROM DISPLAY_ARRAY.CPP
  mov rdi, array
  mov qword rsi, r13
  mov rax, 0
  call print_array
  ;==================================
  ;display the sum
  mov rdi, resultSum
  mov rsi, r13
  mov rdx, r12
  mov rax, 0
  call printf


  ;return sum to main output
  mov rdi, stringFormat
  mov rsi, returnToMain
  mov rax, 0
  call printf

  mov rax, r12


  ;Restore the original values to the general registers before returning to the caller
  ;pop rax
  popf
  pop rbx
  pop r15
  pop r14
  pop r13
  pop r12
  pop r11
  pop r10
  pop r9
  pop r8
  pop rcx
  pop rdx
  pop rsi
  pop rdi
  pop rbp

  ret
