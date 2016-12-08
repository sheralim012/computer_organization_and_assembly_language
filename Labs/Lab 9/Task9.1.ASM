.MODEL SMALL
.STACK 100H
.DATA
  prompt1 DB 10, 13, "Enter first string: $"
  prompt2 DB 10, 13, "Enter second string: $"
  prompt3 DB 10, 13, "First is $"
  prompt4 DB "smaller$"
  prompt5 DB "greater$"
  prompt6 DB " than second.$"
  prompt7 DB 10, 13, "Both strings are equal.$"
  str1 DB 100 DUP('$')
  str2 DB 100 DUP('$')
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
  ;preparing registers for input
  ;
  LEA DI, str1
  MOV CX, 99D

  CALL STRINP ;take input from user in str1
  ;
  ;display prompt2
  ;
  MOV AH, 09H
  LEA DX, prompt2
  INT 21H
  ;
  ;preparing registers for input 
  ;
  LEA DI, str2
  MOV CX, 99D

  CALL STRINP ;take input from user in str2
  ;
  ;preparing registers for comparing the strings
  ;
  LEA SI, str1
  LEA DI, str2

  CALL STRCMP ;compare strings lexicographicaly

  MOV AH, 09H

  CMP AL, 0D
  JE EQUAL_STRINGS ;jump if both strings are equal
  ;
  ;display prompt3
  ;
  LEA DX, prompt3
  INT 21H
  
  CMP AL, 0D
  JL FIRST_IS_LESS ;jump if first string is less then second
  ;
  ;display prompt5
  ;
  LEA DX, prompt5
  INT 21H

  JMP DISPLAY ;stop from goining into FIRST_IS_LESS
  FIRST_IS_LESS:
    ;
    ;display prompt4
    ;
    LEA DX, prompt4
    INT 21H
  DISPLAY:
    ;
    ;display prompt6
    ;
    LEA DX, prompt6
    INT 21H
  JMP REMAIN ;stop from goining into EQUAL_STRINGS
  EQUAL_STRINGS:
    ;
    ;display prompt7 
    ;
    LEA DX, prompt7
    INT 21H
  REMAIN:
    ;
    ;exit DOS
    ;
    MOV AH, 4CH
    INT 21H
MAIN ENDP

;
;parameters are DI(offset of string in which input is taken), CX(total size of input)
;take input from user until user enter return aur input size is zero
;
STRINP PROC
  PUSH AX ;saving content of AX
  MOV AH, 01H
  INPUT:
    INT 21H ;input single character
    CMP AL, 13D
    JE END_INPUT ;jump to END_INPUT if return is pressed
    MOV [DI], AL ;storing input character taken into string
    INC DI ;incrementing DI so it can point to next address in memory
    LOOP INPUT ;loop until input size is zero
  END_INPUT:
    POP AX ;restoring previous content of AX
  RET
STRINP ENDP
;
;parameters are SI(offset of string1) and DI(offset of string2)
;compare string lexicographicaly and store result in AL
;
STRCMP PROC
  PUSH CX
  MOV DX, SI ;moving offset of str1 into DX so STRLEN procedure can use it
  CALL STRLEN
  MOV CL, BL ;length of str1
  MOV DX, DI ;moving offset of str2 into DX so STRLEN procedure can use it
  CALL STRLEN
  MOV CH, BL ;length of str2
  CMP CL, CH
  JE ELSE_ ;jump if length of str1 is equal to str2
    SUB CL, CH ;if lengths of boths strings are different than just subtracting will give answer 
    MOV AL, CL ;storing result in AL
    POP CX
    RET
  ELSE_: ;if both strings are of same length than comparing character by character
    CHECK:
      MOV AH, [SI]
      CMP AH, [DI]
      JNE RETURN_STRCMP ;jump if both characters are different
      INC SI
      INC DI
      DEC CL ;loop will run to the length of any of the two strings
      JNZ CHECK
      JMP REMAINING_CMP ;stop from goining into RETURN_STRCMP
    RETURN_STRCMP:
      SUB AH, [DI] ;AH contains character from first string and DI contains character from second string
      MOV AL, AH ;moving result in AL
      POP CX
      RET
  REMAINING_CMP:
    MOV AL, 0D ;both strings are equal
    POP CX
  RET
STRCMP ENDP

;
;parameters are DX(offset of the string), BL(length of the string)
;calculate length of the given string's offset in DX
;
STRLEN PROC
  PUSH AX
  PUSH CX ;saving content of CX
  PUSH SI ;saving content of SI
  MOV SI, DX ;moving offset of the string present in DX to SI so SI can move around in string
  XOR BL, BL ;BL = 0
  MOV CX, 99 ;initializing counter
  STR_LENGTH:
    MOV AL, [SI]
    CMP AL, '$'
    JE END_LENGTH ;jump if '$' is fing in string
    INC BL ;incrementing length of string
    INC SI ;incrementing SI so it can point to next address
    LOOP STR_LENGTH 
  END_LENGTH:
    POP SI ;restoring content of SI
    POP CX ;restoring content of CX
    POP AX ;restoring content of AX
  RET
STRLEN ENDP

END MAIN
