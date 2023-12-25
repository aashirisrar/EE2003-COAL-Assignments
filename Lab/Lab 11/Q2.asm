[org 0x0100]
 jmp start
seconds: dw 0
counter: dw 0
timerflag: dw 1
oldkb: dd 0

; keyboard interrupt service routine
kbisr: 
 push ax
 in al, 0x60 ; read char from keyboard port
;  cmp al, 0x2a ; has the left shift pressed
 mov word [cs:timerflag], 1; set flag to start printing
 call setColor
 mov word [cs:seconds], 0
 jmp exit ; leave the ISR

exit: mov al, 0x20
 out 0x20, al ; send EOI to PIC
 pop ax
 iret ; return from interrupt
 
printnum: 
push bp
mov bp, sp
push es
push ax
push bx
push cx
push dx
push di
mov ax, 0xb800
mov es, ax ; point es to video base
mov ax, [bp+4] ; load number in ax
mov bx, 10 ; use base 10 for division
mov cx, 0 ; initialize count of digits
nextdigit: mov dx, 0 ; zero upper half of dividend
div bx ; divide by 10
add dl, 0x30 ; convert digit into ascii value
push dx ; save ascii value on stack
inc cx ; increment count of values
cmp ax, 0 ; is the quotient zero
jnz nextdigit ; if no divide it again
mov di, 140 ; point di to 70th column
nextpos: pop dx ; remove a digit from the stack
mov dh, 0x07 ; use normal attribute
mov [es:di], dx ; print char on screen
add di, 2 ; move to next screen location
loop nextpos ; repeat for all digits on stack
pop di
pop dx
pop cx
pop bx
pop ax
pop es
pop bp
ret 2

timer: 
push ax
cmp word [cs:timerflag], 1 ; is the printing flag set
jne skipall ; no, leave the ISR

inc word [cs:counter] ; increment tick count
cmp word [cs:counter], 18
jne skipall
mov word [cs:counter], 0
inc word [cs:seconds] ; increment tick count

cmp word [cs:seconds], 10
jne s

mov word [cs:timerflag], 0 ; clear the printing flag
call changeColor

s:
push word [cs:seconds]
call printnum ; print tick count

skipall: mov al, 0x20
out 0x20, al ; send EOI to PIC
pop ax
iret ; return from interrupt

changeColor:
push bp
pusha 

mov ax, 0xb800
mov es, ax
mov di, 0

mov cx, 2000
mov ax, 0x1720
cld
rep stosw 
popa
pop bp

ret

; subroutine to clear the screen
clrscr: push es
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

setColor:
push bp
pusha 

mov ax, 0xb800
mov es, ax
mov di, 0

mov cx, 2000
mov ax, 0x2720
cld
rep stosw 

popa
pop bp
ret

start: 
 call clrscr
 call setColor
 xor ax, ax
 mov es, ax ; point es to IVT base
 mov ax, [es:9*4]
 mov [oldkb], ax ; save offset of old routine
 mov ax, [es:9*4+2]
 mov [oldkb+2], ax ; save segment of old routine
 cli ; disable interrupts
 mov word [es:9*4], kbisr ; store offset at n*4
 mov [es:9*4+2], cs ; store segment at n*4+2
 mov word [es:8*4], timer ; store offset at n*4
 mov [es:8*4+2], cs ; store segment at n*4+
 sti ; enable interrupts
 mov dx, start ; end of resident portion
 add dx, 15 ; round up to next para
 mov cl, 4
 shr dx, cl ; number of paras
 mov ax, 0x3100 ; terminate and stay resident
 int 0x21 
