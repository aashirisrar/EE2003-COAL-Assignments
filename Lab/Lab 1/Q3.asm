[org 0x100]

mov ax, [0x0025]
mov [0x0FFF], ax
mov bx, [0x0010]
mov cx, 0x002F
mov cx, bx

mov ax, 0x4c00
int 21h



