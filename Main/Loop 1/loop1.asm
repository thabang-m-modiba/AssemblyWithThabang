;	Author:	Mr TM Modiba
.386
.MODEL FLAT ; Flat memory model
.STACK 4096 ; 4096 bytes

include	io.inc

; Exit function
ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD

; The data section stores all global variables
.DATA

; prompt message
strMessage BYTE "Enter number : ", 10, 0

; Print message
message BYTE "Hello World", 10, 0

; Store user input
number DWORD ?

; The code section may contain multiple tags such as _start, which is the entry
; point of this assembly program
.CODE
_start:
    ; Get input from the user
    INVOKE OutputStr, ADDR strMessage
	INVOKE InputInt
	MOV number, eax
	; Loop
	whileBelow:
	    ; Compare
		CMP number, 0
		JE completed
		    INVOKE OutputStr, ADDR message; print Hello World
		    DEC number
	JMP whileBelow
	completed:

	; We call the Operating System ExitProcess system call to close the process.
	INVOKE ExitProcess, 0
Public _start
END
