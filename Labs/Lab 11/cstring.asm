.CODE

  STRINP PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI
    PUSH BP
    MOV BP, SP
    MOV SI, [BP + 14 + 4]
    MOV CX, [BP + 14 + 2]
    MOV AH, 01H
    STRINP_INPUT:
      INT 21H
      CMP AL, 13D
      JE STRINP_END
      MOV [SI], AL
      INC SI
      LOOP STRINP_INPUT
    STRINP_END:
      MOV AL, 00H
      MOV [SI], AL
      POP BP
      POP DI
      POP SI
      POP DX
      POP CX
      POP BX
      POP AX
      RET 4
  STRINP ENDP

  STROUT PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI
    PUSH BP
    MOV BP, SP
    MOV SI, [BP + 14 + 2]
    MOV AH, 02H
    STROUT_OUTPUT:
      MOV AL, 00H
      CMP [SI], AL
      JE STROUT_END
      MOV DL, [SI]
      INT 21H
      INC SI
      JMP STROUT_OUTPUT
    STROUT_END:
      POP BP
      POP DI
      POP SI
      POP DX
      POP CX
      POP BX
      POP AX
      RET 2
  STROUT ENDP

  STRLEN PROC
    PUSH AX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI
    PUSH BP
    MOV BP, SP
    MOV SI, [BP + 12 + 2]
    XOR BX, BX
    STRLEN_CAL_LENGTH:
      MOV AL, 00H
      CMP [SI], AL
      JE STRLEN_END
      INC BX
      INC SI
      JMP STRLEN_CAL_LENGTH
    STRLEN_END:
      POP BP
      POP DI
      POP SI
      POP DX
      POP CX
      POP AX
      RET 2
  STRLEN ENDP

  STRCMP PROC
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI
    PUSH BP
    MOV BP, SP
    MOV SI, [BP + 12 + 4]
    MOV DI, [BP + 12 + 2]
    PUSH SI
    CALL STRLEN
    MOV CL, BL ;length of str1
    PUSH DI
    CALL STRLEN
    MOV CH, BL ;length of str2
    CMP CL, CH
    JE STRCMP_ELSE ;jump if length of str1 is equal to str2
      SUB CL, CH ;if lengths of boths strings are different than just subtracting will give answer 
      MOV AL, CL ;storing result in AL
      POP BP
      POP DI
      POP SI
      POP DX
      POP CX
      POP BX
      RET 4
    STRCMP_ELSE: ;if both strings are of same length than comparing character by character
      STRCMP_CHECK:
        MOV AH, [SI]
        CMP AH, [DI]
        JNE RETURN_STRCMP ;jump if both characters are different
        INC SI
        INC DI
        DEC CL ;loop will run to the length of any of the two strings
        JNZ STRCMP_CHECK
        JMP REMAINING_CMP ;stop from goining into RETURN_STRCMP
      RETURN_STRCMP:
        SUB AH, [DI] ;AH contains character from first string and DI contains character from second string
        MOV AL, AH ;moving result in AL
        POP BP
        POP DI
        POP SI
        POP DX
        POP CX
        POP BX
        RET 4
    REMAINING_CMP:
      MOV AL, 0 ;both strings are equal
    POP BP
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    RET 4
  STRCMP ENDP

  SUBSTR_ PROC
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI
    PUSH BP
    MOV BP, SP
    MOV SI, [BP + 12 + 4]
    MOV DI, [BP + 12 + 2]
    STRCMP_OUTTER:
      MOV AH, [SI]
      CMP AH, [DI]
      JE FIRST_CHAR_FOUND
      JMP SUBSTR_REMAINING
      FIRST_CHAR_FOUND:
        MOV BP, SI
        MOV DX, DI
        AFTER_FIRST_CHAR:
          MOV AH, [SI]
          CMP AH, [DI]
          JNE EXIT_AFTER_FIRST_CHAR
          INC SI
          INC DI
          MOV AH, 00H
          CMP [DI], AH
          JNE AFTER_FIRST_CHAR
          MOV AL, 1D
          JMP SUBSTR_REMAIN
      EXIT_AFTER_FIRST_CHAR:
        MOV SI, BP
        MOV DI, DX
      SUBSTR_REMAINING:
      INC SI
      MOV AH, 00H
      CMP [SI], AH
      JNE STRCMP_OUTTER 
      MOV AL, 0D
      SUBSTR_REMAIN:
        POP BP
        POP DI
        POP SI
        POP DX
        POP CX
        POP BX
      RET 4
  SUBSTR_ ENDP
