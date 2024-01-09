[org 0x100]

mov ax,0x5CAA
mov dx,0x3729
mov cx,0x235A

xor al, dl ; al=83 , dl=29 , cl=5A , cf=0 , of=0 ,sf=1 
add dl, dl ; al=83 , dl=52 , cl=5A , cf=0 , of=0 ,sf=0  
sub cl, dl ; al=83 , dl=52 , cl=08 , cf=0 , of=0 ,sf=0 
sar al, cl ; al=FF , dl=52 , cl=08 , cf=1 , of=0 ,sf=1 
adc al, dl ; al=52 , dl=52 , cl=08 , cf=1 , of=0 ,sf=0 
 
mov ax, 0x4c00
int 21h

