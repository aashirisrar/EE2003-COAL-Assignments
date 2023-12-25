[org 0x100]

mov ax, 0
mov bx, 0
 
mov al, [array1]
mul byte [array1+4]
mul byte [array1+8]
mov bx, ax

mov ax, 0
mov al, [array1+1]
mul byte [array1+5]
mul byte [array1+6]
add bx, ax

mov ax, 0
mov al, [array1+2]
mul byte [array1+3]
mul byte [array1+7]
add bx, ax

mov dx, bx

; other side arrow
mov ax, 0
mov bx, 0

mov al, [array1+2]
mul byte [array1+4]
mul byte [array1+6]
mov bx, ax

mov ax, 0
mov al, [array1]
mul byte [array1+5]
mul byte [array1+7]
add bx, ax

mov ax, 0
mov al, [array1+1]
mul byte [array1+3]
mul byte [array1+8]
add bx, ax

sub dx, bx

mov ax, 0x4c00
int 21h

array1: db 1,2,3,4,5,6,7,8,9