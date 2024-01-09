; Infinite Key Printing
[org 0x0100]
jmp start

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
;------------------------------------------------
start: 
call clrscr
mov ax, 0xb800
mov es, ax
mov di, 0

cont:
mov ah, 0 ; service 0 – get keystroke
int 0x16 ; call BIOS keyboard service
add al, 1
mov ah, 0x07
mov [es:di], ax 
jmp cont

mov ax, 0x4c00 ; terminate program
int 0x21