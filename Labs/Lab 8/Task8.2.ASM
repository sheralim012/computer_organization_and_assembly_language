.MODEL SMALL
.STACK 100H
.DATA
  prompt1 DB "Enter a number in binary: $"
  prompt2 DB " is odd.$"
  prompt3 DB " is even.$"
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
  
  MOV CX, 8 ;input counter
  XOR BL, BL ;clearing BL register

  INPUT:
  MOV AH, 01H
  INT 21H ;single character input
  CMP AL, '0' 
  JL WRONG ;AL < '0' then invalid
  CMP AL, '1'
  JG WRONG ;AL > '1' then invalid

  SUB AL, 48D ;converting character to digit
  
  SHL BL, 1 ;shifting BL one bit to left will vacant lsb for the character entered to be ored with AL
  OR BL, AL ;AL conatins 0 or 1 in its lsb so it will be inserted in lsb of BL
  LOOP INPUT ;loop until 8 binary digits are entered

  JMP AFTER_INPUT ;if input is valid then stop from going into WRONG

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
  ;input is invalid then reinitializing counter and clearing BL
  ;
  MOV CX, 8
  XOR BL, BL
  JMP INPUT

  AFTER_INPUT:
  ;
  ;display newLine
  ;
  MOV AH, 09H
  LEA DX, newLine
  INT 21H
  
  TEST BL, 1 ;check whether lsb of BL is 0 then ZF = 1 otherwise BL is 1 then ZF = 0
  JNZ ODD_NUM ;if lsb != 1 then number is odd

  MOV CX, 8 ;counter to output binary pattern
  MOV AH, 02H
  OUTPUT_BINARY:
  ROL BL, 1 ;rotating one bit to left will preserve BL and put msb in CF
  JC ONE ; CF == 1 then print '1' otherwise '0'
  MOV DL, '0'
  JMP PRINT
  ONE:
  MOV DL, '1'
  PRINT:
  INT 21H
  LOOP OUTPUT_BINARY
  ;
  ;display prompt3
  ;
  MOV AH, 09H
  LEA DX, prompt3
  INT 21H
  JMP REMAIN ;stop from goining into REMAIN

  ODD_NUM:
  MOV CL, 4 ;shifting DL 4 bits
  MOV CH, 2 ;counter to output two digits
  AGAIN:
  MOV DL, BL ;moving BL to DL so content of BL can be preserved from shifting
  SHR DL, CL ;shifting DL 4 bits to right will clear upper nibble of DL and lower nibble will conatin digit to be displayed
  CMP DL, 9 
  JLE DIGIT ;DL <= 9 then converting digits(0-9) to character so it can be displayed
  ADD DL, 37H ;DL conataing Letter so converting Letter to character
  JMP DISPLAY
  DIGIT:
  ADD DL, 30H ;converting digits(0-9) to character
  DISPLAY:
  MOV AH, 02H
  INT 21H ;display character

  ROL BL, CL ;rotating BL 4 bits to left will put lower nibble to upper nibble so in next iteration it can work corectly 
  DEC CH ;decrementing counter
  JNZ AGAIN
  ;
  ;display prompt2
  ;
  MOV AH, 09H
  LEA DX, prompt2
  INT 21H
  ;
  ;exit DOS
  ;
  REMAIN:
  MOV AH, 4CH
  INT 21H

MAIN ENDP
END MAIN