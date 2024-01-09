[org 0x100]

mov al, [p]
mov bl, [q]
mov cl, [r]

cmp al, bl
jg m
cmp al, cl
jg l
mov [smallest], al
jmp exit
l:
mov [smallest], cl
jmp exit

m:
cmp bl, cl
jg n
mov [smallest], bl
jmp exit
n:
mov [smallest], cl

exit:
mov ax, 0x4c00 ; termination statements
int 21h

p: db 42
q: db 18
r: db 30
smallest: db 0
