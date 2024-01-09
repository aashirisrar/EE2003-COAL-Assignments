[org 0x100]
 
mov ax, [num1]
sub word [num2], ax
mov ax, [num1+2]
sbb word [num2+2], ax
mov ax, [num1+4]
sbb word [num2+4], ax
mov ax, [num1+6]
sbb word [num2+6], ax
 
mov ax, 0x4c00
int 21h

num1: dq 1111111111111111h
num2:dq 1111111111111111h
