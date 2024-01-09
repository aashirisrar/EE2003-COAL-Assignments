[org 0x100]
 
jmp start

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

compStr:
mov bx, 0
mov di, 0

a:
mov al, [str+di]

cmp al, [str+di+1]
je skip
mov [tempstr+bx], al
inc bx
skip:
inc di
cmp byte [str+di], 0
jne a

mov byte [tempstr+bx], 0

;placing elements in the original array
mov si, 0
mov di, 0
b:
mov al, [tempstr+si]
mov [str+di], al
inc di
inc si
cmp byte [tempstr+si], 0
jne b

mov byte [str+di], 0

ret

printStr:
mov ax, 0xb800
mov es, ax
mov di, 0
mov si, 0

mov ah, 0x07
l:
mov al, [str+si]
mov [es:di], ax
add di, 2 
inc si
cmp byte [str+si], 0
jne l

ret

start:
call clrscr
mov ax, str
push ax
call compStr
call printStr
 
mov ax, 0x4c00
int 21h

str: db 'gggdddddddyyyyakxxxuww', 0
tempstr: db 0