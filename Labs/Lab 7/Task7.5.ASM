.MODEL SMALL
.STACK 100H
.DATA
  prompt1 DB "Enter a string: $"
  prompt2 DB "It is palindrome.$"
  prompt3 DB "It is not palindrome.$"
  input DB 100 DUP(?)
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
  ;prepare for input
  ;
  LEA SI, input ; SI points to starting address of input
  MOV BL, 0D ; count number of charactrs taken
  MOV CX, 99D
  MOV AH, 01H
  ;
  ;repeat until user enter return
  ;
  AGAIN:
  INT 21H
  CMP AL, 13D
  JE PREPARE_CHECK ; AL == return
  INC BL
  MOV [SI], AL ; storing character taken to input array
  INC SI
  LOOP AGAIN
  ;
  ;DI points to starting address of input
  ;
  PREPARE_CHECK:
  CMP BL, 0D
  JE IS_PALINDROME
  LEA DI, input
  ;
  ;repeat until count of characters taken as input is 0 or left and right character is not same
  ;
  CHECK_PALINDROME:
  DEC SI
  MOV BH, [SI]
  CMP BH, [DI]
  JNE NOT_PALINDROME ; [SI] != [DI]
  INC DI
  DEC BL
  JNZ CHECK_PALINDROME
  ;
  ;display prompt2 if it is palindrome
  ;
  IS_PALINDROME:
  MOV AH, 09H
  LEA DX, prompt2
  INT 21H
  JMP REMAIN
  ;
  ;display prompt3 if not palindrome
  ;
  NOT_PALINDROME:
  MOV AH, 09H
  LEA DX, prompt3
  INT 21H
  ;
  ;exit DOS
  ;
  REMAIN:
  MOV AH, 4CH
  INT 21H

MAIN ENDP
END MAIN