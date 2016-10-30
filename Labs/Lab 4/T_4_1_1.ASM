.MODEL SMALL
.STACK 100H
.DATA
        DISPLAY1 DB 10, 13, "Contents of ARR1 are: "
        ARR1 DB "first-$"
        DISPLAY2 DB 10, 13, "Contents of ARR2 are: "
        ARR2 DB "second$"
.CODE
MAIN PROC
        MOV AX, @DATA
        MOV DS, AX

        MOV SI, OFFSET ARR1
        MOV DI, OFFSET ARR2
        MOV CX, 6
AGAIN:
        MOV AL, [SI]
        MOV BL, [DI]
        MOV [DI], AL
        MOV [SI], BL
        INC SI
        INC DI
        DEC CX
        JNZ AGAIN

        MOV DX, OFFSET DISPLAY1
        MOV AH, 09
        INT 21H

        MOV DX, OFFSET DISPLAY2
        MOV AH, 09
        INT 21H

        MOV AH, 4CH
        INT 21H
MAIN ENDP
END MAIN

