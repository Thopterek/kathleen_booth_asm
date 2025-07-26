; ----------------------------------------------------------
;	Assembly
;				first Hello, World
;											NASM version
; -----------------------------------------------------------
;   This is an introduction for writing some assembly
; below is the first hello world and how notes about it
; I wrote it for myself but hopefully it can also help you!
; ------------------------------------------------------------
; first step: nasm -felf64 0_hello.asm 0_hello.o
; linked object file to our executable: ld hello.o -o hello
; and to finally run: ./hello
; ----------------------------------------------------------
;	x86 - 64 Instruction Format
; {opcode} {operand_list}
;    ^           ^
;    ^      0 till 3 sources and one possible destination
;    ^
; way to identify the type of instruction
; ----------------------------------------------------------
; labels
;		then are instructions
;				and last but not least operands
		global	_start		; directives

    section .text			; is a section for code
_start:	
    mov		rax, 1	    ; system call for write (depends on OS)
		mov		rdi, 1			; file handle to STDOUT
		mov		rsi, message	; address of string
		mov		rdx, 13			; number of bytes
		syscall					  ; invoke os to write
		mov		rax, 60     ; sys call for exit (same as write)
		xor		rdi, rdi		; exit code 0
		syscall					  ; invoke os to exit

		section .data			; section for constant data
message: db	"Hello, World", 10	; 10 is a newline

; ----------------------------------------------------------
;					  Instructions
;  (in brackets im gonna add the C version for some of them)
; ----------------------------------------------------------
;						mov x,y
;
; moves the value y into x (immediate mov rax, 10)
; or copies the value to the other (mov rbx, rax)
; and could store the value into something (mov [var], rax)
; ----------------------------------------------------------
;						and x,y
;
; bitwise operation AND between the x and y, ( & )
; then stores the result in x 0b1100, 0b1010 = 0b1000
; side note, as with the rest nasm uses polish notation
; ----------------------------------------------------------
;						or x,y
;
; same as above it just does it for the bitwise OR
; which means if any of two is 1 it becomes 1 == true
; that would be 0b1100, 0b1010 = 0b1110 ( | )
; ----------------------------------------------------------
;						xor x,y
;
; we are repeating the same thing once again with XOR ( ! )
; if the bit is diffrent from the other one it becomes 1
; if they are the same its 0 (0b1100, 0b1010 = 0b0110)
; ----------------------------------------------------------
;						add x,y
;
; standard sum, adding the values of y + x
; ----------------------------------------------------------
;						sub x,y
;
; substraction from y - x (keep in mind polish notation)
; giving space for the stack,
; ----------------------------------------------------------
;						inc x
;
; increments a value by one, just like {some int}++ in c
; ----------------------------------------------------------
;						dec x
;
; who would guess, like above but decrementing {some int}--
; ----------------------------------------------------------
;						syscall n
;
; executes the system call for reading, writing and etc.
;
; 0x02000004 is a syscall for writing held by rax
; rdi is holding the file descriptor (1 is STDOUT)
; rsi is a pointer to the message we output
; rdx holds the lenght of the message we wrote
;
; and we end that with syscall (and using mov everywhere)
; ----------------------------------------------------------
;						db
;
; declares byte or bytes of data to place in the memory
; ----------------------------------------------------------
