lis $9
.word 0xffff000c
lis $4
.word 4
mult $2,$4
mflo $5
add $5,$1,$5
lis $6
.word 32
lis $7
.word 64
beq $1,$5,8
lw $8, 0($1)
beq $8, $0, 2
add $8, $8,$7
beq $0,$0,1
add $8,$8,$6
sw $8, 0($9)
add $1,$1,$4
beq $0,$0,-9
jr $31
