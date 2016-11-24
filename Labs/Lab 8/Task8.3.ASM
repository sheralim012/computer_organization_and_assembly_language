.MODEL SMALL
.STACK 100H
.DATA
  prompt1 DB "Enter fisrt string: $"
  prompt2 DB "Enter second string: $"
  prompt3 DB "They're equal.$"
  prompt4 DB "They're not equal.$"
  input1 DB 100 DUP(?)
  input2 DB 100 DUP(?)
.CODE
MAIN PROC
  ;
  ;initialization of data segment
  ;
  MOV AX, @DATA
  MOV DS, AX
  ;
  ;display prompt1
  ;
  MOV AH, 09H
  LEA DX, prompt1
  INT 21H
  ;
  ;prepare to take first input
  ;
  LEA SI, input1 ; SI points to starting address of input1
  MOV BL, 0D ; count number of character taken as input
  MOV CX, 99D
  MOV AH, 01H
  ;
  ;repaet until user enter return or count is 99
  ;
  FIRST_INPUT:
  INT 21H
  CMP AL, 13D
  JE PREPARE_SECOND ; AL == return
  INC BL
  CMP AL, 'a'
  JL REMAIN1 ;AL < 'a' then character is already upper
  CALL toUpper
  REMAIN1:
  MOV [SI], AL
  INC SI
  LOOP FIRST_INPUT
  ;
  ;prepare to take second input
  ;
  PREPARE_SECOND:
  ;
  ;display prompt2
  ;
  MOV AH, 09H
  LEA DX, prompt2
  INT 21H

  LEA SI, input2 ; SI points to starting address of input2
  MOV BH, 0D ; count number of character taken as input
  MOV CX, 99D
  MOV AH, 01H
  ;
  ;repaet until user enter return or count is 99
  ;
  SECOND_INPUT:
  INT 21H
  CMP AL, 13D
  JE PREPARE_CHECK ; AL == return
  INC BH
  CMP AL, 'a'
  JL REMAIN2 ;AL < 'a' then character is already upper
  CALL toUpper 
  REMAIN2:
  MOV [SI], AL
  INC SI
  LOOP SECOND_INPUT
  ;
  ;check if both arrays are empty then they are equal
  ;
  PREPARE_CHECK:
  CMP BL, BH
  JNE NOT_EQUAL
  CMP BL, 0D
  JE ELSE_
  ELSE_:
  CMP BH, 0D
  JE EQUAL
  THEN:
  LEA SI, input1 ; SI points to starting address of input1
  LEA DI, input2 ; DI points to starting address of input2
  ;
  ;repeat until count is 0 or unequal characters occur
  ;
  CHECK:
  MOV AL, [SI]
  CMP AL, [DI]
  JNE NOT_EQUAL
  INC SI
  INC DI
  DEC BL
  JNZ CHECK
  ;
  ;display prompt3 if they are equal
  ;
  EQUAL:
  MOV AH, 09H
  LEA DX, prompt3
  INT 21H
  JMP REMAIN
  ;
  ;display prompt4 if they are not equal
  ;
  NOT_EQUAL:
  MOV AH, 09H
  LEA DX, prompt4
  INT 21H
  ;
  ;exit DOS
  ;
  REMAIN:
  MOV AH, 4CH
  INT 21H

MAIN ENDP

toUpper PROC
  AND AL, 0DFH
  RET
toUpper ENDP

END MAIN