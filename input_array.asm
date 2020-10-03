extern printf
extern scanf
extern isinteger
extern atolong


global input_array

section .data
  endMessage db "These number were received and placed into the array:",10,0
  promptInt db "Enter a sequence of long integers separated by white space,",10,0
  promptInt2 db "After the last input press enter followed by Control+D:",10,0
  arrayFull db "Array is full please exit by pressing Cntr+D",10,0
  invalid db "This is invalid",10,0
  longIntFormat db "%ld",0
  stringFormat db "%s", 0


section .bss

section .text

input_array:

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
  push qword -1


  mov r14, 0    ;incrementer
  mov r15, rdi  ;array is in rdi so we put that into r15

  ;print the messages
  ;================================
  mov rdi, stringFormat
  mov rsi, promptInt
  mov rax, 0
  call printf

  mov rdi, stringFormat
  mov rsi, promptInt2
  mov rax, 0
  call printf

  ;================================
  loop_start:
  ;Get the value from the user
  mov rdi, stringFormat
  push qword -1
  mov rsi, rsp
  mov rax, 0
  call scanf

  ;validate the inputted value
  cdqe
  cmp rax, -1
  je end_loop

  ;isinteger Check
  mov rdi, rsp
  mov rax, 0
  call isinteger

  cmp rax, 1
  je legit
  jne notlegit

  legit:
  cmp r14, 100
  je filledArray
  mov rax, 0
  mov rdi, rsp
  call atolong
  mov r13, rax
  pop r8
  mov qword [r15 + r14 * 8], r13
  inc r14
  jmp loop_start

  notlegit:
  mov rdi, stringFormat
  mov rsi, invalid
  mov rax, 0
  call printf
  pop r9
  jmp loop_start

  filledArray:
  pop r9
  mov rdi, stringFormat
  mov rsi, arrayFull
  mov rax, 0
  call printf
  jmp loop_start

  end_loop:
  pop rax
  mov rdi, stringFormat
  mov rsi, endMessage
  mov rax, 0
  call printf


  ;Restore the original values to the general registers before returning to the caller
  pop rax
  mov rax, r14
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
