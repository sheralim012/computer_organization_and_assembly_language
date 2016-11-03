.MODEL SMALL
.STACK 100H
.DATA
  str1 DB 10, 13, "Enter first character: $"
  str2 DB 10, 13, "Enter Second character: $"
  str3 DB 10, 13, "Enter third character: $"
  str4 DB 10, 13, "The other remaining character is: $"
  CH1 DB ?
  CH2 DB ?
.CODE
MAIN PROC
  ;
  ;initialization of data segment
  ;
  MOV AX, @DATA
  MOV DS, AX
  ;
  ;display str1
  ;
  MOV AH, 09H
  MOV DX, OFFSET str1
  INT 21H
  ;
  ;input first character
  ;
  MOV AH, 01H
  INT 21H
  ;
  ;saving AL so second character can be taken
  ;
  MOV CH1, AL
  ;
  ;display str2
  ;
  MOV AH, 09H
  MOV DX, OFFSET str2
  INT 21H
  ;
  ;input second character
  ;
  MOV AH, 01H
  INT 21h
  ;
  ;saving AL so third character can be taken
  ;
  MOV CH2, AL
  ;
  ;dispaly str3
  ;
  MOV AH, 09H
  MOV DX, OFFSET str3
  INT 21H
  ;
  ;input third character
  ;
  MOV AH, 01H
  INT 21H
  ;
  ;display str4
  ;
  MOV AH, 09H
  MOV DX, OFFSET str4
  INT 21H
  ;
  ;a = a + b
  ;a = a - c
  ;
  MOV BH, CH1
  MOV BL, CH2
  ADD BH, BL
  SUB BH, AL
  ;
  ;display remaining character
  ;
  MOV DL, BH
  MOV AH, 02H
  INT 21H
  ;
  ;exit DOS
  ;
  MOV AH, 4CH
  INT 21H
MAIN ENDP
END MAIN
