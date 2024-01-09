[org 0x100]

mov al, [x]
mov bl, [y]
mov cl, [z]

;if(x>y)
cmp al, bl
jl m
;if(x>z)
cmp al, cl
jl q
sub al, cl
mov [result], al
jmp exit
;else
q:
sub cl, al
mov [result], cl
jmp exit

;else
m:
;if(y>z)
cmp bl, cl
jl r
sub bl, cl
mov [result], bl
jmp exit
;else
r:
sub cl, bl
mov [result], cl

exit:
mov ax, 0x4c00 ; termination statements
int 21h


x: db 8
y: db 15
z: db 20
result: db 0
