##########################################################################
# Cameron Stepanski, CS 2318-254, Assignment 2 Part 1 Program B
############################ data segment ################################
		.data
legend:		.asciiz "Set3: A-O       Set2: P-Z       Set1: a-o       Set0: p-z\n"
inPrompt:	.asciiz "Enter a letter (A-Z; a-z): "
outLab:		.asciiz "    <---- letter is from Set"
############################ code segment ################################
		.text
		.globl main
main:
		li $v0, 4
		la $a0, legend        
		syscall				# print legend
		
		la $a0, inPrompt        
		syscall				# print input prompt
		
		li $v0, 12
		syscall				# read input letter

		##########################################################
		# Replace  ##<BWI1>##  ##<BWI2>##  ##<BWI3>##  ##<BWI4>##
		# ("holes" intentionally dug) in the following code block
		# each with a bit manipulating instructions (ANDing, ORing,
		# XORing, and shifting - only whatever that are needed)
		# so that the program will work just like the sample runs 
		# shown at the bottom (some blank lines edited out).
		# You should test your with AT LEAST the test cases shown 
		# because that's how I'd test it when grading.
		##########################################################
						
		and $t0, $v0, $v0 		# save copy of input in $t0 (BWI1)
                
		li $v0, 4
		la $a0, outLab        
		syscall				# print output label
		li $v0, 1			# prep to print desired int
		
		#srl $t0, $t0, 4                 # These 3 instructions (BWI2)
		srl $t0, $t0, 0x4
      		#xori $t0, $t0, 7                # are to make $a0 (BWI3)
      		xori $t0, $t0, 0x7
      		andi $a0, $t0, 7                # hold the desired int (BWI4)
                
		syscall				# print desired int
		                                               
		li $v0, 10			# graceful exit
		syscall

########################## sample test runs ##############################
# Set3: A-O       Set2: P-Z       Set1: a-o       Set0: p-z
# Enter a letter (A-Z; a-z): A    <---- letter is from Set3
# 
# -- program is finished running --
# Reset: reset completed.
# 
# Set3: A-O       Set2: P-Z       Set1: a-o       Set0: p-z
# Enter a letter (A-Z; a-z): H    <---- letter is from Set3
# 
# -- program is finished running --
# Reset: reset completed.
# 
# Set3: A-O       Set2: P-Z       Set1: a-o       Set0: p-z
# Enter a letter (A-Z; a-z): O    <---- letter is from Set3
# 
# -- program is finished running --
# Reset: reset completed.
# 
# Set3: A-O       Set2: P-Z       Set1: a-o       Set0: p-z
# Enter a letter (A-Z; a-z): P    <---- letter is from Set2
# 
# -- program is finished running --
# Reset: reset completed.
# 
# Set3: A-O       Set2: P-Z       Set1: a-o       Set0: p-z
# Enter a letter (A-Z; a-z): U    <---- letter is from Set2
# 
# -- program is finished running --
# Reset: reset completed.
# 
# Set3: A-O       Set2: P-Z       Set1: a-o       Set0: p-z
# Enter a letter (A-Z; a-z): Z    <---- letter is from Set2
# 
# -- program is finished running --
# Reset: reset completed.
# 
# Set3: A-O       Set2: P-Z       Set1: a-o       Set0: p-z
# Enter a letter (A-Z; a-z): a    <---- letter is from Set1
# 
# -- program is finished running --
# Reset: reset completed.
# 
# Set3: A-O       Set2: P-Z       Set1: a-o       Set0: p-z
# Enter a letter (A-Z; a-z): h    <---- letter is from Set1
# 
# -- program is finished running --
# Reset: reset completed.
# 
# Set3: A-O       Set2: P-Z       Set1: a-o       Set0: p-z
# Enter a letter (A-Z; a-z): o    <---- letter is from Set1
# 
# -- program is finished running --
# Reset: reset completed.
# 
# Set3: A-O       Set2: P-Z       Set1: a-o       Set0: p-z
# Enter a letter (A-Z; a-z): p    <---- letter is from Set0
# 
# -- program is finished running --
# Reset: reset completed.
# 
# Set3: A-O       Set2: P-Z       Set1: a-o       Set0: p-z
# Enter a letter (A-Z; a-z): u    <---- letter is from Set0
# 
# -- program is finished running --
# Reset: reset completed.
# 
# Set3: A-O       Set2: P-Z       Set1: a-o       Set0: p-z
# Enter a letter (A-Z; a-z): z    <---- letter is from Set0
# 
# -- program is finished running --
######################## end sample test runs ############################
