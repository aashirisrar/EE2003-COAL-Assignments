[org 0x100]

mov cx, 8 
mov bx, fib 

l:
mov ax, [bx] 
add bx, 2
add ax, [bx]
mov [bx+2], ax

dec cx
jnz l

mov bx, fib
mov cx, 10


f:
mov dx, [bx]
add bx, 2
dec cx
jnz f

mov ax, 0x4c00
int 21h

fib: dw 0, 1
