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
myArray DWORD 10 DUP (?)

; Prompt messages
message BYTE "Enter value to insert in an array: "
newLine BYTE " ", 10, 0
space BYTE " "
strDone BYTE "Done!", 10, 0

; Other helpers
numCount DWORD 10
numCount2 DWORD 10

; The code section may contain multiple tags such as _start, which is the entry
; point of this assembly program
.CODE
_start:
	continue:
	    CMP numCount, 0
		JE done
		DEC numCount
		
		LEA ecx, myArray
		
		; Prompt the user
		INVOKE OutputStr, ADDR message
		INVOKE InputInt
		
		; Insert user input inside of the array
		MOV [ecx], eax
		ADD ecx, 4 ; "Adding space for the next DWORD"
	JMP continue
	done:
	    INVOKE OutputStr, ADDR strDone
		
	

	; We call the Operating System ExitProcess system call to close the process.
	INVOKE ExitProcess, 0
Public _start
END
