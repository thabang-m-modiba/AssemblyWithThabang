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
