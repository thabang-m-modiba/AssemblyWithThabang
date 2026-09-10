;	Author:	Mr TM Modiba
.386
.MODEL FLAT ; Flat memory model
.STACK 4096 ; 4096 bytes

include	io.inc

; Exit function
ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD

; The data section stores all global variables
.DATA
; The array
myArray DWORD 10 DUP (7)

; Prompt messages
newLine BYTE " ", 10, 0
space BYTE " "
strDone BYTE "Done!", 10, 0

; Other helpers
numCount DWORD 10

; The code section may contain multiple tags such as _start, which is the entry
; point of this assembly program
.CODE
_start:
	continue:
	    CMP numCount, 0
		JE done
		DEC numCount
		
		; Print the array
		LEA ebx, myArray
		MOV eax, [ebx]
		INVOKE OutputInt, eax
		INVOKE OutputStr, ADDR space
		ADD ebx, 4
	JMP continue
	done:
	    INVOKE OutputStr, ADDR strDone
	

	; We call the Operating System ExitProcess system call to close the process.
	INVOKE ExitProcess, 0
Public _start
END
