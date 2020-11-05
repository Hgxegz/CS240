;=====================================================================================================================================
;Program Name: areaOfCircle
;Programming Language: x86 Assembly
;Program Description: Finding circumference of circle. ^_^

;Author: SI Class (NOV. 1, 2020)
;Email: kalmdownslowdown@csu.fullerton.edu
;Institution: California State University, Fullerton
;Course: CPSC 240-05
;Start Date: 20 October, 2020

;Copyright (C) 2020 
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
;version 3 as published by the Free Software Foundation.
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
;Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.
;======================================================================================================================================


extern scanf            ;To input
extern printf           ;To print
global areaOfCircle

section .data
    enterRadius db "Please enter a radius.", 0x0a, 0        ;Hex of 10 (0x0a)
    userInput db "Please enter numbers", 0x0a, 0            ;0x0a = 0x000a = 0xa
    
    stringFormat db "%s", 0                   ;string
    intFormat db "%ld", 0                     ;Long int
    floatFormat db "%lf", 0                   ;Double is the same as a long float (%lf)
    floatyFloatFloat db "%lf", 0x0A, 0        ;Float format with new line.
    preciseFloat db "%.1lf", 0x0a, 0   ;Tells printf, after the decimal point print 6 values.
                                                    ;Above makes it precision 6. 
section .bss

section .text

areaOfCircle:

    ;16 Pushes              ;Do not push xmm's.

;First most important to preserve the stack before doing anything
    push rbp ;1 ;pointer that points to the top of the stack of this function
    mov  rbp, rsp ;rbp (pointer to the bottom of the stack)(preserved register) now holds the address of the start of this new stack

;function arguments are stored into 1.RDI, 2.RSI, 3.RDX, 4.RCX, 5.R8, 6.R9 IN THAT ORDER
;values are returned from function calls in register rax (scratch)

;register rip is the instruction pointer that points to the top of the activation record, when a function is called.
;This is to return to the next set of instructions after the new function stack is popped with return, which pops rbp and returns to the old address

;push registers onto the stack to save them ;dont touch rsp = top of the stack pointer
    push rdi ;2
    push rsi ;3
    push rdx ;4
    push rcx ;5
    push r8  ;6
    push r9  ;7
    push r10 ;8
    push r11 ;9
    push r12 ;10
    push r13 ;11
    push r14 ;12
    push r15 ;13
    push rbx ;14
    pushf ;15
    push rax ;16

    ;Print ask for Radius
    xor rax, rax            ;Does the same as mov rax, 0 "God approved"
    mov rdi, stringFormat   ;%s
    mov rsi, enterRadius    ;"Please enter a radius."
    call printf             ;Extern printf is called (for outputs)

    ;Input an Integer pls.
    push qword 69420        ;may or may need, kind of a crapshoot
    xor rax, rax            ;Same as "mov rax, 0" (Faster by a nanosec) 
    mov rdi, floatFormat    ;%lf = taking in a double from user input
    mov rsi, rsp            ;Takes top of stack into rsi
    call scanf              ;Extern scanf is called (for inputs)
    pop r15                 ;Pop top of stack into r15 (Stored integer into r15)
                                ;You can't pop an xmm register. No No. 

    ;Pi symbol = π
    ;we represent π as the IEEE754 number (modern), no longer (22/7)

    ;A = pi * r^2
    mov r14, 0x400921FB54442D18     ;Hex representation of Pi in IEEE, and moving it to r14. 
    
;Uncle Holiday's Preferred Way (For Assignments) Uncy likes it this way -----------------------
    push r15                  ;At this point, number is stored in r15, we want to 
                              ;Push it onto the top of the stack and copy into xmm15
    movsd xmm15, [rsp]   ;Any value in the xmm registers are not preserved (rsp is address, by default)
    pop r15
                                    ;keep scratch number in lower xmm registers
                                    ;put important data in higher xmm registers    
;----------------------------------------------------------------------------------------------

    ;Brian's way (Holliday might give you no points, but its easier)
    ;mov the value from r14 to xmm14
    movq xmm14, r14                 ;Allows to move between any types of registers and
                                    ;q specifies quadword. (So movq any quadword is moved)
    
    ;mulsd (one value (single), double precision (d))
    mulsd xmm15, xmm15      ;Squaring xmm15 = (r^2)
        
    ;mulsd ()
    mulsd xmm15, xmm14      ;multiplying xmm15(radius) and xmm14(pi) to each other, goes into xmm15
                                    ;Area of a circle is now in xmm 15.
                                    
    ;Brian Rule: When you call printf (and rax is not 0) it needs to be 16 byte aligned.

    push qword 69
    mov rax, 1              ;when passing rax to printf, you tell it how many xmm registers 
                            ;are passed, thats why we normally pass 0 to rax
    mov rdi, preciseFloatuwurawrXD 
    movsd xmm0, xmm15       ;Mov xmm15 to xmm0 because printf prints the first xmm register first which is xmm0, and then any xmm registers afterwards, in order.
    call printf             ;If passing 1 then you're passing 1 float in printf.
    pop rax

;Return the answer (xmm0) to main------------------------------------------------------------
;since, we delcared result_code (in main) to be double, main will not expect the return value in rax, it will expect it in xmm0

;Sounds familiar    
    movsd xmm0, xmm15
;Brian rule: Type double is being asked in main, so expect the number in xmm0 instead of rax. 

end:
    ;16 pops
    pop rax ;16
    popf ;15
    pop rbx ;14
    pop r15 ;13
    pop r14 ;12
    pop r13 ;11
    pop r12 ;10
    pop r11 ;9
    pop r10 ;8
    pop r9 ;7
    pop r8 ;6
    pop rcx ;5
    pop rdx ;4
    pop rsi ;3
    pop rdi ;2
    pop rbp  ;1

    ret ;pops the return address from the activation record and returns to the next line of instructions.
;values returned from functions are typically stored in register rax
;return will pull the address from the stack and set it as the register rip
;======================================================================================
