lis $4
.word 4
mult $2, $4
mflo $5
add $5, $1, $5
beq $5, $1, 6
sub $5, $5, $4
lw $7, 0($5)
slt $6, $7,$3
bne $6, $0, 1
lw $3, 0($5)
beq $0, $0, -7
jr $31
