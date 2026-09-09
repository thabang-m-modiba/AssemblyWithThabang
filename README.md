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
