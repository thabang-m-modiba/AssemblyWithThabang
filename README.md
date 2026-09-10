# Assembly With Thabang @ UJ
## Learning Assembly at the University of Johannesburg
* Assembly Language 8086
### The Four General Purpose Registers:
```
EAX ; Extended Accumulator. Primarily used for arithmetic operations and function return values
EBX ; Extended Base Register. Holding base address and general data.
ECX ; Extended Count Register. The loop counter.
EDX ; Extended Data Register. Extra data storage, multiplication, division and I/O.
```

### Index Registers
```
ESI ; Extended Source Index. Points to the source data
EDI ; Extended Destination Index. Points to the desitination data
```
### Overflow
* An overflow happens when the result of a calculation is too large (or too small) to fit in the space available in a register.
* It is more like trying to pour 2 liters of water into a 1 liter bottle. The bottle cannot hold it all, so some of it spills over.
* An 8-bit register can store values from 0 to 255.
* The following would result in an overflow:
```
MOV AL, 255
ADD AL, 1
```
* So the results wraps around <code> AL = 0 </code> and the CPU sets the Carry Flag (<code>CF</code>)

### Assembly Code Skeleton
```
.386 ; Generate 386 (32-bit) compatible machine code
.MODEL FLAT ; Use a flat memory model

; Prototype for the ExitProcess function
ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD

.STACK ; Reserve 4096 bytes of stock space

.DATA ; Section for holding "data"

.CODE ; Section for holding the instructions

_start:

    INVOKE ExitProcess, 0 ; Exit this process
PUBLIC _start ; Export the _start label
END ; End of assembly file
```
### Some Assembly Basic Instructions
```
MOV Instruction
XCHG Instruction
ADD Instruction
INC Instruction
SUB Instruction
DEC Instruction
NEG Instruction
MUL Instruction
IMUL Instruction
DIV Instruction
IDIV Instruction
```
* Some instructions modify the flag register <code>EFLAGS</code>.
* When an instruction modifies a flag register, it means the CPU automatically updates one or more flags in the <code>FLAGS/EFLAGS</code> register to reflect the result of that instruction.
* They function more like status report about the last operation.
* Example:
```
MOV AX, 5
SUB AX, 5
```
* After the substraction:
```
AX = 0
ZF = 1
```
* The <code>SUB</code> instruction modifies the zero flag (<code>ZF</code>) because the result was zero.
* Some example of flag registers:
```
OF - Overflow flag
DF - Direction flag
IF - Interrupt flag
SF - Sign flag
ZF - Zero flag
AF - Auxiliary carry flag
PF - Parity flag
CF - Carry flag
```
  
### <code>MOV</code> Instruction
* The <code>MOV</code> Instruction is used to copy data from one place to another place.
```
MOV destination, source
```
* Does not modify any flags

### <code>XCHG</code> instruction
* Used to swap data from one place to another
```
XCHG destination, source
```
* Does not modify any flags

### <code>ADD</code> Instruction
* Used to add data.
* A source operand is added to a destination operand, the result is stored in the destination operand.
* The result is also present in <code>EAX</code>.
```
ADD destination, source
```
* Flags modified:
```
OF
SF
ZF
AF
PF
CF
```

### <code>INC</code> Instruction
* Used to increment a register or memory location by 1.
```
INC source
```
* Flags modified:
```
OF
SF
ZF
AF
PF
```

### <code>SUB</code> Instruction
* Used to subtract data.
* A source operand is substracted from a destination operand, the result is stored in the destination operand.
* The result is also present in <code>EAX</code>.
```
SUB destination, source
```
* Flags modified:
```
OF
SF
ZF
AF
PF
CF
```

### <code>DEC</code> Instruction
* Used to decrement a register or memory location.
```
DEC source
```
* Flags modified:
```
OF
SF
ZF
AF
PF
```

### <code>NEG</code> Instruction
* Used to negate signed data
```
NEG destination
```
* Flags modified:
```
SF
ZF
```

### <code>MUL</code> Instruction
* Used to multiply <b>unsigned</b> data together.
* Multiplies <code>EAX</code> by a source operand.
* The product is stored in <code>EDX:EAX</code>
```
MUL source
```
* Check illustrations [Here](https://github.com/thabang-m-modiba/AssemblyWithThabang/blob/87a61d78132e38b0410e2750b53a4250727a6f71/Main/MUL%20Instruction/multiplication.asm)

### <code>IMUL</code> Instruction
* Used to multiply <b>signed</b> data together.
* Multiplies source operand and immediate operand.
* The product is stored in the destination register as well as <code>EDX:EAX</code>
```
IMUL destination, source, immediate
```
* Check illustrations [Here](https://github.com/thabang-m-modiba/AssemblyWithThabang/blob/60875c63c89ffdc8ec51884af51c28a7b297c42b/Main/IMUL%20Instruction/imul.asm)

### Division Instructions
* When working with division it is important to note that we require a 64-bit number.
* This 64-bit number will be <code>EDX:EAX</code>.
* <b>Unsigned integer division</b> is simpler to work with since we just need t ensure that <code>EDX</code> has the correct values for the MSB of the 64-bit number.
* If we have a small inter value, for example 5, then we need to load 5 into <code>EAX</code> and 0 into <code>EDX</code> since the final number needs to be 5 in <code>EDX:EAX</code>

* <b>Signed integer division</b> is a bit more complicated since the sign can be problematic.
* The sign may have to be extended over <code>EDX</code>, for instance, if <code>EAX</code> contains -5, the sign must be expanded over to <code>EDX</code>.
* Instructions used to extend the sign:
```
CBW ; Convert byte to word
CWD ; Convert word to doubleword
CDQ ; Convert doubleword to quadword
```

#### <code>DIV</code> Instruction
* Used to divide an unsigned integer
* The result is split with <code>EAX</code> containing the quotient and <code>EDX</code> containing the remainder.
```
DIV divisor
```
* See illustrations [Here](https://github.com/thabang-m-modiba/AssemblyWithThabang/blob/0fe147f2278d94867399d01a9627e379a563a342/Main/DIV%20Instruction/div.asm)

#### <code>IDIV</code> Instruction
* Used to divide signed data.
* <code>IDIV</code> is essential to divide a 64-bit number with a 32-bit divisor.
* <code>EDX</code> contains the higher bits, and <code>EAX</code> contains the lower bits.
```
IDIV divisor
```
* The result is split with <code>EAX</code> containing the quotient and <code>EDX</code> containing the remainder.
* See illustration [here](https://github.com/thabang-m-modiba/AssemblyWithThabang/blob/25f94b12466a6ab271e098f198d93d7e30429d12/Main/IDIV%20Instruction/idiv.asm)

## Branching
* High-level languages use structured programming techniques to control the flow of applications.
* Example:
  1. if statements
  2. for loops
  3. while loops
* Assembly language programs do not have this ability, instead of all these constructs have to be created by hand.
* The <code>JMP</code> statements allow us to redirect control flow (Equivalent to the GOTO statemen)

## Unconditional Branching - <code>JMP</code> statement
* The <code>JMP</code> statement/instruction is used to jump unconditionally to a specified label
```
; sytax
JMP label
```
* Does modify any flags

### Comparing two items
* <code>CMP</code> compares a destination and source by performing an implied substraction.
* The source is substracted from the destination.
* The result is not stored instead the processor updates the FLAGS register.
```
; syntax
CMP destination, source
```
* Every decision us ultimately been implemented using comparisons and jump instructions.
* <code>CMP</code> does not affect destination and source values.

#### Unsigned Comparions
```
JA - Jump if above
JNBE - Jump if not below or equal
JAE - Jump if above or equal
JNB - Jump if not below
JB - Jump if below
JNAE - Jump if not above or equal
JBE - Jump if below or equal
JNA - Jump if not above
```

#### Signed Comparisons
```
JG - Jump if greater
JNLE - Jump if not less or equal
JGE - Jump if greater or equal
JNL - Jump if not less
JL - Jump if less
JNGE - Jump if not greater or equal
JLE - Jump if less or equal
JNG - Jump if not greater
```

* <code>CMP</code> is followed by a jump instruction.

## Direct Addressing
* Direct Addressing allows data to be placed directly into a memory location.
* So far this is the method employed to put data into registers or into global variables.
* Register indirect addressing is an alternate method of addressing memory locations. Analogous to pointers in C/C++.
* How indirect addressing works:
  - Load the address of a label into a register
  - Access the memory location in the register with the []'s
  - A value will then be written to/read from the memory location

 * This is a way to read or write data using the address stored in a register, rather than referring to the variable name directly.
 * Here is some syntax illustration:
```
; Direct Addressing
MOV eax, var1 ; Directly access the memory labeled var1

; Indirect addressing
    ; Instead of using var1, we use a register that holds the address
    LEA ebx, var1 ; Load address of var1 into ebx
    MOV eax, [ebx] ; Use the address in ebx to get the value from memory
```
### Using the <code>LEA</code> Instruction for indirect addressing
* <code>LEA</code> is used to load the memory address (not the value) of a variable into the a register.
```
LEA register, memory ; Loading the address into memory
```
* It does not modify any flags
* Note that <code>LEA</code> does not read the value at the memory location, it just gets the address only.
* To dereference the register you use the square brackets [].
* You can now read/ write data at that memory location using the square brackets.

### Indirect Addressing - Sizing
* The assembler needs more information about the register size and the data size when using register indirect addressing.
* It cannot always guess if you are referring to <code>DWORD</code>, <code>WORD</code> or <code>BYTE</code>.
```
; Assembler doesn't know the size of zero (how many bytes)
MOV [eax], 0 ; Will not assemble

; Need to explicitly indicate size of vale being set
MOV BYTE PTR [eax], 0 ; Moving one byte with value being set

; Same registers need no special syntax
MOV eax, [ebx]
ADD eax, [ebx] ; Other instructions work as well
```

## Arrays
* Arrays are contiguous ranges of memory that can be used to store information.
* Each element in the array is the same size.
* Working with element in an array:
  - The array has a base address.
  - Each element in the array has an index.
* To get an address of an element then the following equation is used:
  $(address of element) = (base address) + ([index of element]*[size of element])$

* In the <code>.Data</code> section, the following syntax is used:
```
; General syntax
myArray DWORD <num_items> DUP (<initial_value>)

; Declare array of size 10 with all zeros
myArray DWORD 10 DUP (0)

; Declare array of size 50 but not initialised
myArray DWORD 50 DUP (?)
```

# Mini Projects
## Input and Output
1. Getting data from the user and displaying the data on the terminal.
* [See details](https://github.com/thabang-m-modiba/AssemblyWithThabang/blob/38182eea3682547ec8d30b5a0d3197c6ace12e1d/Main/User%20Inputs%20and%20Outputs/IOprofile.asm)

## Jump and Compare Instructions
1. Get input number from the user. While the number is greater than 0, print "Hello world" and keep decrementing the number.
   * [See code here](https://github.com/thabang-m-modiba/AssemblyWithThabang/blob/7bd2f8607524b8d30216ce37dadc7f917ce1f73c/Main/Loop%201/loop1.asm)
  
## Loops: Simple Interest Calculator
1. Calculate simple interest by getting input from the user.
   * Prompt the user for <code>principleAmount</code>, <code>totalInterest</code> and <code>timeLength</code> and calculate the <code>totalAmountEarned</code> from those values using the following the formula:
     $totalAmountEarned = totalInterest/(principleAmount*timeLength)$

   * [See code here](https://github.com/thabang-m-modiba/AssemblyWithThabang/blob/c1adeec890aee587f3321be4f250aa6af54f5e8c/Main/Loop%202/loop2.asm)
  
## Arrays:
1. Adding elements into an array.
   * [See code Here](https://github.com/thabang-m-modiba/AssemblyWithThabang/blob/179e25eba5fb214d8a47242f45498cb086b9db65/Main/Arrays%201/array1.asm)
  
2. Printing elements of an array.
   * [See code here](https://github.com/thabang-m-modiba/AssemblyWithThabang/blob/bcabc8cbe9ca39b6d88f8eb4493770935dc4783f/Main/Arrays%201/array2.asm)
   
