[org 0x100]
 
mov bx, 1011000110001001b
mov dx, 1
mov cx , 16
mov bp, 0

; testing for number of 1's
l:
test bx, dx
jz a
inc bp
a:
dec cx
shl dx, 1
jnz l

;inverting the last num of bits
mov ax, 1010101110100101b
mov dx, 1

m:
xor ax, dx
shl dx, 1
dec bp
jnz m
 
mov ax, 0x4c00
int 21h


