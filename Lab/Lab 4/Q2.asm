[org 0x100]

mov ax, [num1]
mov bx, [num2]

xor ax, bx

jnz m
mov dx, 1
jmp exit

m:
mov dx, 0

exit: 
mov ax, 0x4c00
int 21h

num1: dw 0xABCD
num2: dw 0xABCD