# aswell as the number 4 its part of the pwn.college
# assembly crash curse, this time question count-non-zero

# Count the consecutive non-zero bytes
# in a contiguous region of memory, where:
# rdi = memory address of the 1st byte
# rax = number of consecutive non-zero bytes
# Additionally, if rdi = 0, then set rax = 0

# I am repeating myself this code can be compiled but
# it shouldn't be used as standalone and this just
# presents the logic of a while loop

# start is part is checking if the rdi is not NULL
# If not we can go through the actual while

.intel_syntax noprefix
.global _start
_start:
    cmp rdi, 0
    je break
    xor rdx, rdx
while:
    mov al, byte ptr [rdi + rdx]
    cmp al, 0
    je break
    inc rdx
    jmp while
break:
    mov rax, rdx

