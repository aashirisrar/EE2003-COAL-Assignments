[org 0x100]

mov ax, 6597h
mov bx, ax

or bx, ax
xor ax, 0x1BCD
and ax, bx

mov [f], ax

mov ax, 0x4c00
int 21h


f: dw 0