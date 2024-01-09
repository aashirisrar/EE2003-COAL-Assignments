[org 0x100]

jmp start

swap:
push ax
push es

mov ax, 0xb800
mov es, ax
mov si, 0
mov di, 960

mov cx, 960

s:
mov ax, word [es:si]
mov dx, word [es:di]

mov word [es:di], ax
mov word [es:si], dx

add si, 2
add di, 2

loop s

pop es
pop ax
ret

start:
call swap

exit: 
mov ax, 0x4c00
int 21h