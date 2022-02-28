//Cameron Stepanski, CS 2318-254, Assignment 2 Part 2

#include <iostream>
using namespace std;

int a1[9], a2[9], a3[9];

int main()
{
               int  numInts;
               int  used1;
               int  used2;
               int  used3;
               int  intCount;
               int  numDup;
               int  oneInt;
               int  probeIndex;
               int  i;
               int* hopPtr;
               int* hopPtr2;
               int* hopPtr22;
               int* hopPtr3;
               int* endPtr;
               int* endPtr2;
               char reply;

               goto DW1Test;
DW1Body:
                {
                    numInts = 0;
                    goto W1Test;
W1Body:
                {
                    cout << "# of int's for base array ( >= 1 and <= 9 ): ";
                    cin >> numInts;

                    if(numInts < 1) goto goodI1;
                    if(numInts <= 9) goto endI1;
goodI1:
                    cout << "# entered not in range ... try again..." << endl;
                    numInts = 0;
endI1:
W1Test:             if (numInts == 0) goto W1Body;                }

                    used1 = 0;
                    int i = 0;
                    goto F1Test;

F1Body:
                {
                    cout << "integer #" << (i + 1) << ": ";
                    cin >> oneInt;

                    probeIndex = used1;
                    goto W2Test;
W2Body:
                    *(a1 + probeIndex) = *(a1 + probeIndex - 1);
                    --probeIndex;

W2Test:             if(probeIndex > 0 && *(a1 + probeIndex - 1) > oneInt) goto W2Body;
                    *(a1 + probeIndex) = oneInt;
                    ++used1;
                    ++i;
                }
F1Test:             if(i < numInts) goto F1Body;

                    used2 = 0;
                    goto F2Test;
F2Body:
                    *(a2 + used2) = *(a1 + used2);
                    ++used2;

F2Test:              if(used2 < used1) goto F2Body;

                    *a3 = *a2;   //SAME AS: *(a3 + 0) = *(a2 + 0);
                    numDup = 0;
                    used3 = 1;
                    hopPtr2 = a2 + 1;
                    hopPtr3 = a3 + 1;
                    endPtr2 = a2 + used2;
                    goto W3Test;

W3Body:
                    if(*hopPtr2 != *(hopPtr2 - 1)) goto else2;
                {
                    ++numDup;
                    ++hopPtr2;
                }
                    goto I2endif;
else2:
                    *hopPtr3 = *hopPtr2;
                    ++used3;
                    ++hopPtr3;

                    if(numDup <= 0) goto else3;
                {
                    hopPtr22 = hopPtr2;
                    goto F3Test;

F3Body:
                    *(hopPtr22 - 1) = *hopPtr22;
                    ++hopPtr22;

F3Test:             if(hopPtr22 < endPtr2) goto F3Body;
                    --used2;
                    --endPtr2;
                    numDup = 0;
                }
                    goto endI3;
else3:
                {
                    ++hopPtr2;
                }
endI3:
I2endif:

W3Test:             if(hopPtr2 < endPtr2) goto W3Body;
                    if (numDup > 0) goto endI4;
                {
                     --used2;
                }
endI4:

                    cout << endl << "================================" << endl;
                    cout << "a1: ";
                    hopPtr = a1;
                    endPtr = a1 + used1;

                    goto W4Test;

W4Body:         {
                    cout << *hopPtr << "  ";
                     ++hopPtr;
                }
W4Test:             if(hopPtr < endPtr) goto W4Body;
                    cout << endl;
                    cout << "a2: ";
                    hopPtr = a2;
                    endPtr = a2 + used2;
                    goto W5Test;

W5Body:          {
                    cout << *hopPtr << "  ";
                     ++hopPtr;
                 }
W5Test:             if(hopPtr < endPtr) goto W5Body;
                    cout << endl;
                    cout << "a3: ";
                    hopPtr = a3;
                    endPtr = a3 + used3;

                    goto W6Test;

W6Body:           {
                    cout << *hopPtr << "  ";
                    ++hopPtr;
                  }
W6Test:             if(hopPtr < endPtr) goto W6Body;
                    cout << endl;
                    cout << "================================" << endl;

                    cout << "Do another (n or N = no, others = yes) ";
                    cin >> reply;
                }
DW1Test:             if(reply != 'n' && reply != 'N') goto DW1Body;


                    cout << endl << "================================" << endl;
                    cout << "bye..." << endl;
                    cout << "================================" << endl;

                    return 0;
                }
