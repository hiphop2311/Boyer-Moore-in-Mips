.data
text: .asciiz "Text Input : " 
pattern: .asciiz "Text Pattern : "
count: .asciiz "Match count : "

buffer1: .space 100
buffer2: .space 100
.text
	# $s0 Input Text
	# $s1 Pattern Text
	# $s2 lenght Input Text
	# $s3 lenght Pattern Tet
 
main:
	li $v0, 4
	la $a0, text
	syscall

	li $v0,8
	la $a0,buffer1
	li $a1,100
	move $s0,$a0
	syscall

	li $v0, 4
	la $a0, pattern
	syscall

	li $v0,8
	la $a0,buffer2
	li $a1,100
	move $s1,$a0
	syscall
  
  	
  	move $t0,$s0
    li $t2,0  		#initializ count = 0
strlen1:
 	lb $t1, 0($t0)
 	beqz $t1,endStrlen1
 	addi $t0,$t0,1
 	addi $t2, $t2, 1
 	j strlen1
endStrlen1:
	addi $t2,$t2,-1    
	move $s2,$t2

	move $t0,$s1
	li   $t2,0
strlen2:
	lb $t1, 0($t0)
 	beqz $t1,endStrlen2
 	addi $t0,$t0,1
 	addi $t2, $t2, 1
 	j strlen2
endStrlen2:
	addi $t2,$t2,-1    
	move $s3,$t2

	li $v0,1
	move $a0,$s2
	syscall
	li $v0,1
	move $a0,$s3
	syscall




li $v0,10
syscall



