beq $2, $0, 8
lis $4
.word 4
mult $2, $4
mflo $5
sub $5, $5, $4
add $5, $1, $5
lw $3, 0($5)
beq $0, $0, 3
lis $6
.word -1
add $3, $0, $6
jr $31
