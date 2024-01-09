[org 0x0100]

mov ax, 0xb800 ; load video base in ax
mov es, ax ; point es to video base
mov di, 0 ; point di to top left column
underscore:
mov word [es:di], 0x075f ; clear next char on screen
add di, 2 ; move to next screen location
cmp di, 2080 ; has the whole screen cleared
jne underscore ; if no clear next position

dot:
mov word [es:di], 0x072E ; clear next char on screen
add di, 2 ; move to next screen location
cmp di, 4000 ; has the whole screen cleared
jne dot ; if no clear next position

mov ax, 0x4c00 ; terminate program
int 0x21