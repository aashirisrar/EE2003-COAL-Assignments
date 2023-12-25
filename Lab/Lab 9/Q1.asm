[org 0x100]

jmp start

msg1: db "Hi! I am YourName."
msg2: db "I am YourMode(Happy, Sad, etc)."
msg3: db "I Study at FAST."
msg4: db "My Roll No is YourRoll#."

clrscr: 
 push es 
 push ax 
 push di 
 mov ax, 0xb800 
 mov es, ax ; point es to video base 
 mov di, 0 ; point di to top left column
 nextloc: mov word [es:di], 0x0720 ; clear next char on screen 
 add di, 2 ; move to next screen location 
 cmp di, 4000 ; has the whole screen cleared 
 jne nextloc ; if no clear next position 
 pop di 
 pop ax 
 pop es 
 ret 

printFirst:
 mov ah, 0x13 ; service 13 - print string 
 mov al, 1 ; subservice 01 – update cursor 
 mov bh, 0 ; output on page 0 
 mov bl, 7 ; normal attrib 
 mov dx, 0x0000 ; row 10 column 3 
 mov cx, 18 ; length of string 
 push cs 
 pop es ; segment of string 
 mov bp, msg1 ; offset of string 
 int 0x10 ; call BIOS video service 
ret

printSecond:
 mov ah, 0x13 ; service 13 - print string 
 mov al, 1 ; subservice 01 – update cursor 
 mov bh, 0 ; output on page 0 
 mov bl, 7 ; normal attrib 
 mov dx, 0x0100 ; row 10 column 3 
 mov cx, 31 ; length of string 
 push cs 
 pop es ; segment of string 
 mov bp, msg2 ; offset of string 
 int 0x10 ; call BIOS video service 
ret

printThird:
 mov ah, 0x13 ; service 13 - print string 
 mov al, 1 ; subservice 01 – update cursor 
 mov bh, 0 ; output on page 0 
 mov bl, 7 ; normal attrib 
 mov dx, 0x0200 ; row 10 column 3 
 mov cx, 16 ; length of string 
 push cs 
 pop es ; segment of string 
 mov bp, msg3 ; offset of string 
 int 0x10 ; call BIOS video service 
ret

printFourth:
 mov ah, 0x13 ; service 13 - print string 
 mov al, 1 ; subservice 01 – update cursor 
 mov bh, 0 ; output on page 0 
 mov bl, 7 ; normal attrib 
 mov dx, 0x0300 ; row 10 column 3 
 mov cx, 24 ; length of string 
 push cs 
 pop es ; segment of string 
 mov bp, msg4 ; offset of string 
 int 0x10 ; call BIOS video service 
ret


start: 
call clrscr

mov ah, 0
int 16h
call printFirst

mov ah, 0
int 16h
call printSecond

mov ah, 0
int 16h
call printThird

mov ah, 0
int 16h
call printFourth
 
mov ax, 0x4c00
int 21h