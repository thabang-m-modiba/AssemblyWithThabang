;	Author:	Mr TM Modiba
.386
.MODEL FLAT ; Flat memory model
.STACK 4096 ; 4096 bytes

include	io.inc

; Exit function
ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD

; The data section stores all global variables
.DATA

number DWORD 23
multiplier DWORD 2

; The code section may contain multiple tags such as _start, which is the entry
; point of this assembly program
.CODE
_start:
	MOV eax, number
	MUL multiplier
	INVOKE OutputInt, eax ; Results are stored here

	; We call the Operating System ExitProcess system call to close the process.
	INVOKE ExitProcess, 0
Public _start
END
