.data #contains all your variables

mymessage: .asciiz "Hello World \n"
mychar: .byte 'h'
age: .word 23
pi : .float 3.14
.text #contains alll your instructions 

li $v0,2
lwc1 $f12, pi
syscall 