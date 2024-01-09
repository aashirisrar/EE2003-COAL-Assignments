[org 0x100]

mov ax, 10
mov bx, 20
mov cx, 30

mov dx, ax
mov ax, cx
mov cx, bx
mov bx, dx

mov dx, ax
mov ax, cx
mov cx, bx
mov bx, dx

mov ax, 0x4c00
int 21h
