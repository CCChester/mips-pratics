print: 
 
;stores reg on stack 
sw $1, -4($30)  ;value to print 
sw $2, -8($30)  ;value given by user 
sw $3, -12($30) ;stores ascii difference 
sw $4, -16($30) ;stores 4 for stack 
sw $5, -20($30) ;stores print address 
sw $6, -24($30) ;checks if $1 is postive 
sw $7, -28($30) ;negative sign in ascii 
sw $8, -32($30) ; 
sw $9, -36($30) ;store boolean for if $1 is negative 
sw $10, -40($30);stores value 10 for dividing 
sw $11, -44($30) 
sw $12, -48($30);hi reg 
sw $13, -52($30);counter 
sw $14, -56($30);for turning numbers postive (-1) 
sw $15, -60($30);for loading char off stack and printing 
sw $16, -64($30);value for counting (stores a 1) 
sw $31, -68($30)
;sw $17, -70($30) 
;sw $18,        -74($30) 
;sw $19, -78($30) 
;sw $20, -82($30) 
;sw $21, - 
;sw $22, 
;sw $23, 
;sw $24,  
;sw $25, 
;sw $26, 
;sw $27, 
;sw $28, 
 
;move stack pointer 
lis $6; temp value (will get overwritern later) 
.word 68
sub $30, $30, $6 

lis $5		;print address
.word 0xffff000c	
lis $4		;to move along the stack
.word 4
lis $14		;for turning numbers positive
.word -1	
lis $3		;Difference between ASCII and dec
.word 48 	
lis $7		;(-ve) sign in ASCII
.word 45 	
lis $10		;10; to divide by 10
.word 10
lis $16		;1; counter to increment counter
.word 1
lis $8		;stores last negative vale
.word -2147483648

;check if equal to 0
beq $1, $0, isZero
;check if $1 is negative
slt $6, $0, $1  ;$1 is negative, is so $6 = 0?
bne $6, $0, loop   ;if not  negative skip these 3 instr
;if negative
lis $9		;boolean if negative $18 = 1 else $18 = 0
.word 1
;check if last negative
bne $1, $8, turnPositive
add $1, $1, $16	 ;add one so we get -2147483647
add $11, $16, $0 ;$11 = 1 indicating last postive value

turnPositive:
	mult $1, $14     ;multiply value by -1
	mflo $1

loop: 
	beq $1, $0, isNegative
	div $1, $10		
	mfhi $12		;$12 =$1 % 10
	mflo $1		 	;$1  = $1 / 10
	bne $11, $16, 2		;check if last negative
	add $12, $12, $16	;add one if it is
	add $11, $0, $0		;clear $11
	add $12, $12, $3	;convert digit to ASCII value of digit
	sub $30, $30, $4  	;move stack pointer back
	add $13, $13, $16	;increment counter
	sw $12, 0($30) 	  	;store ascii value of digit on stack
	beq $0, $0, loop 

isNegative:		;if negative store the negative sign
	beq $9, $0, unload
	sub $30, $30, $4	
	add $13, $13, $16
	sw $7, 0($30)    ;store negative sign on stack
	beq $0, $0, unload

isZero:
	sub $30, $30, $4
	add $12, $12, $3
	add $13, $13, $16
	sw $12, 0($30)
	
unload:
	beq $13, $0, done	;when counter = 0 stop
	lw $15, 0($30)		;store whats in stack $15
	add $30, $30, $4	;move pointer down
	sw $15, 0($5)		;print
	sub $13, $13, $16	;decrement counter
	beq $0, $0, unload	

done:
	sw $10, 0($5) 		;print new line
        lis $6 
        .word 68
        add $30, $30, $6 
        lw $1, -4($30)  ;value to print 
        lw $2, -8($30)  ;value given by user 
        lw $3, -12($30) 
        lw $4, -16($30) ;stores 4 for stack 
        lw $5, -20($30) ;stores print address 
        lw $6, -24($30) ;checks if $1 is postive 
        lw $7, -28($30) ;negative sign in ascii 
	lw $8, -32($30)
        lw $9, -36($30) ;store boolean for if $1 is negative 
        lw $10, -40($30);stores value 10 for dividing 
	lw $11, -44($30)
        lw $12, -48($30);hi reg 
        lw $13, -52($30);counter 
        lw $14, -56($30);for turning numbers postive (-1) 
        lw $15, -60($30);for loading char off stack and printing 
        lw $16, -64($30);value for counting (stores a 1)
	lw $31, -68($30)
	jr $31
