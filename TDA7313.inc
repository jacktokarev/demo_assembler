#include		"Global.inc"

; Audio processor TDA7313
SLAVEADDR		equ		10001000B	; R/W Flag (8th bit) must be 0 (Read)

;*******************************************************************************
; Audio processor commands
;
; Usage: movlw	AP_VOL|AP_VOL_40|AP_VOL_3c75 ; set volume in -43,75 dB	
;*******************************************************************************		
; Volume
AP_VOL			equ		00000000B	;
; -10 dB step:
AP_VOL_10		equ		00001000B	;
AP_VOL_20		equ		00010000B	;
AP_VOL_30		equ		00011000B	;
AP_VOL_40		equ		00100000B	;
AP_VOL_50		equ		00101000B	;
AP_VOL_60		equ		00110000B	;
AP_VOL_70		equ		00111000B	;
; -1,25 dB step:
AP_VOL_1c25		equ		00000001B	;
AP_VOL_2c5		equ		00000010B	;
AP_VOL_3c75		equ		00000011B	;
AP_VOL_5		equ		00000100B	;
AP_VOL_6c25		equ		00000101B	;
AP_VOL_7c5		equ		00000110B	;
AP_VOL_8c75		equ		00000111B	;
		
;*******************************************************************************
; Speaker Attenuators
AP_ATT_LF		equ		10000000B	; Front Left
AP_ATT_RF		equ		10100000B	; Front Right
AP_ATT_LR		equ		11000000B	; Rear Left
AP_ATT_RR		equ		11100000B	; Rear Right
; -10 dB step:
AP_ATT_10		equ		00001000B	;
AP_ATT_20		equ		00010000B	;
AP_ATT_30		equ		00011000B	;
; -1,25 step:
AP_ATT_1c25		equ		00000001B	;
AP_ATT_2c5		equ		00000010B	;
AP_ATT_3c75		equ		00000011B	;
AP_ATT_5		equ		00000100B	;
AP_ATT_6c25		equ		00000101B	;
AP_ATT_7c5		equ		00000110B	;
AP_ATT_8c75		equ		00000111B	;

;*******************************************************************************
; Audio Switch
AP_ASW			equ		01000000B	;
; Gain with step +3,75 dB:
AP_ASW_G_0		equ		00011000B	;
AP_ASW_G_3c75	equ		00010000B	;
AP_ASW_G_7c5	equ		00001000B	;
AP_ASW_G_11c25	equ		00000000B	;
; LOUDNESS On/Off:
AP_ASW_LOUD_ON	equ		00000000B	;
AP_ASW_LOUD_OFF	equ		00000100B	;
; Input Channel:
AP_ASW_CNL_1	equ		00000000B	;
AP_ASW_CNL_2	equ		00000001B	;
AP_ASW_CNL_3	equ		00000010B	;
AP_ASW_CNL_4	equ		00000011B	; Off

;*******************************************************************************
; Bass and Treble
AP_FRQ			equ		01100000B	;
AP_FRQ_B		equ		00000000B	;
AP_FRQ_T		equ		00010000B	;
; Sign:
AP_FRQ_S_P		equ		00001000B	;
AP_FRQ_S_M		equ		00000000B	;
; Level with step 2 dB:
AP_FRQ_L_0		equ		00000111B	;
AP_FRQ_L_2		equ		00000110B	;
AP_FRQ_L_4		equ		00000101B	;
AP_FRQ_L_6		equ		00000100B	;
AP_FRQ_L_8		equ		00000011B	;
AP_FRQ_L_10		equ		00000010B	;
AP_FRQ_L_12		equ		00000001B	;
AP_FRQ_L_14		equ		00000000B	;
