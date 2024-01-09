; Infinite Key Printing
[org 0x0100]
jmp start

l: db "left"
r: db "right"

clrscr: 
push es
push ax
push cx
push di
mov ax, 0xb800
mov es, ax ; point es to video base
xor di, di ; point di to top left column
mov ax, 0x0720 ; space char in normal attribute
mov cx, 2000 ; number of screen locations
cld ; auto increment mode
rep stosw ; clear the whole screen
pop di
pop cx
pop ax
pop es
ret

leftprint:
mov ah, 0x13 ; service 13 - print string
mov al, 1 ; subservice 01 – update cursor
mov bh, 0 ; output on page 0
mov bl, 7 ; normal attrib
mov dx, 0x0C23 ; row 10 column 3
mov cx, 4 ; length of string
push cs
pop es ; segment of string
mov bp, l ; offset of string
int 0x10 ; call BIOS video service
jmp cont

rightprint:
mov ah, 0x13 ; service 13 - print string
mov al, 1 ; subservice 01 – update cursor
mov bh, 0 ; output on page 0
mov bl, 7 ; normal attrib
mov dx, 0x0C2A ; row 10 column 3
mov cx, 5 ; length of string
push cs
pop es ; segment of string
mov bp, r ; offset of string
int 0x10 ; call BIOS video service
jmp cont

;------------------------------------------------
start: 
call clrscr

mov ax, 0xb800
mov es, ax
mov di, 2000
mov word [es:di], 0x0743

mov ah, 0
int 0x16

cmp al, 0x6C
jne right
jmp leftprint

cont:
right:
int 0x16
cmp al, 0x72
jne exit
jmp rightprint
 


exit:
mov ax, 0x4c00 ; terminate program
int 0x21