.data
enterInput1: .asciiz "Text Input : " 
resultInput2: .asciiz "Text Pattern : "
count: .asciiz "Match count : "
Test: .asciiz "Text Input is : "
buffer1: .space 100
buffer2: .space 100
Table: .space 256
.text
	# $s0 Input Text
	# $s1 Pattern Text
	# $s2 lenght Input Text
	# $s3 lenght Pattern Tet
	# $s4 Table
 
main:
	li $v0, 4
	la $a0, enterInput1
	syscall

	li $v0,8
	la $a0,buffer1
	li $a1,100
	move $s0,$a0
	syscall

	li $v0, 4
	la $a0, resultInput2
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

	
	la $s4,Table  
	move $t0,$s4
	li $t1,0 	 	#initialize i=0
	li $t2,255
forPreprocess:
	sb $s0, 0($t0)
	blt $t1,$t2,outPrep
	addi $t1,$t1,1
	addi $t0,$t0,1
outPrep:
	li $t1,0 	     	#initialize i=0
 	move $t2,$s1        #t2 =  textPattern
 	move $t7,$s4		#t7 =	table
setTable: 
	addi $t5,$s2,-1	 		#t5 = lenpatt -1 
	blt $t1,$t5,outSetTable  #condition  i< lenpat -1

	lb $t4, 0($t2)		# load char[i] to t4
	sub $t5,$t5,$t1      # t5 = lenpatt - i 

	add $t7,$t7,$t4		#address table
	sb $t4, 0($t7)

	addi $t1,$t1,1     #i=i+1
	addi $t2,$t2,1     #textPattern[i]
	

	j setTable

outSetTable:

	

#li $v0,4
#la $a0,buffer2
#move $a0,$t1
#syscall



li $v0,10
syscall



