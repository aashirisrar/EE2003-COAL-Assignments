[org 0x100]

; first sort the array using bubble sort
start: 
mov bx, 0
mov cx, [sizeArr]
dec cx
mov byte [swap], 0

loop1: 
mov al, [array1+bx] 
cmp al, [array1+bx+1] 
jbe noswap 

mov dl, [array1+bx+1]
mov [array1+bx+1], al 
mov [array1+bx], dl 
mov byte [swap], 1 

noswap: 
inc bx
loop loop1 

cmp byte [swap], 1 
je start 

;putting even and odd numbers in separate arrays
mov si, 0
mov di, 0
mov bx, 0
mov ax, 0
mov dx, 0
; 
mov cx, [sizeArr]
; 
l:
mov al, [array1+si]
test al, 1
jz even
; for odd
mov [oddArr+bx], al
inc bx
continue:
inc si
loop l
jmp c
; 
even: 
mov [evenArr+di], al
inc di
jmp continue

c: ; putting elements back in the original array
mov cx, di
mov si, 0
mov di, 0
p: ; putting even numbers
mov al, [evenArr+si]
mov [array1+di], al
inc si
add di, 2 
loop p
 
; putting odd numbers
mov cx, bx
mov si, 0
mov di, 1
q:
mov al, [oddArr+si]
mov [array1+di], al
inc si
add di, 2 
loop q
 
mov ax, 0x4c00
int 21h

swap: db 0
sizeArr: dw 6
array1: db 10,17,6,5,11,8
evenArr: db 0,0,0,0,0,0
oddArr: db 0,0,0,0,0,0