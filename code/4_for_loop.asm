# as -o 4_for_loop.o 4_for_loop.asm
# ld -o exec 4_for_loop.o
# Part of the pwn.college Assembly crash curse

# in this way it is made to be run with as the stand alone
# thats way it has the _start (acting as main), in actual code
# we would just call it, most likely using AMDx64 convention

# The for loop tries to calculate the sum of number 1 to n
# per stated subject it was used as:
# Please compute the average of n consecutive quad words, where:
# rdi = memory address of the 1st quad word
# rsi = n (amount to loop for)
# rax = average computed

.intel_syntax noprefix
.global _start

_start:
    xor rax, rax
    xor rdx, rdx

for_loop:
    cmp rdx, rsi
    je broken
    add rax, [rdi + rdx * 8]
    inc rdx
    jmp for_loop

broken:
    xor rdx, rdx
    div rsi
    mov rdi, 0
