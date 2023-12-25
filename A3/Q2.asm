[org 0x100]
 
jmp st

t dw 2
b dw 10
l dw 2
r dw 15

copyareatocenter:
push bp
mov bp, sp
pusha

mov ax, 0xb800
mov es, ax

mov bx, 39
mov dx, 12

mov cx, [bp+4]
sub cx,[bp+8]
push cx
mov ax, cx
sub ax, 2
shr ax, 1

sub bx, ax 

mov cx, [bp+6]
sub cx,[bp+10]
push cx
mov ax, cx
sub ax, 1
shr ax, 1

sub dx, ax

mov ax, 80
dec byte [bp+10]
mul byte [bp+10] 
dec byte [bp+8]
add ax, [bp+8]
shl ax, 1
mov si, ax

mov ax, 80
mul dx
add ax, bx
shl ax, 1
mov di, ax

pop ax 
pop cx

push es
pop ds

mov bx, 0

m:
push si
push di
push cx
rep movsw
pop cx
pop di
pop si
add si, 160
add di, 160
inc bx
cmp bx, ax
jnz m

popa
pop bp
ret

st:
mov ax,  [t]
push ax
mov ax,  [l]
push ax
mov ax,  [b]
push ax
mov ax,  [r]
push ax
call copyareatocenter

mov ax, 0x4c00
int 21h