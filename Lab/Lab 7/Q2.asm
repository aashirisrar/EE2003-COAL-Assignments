[org 0x0100]
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
mov dl, [bp+8]
mov dh, 0x0070

mov bh,[bp+6]; starting row
mov bl,[bp+4]; ending row

mov di, 80 ; middle
mov cl, 160; row length
mov al, [bp+6]; moving starting row into al
mul cl

add di,ax ;reached tip of triangle
mov cx,0
sub bl,bh
mov cl,bl

nextchar:
mov word [es:di], dx ; show this char on screen
sub di, 2 ; move to previous screen location
add di, 160
loop nextchar ; repeat the operation cx times

mov cx,0
mov bh,[bp+6]; starting row
mov bl,[bp+4]; ending row
sub bl,bh
mov cl,bl
shl cx,1


nextchar1:
mov word [es:di], dx ; show this char on screen
add di, 2 ; move to next screen location

loop nextchar1 ; repeat the operation cx times

mov cx,0
mov bh,[bp+6]; starting row
mov bl,[bp+4]; ending row
sub bl,bh
mov cl,bl

nextchar2:
mov word [es:di], dx ; show this char on screen
sub di, 162 ;move to previous location

loop nextchar2; repeat the operation cx times

pop di
pop si
pop cx
pop ax
pop es
pop bp
ret 8


start: 
call clrscr ; call the clrscr subroutine
mov ax,[character]
push ax ; push "%"

mov ax,[startrow]
push ax ; push starting row

mov ax,[endrow]
push ax ; push ending row

call printstr ; call the printstr subroutine
mov ax, 0x4c00 ; terminate program
int 0x21

character: db '%' 
startrow: db 3
endrow: db 20