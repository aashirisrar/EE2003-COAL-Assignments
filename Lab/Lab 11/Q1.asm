[org 0x0100]

	jmp start


ms:		dw 0 						

count:  dw 0, 0, 0, 0, 0 			
tCount: dw -1  			

iNo : dw 0
location: db 0			

clrscr:			pusha
				push es

				mov ax, 0xb800
				mov es, ax
				xor di,di
				mov ax,0x0720
				mov cx,2000

				cld
				rep stosw
				pop es
				popa
				ret

printStars:		pusha
				push es
				mov ax, 0xb800
				mov es, ax

				mov al, 80
				mul byte [cs:location]
				add ax, 159
				shl ax, 1

				mov di, ax

				mov cx, [cs:tCount]

				cmp cx, 0 
				jle return


l1:				mov byte [es:di], '*'
				inc byte [cs:location]
				add di, 160
				loop l1

return:			pop es
				popa
				ret



CTS:			pusha
				cmp word [cs:iNo], 10
				jz l2

				add word [cs:ms], 55
				cmp word [cs:ms], 1000
				jl EOI2

				mov word [cs:ms], 0 	
				call printStars 				

				mov ax, [cs:tCount]
				mov bx, [cs:iNo]

				mov word [cs:count + bx], ax

				mov word [cs:tCount], 0
				add word [cs:iNo], 2

				jmp EOI2			



l2:				add word [cs:ms], 55
				cmp word [cs:ms], 1000
				jl EOI2

				mov word [cs:ms], 0 			


				mov dx, 0

				mov ax, [cs:count + 2]
				add dx, ax
				mov [cs:count], ax

				mov ax, [cs:count + 4]
				add dx, ax
				mov [cs:count + 2], ax


				mov ax, [cs:count + 6]
				add dx, ax
				mov [cs:count + 4], ax

				mov ax, [cs:count + 8]
				add dx, ax
				mov [cs:count + 6], ax

				mov ax, [cs:tCount]
				add dx, ax
				mov [cs:count + 8], ax

				jmp a1


EOI2:			jmp EOI 							

a1:				mov [cs:tCount], dx

				call clrscr

				mov byte [cs:location], 0
				call printStars

				mov word [cs:tCount], 0

EOI:			mov al, 0x20
				out 0x20, al



exit:			popa
				iret


kbisr:	push ax

		in al, 0x60

		shl al, 1
		jnc EOI1

		inc word [cs:tCount] 	

EOI1:	mov al, 0x20
		out 0x20, al
		pop ax

		iret

start:			mov ax, 0
				mov es, ax

				mov bx, 0

				call clrscr
				cli

				mov word [es: 9*4], kbisr
				mov [es:9*4+2], cs

				mov word [es:8*4], CTS
				mov [es:8*4+2], cs

				sti 

				mov dx, start 					
				add dx, 15					
				mov cl, 4
				shr dx, cl 						

end:			mov ax, 0x3100					
				int 21h