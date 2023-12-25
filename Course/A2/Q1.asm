[org 0x100]

start:
mov ax, [num] 
mov cx, 8         
mov bl, 0         

rotate:
shr al, 1          ; Shift AX right by 1 bit (remove the least significant bit)
rcl bl, 1          ; Rotate the carry flag (CF) into BL
dec cx             ; Decrement the loop counter
jnz rotate         ; Repeat the loop until all bits are processed

cmp ah, bl         ; Compare the two numbers
jne notEqual 
mov dx,1           ; Set DX to 1 (indicating it's a palindrome)
jmp end

notEqual:
mov dx, 0          ; Set DX to 0 (indicating it's not a palindrome)

end:
mov ax, 0x4C00     
int 21h

num: dw 0xA425