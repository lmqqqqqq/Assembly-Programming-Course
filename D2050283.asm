DATA   SEGMENT 
Msg 	DB  	13, 10, "Please input a number: ", 13, 10, "$"
s1  	DB	    9, "Monday", 13, 10, '$'
s2  	DB  	9, "Tuesday", 13, 10, '$'
s3  	DB  	9, "Wednesday", 13, 10, '$'
s4  	DB  	9, "Thursday", 13, 10, '$'
s5  	DB  	9, "Friday", 13, 10, '$'
s6  	DB  	9, "Saturday", 13, 10, '$'
s7  	DB  	9, "Sunday", 13, 10, '$'
err 	DB  	9, "Error!", 13, 10, '$'
ADDTBL  DW      c0,c1,c2,c3,c4,c5,c6,c7,dfa
DATA   ENDS

CODE   SEGMENT 
	ASSUME 	CS: CODE, DS: DATA
Start:  MOV 	AX, DATA
	    MOV 	DS, AX
Again:  MOV 	AH, 9
	    MOV 	DX, Offset Msg
	    INT 	21H
	    MOV 	AH, 1
	    INT 	21H
	    SUB 	AL, '0'
	    JL  	Error   ; 输入字符小于'0'的情况
	    CMP 	AL, 7
	    JLE 	Loc1
Error:  MOV 	AL, 8
Loc1:   MOV 	AH, 0
	    ADD 	AX, AX  ;AX×2
	    MOV 	BX, AX
	    JMP 	Word Ptr DS: ADDTBL [BX]

dfa:    MOV 	DX, Offset err
	    JMP 	EndSwitch
c0:     MOV 	AX, 4C00h
	    INT 	21H
c1:     MOV 	DX, Offset s1
	    JMP 	EndSwitch
c2:     MOV 	DX, Offset s2
	    JMP 	EndSwitch
c3:     MOV 	DX, Offset s3
	    JMP 	EndSwitch
c4:     MOV 	DX, Offset s4
	    JMP 	EndSwitch
c5:     MOV 	DX, Offset s5
	    JMP 	EndSwitch
c6:     MOV 	DX, Offset s6
	    JMP 	EndSwitch
c7:     MOV 	DX, Offset s7
	    JMP 	EndSwitch
EndSwitch:  MOV     AH, 9
	        INT 	21H
	        JMP 	Again
CODE   ENDS
	END 	Start
