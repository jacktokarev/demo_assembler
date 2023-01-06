#include		"Global.inc"
	
ENC_PORT		equ			PORTB
ENC_A_POS		equ			BIT6
ENC_B_POS		equ			BIT7
	
#define			ENC_A		BANKMASK(ENC_PORT),ENC_A_POS
#define			ENC_B		BANKMASK(ENC_PORT),ENC_B_POS
