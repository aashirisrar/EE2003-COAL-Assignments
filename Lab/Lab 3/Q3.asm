[org 0x100]

mov si, 0
mov bx, 0
mov di, 0

mov cl, [len1]
mov ch, [len2]

outerLoop:
	mov ah, [arr1+si]
    mov bx, 0
    mov ch, [len2]

	innerLoop:
		mov al, [arr2+bx]
		cmp ah, al
		jne p
		mov [arr3+di], ah
		inc di
		p:
		inc bx
	    dec ch
	jnz innerLoop

inc si
dec cl
jnz outerLoop

mov ax, 0x4c00
int 21h

len1: db 5
len2: db 5 

arr1: db 1, 4, 5, 6, 7
arr2: db 5, 3, 1, 2, 8
arr3: db 0
