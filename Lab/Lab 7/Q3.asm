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

lengthStr:
push bp
mov bp, sp
push es
push cx
push di

les di, [bp+4]
mov cx, 0xFFFF
xor al, al

repne scasb

mov ax, 0xFFFF
sub ax, cx
dec ax

pop di 
pop cx 
pop es
pop bp
ret

cmpStr:
push bp
mov bp, sp
mov cx, [bp+6]
mov si, 0
p:
mov dl, [string+si]
cmp dl, [substring]
jne q
; check if the whole substring is equal
push cx
mov di, si
mov bx, 0
mov cx, [bp+4]
r:
mov dl, [string+di]
cmp dl, [substring+bx]
jnz notEqual
inc di
inc bx
dec cx
jnz r
jmp equal

notEqual:
pop cx
q:
inc si
loop p

; print as it
a:

pop bp
ret

equal:
; original string si -> di highlight (length of substring times)

 
mov ax, 0xb800
mov es, ax
mov bx, 0
mov di, 0
mov cx, [bp+6]
mov ah, 0x07
s:
mov al, [string+bx]
cmp si, bx
je z
mov [es:di], ax
add di, 2
inc bx
x:
loop s

pop cx

jmp a

z:
push cx
mov ah, 0x30
mov cx, [bp+4]

y:
mov al, [string+bx]
mov [es:di], ax
add di, 2
inc bx
loop y

mov dx, [bp+4]
pop cx
sub cx, dx
inc cx
mov ah, 0x07
jmp x


start:
call clrscr ; call the clrscr subroutine

; calculate the length of string
; calculate the length of substring
push ds
mov ax, string
push ax
call lengthStr

push ax

push ds
mov ax, substring
push ax
call lengthStr

pop bx
pop bx
push ax

call cmpStr

pop ax
pop ax
pop ax
pop ax

mov ax, 0x4c00
int 21h

string: db 'I am a student of COAL', 0
substring: db 'student', 0
