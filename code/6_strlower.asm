# This time we are working with an actual callable function
# if you are going to try and assemble it without _start
# you should receive an error message from your assembler

# the main goal of this one was:
# string-lower building the loop to call another
# that takes an character small than or equal to Z (0x5a)
# from the the given string (src_addr) in code rdi

# str_lower(src_addr):
#  i = 0
#  if src_addr != 0:
#    while [src_addr] != 0x00:
#      if [src_addr] <= 0x5a:
#        [src_addr] = foo([src_addr])
#        i += 1
#      src_addr += 1
#  return i
# foo is provided at 0x403000. 
# foo takes a single argument as a value and returns a value.

# All functions (foo and str_lower) must follow the Linux amd64
# calling convention (also known as System V AMD64 ABI): 
# System V AMD64 ABI

.intel_syntax noprefix
.global str_lower

mov r8, 0x403000

str_lower:
    xor rdx, rdx
    cmp rdi, 0
    je end

while:
    cmp byte ptr [rdi], 0x0
    je end
    cmp byte ptr [rdi], 0x5a
    jbe if

inc:
    add rdi, 1
    jmp while

end:
    mov rax, rdx
    ret

if:
    mov rbp, rdi
    movzx rdi, byte ptr [rdi]
    call r8
    mov rdi, rbp
    mov byte ptr [rdi], al
    add rdx, 1
    jmp inc

