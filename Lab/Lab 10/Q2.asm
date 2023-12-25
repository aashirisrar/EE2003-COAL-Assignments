[org 0x100]

jmp start

seconds: dw 0
timerflag: dw 0
oldkb: dd 0

kbisr:

push ax

in al, 0x60
cmp al, 0x10
jne nextcmp

cmp word [cs:timerflag], 1
je exit

mov word [cs:timerflag], 1
jmp exit

nextcmp:

cmp al, 0x90
jne nomatch

mov word [cs:timerflag], 0
jmp exit

nomatch:

pop ax
jmp far [cs:oldkb]

exit:

mov al, 0x20
out 0x20, al
pop ax
iret

printnum:

push bp
mov bp, sp
push es
push ax
push bx
push cx
push dx
push di

mov ax, 0xB800
mov es, ax
mov ax, [bp+4]
mov bx, 10
mov cx, 0

nextdigit:

mov dx, 0
div bx
add dl, 0x30
push dx
inc cx
cmp ax, 0
jne nextdigit

mov di, 140

nextpos:

pop dx
mov dh, 0x07
mov [es:di], dx
add di, 2
loop nextpos

pop di
pop dx
pop cx
pop bx
pop ax
pop es
pop bp
ret 2

timer:                        ; timer interrupt service routine

push ax

cmp word [cs:timerflag], 1
jne skipall

inc word [cs:seconds]
push word [cs:seconds]
call printnum

skipall:

mov al, 0x20
out 0x20, al

pop ax
iret

start: 

xor ax, ax
mov es, ax
mov ax, [es:9*4]
mov [oldkb], ax
mov ax, [es:9*4+2]
mov [oldkb+2], ax

cli

mov word [es:9*4], kbisr
mov [es:9*4+2], cs
mov word [es:8*4], timer
mov [es:8*4+2], cs

sti

mov dx, start
add dx, 15
mov cl, 4
shr dx, cl
mov ax, 0x3100
int 0x21