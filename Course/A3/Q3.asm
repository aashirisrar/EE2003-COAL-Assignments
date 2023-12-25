[org 0x100]
 
jmp start

swap1with4:
mov ax, 0xb800
mov es, ax
mov di, 0
mov si, 2000

mov cx, 12
q:
push cx
mov cx, 40
p:
mov ax, [es:si]
mov bx, [es:di]
mov word [es:di], ax
mov word [es:si], bx
add si,2
add di,2
loop p
pop cx
add di, 80
add si, 80
loop q

jmp start

swap2with3:
mov ax, 0xb800
mov es, ax
mov di, 80
mov si, 1920

mov cx, 12
s:
push cx
mov cx, 40
t:
mov ax, [es:si]
mov bx, [es:di]
mov word [es:di], ax
mov word [es:si], bx
add si,2
add di,2
loop t
pop cx
add di, 80
add si, 80
loop s
jmp start

start:
mov ah, 0
int 16h

cmp al, 0x31
je swap1with4

cmp al, 0x32
je swap2with3


mov ax, 0x4c00
int 21h