[org 0x100]

;a
mov ax, [22]
mov [20], ax

;b
mov ax, 20
mov [wordvar], ax

;c
mov bl, al

;d
mov bx, di
mov ax, [si+bx+100]


mov ax, 0x4c00 ; termination statements
int 21h

wordvar: dw 0000h
