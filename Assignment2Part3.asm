###############################################################################
# Title: Assign02P3                   Author: Cameron Stepanski
# Class: CS 2318-254, Spring 2021     Submitted: 4/11/2021
###############################################################################
# Program: MIPS tranlation of a given C++ program
###############################################################################
# Pseudocode description: supplied a2p2_SampSoln.cpp
###############################################################################

##include <iostream>
#using namespace std;

#int a1[9], a2[9], a3[9];
			.data
a1:			.space 36
a2:			.space 36
a3:			.space 36
noiPrompt:		.asciiz "# of int's for base array ( >= 1 and <= 9 ): "
eniPrompt:		.asciiz "# entered not in range ... try again...\n"
inPrompt:		.asciiz "integer #"
colSpace:		.asciiz ": "
divider:		.asciiz "\n================================"
a1cs:			.asciiz "\na1: "
space:			.asciiz " "
a2cs:			.asciiz "\na2: "
a3cs:			.asciiz "\na3: "
daPrompt:		.asciiz "\nDo another (n or N = no, others = yes) "
nl:			.asciiz "\n"
bye:			.asciiz "\nbye..."
#int main()
			.text
			.globl main
main:
#{
#               int  numInts;
#               int  used1;
#               int  used2;
#               int  used3;
#               int  numDup;
#               int  oneInt;
#               int  probeIndex;
#               int  i;
#               int* hopPtr;
#               int* hopPtr2;
#               int* hopPtr22;
#               int* hopPtr3;
#               int* endPtr;
#               int* endPtr2;
#               char reply;

#######################################################
# Register usage:
#######################################################
# $a0: short-lived holder (in no-syscall areas)
# $a1: endPtr
# $a2: endPtr2
# $a3: still yet another short-lived holder
# $t0: oneInt
# $t1: used1
# $t2: used2
# $t3: used3
# $t4: hopPtr
# $t5: hopPtr2
# $t6: hopPtr3
# $t7: hopPtr22 or i or reply (non-overlappingly)
# $t8: numDup or probeIndex (non-overlappingly)
# $t9: numInts
# $v0: another short-lived holder (in no-syscall areas)
# $v1: yet another short-lived holder
#######################################################

#               //do
begDW1:#//      {
#                  numInts = 0;
			li $t9, 0
#                  	goto WTest1;
			j WTest1
#                  //while (numInts == 0)
begW1:#//          {
#                     cout << "# of int's for base array ( >= 1 and <= 9 ): ";
			li $v0, 4
			la $a0, noiPrompt
			syscall
#                     cin >> numInts;
			li $v0, 5
			syscall
			move $t9, $v0
#                     //if (numInts < 1 || numInts > 9)
#                     if (numInts < 1) goto begI1;
			li $a0, 1
			blt $t9, $a0, begI1
#                     if (numInts <= 9) goto endI1;
			li $a0, 9
			ble $t9, $a0, endI1			
			
begI1:#//             {
#                        cout << "# entered not in range ... try again..." << endl;
			li $v0, 4
			la $a0, eniPrompt
			syscall
#                        numInts = 0;
			li $t9, 0
			
endI1:#//             }
endW1:#//          }
#WTest1:           if (numInts == 0) goto begW1;
WTest1:			beqz $t9, begW1

#                  used1 = 0;
			li $t1, 0

#                  i = 0;
			li $t7, 0			
                  
#                  goto FTest1;
			j FTest1
#                  //for (i = 0; i < numInts; ++i)
begF1:#//          {
#                     cout << "integer #" << (i + 1) << ": ";
			li $v0, 4
			la $a0, inPrompt
			syscall
			li $v0, 1
			addi $a0, $t7, 1
			syscall
			li $v0, 4
			la $a0, colSpace
			syscall                     
#                     cin >> oneInt;
			li $v0, 5
			syscall
			move $t0, $v0

#                     probeIndex = used1;
			move $t8, $t1 

#                     goto WTest2;
			j WTest2
#                     //while ( probeIndex > 0 && *(a1 + probeIndex - 1) > oneInt ) 
begW2:#//             { 
#                        *(a1 + probeIndex) = *(a1 + probeIndex - 1);
			la $a0, a1
			sll $a3, $t8, 2
			add $a3, $a3, $a0
			lw $v1, -4($a3)
			sw $v1, 0($a3)
#                        --probeIndex;
			addi $t8, $t8, -1
endW2:#//             } 
#////WTest2:              if ( probeIndex > 0 && *(a1 + probeIndex - 1) > oneInt ) goto begW2;
#WTest2:              if ( probeIndex <= 0 ) goto xitW2;
WTest2:			li $a0, 0
			ble $t8, $a0, xitW2 
#                     if ( *(a1 + probeIndex - 1) > oneInt ) goto begW2;
			la $a0, a1
			sll $a3, $t8, 2
			add $a3, $a3, $a0
			lw $v1, -4($a3)
			bgt $v1, $t0, begW2
			
xitW2:
#                     *(a1 + probeIndex) = oneInt; 
			la $a0, a1
			sll $a3, $t8, 2
			add $a3, $a3, $a0
			sw $t0, 0($a3)
#                     ++used1;
			addi $t1, $t1, 1
#                  ++i;
			addi $t7, $t7, 1
endF1:#//          }
#FTest1:           if (i < numInts) goto begF1;
FTest1:			blt $t7, $t9, begF1

#                  used2 = 0;
			li $t2, 0	
#                  goto FTest2;
			j FTest2
#                  //for (used2 = 0; used2 < used1; ++used2)
begF2:#//          {
#                     *(a2 + used2) = *(a1 + used2);
			la $a0, a1		# $a0 has a1
			sll $a3, $t2, 2		# $a3 has 4*used2
			add $a3, $a3, $a0 	# #a3 has (a1 + 4*used2)
			lw $v1, 0($a3)		# $v1 has MEM(a1 + used2)
			la $a0, a2		# $a0 has a2
			sll $a3, $t2, 2		# $a3 has 4*used2
			add $a3, $a3, $a0	# #a3 has (a2 + 4*used2)
			sw $v1, 0($a3)		# MEM(a2 + 4*used2) gets MEM(a1 + 4*used2)
#                  ++used2;
			addi $t2, $t2, 1
endF2:#//          }
#FTest2:           if (used2 < used1) goto begF2;
FTest2:			blt $t2, $t1, begF2

#                  *a3 = *a2;   //SAME AS: *(a3 + 0) = *(a2 + 0);
			la $a0, a2		# $a0 has a2
			lw $v1, 0($a0)		# $v1 has MEM(a2)
			la $a0, a3		# $a0 has a3
			sw $v1, 0($a0)		# MEM(a3) get MEM(a2)
#                  numDup = 0;
			li $t8, 0
#                  used3 = 1;
			li $t3, 1
#                  hopPtr2 = a2 + 1;
			la $t5, a2
			addi $t5, $t5, 4
#                  hopPtr3 = a3 + 1;
			la $t6, a3
			addi $t6, $t6, 4 
#                  endPtr2 = a2 + used2;
			la $a2, a2
			sll $a3, $t2, 2
			add $a2, $a2, $a3

#                  goto WTest3;
			j WTest3
#                  //while (hopPtr2 < endPtr2)
begW3:#//          {
#                     //if ( *hopPtr2 == *(hopPtr2 - 1) )
#                     if ( *hopPtr2 != *(hopPtr2 - 1) ) goto else2;
			lw $v0, 0($t5)		# $v0 has MEM(hopPtr2)
			lw $v1, -4($t5)		# $v1 has MEM(hopPtr2 - 1)
			bne $v0, $v1, else2
begI2:#//             {
#                        ++numDup;
			addi $t8, $t8, 1
#                        ++hopPtr2;
			addi $t5, $t5, 4
#                     goto endI2;
			j endI2
#//                   }
else2:#//             else
#//                   {
#                        *hopPtr3 = *hopPtr2;
			lw $v1, 0($t5)
			sw $v1, 0($t6)
#                        ++used3;
			addi $t3, $t3, 1
#                        ++hopPtr3;
			addi, $t6, $t6, 4
#                        //if (numDup > 0)
#                        if (numDup <= 0) goto else3;
			li $a0, 0
			ble $t8, $a0, else3
begI3:#//                {
#                           hopPtr22 = hopPtr2;
			move $t7, $t5
#                           goto FTest3;
			j FTest3
#                           //for (hopPtr22 = hopPtr2; hopPtr22 < endPtr2; ++hopPtr22)
begF3:#//                   {
#                              *(hopPtr22 - 1) = *hopPtr22;
			lw $v1, 0($t7)
			sw $v1, -4($t7)
#                           ++hopPtr22;
			addi $t7, $t7, 4
endF3:#//                   }
#FTest3:                    if (hopPtr22 < endPtr2) goto begF3;
FTest3:			blt $t7, $a2, begF3

#                           --used2;
			addi $t2, $t2, -1
#                           --endPtr2;
			addi $a2, $a2, -4
#                           numDup = 0;
			li $t8, 0
#                        goto endI3;
			j endI3
#//                      }
else3:#//                else
#//                      {
#                           ++hopPtr2;
			addi $t5, $t5, 4
endI3:#//                }
endI2:#//             }
#//                }
#WTest3:           if (hopPtr2 < endPtr2) goto begW3;
WTest3:			blt $t5, $a2, begW3

#                  //if (numDup > 0)
#                  if (numDup <= 0) goto endI4;
			li $a0, 0
			ble $t8, $a0, endI4
begI4:#//          {
#                     --used2;
			addi $t2, $t2, -1
endI4:#//          }

#                  cout << endl << "================================" << endl;
			li $v0, 4
			la $a0, divider
			syscall
#                  cout << "a1: ";
			li $v0, 4
			la $a0, a1cs
			syscall
			
#                  hopPtr = a1;
			la $t4, a1	
#                  endPtr = a1 + used1;
			la $a1, a1
			sll $a3, $t1, 2
			add $a1, $a1, $a3
#                  goto WTest4;
			j WTest4
#                  //while (hopPtr < endPtr)
begW4:#//          {
#                     cout << *hopPtr << "  ";
			li $v0, 1
			lw $a0, 0($t4)
			syscall
			li $v0, 4
			la $a0, space
			syscall
#                     ++hopPtr;
			addi $t4, $t4, 4
endW4:#//          }
#WTest4:           if (hopPtr < endPtr) goto begW4;
WTest4:			blt $t4, $a1, begW4

#                  cout << endl;
#                  cout << "a2: ";
			li $v0, 4
			la $a0, a2cs
			syscall
                  
#                  hopPtr = a2;
			la $t4, a2
#                  endPtr = a2 + used2;
			la $a1, a2
			sll $a3, $t2, 2
			add $a1, $a1, $a3

#                  goto WTest5;
			j WTest5
#                  //while (hopPtr < endPtr)
begW5:#//          {
#                     cout << *hopPtr << "  ";
			li $v0, 1
			lw $a0, 0($t4)
			syscall
			li $v0, 4
			la $a0, space
			syscall
#                     ++hopPtr;
			addi $t4, $t4, 4
endW5:#//          }
#WTest5:           if (hopPtr < endPtr) goto begW5;
WTest5:			blt $t4, $a1, begW5

#                  cout << endl;
#                  cout << "a3: ";
			li $v0, 4
			la $a0, a3cs
			syscall
#                  hopPtr = a3;
			la $t4, a3
#                  endPtr = a3 + used3;
			la $a1, a3
			sll $a3, $t3, 2
			add $a1, $a1, $a3

#                  goto WTest6;
			j WTest6
#                  //while (hopPtr < endPtr)
begW6:#//          {
#                     cout << *hopPtr << "  ";
			li $v0, 1
			lw $a0, 0($t4)
			syscall
			li $v0, 4
			la $a0, space
			syscall
#                     ++hopPtr;
			addi $t4, $t4, 4
endW6:#//          }
#WTest6:           if (hopPtr < endPtr) goto begW6;
WTest6:			blt $t4, $a1, begW6

#                  cout << endl;
#                  cout << "================================" << endl;
			li $v0, 4
			la $a0, divider
			syscall
#                  cout << "Do another (n or N = no, others = yes) ";
			li $v0, 4
			la $a0, daPrompt
			syscall
#                  cin >> reply;
			li $v0, 12
			syscall
			move $t7, $v0
			
			li $v0, 12
			la $a0, nl
			syscall
endDW1:#//      }
#               //while (reply != 'n' && reply != 'N');
#               ////if (reply != 'n' && reply != 'N') goto begDW1;
#               if (reply == 'n') goto xitDW1;
			li $v0, 'n'
			beq $t7, $v0, xitDW1
#               if (reply != 'N') goto begDW1;
			li $v0, 'N'
			bne $t7, $v0, begDW1
xitDW1:

#               cout << endl << "================================" << endl;
			li $v0, 4
			la $a0, divider
			syscall
#               cout << "bye..." << endl;
			li $v0, 4
			la $a0, bye
			syscall               
#               cout << "================================" << endl;
			li $v0, 4
			la $a0, divider
			syscall

#               return 0;
			li $v0, 10
			syscall
#}
