.data
    
    .align 3
    struct_complex: .space 8
    .align 3
    array: .space 32
    len : .word 4
    
.globl struct_complex 
.globl len 
.globl array
.globl main

.text

main:
la $t0 , array #get the baseaddress of the array

li $t1,0
li $t2,0

sw $t1,0($t0)
sw $t2,4($t0)

li $t1,-1
li $t2,2

sw $t1,8($t0)
sw $t2,12($t0)


li $t1,0
li $t2,2

sw $t1,16($t0)
sw $t2,20($t0)


li $t1,-1
li $t2,-1

sw $t1,24($t0)
sw $t2,28($t0)

addi $t3,$t0,16

lw $t1,0($t3)
lw $t2,4($t3)


add $a0,$t1,$t2

li $v0,1
syscall

li $v0,10
syscall