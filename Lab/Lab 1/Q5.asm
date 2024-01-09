[org 0x100]

mov ax, [num]

mov bx, 3
m:
add ax, [num]
dec bx
jnz m

mov [mresult], ax

; ax = dividend
mov bx, 3 ; divisor
mov cx, 0 ; quotient
mov dx, 0 ; remainder
d:
sub ax, bx

cmp ax, bx
jle e

inc cx
add dx, bx
jmp d

e:
mov [dresult], cx

mov ax, 0x4c00
int 0x21

num: dw 6
mresult: dw 0
dresult: dw 0