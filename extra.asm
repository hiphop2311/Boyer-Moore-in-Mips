.data
resultInput2: .asciiz "\nText Pattern : "
count: .asciiz "Match count : "
Test: .asciiz "check test"
buffer1: .space 1024
buffer2: .space 100
Table: .space 256
fin: .asciiz "C:\sample.txt"
.text
	# $s0 Input Text
	# $s1 Pattern Text
	# $s2 lenght Input Text
	# $s3 lenght Pattern Tet
	# $s4 Table
	# $s5 count
 
main:
		li   $v0, 13       # system call for open file
		la   $a0, fin      # input file name
		li   $a1, 0        # flag for reading
		li   $a2, 0        # mode is ignored
		syscall            # open a file 
		move $s0, $v0      # save the file descriptor 

		# reading from file just opened

		li   $v0, 14       # system call for reading from file
		move $a0, $s0      # file descriptor 
		la   $a1, buffer1   # address of buffer from which to read
		li   $a2, 1024     # hardcoded buffer length
		syscall            # read from file
		move $s7 , $a1

		li  $v0, 4         # 
		move  $a0, $s7     # buffer contains the values
		syscall           

    move 	$s0, $s7		 
	li $v0, 4				#print "Text Pattern : "
	la $a0, resultInput2 
	syscall

	li $v0,8
	la $a0,buffer2	    	#Receive string Pattern
	li $a1,100
	move $s1,$a0			# $s1 = string Pattern
	syscall

	li $s5,0				#count(result) = 0
  
  	
  	move $t0,$s0            #t0 = start & of text Input

    li $t2,0  		        #initializ count = 0
strlen1:
 	lb $t1, 0($t0)          #load charactor to t1
 	beqz $t1,endStrlen1     #check whether 0 or not 0 branched
 	addi $t0,$t0,1  	    # &[++]
 	addi $t2, $t2, 1        # count String ++
 	j strlen1
endStrlen1:
	#addi $t2,$t2,-1         #clear count of \n
	move $s2,$t2		    #s2 store len of Text Input	

	move $t0,$s1   		    #t1 =start & of text Pattern
	li   $t2,0
strlen2:
	lb $t1, 0($t0)			#load charactor to t1
 	beqz $t1,endStrlen2		#check whether 0 or not 0 branched
 	addi $t0,$t0,1			# &[++]
 	addi $t2, $t2, 1		# count String ++
 	j strlen2
endStrlen2:
	addi $t2,$t2,-1   	    #clear count of \n
	move $s3,$t2			#s3 store len of Text Pttern

	la $s4,Table  			
	move $t0,$s4			#t0 = start&s4 (table)
	li $t1,0 	 			#initialize i=0
	li $t2,256
forPreprocess:
	sb $s3, 0($t0)			#store lenpatt to all array of Table
	bge $t1,$t2,outPrep		#if(i>=256) branched
	addi $t1,$t1,1			#i++
	addi $t0,$t0,1			# &Table++
	j forPreprocess
outPrep:
	li $t1,0 	     		#initialize i=0
 	move $t2,$s1      	    #t2 =  textPattern
 	#move $t7,$s4	 		#t7 =	table
 	addi $t5,$s3,-1			#t5 = lenpatt -1 	 
setTable: 
						   	
	bge $t1,$t5,outSetTable  #condition  i< lenpat -1

	lb $t4, 0($t2)		# load pat[i] to t4
	add $t7,$s4,$t4		#address table

	sub $t6,$t5,$t1      # t6 = lenpatt - i -1
	
	sb $t6, 0($t7)

	addi $t1,$t1,1     #i=i+1
	addi $t2,$t2,1     #textPattern[i]
	
	j setTable

outSetTable:
	li 		$t2,0				#shift = 0
while1:
		sub 	$t3,$s2,$t2			#$t3 = txtlen - shift
		blt		$t3,$s3,endwhile1		#$t3<$s3? go endAlgo (out while)
		addi	$t1,$s3, -1			# $i = patlen - 1
		
	while2:		
				blt		$t1,$zero,exitwhile2
				add		$t4,$t2,$t1			# $t4 = shift + i
				add		$t4,$s0,$t4
				lb		$t5, 0($t4)			# load  $t5 = txt[shift+i]
				add		$t4,$s1,$t1			
				lb		$t6, 0($t4)			# load	$t6 = pat[i]
				bne		$t5,$t6,exitwhile2
				addi	$t1,$t1,-1
				j		while2				# jump to while2
				
exitwhile2:	
			bge 	$t1,$zero,lowerstep		#i>=0 exit if
			addi	$s5,$s5,1			
lowerstep:
			addi	$t4,$t2,-1			# $t4 = shift -1
			add		$t4,$s3,$t4			# $t4 = patlen + $t4
			add		$t4,$s0,$t4			# $t4 = &txt[$t4]
			lb		$t5,0($t4)
			add		$t5,$s4,$t5 		# $t5 = &table[txt[]]
			lb		$t6,0($t5)
			add		$t2,$t2,$t6
			j	while1
endwhile1:
	li	$v0,4
	la	$a0,count
	syscall

	li $v0,1
	move $a0,$s5
	syscall
	


	




li $v0,10
syscall	