#include		"Global.inc"

; Audio processor TDA7439
; адрес ведомого устройства
SLAVEADDR		equ		10001000B	; R/W Flag (8th bit) must be 0 (Read)
; подадрес команды
SUBADDRAI		equ		00010000B	; автоинкримент подадреса
SUBADDRIN		equ		00000000B	; селектор входов
SUBADDRGN		equ		00000001B	; предусиление
SUBADDRVL		equ		00000010B	; громкость
SUBADDRBS		equ		00000011B	; низкие частоты
SUBADDRML		equ		00000100B	; средние частоты
SUBADDRTL		equ		00000101B	; высокие частоты
SUBADDRAR		equ		00000110B	; аттенюатор правого канала
SUBADDRAL		equ		00000111B	; аттенюатор левого канала

;*******************************************************************************
; Audio processor commands
;
; Usage: movlw	AP_VOL32|AP_VOL7	; set volume in -39 dB	
;*******************************************************************************
; Input Channel:
AP_IN4			equ		00000000B	;
AP_IN3			equ		00000001B	;
AP_IN2			equ		00000010B	;
AP_IN1			equ		00000011B	;
;*******************************************************************************
; Input Gain with step +2 dB:
AP_GAIN0		equ		00000000B	;
AP_GAIN2		equ		00000001B	;
AP_GAIN4		equ		00000010B	;
AP_GAIN6		equ		00000011B	;
AP_GAIN8		equ		00000100B	;
AP_GAIN10		equ		00000101B	;
AP_GAIN12		equ		00000110B	;
AP_GAIN14		equ		00000111B	;
AP_GAIN16		equ		00001000B	;
AP_GAIN18		equ		00001001B	;
AP_GAIN20		equ		00001010B	;
AP_GAIN22		equ		00001011B	;
AP_GAIN24		equ		00001100B	;
AP_GAIN26		equ		00001101B	;
AP_GAIN28		equ		00001110B	;
AP_GAIN30		equ		00001111B	;
;*******************************************************************************
; Volume
; -8 dB step:
AP_VOL8			equ		00001000B	;
AP_VOL16		equ		00010000B	;
AP_VOL24		equ		00011000B	;
AP_VOL32		equ		00100000B	;
AP_VOL40		equ		00101000B	;
AP_VOLMUTE		equ		00111000B	;
; -1 dB step:
AP_VOL0			equ		00000000B	;
AP_VOL1			equ		00000001B	;
AP_VOL2			equ		00000010B	;
AP_VOL3			equ		00000011B	;
AP_VOL4			equ		00000100B	;
AP_VOL5			equ		00000101B	;
AP_VOL6			equ		00000110B	;
AP_VOL7			equ		00000111B	;
;*******************************************************************************
; Bass, Midle and Treble
; Sign:
AP_FRQP			equ		00001000B	;
AP_FRQM			equ		00000000B	;
; Level with step 2 dB:
AP_FRQ0			equ		00000111B	;
AP_FRQ2			equ		00000110B	;
AP_FRQ4			equ		00000101B	;
AP_FRQ6			equ		00000100B	;
AP_FRQ8			equ		00000011B	;
AP_FRQ10		equ		00000010B	;
AP_FRQ12		equ		00000001B	;
AP_FRQ14		equ		00000000B	;		
;*******************************************************************************
; Speaker Attenuators
; -8 dB step:
AP_ATT8			equ		00001000B	;
AP_ATT16		equ		00010000B	;
AP_ATT24		equ		00011000B	;
AP_ATT32		equ		00100000B	;
AP_ATT40		equ		00101000B	;
AP_ATT48		equ		00110000B	;
AP_ATT56		equ		00111000B	;
AP_ATT64		equ		01000000B	;
AP_ATT72		equ		01001000B	;
AP_ATTMUTE		equ		01111000B	;
; -1 dB step:
AP_ATT0			equ		00000000B	;
AP_ATT1			equ		00000001B	;
AP_ATT2			equ		00000010B	;
AP_ATT3			equ		00000011B	;
AP_ATT4			equ		00000100B	;
AP_ATT5			equ		00000101B	;
AP_ATT6			equ		00000110B	;
AP_ATT7			equ		00000111B	;

;*******************************************************************************
