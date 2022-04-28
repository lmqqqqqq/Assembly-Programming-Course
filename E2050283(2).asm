MYDATA SEGMENT
DATA DW 1234H,5678H,9B4DH,0D7H,0,-1,7F2EH,8E0AH,10F5H,645DH
N EQU $-DATA
MIN     DW      ?
MYDATA ENDS

CODE    SEGMENT
        ASSUME  CS:CODE,DS:MYDATA
MAIN PROC FAR
        PUSH	DS
		MOV	    AX,0
		PUSH	AX
        MOV     AX,MYDATA
        MOV     DS,AX
        MOV     CX,N-1
        MOV     BX,OFFSET DATA
        MOV     AX,[BX]
AGAIN:  INC     BX
        MOV     SI, [BX]
        TEST    SI, 01H
        JNZ     NEXT
        CMP     AX,[BX]
        JLE     NEXT
        MOV     AX,[BX]
NEXT:   LOOP    AGAIN

        MOV     MIN,AX
        MOV     BX,AX
        CALL    PRINTPROC
        RET
MAIN    ENDP

PRINTPROC   PROC      
        MOV     CH,2
        MOV     CL,4
ROTATE: ROR     BH,CL
        MOV     AL,BH
        AND     AL,0FH
        ADD     AL,30H
        CMP     AL,3AH
        JL      PRINTIT
        ADD     AL,7
PRINTIT:MOV     DL,AL
        MOV     AH,2
        INT     21H
        DEC     CH
        JNZ     ROTATE
        MOV     CH,2
        MOV     CL,4
ROTATE2: ROR     BL,CL
        MOV     AL,BL
        AND     AL,0FH
        ADD     AL,30H
        CMP     AL,3AH
        JL      PRINTIT2
        ADD     AL,7
PRINTIT2:MOV     DL,AL
        MOV     AH,2
        INT     21H
        DEC     CH
        JNZ     ROTATE2                
        MOV     AH,2
        MOV     DL,48H
        INT     21H
        RET
PRINTPROC   ENDP

CODE    ENDS
END     MAIN
