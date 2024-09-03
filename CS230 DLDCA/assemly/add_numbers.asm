.data

.text

main:

addi $a0 ,$0,50
addi $a1, $0, 100
jal addnumbers
li $v0, 1
add $a0,$v1,$zero
syscall

li $v0 ,10
syscall

addnumbers:

add $v1,$a0,$a1
jr $ra