; ----------------------------------------------------------
;	Playground
;					taking user input
;										arch and operands
; ----------------------------------------------------------
; For this one I tried to compile for MacOS:
;   thats also why we have different numbers on syscalls
; ----------------------------------------------------------
; nasm -fmacho64 1_input.asm
; ld 1_input.o -o a.out -platform_version macos 10.15 11.0 -e start -static
; ./a.out
; ----------------------------------------------------------
;	Everything written before and now uses Intel Syntax
; A <- A <op> B, which you can see in code below and file 0
; 	but there is also syntax that comes from AT&T
; used by clang, objdump, perf, MIT, which is B <- B <op> B 
; which means that the second operand is the destination
; ----------------------------------------------------------
;	<op> (opcode) can have suffixes for the data type 
; Well it would have but I am using NASM which doesn't care
; it prefers readablity, with them you need a cheat sheet
; ----------------------------------------------------------

		global	start

		section	.text
start:	mov		rax, 0x02000003		; syscall for read
		mov		rdi, 0				; go the STDIN
		mov		rsi, input_buffer	; address to store
		mov		rdx, 100			; max to read
		syscall
		mov		rcx, rax			; save read bytes
		mov		rax, 0x02000004
		mov		rdi, 1
		mov		rsi, input_buffer
		mov		rdx, rcx			; bytes to read
		syscall
		mov		rax, 0x02000001	
		xor		rdi, rdi
		syscall	

		section	.bss				; for unitialized data
input_buffer: resb	100

; ----------------------------------------------------------
; Register Operands and introduction to x86-64 Architecture
; ----------------------------------------------------------
; (same name as AMD64 + Intel adopted the same instructions)
;
;					Register = fast storage area in the CPU
;                          ^
; Operands = held by the register for instructions 
;
; ----------------------------------------------------------
;		General-Purpose Registers (in use by us)
; ----------------------------------------------------------
; Chunks of memory (in bit)			Purpose for them
; 64	32    16   8
; RAX | EAX | AX | AL, AH	accumulator, often in arithmetic.
; RCX | ECX | CX | CL		counter, loops, shifts, etc.
; RDX | EDX | DX | DL		data, often used in division.
; RBX | EBX | BX | BL, BH	base, memory access.
; RSP | ESP | SP | SPL		stack pointer, point to head.
; RBP | EBP | BP | BPL		base pointer, local variable.
; RSI | ESI | SI | SIL		source index, string operations.
; RDI | EDI | DI | DIL		destinat. index, function args.
; RIP (to add the whole explanation with lower registers)
; R8  | R8D | R8W| R8B
; from above 8 till below 15 are just additional 8 registers
; R15 | R15D| R15W| R15B
; ----------------------------------------------------------
;	{from C: int ac == 6}
;	first 6 arguments parsed in RCX, RDX, RSI, RDI, R8, R9
;
;		{return(value)}
;		return values are stored in RAX and / or RDX
;
;			all the other arguments are pushed to stack
; ----------------------------------------------------------
;		SIMD Registers / XMM Registers (special call)
; (in use for vector operations, not gonna use it right now)
; ----------------------------------------------------------
; Chunks of memory (in bit)				Purpose for them
;	128		| 	256		 |	512		  (diff. instructions)
; XMM0–XMM15|			 |				SSE
;			| YMM0–YMM15 |				AVX
;			| 			 | ZMM0–ZMM31	AVX-512
; all of them are in use for doing things simultaneously,
; for need of multimedia, graphics, numerical simulations
; ----------------------------------------------------------
