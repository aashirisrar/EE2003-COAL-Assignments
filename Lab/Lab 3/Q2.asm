[org 0x100]

mov al, [arr]
mov ah, [arr]
mov bx, 1
mov cx, 9
mov dh, [arr]

outerLoop:

cmp ah, [arr+bx] ;if 

jg p
mov al, [arr+bx]
mov ah, al

p:
cmp dh, [arr+bx]
jl q
mov al, [arr+bx]
mov dh, al


q:
mov al, [arr+bx]
inc bx

dec cx
jnz outerLoop

mov [max], ah
mov [min], dh


mov ax, 0x4c00
int 21h

arr: db 4, 3, 2, 1, 6, 5, 7, 8, 10, 9
min: db 0
max: db 0