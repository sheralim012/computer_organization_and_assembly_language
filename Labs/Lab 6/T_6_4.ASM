.MODEL SMALL
.STACK 100H
.DATA
    prompt DB 10, 13, "Enter size: $"
    newLine DB 10, 13, "$"
    totalRows DB ?
    totalCols DB ?
.CODE
MAIN PROC
    ;
    ;initialization of data segment
    ;
    MOV AX, @DATA
    MOV DS, AX
    ;
    ;display prompt
    ;
    MOV AH, 09H
    LEA DX, prompt
    INT 21H
    ;
    ;input single character
    ;
    MOV AH, 01H
    INT 21H
    ;
    ;converting character to digit
    ;
    SUB AL, 48D
    ;
    ;initializing totalRows
    ;
    MOV totalRows, AL
    ;
    ;helps in print columns of rows - every row has same number of * as row number
    ;
    MOV BL, 1D
    ;
    ;display newLine
    ;
    MOV AH, 09H
    LEA DX, newLine
    INT 21H
    ;
    ;this loop control rows
    ;
    ROW:
        MOV totalCols, BL ;each row have same number of columns as row number
        MOV DL, '*'
        MOV AH, 02H
        COL:
            ;
            ;display *
            ;
            INT 21H
            ;
            ;decrementing totalCols so loop can be ended
            ;
            DEC totalCols
            JNZ COL
        ;
        ;incrementing BL because every row has one more * than previous roe
        ;
        INC BL
        ;
        ;display newLine
        ;
        MOV AH, 09H
        LEA DX, newLine
        INT 21H
        ;
        ;decrementing totalRows so loop can be ended
        ;
        DEC totalRows
        JNZ ROW
    ;
    ;exit DOS
    ;
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN