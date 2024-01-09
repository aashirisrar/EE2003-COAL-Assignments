[org 0x100]
jmp start
	array1:dw 1,2
	array2:dw 5,4
	size:dw 2
	result:dw 0


start:
	mov di,0
	mov si,0
	sub sp,2
	push array1
	push array2
	push word[size]
	call series

series:

	sub sp,2
	push word[array1+si]
	push word[array2+si]
	call multiply
	pop dx
	add [result],dx
	add si,2
	add di,1
	cmp di,[size]
	jl series

end:
	mov ax ,0x4c00
	int 21h


multiply:
	mov dx,0
	push bp
	mov bp,sp
	mov ax,[bp+4]
	mov bx,[bp+6]
	
	mov cx,8
checkBit:
	shr bx,1
	jnc skip
	add dx,ax

skip:
	shl ax,1
	dec cx 
	jnz checkBit
	
	mov [bp+8],dx
	pop bp
	ret 4
