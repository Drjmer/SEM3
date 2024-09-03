.data

mymessage: .asciiz "hello"

.text

main:

jal display
li $v0 ,10
syscall
display:

li $v0 ,4
la $a0 ,mymessage
syscall

jr $ra