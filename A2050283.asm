DATA    SEGMENT
X   DW      32, 100, 128, 1025
Y   DW      4 DUP (-1)
DATA    ENDS
CODE    SEGMENT
	ASSUME  CS: CODE, DS: DATA
START:  MOV     AX, DATA
	MOV DS, AX
	MOV AX, X+2       ;ȡ��X�����2��Ԫ��
	MOV Y+2, AX       ;����Y�����2��Ԫ����
	MOV X+2,0         ;X����ڶ���Ԫ������
	MOV AX, X+6       ;ȡ��X�����4��Ԫ��
	MOV Y+6, AX       ;����Y�����4��Ԫ����
	MOV X+6,0         ;X������ĸ�Ԫ������
	MOV AX, 4C00H
	INT     21H
CODE    ENDS
	END START
