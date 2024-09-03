.data
string1: .asciiz "enter first number: "
string2: .asciiz "enter second number: "
string3: .asciiz "lowest 32 bits "
string4: .asciiz "higher 32 bits"
endline: .asciiz "\n"

.text

li $v0, 4
la $a0, string1
syscall

li $v0,5 #system input
syscall

move $t0,$v0 #move value in temporary variable

li $v0, 4
la $a0,endline
syscall

li $v0, 4
la $a0, string2
syscall

li $v0,5
syscall

move $t1,$v0

li $v0,4
la $a0,endline
syscall

li $v0,4
la $a0, string3
syscall

mult $t0,$t1
mflo $a0
li $v0,1
syscall

li $v0, 4
la $a0, endline
syscall

li $v0,4
la $a0, string4
syscall

mfhi $a0
li $v0,1
syscall




