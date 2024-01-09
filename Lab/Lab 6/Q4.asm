[org 0x0100]
jmp start

message: db " " ; string to be printed
length: dw 1

clrscr: 
push es
push ax
push di
mov ax, 0xb800
mov es, ax ; point es to video base
mov di, 0 ; point di to top left column

nextloc: 
mov word [es:di], 0x0720 ; clear next char on screen
add di, 2 ; move to next screen location
cmp di, 4000 ; has the whole screen cleared
jne nextloc ; if no clear next position

pop di
pop ax
pop es
ret

printstr: 
push bp
mov bp, sp

push es
push ax
push cx
push si
push di

mov ax, 0xb800
mov es, ax ; point es to video base
mov al, 80 ; load al with columns per row
mul byte [bp+10] ; multiply with y position
add ax, [bp+12] ; add x position
shl ax, 1 ; turn into byte offset
mov di, ax ; point di to required location
mov si, [bp+6] ; point si to string
mov cx, 60 ; number of cols (till where we need to print)
mov ah, [bp+8] ; load attribute in ah


nextcharA: 
cmp cx, 60
je d

cmp cx, 1
je e
jmp skip

d:
e:
mov al, [si] ; load next char of string
mov [es:di], ax ; show this char on screen
skip:
add di, 2 ; move to next screen location
loop nextcharA ; repeat the operation cx times



pop di
pop si
pop cx
pop ax
pop es
pop bp
ret 10

printStrHorizontal: 
push bp
mov bp, sp

push es
push ax
push cx
push si
push di

mov ax, 0xb800
mov es, ax ; point es to video base
mov al, 80 ; load al with columns per row
mul byte [bp+10] ; multiply with y position
add ax, [bp+12] ; add x position
shl ax, 1 ; turn into byte offset
mov di, ax ; point di to required location
mov si, [bp+6] ; point si to string
mov cx, 60 ; number of cols (till where we need to print)
mov ah, [bp+8] ; load attribute in ah


nextcharB: 
cmp cx, 60
je a
cmp cx, 1
je b
mov al, [si] ; load next char of string
mov [es:di], ax ; show this char on screen
a:
b:
add di, 2 ; move to next screen location
loop nextcharB ; repeat the operation cx times


pop di
pop si
pop cx
pop ax
pop es
pop bp
ret 10


start: 
call clrscr ; call the clrscr subroutine

mov ax, 10
push ax ; push x position
mov ax, 2
push ax ; push y position
mov ax, 01000000b 
push ax ; push attribute
mov ax, message
push ax ; push address of message
push word [length] ; push message length
call printStrHorizontal ; call the printstr subroutine


mov ax, 10
push ax ; push x position
mov ax, 20
push ax ; push y position
mov ax, 01000000b 
push ax ; push attribute
mov ax, message
push ax ; push address of message
push word [length] ; push message length
call printStrHorizontal ; call the printstr subroutine

mov dx, 2

mov cx, 17
m:
mov ax, 10
push ax ; push x position
inc dx
mov ax, dx
push ax ; push y position
mov ax, 01000000b 
push ax ; push attribute
mov ax, message
push ax ; push address of message
push word [length] ; push message length
call printstr ; call the printstr subroutine
loop m

mov ax, 0x4c00 ; terminate program
int 0x21

