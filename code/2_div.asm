;-----------------------------
; modulo and division
;   because division is weird
;-----------------------------
; to remember just like in
; C or C++ you can't cast
; if the sizes are different
; the same we need to move
; the same register sizes
;-----------------------------
; Below is simple division
;         10 % 2
; but there is another catch
;-----------------------------
;     written for linux
;-----------------------------
global _start

_start:
  xor rdx, rdx ; zero out place for modulo
  mov rax, 10
  mov rdi, 2
  div rdi
  mov rdi, rax ; we exit with div result
  mov rax, 60
  syscall
;-----------------------------
; catch is the division itself
;           its bad
; not only for us (look at it)
;   but also for compiler
;-----------------------------
;     FROM PWN.COLLEGE
;-----------------------------
; math trick to optimize 
; the modulo operator (%)
;
; If we have "x % y" 
; y is a power of 2, such as 2^n 
; result is the lower n bits of x.
;
; using lower register byte access 
;       rax = rdi % 256
; and to get modulo we use
;         mov al, dil
;-----------------------------
