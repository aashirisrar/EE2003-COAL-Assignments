[org 0x100]
 
jmp start

flip:
push bp
mov bp, sp
pusha

mov ax, 0xb800
mov es, ax
mov si, 0
mov di, 3998

mov cx, 1960

p:
mov bx, [es:si]
mov [es:di], bx
add si, 2
sub di, 2
loop p


popa
popa
ret

start:
call flip
 
mov ax, 0x4c00
int 21h