;	Author:	Mr TM Modiba
.386
.MODEL FLAT ; Flat memory model
.STACK 4096 ; 4096 bytes

include	io.inc

; Exit function
ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD

; The data section stores all global variables
.DATA

; Prompt Messages
strStudents BYTE "Enter Number of Students: "

; Label messages
labelResults BYTE "Number of students recorded: "

; Store user input
numStudent DWORD ?


; The code section may contain multiple tags such as _start, which is the entry
; point of this assembly program
.CODE
_start:
    ; Get the input from the user
    INVOKE OutputStr, ADDR strStudents
	INVOKE InputInt
	MOV numStudent, eax
	
	; Output the results
	INVOKE OutputStr, ADDR labelResults
	INVOKE OutputInt, numStudent

	; We call the Operating System ExitProcess system call to close the process.
	INVOKE ExitProcess, 0
Public _start
END
