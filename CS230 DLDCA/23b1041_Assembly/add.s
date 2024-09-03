.text

main:

li $v0,5 #system input
syscall

move $t0,$v0  #move value in temporary variable

li $v0,5 #system input
syscall

move $t1,$v0 #move value in temporary variable

add $a0,$t0,$t1
li $v0,1
syscall

li $v0,10
syscall