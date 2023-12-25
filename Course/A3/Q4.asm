[org 0x100]
 
jmp start

message1: db 'happy'
message2: db 'unhappy'

clrscr:
 push es 
 push ax 
 push cx 
 push di 
 mov ax, 0xb800 
 mov es, ax 
 xor di, di 
 mov ax, 0x0720 
 mov cx, 2000  
 cld 
 rep stosw 
 pop di 
 pop cx 
 pop ax 
 pop es 
ret

happy:
 mov ah, 0x13 
 mov al, 1
 mov bh, 0 
 mov bl, 7
 mov dx, 0
 mov cx, 5
 push cs 
 pop es
 mov bp, message1
 int 0x10
jmp exit

unhappy:
 mov ah, 0x13 
 mov al, 1
 mov bh, 0 
 mov bl, 7
 mov dx, 0
 mov cx, 7
 push cs 
 pop es
 mov bp, message2 
 int 0x10 
jmp exit


start:
call clrscr
; for getting the 4 digit number and squaring and adding them and placing the final result in si
mov di, 0
mov cx, 4
mov bx, 10
mov si, 0

q:
mov ah, 0
int 16h
sub al, 48
mov ah, 0 ; result = result * 10 + digit
mov di, ax ; digit
mov ax, si
mul bx
mov si, ax
add si, di
loop q

mov di, si

mov cx, 256
p:
mov ax, di
mov dx, 0
mov bx, 10
mov di, 0
push cx
mov cx, 4
l:
div bx
push ax
mov ax, dx
mul ax
add di, ax
pop ax
mov dx, 0
loop l
pop cx
cmp di, 1
je happy
loop p

jmp unhappy

exit:
mov ax, 0x4c00
int 21h