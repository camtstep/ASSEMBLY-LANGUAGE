# Cameron Stepanski, CS 2318-254, Assignment 2 Part 1 Program A
# Prompts user to enter integer and displays it
# Prompts user to enter string up to 70 characters and displays it
# Prompts user to enter character and displays it

			.data
string:			.space 71			
eyiPrmpt:		.asciiz "Enter an integer: "
yiiLab:			.asciiz "Your integer is "
eysPrmpt:		.asciiz "Enter string up to 70 characters: "
ysiLab:			.asciiz "Your string is "
eycPrmpt:		.asciiz "Enter character: "
yciLab:			.asciiz "Your character is "

			.text
			.globl main
main:			
			li $v0,4
			la $a0, eyiPrmpt
			syscall
			li $v0,5
			syscall
			move $t0, $v0
			li $v0,4
			la $a0, yiiLab
			syscall
			li $v0,1
			move $a0, $t0
			syscall
			
			li $v0, 11
			li $a0, '\n'
			syscall
			
			li $v0,4
			la $a0, eysPrmpt
			syscall
			li $v0, 8
			la $a0, string
			li $a1, 71
			syscall

			li $v0, 11
			#li $a0, '\n'
			syscall
			
			li $v0,4
			la $a0, ysiLab
			syscall
			#li $v0,4
			la $a0, string
			syscall
			
			li $v0,4
			la $a0, eycPrmpt
			syscall
			li $v0,12
			syscall
			move $t0, $v0
			
			li $v0, 11
			li $a0, '\n'
			syscall
			
			li $v0,4
			la $a0, yciLab
			syscall
			li $v0,11
			move $a0, $t0
			syscall
			
			li $v0, 11
			li $a0, '\n'
			syscall

			li $v0, 10
			syscall
