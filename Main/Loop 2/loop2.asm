;	Author:	Mr TM Modiba
.386
.MODEL FLAT ; Flat memory model
.STACK 4096 ; 4096 bytes

include	io.inc

; Exit function
ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD

; The data section stores all global variables
.DATA

; prompt messages
strNumEntries BYTE "Enter number of entries: ", 10, 0
strTotalInterest BYTE "Enter total interest (0 - 30): ", 10, 0
strPrincipleAmount BYTE "Enter principle amount: ", 10, 0
strTimeLength BYTE "Enter time length (years): ", 10, 0

; Store used inputs
totalAmountEarned DWORD ?
totalInterest DWORD ?
principleAmount DWORD ?
timeLength DWORD ?
numEntries DWORD ?

; Others
newLine BYTE " ", 10, 0
results BYTE "Total amount earned: "

interestRange1 DWORD 0
interestRange2 DWORD 30

; Error messages 
interestError BYTE "Error interest!", 10, 0
msgInvalidTime BYTE "Invalid time length!", 10, 0
 
; The code section may contain multiple tags such as _start, which is the entry
; point of this assembly program
.CODE
_start:
	; Prompt the user
    INVOKE OutputStr, ADDR strNumEntries
	INVOKE InputInt
	MOV numEntries, eax
	INVOKE OutputStr, ADDR newLine
	
	continue:
	    CMP numEntries, 0
	    JLE InvalidEntries
	    DEC numEntries
		
		INVOKE OutputStr, ADDR strTotalInterest
		INVOKE InputInt
		MOV totalInterest, eax
		
		; Verify the interest range
		CMP totalInterest, 0
		JLE InvalidInterest
		CMP totalInterest, 30
		JG InvalidInterest2
		
		INVOKE OutputStr, ADDR strPrincipleAmount
		INVOKE InputInt
		MOV principleAmount, eax
		
		INVOKE OutputStr, ADDR strTimeLength
		INVOKE InputInt
		MOV timeLength, eax
		
		CMP timeLength, 0
		JLE invalidTime
		
		; Do the calculations here
		;MOV totalAmountEarned, totalInterest
		MOV  eax, principleAmount
		MUL timeLength
		MOV ebx, eax
		MOV eax, totalInterest
		CDQ
		IDIV ebx
		MOV totalAmountEarned, eax
		; Output the results
		INVOKE OutputStr, ADDR results
		INVOKE OutputInt, totalAmountEarned
		INVOKE OutputStr, ADDR newLine
		
		; Come back to fix the calculations :(
		
	
	JMP continue
	
	InvalidInterest:
	InvalidInterest2:
	    INVOKE OutputStr, ADDR interestError
	invalidTime:
	    INVOKE OutputStr, ADDR msgInvalidTime 
	InvalidEntries:
	


	; We call the Operating System ExitProcess system call to close the process.
	INVOKE ExitProcess, 0
Public _start
END
