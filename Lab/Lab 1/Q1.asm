[org 0x100]

mov ax, 3
mov bx, 6
add ax, bx
add ax, 9

mov ax, 0x4c00
int 21h
