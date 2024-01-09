[org 0x100]

mov ax, 0;
mov cx, 20;

x:
add ax, 20
dec cx
jnz x

mov ax, 0x4c00
int 21h