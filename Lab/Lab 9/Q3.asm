[org 0x0100]

jmp start

year: dw '0'
month: dw '0'
day: dw '0'

jan: db "Jan"
feb: db "Feb"
mar: db "Mar"
apr: db "Apr"
may: db "May"
jun: db "Jun"
jul: db "Jul"
aug: db "Aug"
sep: db "Sep"
oct: db "Oct"
nov: db "Nov"
dece: db "Dec"

mon: db "Mon"
tue: db "Tue"
wed: db "Wed"
thu: db "Thu"
fri: db "Fri"
sat: db "Sat"
sun: db "Sun"

monday:
mov bp, mon
jmp n

tuesday:
mov bp, tue
jmp n

wednesday:
mov bp, wed
jmp n

thursday:
mov bp, thu
jmp n

friday:
mov bp, fri
jmp n

saturday:
mov bp, sat
jmp n

sunday:
mov bp, sun
jmp n

january:
mov bp, jan
jmp s

february:
mov bp, feb
jmp s

march:
mov bp, mar
jmp s

april:
mov bp, apr
jmp s

may1:
mov bp, may
jmp s

june:
mov bp, jun
jmp s

july:
mov bp, jul
jmp s

august:
mov bp, aug
jmp s

september:
mov bp, sep
jmp s

october:
mov bp, oct
jmp s

november:
mov bp, nov
jmp s

december:
mov bp, dece
jmp s

january2:
mov bp, jan
jmp t

february2:
mov bp, feb
jmp t

march2:
mov bp, mar
jmp t

april2:
mov bp, apr
jmp t

may12:
mov bp, may
jmp t

june2:
mov bp, jun
jmp t

july2:
mov bp, jul
jmp t

august2:
mov bp, aug
jmp t

september2:
mov bp, sep
jmp t

october2:
mov bp, oct
jmp t

november2:
mov bp, nov
jmp t

december2:
mov bp, dece
jmp t

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

backsashone:
 push bp 
 pusha
 
 ;-------------------------------------
 mov ax, 0xb800 
 mov es, ax ; point es to video base 
 mov ax, [day] ; load number in ax 
 mov bx, 10 ; use base 10 for division 
 mov cx, 0 ; initialize count of digits 
nextdigit:
 mov dx, 0 ; zero upper half of dividend 
 div bx ; divide by 10 
 add dl, 0x30 ; convert digit into ascii value 
 push dx ; save ascii value on stack 
 inc cx ; increment count of values 
 cmp ax, 0 ; is the quotient zero 
 jnz nextdigit ; if no divide it again 
 mov di, 0 

nextpos: pop dx ; remove a digit from the stack 
 mov dh, 0x07 ; use normal attribute 
 mov [es:di], dx ; print char on screen 
 add di, 2 ; move to next screen location 
 loop nextpos ; repeat for all digits on stack
 
mov word [es:di], 0x072F
;--------------------------------------------
 mov ax, 0xb800 
 mov es, ax ; point es to video base 
 mov ax, [month] ; load number in ax 
 mov bx, 10 ; use base 10 for division 
 mov cx, 0 ; initialize count of digits 
m: mov dx, 0 ; zero upper half of dividend 
 div bx ; divide by 10 
 add dl, 0x30 ; convert digit into ascii value 
 push dx ; save ascii value on stack 
 inc cx ; increment count of values 
 cmp ax, 0 ; is the quotient zero 
 jnz m ; if no divide it again 
 mov di, 6

l: pop dx ; remove a digit from the stack 
 mov dh, 0x07 ; use normal attribute 
 mov [es:di], dx ; print char on screen 
 add di, 2 ; move to next screen location 
 loop l ; repeat for all digits on stack

mov word [es:di], 0x072F
 ;--------------------------------------------
 mov ax, 0xb800 
 mov es, ax ; point es to video base 
 mov ax, [year] ; load number in ax 
 mov bx, 10 ; use base 10 for division 
 mov cx, 0 ; initialize count of digits 
y:
 mov dx, 0 ; zero upper half of dividend 
 div bx ; divide by 10 
 add dl, 0x30 ; convert digit into ascii value 
 push dx ; save ascii value on stack 
 inc cx ; increment count of values 
 cmp ax, 0 ; is the quotient zero 
 jnz y ; if no divide it again 
 mov di, 12

z: 
 pop dx ; remove a digit from the stack 
 mov dh, 0x07 ; use normal attribute 
 mov [es:di], dx ; print char on screen 
 add di, 2 ; move to next screen location 
 loop z ; repeat for all digits on stack


 popa
 pop bp 
ret

;-----------------------------------------------------------

spaceone:
push bp 
 pusha
 
 ;-------------------------------------
 mov ax, 0xb800 
 mov es, ax ; point es to video base 
 mov ax, [day] ; load number in ax 
 mov bx, 10 ; use base 10 for division 
 mov cx, 0 ; initialize count of digits 
nextdigit2:
 mov dx, 0 ; zero upper half of dividend 
 div bx ; divide by 10 
 add dl, 0x30 ; convert digit into ascii value 
 push dx ; save ascii value on stack 
 inc cx ; increment count of values 
 cmp ax, 0 ; is the quotient zero 
 jnz nextdigit2 ; if no divide it again 
 mov di, 160 

nextpos2: pop dx ; remove a digit from the stack 
 mov dh, 0x07 ; use normal attribute 
 mov [es:di], dx ; print char on screen 
 add di, 2 ; move to next screen location 
 loop nextpos2 ; repeat for all digits on stack
 
mov word [es:di], 0x0720
;--------------------------------------------
; bios video service for strings
mov ah, 0x13 ; service 13 - print string 
 mov al, 1 ; subservice 01 – update cursor 
 mov bh, 0 ; output on page 0 
 mov bl, 7 ; normal attrib 
 mov dx, 0x0103 ; row 10 column 3 
 mov cx, 3 ; length of string 
 push cs 
 pop es ; segment of string

 ; checks for month
 mov si, [month]
 cmp si, 1
 je january
 
 cmp si, 2
 je february

 cmp si, 3
 je march

 cmp si, 4
 je april
 
 cmp si, 5
 je may1
 
 cmp si, 6
 je june
 
 cmp si, 7
 je july 
 
 cmp si, 8
 je august
 
 cmp si, 9
 je september
 
 cmp si, 10
 je october
 
 cmp si, 11
 je november
 
 cmp si, 12
 je december

 s:
 int 0x10 ; call BIOS video service 

mov di, 14
mov word [es:di], 0x0720
 ;--------------------------------------------
 mov ax, 0xb800 
 mov es, ax ; point es to video base 
 mov ax, [year] ; load number in ax 
 mov bx, 10 ; use base 10 for division 
 mov cx, 0 ; initialize count of digits 
y2:
 mov dx, 0 ; zero upper half of dividend 
 div bx ; divide by 10 
 add dl, 0x30 ; convert digit into ascii value 
 push dx ; save ascii value on stack 
 inc cx ; increment count of values 
 cmp ax, 0 ; is the quotient zero 
 jnz y2 ; if no divide it again 
 mov di, 174

z2: 
 pop dx ; remove a digit from the stack 
 mov dh, 0x07 ; use normal attribute 
 mov [es:di], dx ; print char on screen 
 add di, 2 ; move to next screen location 
 loop z2 ; repeat for all digits on stack

 popa
 pop bp 
ret

;-----------------------------------------------------------

dayone:
push bp 
 pusha
 
 ; bios video service for strings
mov ah, 0x13 ; service 13 - print string 
 mov al, 1 ; subservice 01 – update cursor 
 mov bh, 0 ; output on page 0 
 mov bl, 7 ; normal attrib 
 mov dx, 0x0200 ; row 10 column 3 
 mov cx, 3 ; length of string 
 push cs 
 pop es ; segment of string

 push si
 ; checks for day
 mov si, [day]

 cmp si, 1
 je monday
 
 cmp si, 2
 je tuesday

 cmp si, 3
 je wednesday

 cmp si, 4
 je thursday
 
 cmp si, 5
 je friday
 
 cmp si, 6
 je saturday
 
 cmp si, 7
 je sunday
 
 mov bp, fri

 n:
 pop si
 int 0x10 ; call BIOS video service 

mov di, 326
mov word [es:di], 0x0720
 
 ;-------------------------------------
 mov ax, 0xb800 
 mov es, ax ; point es to video base 
 mov ax, [day] ; load number in ax 
 mov bx, 10 ; use base 10 for division 
 mov cx, 0 ; initialize count of digits 
nextdigit3:
 mov dx, 0 ; zero upper half of dividend 
 div bx ; divide by 10 
 add dl, 0x30 ; convert digit into ascii value 
 push dx ; save ascii value on stack 
 inc cx ; increment count of values 
 cmp ax, 0 ; is the quotient zero 
 jnz nextdigit3 ; if no divide it again 
 mov di, 328

nextpos3: pop dx ; remove a digit from the stack 
 mov dh, 0x07 ; use normal attribute 
 mov [es:di], dx ; print char on screen 
 add di, 2 ; move to next screen location 
 loop nextpos3 ; repeat for all digits on stack
 
mov word [es:di], 0x0720
;--------------------------------------------
; bios video service for strings
mov ah, 0x13 ; service 13 - print string 
 mov al, 1 ; subservice 01 – update cursor 
 mov bh, 0 ; output on page 0 
 mov bl, 7 ; normal attrib 
 mov dx, 0x0207  ; row 10 column 3 
 mov cx, 3 ; length of string 
 push cs 
 pop es ; segment of string

 ; checks for month
 mov si, [month]
 cmp si, 1
 je january2
 
 cmp si, 2
 je february2

 cmp si, 3
 je march2

 cmp si, 4
 je april2
 
 cmp si, 5
 je may12
 
 cmp si, 6
 je june2
 
 cmp si, 7
 je july2
 
 cmp si, 8
 je august2
 
 cmp si, 9
 je september2
 
 cmp si, 10
 je october2
 
 cmp si, 11
 je november2
 
 cmp si, 12
 je december2

 t:
 int 0x10 ; call BIOS video service 

mov di, 340
mov word [es:di], 0x0720
 ;--------------------------------------------
 mov ax, 0xb800 
 mov es, ax ; point es to video base 
 mov ax, [year] ; load number in ax 
 mov bx, 10 ; use base 10 for division 
 mov cx, 0 ; initialize count of digits 
y3:
 mov dx, 0 ; zero upper half of dividend 
 div bx ; divide by 10 
 add dl, 0x30 ; convert digit into ascii value 
 push dx ; save ascii value on stack 
 inc cx ; increment count of values 
 cmp ax, 0 ; is the quotient zero 
 jnz y3 ; if no divide it again 
 mov di, 342

z3: 
 pop dx ; remove a digit from the stack 
 mov dh, 0x07 ; use normal attribute 
 mov [es:di], dx ; print char on screen 
 add di, 2 ; move to next screen location 
 loop z3 ; repeat for all digits on stack

 popa
 pop bp 
ret

customISRforINT21h:
call backsashone
call spaceone
call dayone

iret

start: 
call clrscr

mov ah, 0x2A
int 21h

mov word [year], cx
mov byte [month], dh
mov byte [day], dl

xor ax, ax
mov es, ax ; load zero in es
mov di, 2000
mov word [es:21h*4], customISRforINT21h ; store offset at n*4
mov [es:21h*4+2], cs ; store segment at n*4+2
mov ax, 0xb800
mov es, ax
int 21h

mov ax, 0x4c00 ; terminate program
int 0x21