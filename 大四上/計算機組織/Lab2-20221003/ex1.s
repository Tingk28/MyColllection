main:
addi x18,x0,10 //a
addi x19,x0,-16 //b
addi x20,x0,-40 //c
addi x6,x0,0 //sum
andi x21,x18,3 //d
slli x22,x19,3 //b*8
srai x23,x18,3 //a/8
add x6,x22,x23 
srai x22, x19,2 //b/4
addi x23,x22,36
slli x24,x23,3
add x24,x24,x23
add x6,x6,x24
slli x22,x18,2
srai x23,x18,1
sub x24,x22,x23
add x6,x6,x24
sub x6,x6,x21
bge x0,x20,Else
add x6,x6,x20
beq x0,x0,Exit
Else:
addi x22,x0,-1
add x23,x20,x0
xor x24,x22,x23
addi x24,x24,1
add x6,x6,x24
beq x0,x0,Exit
Exit:
return
