[org 0x0100]

jmp dummystart

array:  dw  1,  2,  3,  4
size:   db  4
direction: dw 1
count:  db  1

rotateLeft: 
push bp
mov bp, sp
            add bp, 4
            mov dx, [bp]
            mov cx, [bp + 2]
            dec cl
            mov si, [bp + 4]
            mov di, [bp + 6]
            cmp dx, 1
            je rotateRight
            
            innerloop:  mov ax, [di]
                        xchg [si],    ax
                        mov [di],   ax
                        add si, 2
                        add di, 2
                        dec cl
                        jnz innerloop
                        jmp  here

rotateRight:    add si, 6
                mov di, si
                sub di, 2

rotation:       mov ax, [si]
                xchg [di],  ax
                mov [si],   ax
                sub di, 2
                sub si, 2
                dec cl
                jnz rotation
                jmp here



dummystart:  mov ch, [count]
start:  mov cl, [size]
        mov dx, [direction]
        mov si, array
        mov di, si
        add di, 2

        push di
        push si
        push cx
        push dx


        call rotateLeft
here:   dec ch
        jnz start 

terminate:  mov ax,0x4c00
            int 0x21