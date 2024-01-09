[org 0x0100]
jmp start


;;;;; COPY LINES 005-024 FROM EXAMPLE 7.1 (clrscr) ;;;;;
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

printasterik:
push bp
mov bp, sp
pusha

mov ax, 0xb800
mov es, ax
mov di, 2000

mov word [es:di], 0x072A

popa
pop bp
ret

up:
call clrscr

sub di, 160

mov word [es:di], 0x072A

jmp cont

down:
call clrscr

add di, 160

mov word [es:di], 0x072A

jmp cont

left:
call clrscr

sub di, 2

mov word [es:di], 0x072A

jmp cont

right:
call clrscr

add di, 2

mov word [es:di], 0x072A

jmp cont

customISRforINT80h:
push bp
mov bp, sp

push ax

d:

mov ah, 0
int 0x16


cmp ah, 0x48
je up

cmp ah, 0x50
je down

cmp ah, 0x4D
je right

cmp ah, 0x4B
je left

cont:
jmp d


start: 
call clrscr
call printasterik
xor ax, ax
mov es, ax ; load zero in es
mov di, 2000
mov word [es:80h*4], customISRforINT80h ; store offset at n*4
mov [es:80h*4+2], cs ; store segment at n*4+2
mov ax, 0xb800
mov es, ax
int 80h

mov ax, 0x4c00 ; terminate program
int 0x21