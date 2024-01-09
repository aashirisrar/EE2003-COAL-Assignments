; to find and replace a character in a string first run the program then type the string, press enter and then press the charcter you want to find and then the chracter you want to replace

[org 0x100]
 
jmp start

mystr: times 50 db 0
chartofind: db 0
chartoreplace: db 0


; subroutine to clear the screen
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

readstr: 
push bp
mov bp, sp
push ax
push bx
push dx

mov di, 0
mov bx, [bp + 4]
mov cx, 50

p:
mov ah, 0
int 16h

cmp ah, 0x1C
je exit

mov [bx + di], al
inc di
loop p

exit:
;to find
mov ah, 0
int 16h
mov bx, [bp+8]
mov [bx], al

; to replace
mov ah, 0
int 16h
mov bx, [bp+6]
mov [bx], al

pop dx
pop bx
pop ax
pop bp
ret 6

printstr:
push bp
mov bp, sp
mov ah, 0x13 ; service 13 - print string
mov al, 1 ; subservice 01 – update cursor
mov bh, 0 ; output on page 0
mov bl, 7 ; normal attrib
mov dx, 0x0000 ; row 10 column 3
sub cx, 50
neg cx
push cs
pop es ; segment of string
mov bp, [bp+4] ; offset of string
int 0x10 ; call BIOS video service
pop bp
ret

remove:
push bp
mov bp, sp
push ax
push bx
push cx
push dx
push si
push di

mov ax, [bp+8] ; char to find
mov dx, [bp+6] ; char to replace
mov bx, [bp+4] ; array

mov si, 0

sub cx, 50
neg cx

q:
cmp byte [bx+si], al
je replace
cont:
inc si
loop q

pop di
pop si
pop dx
pop cx
pop bx
pop ax
pop bp
ret 6

replace:
mov byte [bx+si], dl
jmp cont

start:
call clrscr
mov ax, chartofind
push ax
mov ax, chartoreplace
push ax
mov ax, mystr
push ax
call readstr
mov ax, [chartofind]
push ax
mov ax, [chartoreplace]
push ax
mov ax, mystr
push ax
call remove
mov ax, mystr
push ax
call printstr


mov ax, 0x4c00
int 21h