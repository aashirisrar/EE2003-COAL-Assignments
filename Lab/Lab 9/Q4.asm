[org 0x0100]

jmp start

msg1 db "A key is pressed"
msg2 db "A key is released"

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

; keyboard interrupt service routine 
kbisr: 
 push ax 
 push es 
 mov ax, 0xb800 
 mov es, ax ; point es to video memory 
 in al, 0x60 ; read a char from keyboard port 
 cmp al, 00101010b ; is the key left shift pressed
 jne nextcmp ; no, try next comparison 

 ;-------------------
; bios video service for strings
 call clrscr
 mov ah, 0x13 ; service 13 - print string 
 mov al, 1 ; subservice 01 – update cursor 
 mov bh, 0 ; output on page 0 
 mov bl, 7 ; normal attrib 
 mov dx, 0x0000  ; row 10 column 3 
 mov cx, 16 ; length of string 
 push cs 
 pop es ; segment of string

 mov bp, msg1 ; offset of string
 int 0x10 ; call BIOS video service 
 ;-------------------

 jmp nomatch ; leave interrupt routine 
nextcmp: 
 call clrscr
 cmp al, 10101010b ; is the key left shift released
 jne nomatch ; no, leave interrupt routine 
 ; bios video service for strings
mov ah, 0x13 ; service 13 - print string 
 mov al, 1 ; subservice 01 – update cursor 
 mov bh, 0 ; output on page 0 
 mov bl, 7 ; normal attrib 
 mov dx, 0x0000  ; row 10 column 3 
 mov cx, 17 ; length of string 
 push cs 
 pop es ; segment of string

 mov bp, msg2 ; offset of string
 int 0x10 ; call BIOS video service  
nomatch: 
 mov al, 0x20 
 out 0x20, al ; send EOI to PIC 
 pop es 
 pop ax 
iret 

start: 
call clrscr
 
xor ax, ax 
mov es, ax ; point es to IVT base 
cli ; disable interrupts 
mov word [es:9*4], kbisr ; store offset at n*4 
mov [es:9*4+2], cs ; store segment at n*4+2 
sti ; enable interrupts

mov ax, 0x4c00 ; terminate program
int 0x21