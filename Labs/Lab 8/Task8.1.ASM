.MODEL SMALL
.STACK 100H
.DATA
  prompt1 DB "Enter a number in hexa-decimal: $"
  prompt2 DB "Its binary equivalent is: $"
  prompt3 DB "It is palindrome in binary.$"
  prompt4 DB "It is not palindrome in binary.$"
  newLine DB 10, 13, "$"
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

  XOR BL, BL ;clear BL register
  MOV CH, 2 ;two character input count
  MOV CL, 4 ;number of shifts 

  INPUT:
  ;
  ;single character input
  ;
  MOV AH, 01H
  INT 21H
  ;
  ;input vaidation of digit
  ;
  CMP AL, '0'
  JL WRONG ;AL < '0' then character entered is invalid or might be a Letter
  CMP AL, '9'
  JG CHECK_CHARACTER ;AL > '9' then character entered is invalid or might be a Letter

  SUB AL, 30H ;converting character to digit

  JMP STORE_INPUT

  CHECK_CHARACTER:
  CMP AL, 'A' 
  JL WRONG ;AL < 'A' then character entered is invalid
  CMP AL, 'Z'
  JG WRONG ;AL > 'Z' then character entered is invalid

  SUB AL, 37H ;converting character to digit

  STORE_INPUT:
  SHL BL, CL ;shifting 4 bits to left so entered digit can be inserted at shifted places
  OR BL, AL ;inerting entered digit to BL which is shifted 4 bit to left and contain 0000 in its lower nibble
  DEC CH ;counter to check if two characters have be entered or not
  JNZ INPUT ;if counter is not zero then gain take input

  JMP PREPARE_OUTPUT ;stop from going into WRONG after two valid characters have been entered

  WRONG:
  MOV AH, 09H
  ;
  ;display newLine
  ;
  LEA DX, newLine
  INT 21H
  ;
  ;display prompt1
  ;
  LEA DX, prompt1
  INT 21H
  ;
  ;chracter entered is invalid so initializing counter and clearing BL register
  ;
  MOV CH, 2
  XOR BL, BL
  JMP INPUT

  PREPARE_OUTPUT:
  MOV AH, 09H
  ;
  ;displaying newLine
  ;
  LEA DX, newLine
  INT 21H
  ;
  ;displaying prompt2
  ;
  LEA DX, prompt2
  INT 21H

  MOV CX, 8 ;counter to output binary pattern of the number
  MOV AH, 02H

  OUTPUT:
  ROL BL, 1 ;rotating BL one bit to left will preserve content of BL and put msb in CF 
  JC ONE ;CF == 1 then display '1' otherwise '0'
  MOV DL, '0' 
  JMP PRINT_BINARY

  ONE:
  MOV DL, '1'
  PRINT_BINARY:
  INT 21H
  LOOP OUTPUT 
  ;
  ;display newLine
  ;
  MOV AH, 09H
  LEA DX, newLine
  INT 21H
  
  XOR BH, BH ;clearing BH register
  MOV CX, 8 ;counter to rotate BL 8 times

  STORE_REVERSE:
  ROL BH, 1 ;rotating BH one bit to left will empty lsb for oring with BL's lsb which can be checked by CF 
  ROR BL, 1 ;rotating BL one bit to right will preserve BL and will put lsb in CF
  JC ONE1 ;CF == 1 than insert 1 at lsb of BH other wise 0
  OR BH, 0
  JMP REMAININIG_PATTERN
  ONE1:
  OR BH, 1
  REMAININIG_PATTERN:
  LOOP STORE_REVERSE
  ;
  ;if pattern is same then BL and BH should contain same value
  ;
  CMP BL, BH
  JNE NOT_PALINDROME ;BL != BH
  ;
  ;display prompt3
  ;
  MOV AH, 09H
  LEA DX, prompt3
  INT 21H
  JMP REMAIN

  NOT_PALINDROME:
  ;
  ;display prompt4
  ;
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
END MAIN