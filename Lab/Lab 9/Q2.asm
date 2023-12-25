[org 0x0100]

jmp start

t dw 11
l dw 38 
b dw 15
r dw 42

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

mov word [es:di], 0x075F

popa
pop bp
ret

up:
cmp di, 2000
je s

cmp di, 1998
je s

call clrscr

mov ax, [t]
push ax
mov ax, [l]
push ax
mov ax, [b]
push ax
mov ax, [r]
push ax
call printbox

sub di, 160

mov word [es:di], 0x075F
s:
jmp cont

down:
cmp di, 2160
je p

cmp di, 2158
je p


call clrscr

mov ax, [t]
push ax
mov ax, [l]
push ax
mov ax, [b]
push ax
mov ax, [r]
push ax
call printbox

add di, 160

mov word [es:di], 0x075F

p:
jmp cont

left:
cmp di, 1998
je q

cmp di, 2158
je q

call clrscr

mov ax, [t]
push ax
mov ax, [l]
push ax
mov ax, [b]
push ax
mov ax, [r]
push ax
call printbox

sub di, 2

mov word [es:di], 0x075F

q:
jmp cont

right:
cmp di, 2000
je u

cmp di, 2160
je u


call clrscr

mov ax, [t]
push ax
mov ax, [l]
push ax
mov ax, [b]
push ax
mov ax, [r]
push ax
call printbox

add di, 2

mov word [es:di], 0x075F

u:
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

printbox:
push bp 
mov bp, sp
pusha

mov ax, 0xb800
mov es, ax
mov di, 0

;[bp+10] top
;[bp+8] left
;[bp+6] bottom
;[bp+4] right

;calculate the start pos
mov ax, [bp+10] ;top
mov bx, 80
mul bx
add ax, [bp+8] ;left
shl ax, 1
mov di, ax

;calculate the height
mov ax, [bp+6] ;bottom
sub ax, [bp+10] ;top
mov cx, ax
mov si, cx

;calculating the end pos for di
mov ax, [bp+4] ;right
sub ax, [bp+8] ;left
mov dx, ax

;starting to print
outerloop:
cmp cx, si
je printcomplete
cmp cx, 1
je printcomplete

mov dx, ax
innerloop:
cmp dx, ax
je print
cmp dx, 1
je print
jmp skip
print:
mov word [es:di], 0x0741
skip:
add di, 2
dec dx
jnz innerloop
a:
mov dx, ax
shl dx, 1
sub di, dx
add di, 160
loop outerloop

popa
pop bp
ret 8

printcomplete:
;starting to print
mov dx, ax
i:
mov word [es:di], 0x0741
add di, 2
dec dx
jnz i
jmp a

start: 
call clrscr
mov ax, [t]
push ax
mov ax, [l]
push ax
mov ax, [b]
push ax
mov ax, [r]
push ax
call printbox
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