[org 0x100]

mov ax, 9876h
mov bx, 5432h
mov [num1], ax ;num1 becomes 9876
mov [num2], bx ;num2 becomes 54320C0D
mov [num2+2], bx ;num2 becomes 54325432
mov [array1], ax ;array1 first index becomes 9876, 0304
mov [array2], bl ;array2 becomes 32, 06, 07
mov [array2], ax ;array2  becomes 98, 76, 07
mov word [num1], 0000h ;num1 becomes 0000
mov byte [num1], 01h ;num1 becomes 0001
mov byte [num2+1], 11h ;num2 becomes 11325432
mov word [array1+2], 3870h ;array1 = 9876, 3870


mov ax, 0x4c00 ; termination statements
int 21h



num1: dw 0A0Bh
num2: dd 0C0D0E0Dh
array1: dw 0102h , 0304h
array2: db 05h , 06h, 07h