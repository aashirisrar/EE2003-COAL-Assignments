[org 0x100]

mov si, buffer
mov cl, [startBitNum]

shr cl, 3   
and cl, 7
add si, cl
mov al, [si]
mov ah, 0
shl ax, cl
 
mov ax, 0x4c00
int 21h

buffer: db 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32
startBitNum: db 1


