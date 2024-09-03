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

la $a0,0($t0)
la $a1,24($t0)

jal isLessThan

move $a0,$v0

li $v0,1
syscall

li $v0,10
syscall


isLessThan:

    li $t0,0;
    lw $t4,0($a0)
    lw $t5,0($a1)
    lw $t6,4($a0)
    lw $t7,4($a1)


    slt $t1,$t4,$t5
    beq $t1,$0,real_bada_nhi_hai
    addi $t0,$t0,1
    j return

    real_bada_nhi_hai:

    beq $t4,$t5,real_equal
    j return

    real_equal:

    slt $t1,$t6,$t7
    beq $t1,$0,return
    add $t0,$t0,1
    j return

    return:

    move $v0,$t0

    jr $ra
    
