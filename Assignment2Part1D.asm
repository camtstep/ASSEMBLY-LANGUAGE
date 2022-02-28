#Cameron Stepanski, CS 2318-254, Assignment 2 Part 1 Program D
#Compute/display weighted average of exam 1, exam 2, and final
#Formula: ((63*exam1)/256) + ((128*exam2)/504) + (final/2)

			.data
Exm1Prmpt:		.asciiz "Enter integer for exam 1 score: "
Exm2Prmpt:		.asciiz "Enter integer for exam 2 score: "
FnlPrmpt:		.asciiz "Enter integer for final score: "
ScoreLab:		.asciiz "Weighted average score: "
			.text
			.globl main
main:
			li $v0, 4
			la $a0, Exm1Prmpt
			syscall
			
			li $v0, 5		
			syscall
			move $t0, $v0
			
			li $v0, 4
			la $a0, Exm2Prmpt
			syscall
			
			li $v0, 5
			syscall
			move $t1, $v0
			
			li $v0, 4
			la $a0, FnlPrmpt
			syscall
			
			li $v0, 5
			syscall
			move $t2, $v0
			
			
			li $t3, 63
			mult $t3, $t0
			mflo $t9
			sra $t9, $t9, 8
			#################
			sll $t1, $t1, 7
			li $t3, 504
			div $t1, $t3
			mflo $t0	
			#################
			sra $t2, $t2, 1
			#################
			add $t9, $t9, $t0
			add $t9, $t9, $t2
			
			li $v0, 4
			la $a0, ScoreLab
			syscall
			
			li $v0, 1
			move $a0, $t9
			syscall
			
			li $v0, 10
			syscall
