#Cameron Stepanski, CS 2318-254, Assignment 2 Part 1 Program C
#Allocate global array with contents 3, 5, 2, 4, & 1 in that order
#Display contents of array from 1st to 5th element
#Swap 2nd & 5th elements and 3rd & 4th elements in memory
#Display contents of array from 5th to 1st element

			.data
intArr:			.word 3, 5, 2, 4, 1			
iacPrmpt:		.asciiz "Initial Array Contents from 1st to 5th element: "
acasPrmpt:		.asciiz "Array Contents After Swaps from 5th to 1st element: "

			.text
			.globl main
main:
			li $v0, 4
			la $a0, iacPrmpt
			syscall
			
			li $v0, 1
			la $t0 intArr 
			lb $a0, 0($t0)
			syscall
			lb $a0, 4($t0)
			syscall
			lb $a0, 8($t0)
			syscall
			lb $a0, 12($t0)
			syscall
			lb $a0, 16($t0)
			syscall
			
			li $v0, 11
			li $a0, '\n'
			syscall
			
			lb $t1, 4($t0)
			lb $t3, 16($t0)
			sb $t1, 16($t0)
			sb $t3, 4($t0)
			
			lb $t1, 8($t0)
			lb $t3, 12($t0)
			sb $t1, 12($t0)
			sb $t3, 8($t0)
			
			li $v0, 4
			la $a0, acasPrmpt
			syscall
			
			li $v0, 1
			
			lb $a0, 16($t0)
			syscall
			lb $a0, 12($t0)
			syscall
			lb $a0, 8($t0)
			syscall
			lb $a0, 4($t0)
			syscall
			lb $a0, 0($t0)
			syscall
			
			
			li $v0, 10
			syscall
