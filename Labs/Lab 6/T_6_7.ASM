.MODEL SMALL
.STACK 100H
.DATA
    newline DB 10, 13, "$"
.CODE
MAIN PROC
    ;
    ;initilization of data segment
    ;
    MOV AX, @DATA
    MOV DS, AX
    ;
    ;initializing ASCII and counter
    ;
    MOV DL, 00H
    MOV CX, 7FH
    ;
    ;this loop display rows
    ;
    ROW:
        MOV AH, 02H
        ;
        ;every row has 10 columns
        ;
        MOV BL, 10D
        ;
        ;this loop display ASCII characters
        ;
        COL:
            ;
            ;display ASCII character
            ;
            INT 21H
            ;
            ;next ASCII character to display
            ;
            INC DL
            ;
            ;decrementing so loop can be terminated
            ;
            DEC BL
            JNZ COL
        ;
        ;svaing content of DL so newline can be displayed using DX
        ;
        MOV BH, DL
        ;
        ;display newline
        ;
        MOV AH, 09H
        LEA DX, newline
        INT 21H
        ;
        ;putting back value in DL
        ;
        MOV DL, BH
        ;
        ;CX is automatically decremented and checked
        ;
        LOOP ROW
    ;
    ;exit DOS
    ;
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN