#include "main.inc"
	
; CONFIG
CONFIG  FOSC = INTOSCIO       ; Oscillator Selection bits (INTOSC oscillator: I/O function on RA6/OSC2/CLKOUT pin, I/O function on RA7/OSC1/CLKIN)
CONFIG  WDTE = OFF            ; Watchdog Timer Enable bit (WDT disabled)
CONFIG  PWRTE = ON            ; Power-up Timer Enable bit (PWRT enabled)
CONFIG  MCLRE = OFF           ; RA5/MCLR/VPP Pin Function Select bit (RA5/MCLR/VPP pin function is digital input, MCLR internally tied to VDD)
CONFIG  BOREN = ON            ; Brown-out Detect Enable bit (BOD enabled)
CONFIG  LVP = OFF             ; Low-Voltage Programming Enable bit (RB4/PGM pin has digital I/O function, HV on MCLR must be used for programming)
CONFIG  CPD = OFF             ; Data EE Memory Code Protection bit (Data memory code protection off)
CONFIG  CP = OFF              ; Flash Program Memory Code Protection bit (Code protection off)


;==========================================================================
;
;       Register Definitions
;
;==========================================================================
; Used Registers
psect	udata_bank0
REG020:		DS	1	;	equ	020h
REG021:		DS	1	;	equ	021h
REG022:		DS	1	;		equ	022h
REG023:		DS	1	;		equ	023h
REG024:		DS	1	;		equ	024h
BAL_TMP:		DS	1	;		equ	025h
BASS_TMP:		DS	1	;		equ	026h
CNL_TMP:		DS	1	;		equ	027h
REG028:		DS	1	;		equ	028h
ENC_rot:		DS	1	;		equ	029h
REG02A:		DS	1	;		equ	02Ah
PAMP_TMP:		DS	1	;		equ	02Bh
PRESSED_KEY:		DS	1	;		equ	02Ch
WH8REG:		DS	1	;	equ	02Dh
TRBL_TMP:		DS	1	;		equ	02Eh
VOL_TMP:		DS	1	;		equ	02Fh
TIME_pl1:		DS	1	;		equ	030h
PKG_lcd:		DS	1	;		equ	031h
BIT_POSITION:		DS	1	;		equ	032h
CURSOR_POSITION_LCD:		DS	1	;		equ	033h
COUNT3:		DS	1	;		equ	034h
COUNT4:		DS	1	;		equ	035h
REG036:		DS	1	;		equ	036h
REG037:		DS	1	;		equ	037h
COUNT1:		DS	1	;		equ	038h
COUNT2:		DS	1	;		equ	039h
REG03A:		DS	1	;		equ	03Ah
REG03B:		DS	1	;		equ	03Bh
	
psect		udata_shr

REG070:		DS	1	;		equ	070h
REG071:		DS	1	;		equ	071h
REG072:		DS	1	;		equ	072h
REG073:		DS	1	;		equ	073h
TMP_STATUS:		DS	1	;		equ	074h
TMP_PCLATH:		DS	1	;		equ	075h
REG076:		DS	1	;		equ	076h
ENC_B:		DS	1	;		equ	077h
REG078:		DS	1	;		equ	078h
REG079:		DS	1	;		equ	079h
REG07A:		DS	1	;		equ	07Ah
REG07B:		DS	1	;		equ	07Bh
REG07C:		DS	1	;		equ	07Ch
ENC_A:		DS	1	;		equ	07Dh
TMP_W:		DS	1	;		equ	07Eh
	
;REG020	equ	020h
;REG021	equ	021h
;REG022	equ	022h
;REG023	equ	023h
;REG024	equ	024h
;BAL_TMP	equ	025h
;BASS_TMP	equ	026h
;CNL_TMP	equ	027h
;REG028	equ	028h
;ENC_rot	equ	029h
;REG02A	equ	02Ah
;PAMP_TMP	equ	02Bh
;PRESSED_KEY	equ	02Ch
;WH8REG	equ	02Dh
;TRBL_TMP	equ	02Eh
;VOL_TMP	equ	02Fh
;TIME_pl1	equ	030h
;PKG_lcd	equ	031h
;BIT_POSITION	equ	032h
;CURSOR_POSITION_LCD	equ	033h
;COUNT3	equ	034h
;COUNT4	equ	035h
;REG036	equ	036h
;REG037	equ	037h
;COUNT1	equ	038h
;COUNT2	equ	039h
;REG03A	equ	03Ah
;REG03B	equ	03Bh
;REG070	equ	070h
;REG071	equ	071h
;REG072	equ	072h
;REG073	equ	073h
;TMP_STATUS	equ	074h
;TMP_PCLATH	equ	075h
;REG076	equ	076h
;ENC_B	equ	077h
;REG078	equ	078h
;REG079	equ	079h
;REG07A	equ	07Ah
;REG07B	equ	07Bh
;REG07C	equ	07Ch
;ENC_A	equ	07Dh
;TMP_W	equ	07Eh
	
psect	edata
	DW	0X53,0x74,0x61,0x6e,0x64,0x20,0x62,0x79,0
	DW	0x56,0x6f,0x6c,0x75,0x6d,0x65,0
	DW	0x54,0x72,0x65,0x62,0x6c,0x65,0
	DW	0x42,0x61,0x73,0x73,0
	DW	0x42,0x61,0x6c,0x61,0x6e,0x63,0x65,0
	DW	0x50,0x72,0x65,0x61,0x6d,0x70,0x6c,0x69,0x66,0x65,0x72,0
	DW	0x43,0x68,0x65,0x6e,0x61,0x6c,0
	DW	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff
	DW	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff
	DW	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff
	DW	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff
	DW	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff
	DW	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff
	DW	0x20,0x53,0x55,0x50,0x45,0x52,0x2d,0x20
	DW	0x20,0x4e,0x41,0x53,0x54,0x59,0x41,0x20
	DW	0x0a,0x08,0x0a,0x20,0x00,0x01,0xff,0xff	


;*******************************************************************************
psect ResVect, class=CODE, abs, delta=2
	org	0x0000
ResetVector:
	goto		start
	org	0x0004
;*******************************************************************************
HighInterruptVector:
	movwf		TMP_W		; сохранить значение аккумулятора
	movf		STATUS,W	; сохранить
	movwf		TMP_STATUS	; состояние регистра STATUS
	movf		PCLATH,W	; сохранить
	movwf		TMP_PCLATH	; значение PCLATH
	goto		intrpt		; переход на обработку прерывания
;*******************************************************************************
;start:
;	goto		start1
L_000B:
	movlw		0x00		;b'0000 0000',' ',.00
	movwf		PCLATH
	movf		FSR,W
	incf		FSR,F
	addwf		PCL,F
	retlw		0x00		;b'0000 0000',' ',.00
	retlw		0x00		;b'0000 0000',' ',.00
	retlw		0x00		;b'0000 0000',' ',.00
	retlw		0x01		;b'0000 0001',' ',.01
	retlw		0x02		;b'0000 0010',' ',.02
	retlw		0x03		;b'0000 0011',' ',.03
	retlw		0x04		;b'0000 0100',' ',.04
	retlw		0x05		;b'0000 0101',' ',.05
	retlw		0x06		;b'0000 0110',' ',.06
	retlw		0x07		;b'0000 0111',' ',.07
	retlw		0x0F		;b'0000 1111',' ',.15
	retlw		0x0E		;b'0000 1110',' ',.14
	retlw		0x0D		;b'0000 1101',' ',.13
	retlw		0x0C		;b'0000 1100',' ',.12
	retlw		0x0B		;b'0000 1011',' ',.11
	retlw		0x0A		;b'0000 1010',' ',.10
	retlw		0x09		;b'0000 1001',' ',.09
	retlw		0x08		;b'0000 1000',' ',.08
;*******************************************************************************
start:
	bcf		STATUS,7	;банки 0, 1 при косвенной адресации 
	movlw		0x20		;адрес первого регистра диапозона
	movwf		FSR
	movlw		0x30		;адрес последнего регистра диапозона
	call		clrregs		;очистка диапазона регистров
;	movlw		0x01		;b'0000 0001',' ',.01
	movwf		REG03A
	movwf		REG03B
	clrf		STATUS
	call		init_ports		; настойка портов
	call		_init_lcd
	call		fill_CGRAM	; запись своих символов в CGRAM
	call		disp_off
;	call		start4		; инициализация LCD
;*******************************************************************************
;start2:
;	movlw		0xFF		;
;	movwf		COUNT1
;	movwf		COUNT2
;pause1:
;	movlw		0x01		;
;	subwf		COUNT1,F
;	movlw		0x00		;
;	btfss		CARRY
;	    decf	COUNT2,F
;	subwf		COUNT2,F
;;	incf		COUNT1,W
;	btfsc		ZERO
;	    incf	COUNT2,W
;	btfss		ZERO
;	    goto	pause1
;	call		init_ports		; настойка портов
;	call		start4		; инициализация LCD
;*******************************************************************************
; Чтение настроек из EEPROM
COPYEEDT    MACRO   EADR, FREG
	movlw		EADR
	BANKSEL		EEADR
	movwf		EEADR
	bsf		EECON1, 0
	movf		EEDATA, W
	BANKSEL		FREG
	movwf		FREG
	ENDM
	
	COPYEEDT	0x78, VOL_TMP
	COPYEEDT	0x79, TRBL_TMP
	COPYEEDT	0x7A, BASS_TMP
	COPYEEDT	0x7B, BAL_TMP
	COPYEEDT	0x7C, PAMP_TMP
	COPYEEDT	0x7D, CNL_TMP
	
;	movlw		0x78		; громкость
;;	bsf		RP0
;	BANKSEL		EEADR
;	movwf		EEADR
;	bsf		EECON1,0
;	movf		EEDATA,W
;;	bcf		RP0
;	BANKSEL		VOL_TMP
;	movwf		VOL_TMP
;	movlw		0x79		; высокие
;;	bsf		RP0
;	BANKSEL		EEADR
;	movwf		EEADR
;	bsf		EECON1,0
;	movf		EEDATA,W
;;	bcf		RP0
;	BANKSEL		TRBL_TMP
;	movwf		TRBL_TMP
;	movlw		0x7A		; низкие
;;	bsf		RP0
;	BANKSEL		EEADR
;	movwf		EEADR
;	bsf		EECON1,0
;	movf		EEDATA,W
;;	bcf		RP0
;	BANKSEL		BASS_TMP
;	movwf		BASS_TMP
;	movlw		0x7B		; балланс
;;	bsf		RP0
;	BANKSEL		EEADR
;	movwf		EEADR
;	bsf		EECON1,0
;	movf		EEDATA,W
;;	bcf		RP0
;	BANKSEL		BAL_TMP
;	movwf		BAL_TMP
;	movlw		0x7C		; предусиление
;;	bsf		RP0
;	BANKSEL		EEADR
;	movwf		EEADR
;	bsf		EECON1,0
;	movf		EEDATA,W
;;	bcf		RP0
;	BANKSEL		PAMP_TMP
;	movwf		PAMP_TMP
;	movlw		0x7D		; канал
;;	bsf		RP0
;	BANKSEL		EEADR
;	movwf		EEADR
;	bsf		EECON1,0
;	movf		EEDATA,W
;;	bcf		RP0
;	BANKSEL		CNL_TMP
;	movwf		CNL_TMP
;*******************************************************************************
	call		L_028F
	call		L_056E
L_005E:
	call		check_KEY
	movf		PRESSED_KEY,W
	btfsc		ZERO
	    goto	L_0096
	movf		PRESSED_KEY,W
	xorlw		0x04		;b'0000 0100',' ',.04
	btfss		ZERO
	    goto	L_006C
	call		on_of_LED
L_0067:
	movf		PRESSED_KEY,F
	btfsc		ZERO
	    goto	L_006C
	call		check_KEY
	goto		L_0067
L_006C:
	movf		REG03B,F
	btfsc		ZERO
	    goto	L_007A
	goto		L_0084
L_0070:
	call		invertor
L_0071:
	movf		PRESSED_KEY,F
	btfsc		ZERO
	    goto	L_0084
	call		check_KEY
	goto		L_0071
L_0076:
	call		wheel_8
	goto		L_0084
L_0078:
	call		L_05AC
	goto		L_0084
L_007A:
	movf		PRESSED_KEY,W
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
	    goto	L_0070
	xorlw		0x03		;b'0000 0011',' ',.03
	btfsc		ZERO
	    goto	L_0076
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
	    goto	L_0078
L_0084:
	call		L_056E
	movlw		0xFF		;b'1111 1111','я',.255
	movwf		REG022
	movwf		REG023
	movwf		COUNT1
	movlw		0x8F		;b'1000 1111','Џ',.143
	movwf		COUNT2
L_008B:
	movlw		0x01		;b'0000 0001',' ',.01
	subwf		COUNT1,F
	movlw		0x00		;b'0000 0000',' ',.00
	btfss		CARRY
	    decf	COUNT2,F
	subwf		COUNT2,F
	incf		COUNT1,W
	btfsc		ZERO
	    incf	COUNT2,W
	btfss		ZERO
	    goto	L_008B
L_0096:
	decfsz		REG028,W
	    goto	L_00A2
	clrf		REG028
	decfsz		REG02A,W
	    goto	L_009D
	call		encoder_plus
	goto		L_009E
L_009D:
	call		encoder_minus
L_009E:
	movlw		0xFF		;b'1111 1111','я',.255
	movwf		REG022
	movwf		REG023
	call		L_0380
L_00A2:
	movf		REG024,W
	btfsc		ZERO
	    goto	L_010D
	movf		REG024,W
	xorlw		0x0C		;b'0000 1100',' ',.12
	btfss		ZERO
	    goto	L_00AE
	movf		REG021,W
	iorwf		REG020,W
	btfss		ZERO
	    goto	L_00AE
	call		on_of_LED
L_00AE:
	movf		REG03B,F
	btfsc		ZERO
	    goto	L_00DC
	goto		L_0104
L_00B2:
	clrf		CNL_TMP
	incf		CNL_TMP,F
	goto		L_0104
L_00B5:
	movlw		0x02		;b'0000 0010',' ',.02
	goto		L_00B8
L_00B7:
	movlw		0x03		;b'0000 0011',' ',.03
L_00B8:
	movwf		CNL_TMP
	goto		L_0104
L_00BA:
	movf		REG021,W
	iorwf		REG020,W
	btfss		ZERO
	    goto	L_0104
	call		invertor
	goto		L_0104
L_00C0:
	movf		REG021,W
	iorwf		REG020,W
	btfss		ZERO
	    goto	L_0104
	call		wheel_8
	goto		L_0104
L_00C6:
	movf		REG021,W
	iorwf		REG020,W
	btfss		ZERO
	    goto	L_0104
	call		L_05AC
	goto		L_0104
L_00CC:
	call		encoder_minus
	goto		L_0104
L_00CE:
	call		encoder_plus
	goto		L_0104
L_00D0:
	clrf		WH8REG
	incf		WH8REG,F
	goto		L_0104
L_00D3:
	movlw		0x02		;b'0000 0010',' ',.02
	goto		L_00DA
L_00D5:
	movlw		0x03		;b'0000 0011',' ',.03
	goto		L_00DA
L_00D7:
	movlw		0x04		;b'0000 0100',' ',.04
	goto		L_00DA
L_00D9:
	movlw		0x05		;b'0000 0101',' ',.05
L_00DA:
	movwf		WH8REG
	goto		L_0104
L_00DC:
	movf		REG024,W
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
	    goto	L_00B2
	xorlw		0x03		;b'0000 0011',' ',.03
	btfsc		ZERO
	    goto	L_00B5
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
	    goto	L_00B7
	xorlw		0x0E		;b'0000 1110',' ',.14
	btfsc		ZERO
	    goto	L_00BA
	xorlw		0x1D		;b'0001 1101','',.29
	btfsc		ZERO
	    goto	L_00C0
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
	    goto	L_00C6
	xorlw		0x04		;b'0000 0100',' ',.04
	btfsc		ZERO
	    goto	L_00CC
	xorlw		0x03		;b'0000 0011',' ',.03
	btfsc		ZERO
	    goto	L_00CE
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
	    goto	L_00D0
	xorlw		0x3C		;b'0011 1100','<',.60
	btfsc		ZERO
	    goto	L_00D3
	xorlw		0x07		;b'0000 0111',' ',.07
	btfsc		ZERO
	    goto	L_00D5
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
	    goto	L_00D7
	xorlw		0x03		;b'0000 0011',' ',.03
	btfsc		ZERO
	    goto	L_00D9
L_0104:
	clrf		REG024
	call		L_056E
	movlw		0xFF		;b'1111 1111','я',.255
	movwf		REG020
	movlw		0x04		;b'0000 0100',' ',.04
	movwf		REG021
	movlw		0xFF		;b'1111 1111','я',.255
	movwf		REG022
	movwf		REG023
L_010D:
	movf		REG021,W
	iorwf		REG020,W
	btfsc		ZERO
	    goto	L_0117
	movlw		0x01		;b'0000 0001',' ',.01
	subwf		REG020,F
	movlw		0x00		;b'0000 0000',' ',.00
	btfss		CARRY
	    decf	REG021,F
	subwf		REG021,F
L_0117:
	movf		REG023,W
	iorwf		REG022,W
	btfsc		ZERO
	    goto	L_0124
	movf		WH8REG,W
	btfsc		ZERO
	    goto	L_0124
	movlw		0x01		;b'0000 0001',' ',.01
	subwf		REG022,F
	movlw		0x00		;b'0000 0000',' ',.00
	btfss		CARRY
	    decf	REG023,F
	subwf		REG023,F
L_0124:
	decf		REG022,W
	iorwf		REG023,W
	btfss		ZERO
	    goto	L_005E
	clrf		WH8REG
	incf		WH8REG,F
	call		L_056E
;*******************************************************************************
;EEPROM_SAVE  MACRO	EADR, REG
;;	bsf		RP0
;	BANKSEL		EECON1
;	btfsc		WR
;	    goto	save_VOL
;	movlw		0x78		;b'0111 1000','x',.120
;	movwf		EEADR
;;	bcf		RP0
;	BANKSEL		VOL_TMP
;	movf		VOL_TMP,W
;;	bsf		RP0
;	BANKSEL		EEDATA
;	movwf		EEDATA
;	bcf		CARRY
;	btfsc		GIE
;	    bsf		CARRY
;	bcf		GIE
;	bsf		WREN
;	movlw		0x55		;b'0101 0101','U',.85
;	movwf		EECON2
;	movlw		0xAA		;b'1010 1010','Є',.170
;	movwf		EECON2
;	bsf		WR
;	bcf		WREN
;	btfsc		CARRY
;	    bsf		GIE
;*******************************************************************************
save_VOL:
;	bsf		RP0
	BANKSEL		EECON1
	btfsc		WR
	    goto	save_VOL
	movlw		0x78		;b'0111 1000','x',.120
	movwf		EEADR
;	bcf		RP0
	BANKSEL		VOL_TMP
	movf		VOL_TMP,W
;	bsf		RP0
	BANKSEL		EEDATA
	movwf		EEDATA
	bcf			CARRY
	btfsc		GIE
	    bsf		CARRY
	bcf			GIE
	bsf			WREN
	movlw		0x55		;b'0101 0101','U',.85
	movwf		EECON2
	movlw		0xAA		;b'1010 1010','Є',.170
	movwf		EECON2
	bsf			WR
	bcf			WREN
	btfsc		CARRY
	    bsf		GIE
;*******************************************************************************
save_TRBL:
	btfsc		WR
		goto	save_TRBL
	movlw		0x79		;b'0111 1001','y',.121
	movwf		EEADR
	bcf			RP0
	movf		TRBL_TMP,W
	bsf			RP0
	movwf		EEDATA
	bcf			CARRY
	btfsc		GIE
		bsf		CARRY
	bcf			GIE
	bsf			WREN
	movlw		0x55		;b'0101 0101','U',.85
	movwf		EECON2
	movlw		0xAA		;b'1010 1010','Є',.170
	movwf		EECON2
	bsf			WR
	bcf			WREN
	btfsc		CARRY
		bsf		GIE
;*******************************************************************************
save_BASS:
	btfsc		WR
		goto	save_BASS
	movlw		0x7A		;b'0111 1010','z',.122
	movwf		EEADR
	bcf			RP0
	movf		BASS_TMP,W
	bsf			RP0
	movwf		EEDATA
	bcf			CARRY
	btfsc		GIE
		bsf		CARRY
	bcf			GIE
	bsf			WREN
	movlw		0x55		;b'0101 0101','U',.85
	movwf		EECON2
	movlw		0xAA		;b'1010 1010','Є',.170
	movwf		EECON2
	bsf			WR
	bcf			WREN
	btfsc		CARRY
		bsf		GIE
;*******************************************************************************
save_BAL:
	btfsc		WR
		goto	save_BAL
	movlw		0x7B		;b'0111 1011','{',.123
	movwf		EEADR
	bcf			RP0
	movf		BAL_TMP,W
	bsf			RP0
	movwf		EEDATA
	bcf			CARRY
	btfsc		GIE
		bsf		CARRY
	bcf			GIE
	bsf			WREN
	movlw		0x55		;b'0101 0101','U',.85
	movwf		EECON2
	movlw		0xAA		;b'1010 1010','Є',.170
	movwf		EECON2
	bsf			WR
	bcf			WREN
	btfsc		CARRY
		bsf		GIE
;*******************************************************************************
save_PAMP:
	btfsc		WR
		goto	save_PAMP
	movlw		0x7C		;b'0111 1100','|',.124
	movwf		EEADR
	bcf			RP0
	movf		PAMP_TMP,W
	bsf			RP0
	movwf		EEDATA
	bcf			CARRY
	btfsc		GIE
		bsf		CARRY
	bcf			GIE
	bsf			WREN
	movlw		0x55		;b'0101 0101','U',.85
	movwf		EECON2
	movlw		0xAA		;b'1010 1010','Є',.170
	movwf		EECON2
	bsf			WR
	bcf			WREN
	btfsc		CARRY
		bsf		GIE
;*******************************************************************************
save_CNL:
	btfsc		WR
		goto	save_CNL
	movlw		0x7D		;b'0111 1101','}',.125
	movwf		EEADR
	bcf			RP0
	movf		CNL_TMP,W
	bsf			RP0
	movwf		EEDATA
	bcf			CARRY
	btfsc		GIE
	bsf			CARRY
	bcf			GIE
	bsf			WREN
	movlw		0x55		;b'0101 0101','U',.85
	movwf		EECON2
	movlw		0xAA		;b'1010 1010','Є',.170
	movwf		EECON2
	bsf			WR
	bcf			WREN
	btfss		CARRY
		goto	L_005E
	bsf		GIE
	goto		L_005E
;*******************************************************************************
;*******************************************************************************
; обработчик прерываний
intrpt:
	movlw		0x01		; 1 в аккумулятор
	btfss		RBIF		; измеения энкодера
	    andlw	0x00		;   нет
	btfss		RBIE		; прерывания по энкодеру
	    andlw	0x00		;   запрещены
	iorlw		0x00		;
	btfsc		ZERO		; работа энкодера
	    goto	int_next1	;   не обнаружена
;*******************************************************************************
; обнаружено прерывание по энкодеру
	bcf			RBIF		; сброс флага прерывания по энкодеру
	movlw		0x00		; 0 в аккумулятор
;	bcf		RP0
;	bcf		RP1
	BANKSEL		PORTB
	btfsc		RB7			; энкодер влево?
	    movlw	0x01		;   нет, вправо
	movwf		ENC_B
	movlw		0x00		; 0 в аккумулятор
	btfsc		RB6			; сброшен импульс изменения значения?
	    movlw	0x01		;   нет, активен
	movwf		ENC_A		;
	xorwf		ENC_rot,W	;
	btfsc		ZERO		; есть изменение уровня А энкодера?  
	    goto	L_01CE		;   нет
	decf		ENC_A,W		; 
	btfsc		ZERO		; 
	    goto	L_01CE		;
	decf		ENC_B,W		;
	btfsc		ZERO		;
	    goto	L_01CB
	clrf		REG02A
	incf		REG02A,F
	goto		L_01CC
L_01CB:
	clrf		REG02A
L_01CC:
	clrf		REG028
	incf		REG028,F
;*******************************************************************************
L_01CE:
	movf		ENC_A,W
	movwf		ENC_rot
;*******************************************************************************
; Проврка прерывания по TMR0
int_next1:
	movlw		0x01		;b'0000 0001',' ',.01
	btfss		T0IF
	    andlw	0x00		;b'0000 0000',' ',.00
	btfss		T0IE
	    andlw	0x00		;b'0000 0000',' ',.00
	iorlw		0x00		;b'0000 0000',' ',.00
	btfsc		ZERO
	    goto	L_0224		;
	bcf		T0IF
;*******************************************************************************
; Опрос ДУ
	clrf		REG078
	incf		REG078,F
	clrf		REG079
	clrf		REG07A
L_01DD:
	movlw		0xA0		;b'1010 0000',' ',.160
	movwf		REG07B
	clrf		REG07C
L_01E0:
	movlw		0x01		;b'0000 0001',' ',.01
	subwf		REG07B,F
	btfss		CARRY
	    decf	REG07C,F
	incf		REG07B,W
	btfsc		ZERO
	    incf	REG07C,W
	btfss		ZERO
	    goto	L_01E0
	bcf		CARRY
	bcf		RP0
	bcf		RP1
	btfsc		RA4
	    bsf		CARRY
	movlw		0x00		;b'0000 0000',' ',.00
	btfsc		CARRY
	    movlw	0x01		;b'0000 0001',' ',.01
	movwf		REG070
	clrf		REG071
	movf		REG079,W
	movwf		REG073
	movf		REG078,W
	movwf		REG072
	bcf		CARRY
	rlf		REG072,F
	rlf		REG073,F
	movf		REG070,W
	addwf		REG072,W
	movwf		REG078
	movf		REG071,W
	btfsc		CARRY
	    incf	REG071,W
	addwf		REG073,W
	movwf		REG079
	movlw		0x00		;b'0000 0000',' ',.00
	btfsc		RA4
	    movlw	0x01		;b'0000 0001',' ',.01
	movwf		REG076
	movlw		0x32		;b'0011 0010','2',.50
	movwf		REG07B
L_0208:
	clrf		REG07C
L_0209:
	movf		REG07C,W
	iorwf		REG07B,W
	btfsc		ZERO
	    goto	L_0219
	movlw		0x01		;b'0000 0001',' ',.01
	subwf		REG07B,F
	movlw		0x00		;b'0000 0000',' ',.00
	btfss		CARRY
	    decf	REG07C,F
	btfsc		RA4
	    movlw	0x01		;b'0000 0001',' ',.01
	xorwf		REG076,W
	btfsc		ZERO
	    goto	L_0209
	clrf		REG07B
	goto		L_0208
L_0219:
	incf		REG07A,F
	movlw		0x0D		;b'0000 1101',' ',.13
	subwf		REG07A,W
	btfss		CARRY
	    goto	L_01DD
	movf		REG078,W
	movwf		REG024
	movlw		0x3F		;b'0011 1111','?',.63
	andwf		REG024,F
	movlw		0xFF		;b'1111 1111','я',.255
	movwf		TMR0
;*******************************************************************************
; Восстановление состояния при выходе из прарывания
L_0224:
	movf		TMP_PCLATH,W
	movwf		PCLATH
	movf		TMP_STATUS,W
	movwf		STATUS
	swapf		TMP_W,F
	swapf		TMP_W,W
	retfie
;*******************************************************************************
; Запись собственных символов в CGRAM LCD
; номера каналов
BYTE_CGRAM  MACRO	BT
	movlw		BT
;	movwf		_PKG_LCD
	call		_print_smb
	ENDM
	
fill_CGRAM:
    
	bcf		CTRL_LCD, RS_LCD
	BYTE_CGRAM	CGRADDR|0x00
	bsf		CTRL_LCD, RS_LCD
IRP	BT, 0x01, 0x03, 0x1D, 0x15, 0x1D, 0x03, 0x01, 0x00 
	BYTE_CGRAM	BT
	ENDM
REPT	8
	BYTE_CGRAM  0x10
	ENDM
REPT	8
	BYTE_CGRAM  0x18
	ENDM
REPT	8
	BYTE_CGRAM  0x1C
	ENDM
REPT	8
	BYTE_CGRAM  0x1E
	ENDM
IRP	BT, 0x1F, 0x1B, 0x13, 0x1B, 0x1B, 0x11, 0x1F, 0x00
	BYTE_CGRAM	BT
	ENDM
IRP	BT, 0x1F, 0x11, 0x1D, 0x11, 0x17, 0x11, 0x1F, 0x00
	BYTE_CGRAM	BT
	ENDM
IRP	BT, 0x1F, 0x11, 0x1D, 0x19, 0x1D, 0x11, 0x1F, 0x00
	BYTE_CGRAM	BT
	ENDM
	return

	
;;	bcf		RA2
;	bcf		CTRL_LCD, RS_LCD
;;	movlw		0x7F		;b'0111 1111','',.127
;	BYTE_CGRAM	CGRADDR|0x3F
;;	call		out_w_lcd
;;	bsf		RA2
;	bsf		CTRL_LCD, RS_LCD
;	movlw		0x1F		;b'0001 1111','',.31
;	call		out_w_lcd
;	movf		_PKG_LCD
;	call		_print_smb
;	movlw		0x11		;b'0001 0001','',.17
;	call		out_w_lcd
;	movlw		0x1D		;b'0001 1101','',.29
;	call		out_w_lcd
;	movlw		0x19		;b'0001 1001','',.25
;	call		out_w_lcd
;	movlw		0x1D		;b'0001 1101','',.29
;	call		out_w_lcd
;	movlw		0x11		;b'0001 0001','',.17
;	call		out_w_lcd
;	movlw		0x1F		;b'0001 1111','',.31
;	call		out_w_lcd
;	movlw		0x00		;b'0000 0000',' ',.00
;	call		out_w_lcd
;	movlw		0x1F		;b'0001 1111','',.31
;	call		out_w_lcd
;	movlw		0x11		;b'0001 0001','',.17
;	call		out_w_lcd
;	movlw		0x17		;b'0001 0111','',.23
;	call		out_w_lcd
;	movlw		0x11		;b'0001 0001','',.17
;	call		out_w_lcd
;	movlw		0x1D		;b'0001 1101','',.29
;	call		out_w_lcd
;	movlw		0x11		;b'0001 0001','',.17
;	call		out_w_lcd
;	movlw		0x1F		;b'0001 1111','',.31
;	call		out_w_lcd
;	movlw		0x00		;b'0000 0000',' ',.00
;	call		out_w_lcd
;	movlw		0x1F		;b'0001 1111','',.31
;	call		out_w_lcd
;	movlw		0x11		;b'0001 0001','',.17
;	call		out_w_lcd
;	movlw		0x1B		;b'0001 1011','',.27
;	call		out_w_lcd
;	movlw		0x1B		;b'0001 1011','',.27
;	call		out_w_lcd
;	movlw		0x13		;b'0001 0011','',.19
;	call		out_w_lcd
;	movlw		0x1B		;b'0001 1011','',.27
;	call		out_w_lcd
;	movlw		0x1F		;b'0001 1111','',.31
;	call		out_w_lcd
;	movlw		0x00		;b'0000 0000',' ',.00
;	call		out_w_lcd
;*******************************************************************************
; блоки заполнения шкалы
;	clrf		BIT_POSITION
;L_0260:
;	movlw		0x1E		;b'0001 1110','',.30
;	call		out_w_lcd
;	incf		BIT_POSITION,F
;	movlw		0x08		;b'0000 1000',' ',.08
;	subwf		BIT_POSITION,W
;	btfss		CARRY
;	    goto	L_0260
;	clrf		BIT_POSITION
;L_0268:
;	movlw		0x1C		;b'0001 1100','',.28
;	call		out_w_lcd
;	incf		BIT_POSITION,F
;	movlw		0x08		;b'0000 1000',' ',.08
;	subwf		BIT_POSITION,W
;	btfss		CARRY
;	    goto	L_0268
;	clrf		BIT_POSITION
;L_0270:
;	movlw		0x18		;b'0001 1000','',.24
;	call		out_w_lcd
;	incf		BIT_POSITION,F
;	movlw		0x08		;b'0000 1000',' ',.08
;	subwf		BIT_POSITION,W
;	btfss		CARRY
;	    goto	L_0270
;	clrf		BIT_POSITION
;L_0278:
;	movlw		0x10		;b'0001 0000',' ',.16
;	call		out_w_lcd
;	incf		BIT_POSITION,F
;	movlw		0x08		;b'0000 1000',' ',.08
;	subwf		BIT_POSITION,W
;	btfss		CARRY
;	    goto	L_0278
;*******************************************************************************
;  Динамик
;	movlw		0x01		;b'0000 0001',' ',.01
;	call		out_w_lcd
;	movlw		0x03		;b'0000 0011',' ',.03
;	call		out_w_lcd
;	movlw		0x1D		;b'0001 1101','',.29
;	call		out_w_lcd
;	movlw		0x15		;b'0001 0101','',.21
;	call		out_w_lcd
;	movlw		0x1D		;b'0001 1101','',.29
;	call		out_w_lcd
;	movlw		0x03		;b'0000 0011',' ',.03
;	call		out_w_lcd
;	movlw		0x01		;b'0000 0001',' ',.01
;	call		out_w_lcd
;	movlw		0x00		;b'0000 0000',' ',.00
;	goto		out_w_lcd
;	return
	
;*******************************************************************************
L_028F:
	call		_iic_start_condition
	movlw		0x88		;b'1000 1000','€',.136
	call		_iic_send_byte
;	bcf		RP0
	BANKSEL		VOL_TMP
	movf		VOL_TMP,W
	sublw		0x40		;b'0100 0000','@',.64
	call		_iic_send_byte
;	bcf		RP0
	BANKSEL		REG03A
	decfsz		REG03A,W
	    goto	L_029B
	movlw		0x43		;b'0100 0011','C',.67
	goto		L_02D2
L_029B:
	clrf		COUNT3
	movlw		0x21		;b'0010 0001','!',.33
	subwf		BAL_TMP,W
	btfsc		CARRY
	    goto	L_02A3
	movf		BAL_TMP,W
	sublw		0x20		;b'0010 0000',' ',.32
	movwf		COUNT3
L_02A3:
	clrf		COUNT4
	movlw		0x21		;b'0010 0001','!',.33
	subwf		BAL_TMP,W
	btfss		CARRY
		goto	L_02AB
	movf		BAL_TMP,W
	addlw		0xDF		;b'1101 1111','Я',.223
	movwf		COUNT4
L_02AB:
	movf		COUNT4,W
	addlw		0x80		;b'1000 0000','Ђ',.128
	call		_iic_send_byte
;	bcf		RP0	
	BANKSEL		COUNT3
	movf		COUNT3,W
	addlw		0xA0		;b'1010 0000',' ',.160
	call		_iic_send_byte
	bcf		RP0
	movf		COUNT4,W
	addlw		0xC0		;b'1100 0000','А',.192
	call		_iic_send_byte
	bcf		RP0
	movf		COUNT3,W
	addlw		0xE0		;b'1110 0000','а',.224
	call		_iic_send_byte
	bcf		RP0
	movf		CNL_TMP,W
	addlw		0x3F		;b'0011 1111','?',.63
	movwf		CURSOR_POSITION_LCD
	movf		PAMP_TMP,F
	btfss		ZERO
		goto	L_02C3
	movlw		0x18		;b'0001 1000','',.24
	addwf		CURSOR_POSITION_LCD,F
L_02C3:
	movf		CURSOR_POSITION_LCD,W
	call		_iic_send_byte
	bcf		RP0
	movf		BASS_TMP,W
	addlw		0x01		;b'0000 0001',' ',.01
	movwf		FSR
	call		L_000B
	addlw		0x60		;b'0110 0000','`',.96
	call		_iic_send_byte
	bcf		RP0
	movf		TRBL_TMP,W
	addlw		0x01		;b'0000 0001',' ',.01
	movwf		FSR
	call		L_000B
	addlw		0x70		;b'0111 0000','p',.112
L_02D2:
	call		_iic_send_byte
	goto		_iic_stop_condition
;*******************************************************************************
;encoder_plus:
;	goto		encoder_plus
;*******************************************************************************
volume_plus:
	incf		VOL_TMP,F
	movlw		0x41		;b'0100 0001','A',.65
	subwf		VOL_TMP,W
	btfss		CARRY
	    return	
	movlw		0x40		;b'0100 0000','@',.64
	movwf		VOL_TMP
	return
;*******************************************************************************
treble_plus:
	incf		TRBL_TMP,F
	movlw		0x11		;b'0001 0001','',.17
	subwf		TRBL_TMP,W
	btfss		CARRY
	    return	
	movlw		0x10		;b'0001 0000',' ',.16
	movwf		TRBL_TMP
	return
;*******************************************************************************
bass_plus:
	incf		BASS_TMP,F
	movlw		0x11		;b'0001 0001','',.17
	subwf		BASS_TMP,W
	btfss		CARRY
	    return	
	movlw		0x10		;b'0001 0000',' ',.16
	movwf		BASS_TMP
	return
;*******************************************************************************
balance_plus:
	incf		BAL_TMP,F
	movlw		0x41		;b'0100 0001','A',.65
	subwf		BAL_TMP,W
	btfss		CARRY
	    return	
	movlw		0x40		;b'0100 0000','@',.64
	movwf		BAL_TMP
	return
;*******************************************************************************
preamp_on:
	clrf		PAMP_TMP
	incf		PAMP_TMP,F
	return
;*******************************************************************************
channel_wheel:
	movf		REG021,W
	iorwf		REG020,W
	btfsc		ZERO
	    incf	CNL_TMP,F
	movlw		0x04		;b'0000 0100',' ',.04
	subwf		CNL_TMP,W
	btfss		CARRY
	    return	
	clrf		CNL_TMP
	incf		CNL_TMP,F
	return
;*******************************************************************************
encoder_plus:
	movf		WH8REG,W
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
	    goto	volume_plus
	xorlw		0x03		;b'0000 0011',' ',.03
	btfsc		ZERO
	    goto	treble_plus
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
	    goto	bass_plus
	xorlw		0x07		;b'0000 0111',' ',.07
	btfsc		ZERO
	    goto	balance_plus
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
	    goto	preamp_on
	xorlw		0x03		;b'0000 0011',' ',.03
	btfss		ZERO
	    return	
	goto		channel_wheel
;*******************************************************************************
volume_minus:
	decfsz		VOL_TMP,F
	    return	
	clrf		VOL_TMP
	incf		VOL_TMP,F
	return
;*******************************************************************************
treble_minus:
	decfsz		TRBL_TMP,F
	    return	
	clrf		TRBL_TMP
	incf		TRBL_TMP,F
	return
;*******************************************************************************
bass_minus:
	decfsz		BASS_TMP,F
	    return	
	clrf		BASS_TMP
	incf		BASS_TMP,F
	return
;*******************************************************************************
balance_minus:
	decfsz		BAL_TMP,F
	    return	
	clrf		BAL_TMP
	incf		BAL_TMP,F
	return
;*******************************************************************************
preamp_off:
	clrf		PAMP_TMP
	return
;*******************************************************************************
chanel_wheel_left:
	movf		REG021,W
	iorwf		REG020,W
	btfsc		ZERO
	    decf	CNL_TMP,F
	movf		CNL_TMP,F
	btfss		ZERO
	    return	
	movlw		0x03		;b'0000 0011',' ',.03
	movwf		CNL_TMP
	return
;*******************************************************************************
encoder_minus:
	movf		WH8REG,W
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
	    goto	volume_minus
	xorlw		0x03		;b'0000 0011',' ',.03
	btfsc		ZERO
	    goto	treble_minus
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
	    goto	bass_minus
	xorlw		0x07		;b'0000 0111',' ',.07
	btfsc		ZERO
	    goto	balance_minus
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
	    goto	preamp_off
	xorlw		0x03		;b'0000 0011',' ',.03
	btfss		ZERO
	    return	
	goto		chanel_wheel_left
;*******************************************************************************
on_of_LED:
	decfsz		REG03B,W
	    goto	L_0353
	clrf		REG03B
	clrf		REG03A
	clrf		WH8REG
	incf		WH8REG,F
	goto		L_0358
L_0353:
	clrf		REG03B
	incf		REG03B,F
	clrf		REG03A
	incf		REG03A,F
	clrf		WH8REG
L_0358:
	bcf		GIE
	movlw		0xFF		;b'1111 1111','я',.255
	movwf		PKG_lcd
L_035B:
	decf		PKG_lcd,F
	movf		PKG_lcd,W
	xorlw		0xFF		;b'1111 1111','я',.255
	btfsc		ZERO
	    goto	L_037E
	movf		PKG_lcd,W
	movwf		TIME_pl1
	btfss		REG03B,0
	    goto	L_0368
;	bcf		RP0
;	bcf		RP1
	BANKSEL		PORTB
	bsf		RB4
	goto		L_036B
L_0368:
;	bcf		RP0
;	bcf		RP1
	BANKSEL		PORTB
	bcf		RB4
L_036B:
	decf		TIME_pl1,F
	movf		TIME_pl1,W
	xorlw		0xFF		;b'1111 1111','я',.255
	btfss		ZERO
	    goto	L_036B
	movf		PKG_lcd,W
	movwf		TIME_pl1
	btfsc		REG03B,0
	    goto	L_0378
;	bcf		RP0
;	bcf		RP1
	BANKSEL		PORTB
	bsf		RB4
	goto		L_037B
L_0378:
;	bcf		RP0
;	bcf		RP1
	BANKSEL		PORTB
	bcf		RB4
L_037B:
	incfsz		TIME_pl1,F
	    goto	L_037B
	goto		L_035B
L_037E:
	bsf		GIE
	return
;*******************************************************************************
L_0380:
	movlw		0x02		;b'0000 0010',' ',.02
	call		space_line_LCD
	goto		L_039F
L_0383:
	movf		VOL_TMP,W
	call		L_04C3
	goto		L_03B2
L_0386:
	movf		TRBL_TMP,W
	call		fill_skale
	goto		L_03B2
L_0389:
	movf		BASS_TMP,W
	call		fill_skale
	goto		L_03B2
L_038C:
	movf		BAL_TMP,W
	call		balance_scale
	goto		L_03B2
L_038F:
	movlw		0x10		;b'0001 0000',' ',.16
	movwf		BIT_POSITION
	movlw		0x01		;b'0000 0001',' ',.01
	call		set_DDRAM_ADDR
	movf		PAMP_TMP,W
	addlw		0x30		;b'0011 0000','0',.48
;	call		out_w_lcd
	call		_print_smb
	goto		L_03B2
L_0397:
	movlw		0x10		;b'0001 0000',' ',.16
	movwf		BIT_POSITION
	movlw		0x01		;b'0000 0001',' ',.01
	call		set_DDRAM_ADDR
	movf		CNL_TMP,W
;	addlw		0x04		;b'0000 0100',' ',.04
	addlw		0x04
;	call		out_w_lcd
	call		_print_smb
	goto		L_03B2
L_039F:
	movf		WH8REG,W
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
		goto	L_0383
	xorlw		0x03		;b'0000 0011',' ',.03
	btfsc		ZERO
		goto	L_0386
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
		goto	L_0389
	xorlw		0x07		;b'0000 0111',' ',.07
	btfsc		ZERO
		goto	L_038C
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
		goto	L_038F
	xorlw		0x03		;b'0000 0011',' ',.03
	btfsc		ZERO
		goto	L_0397
L_03B2:
	goto		L_028F
;*******************************************************************************
; инициализация LCD
;start4:
;	call		_init_lcd
;	movlw		0x53		;
;	movwf		COUNT3
;	movlw		0x05		;
;	movwf		COUNT4
;pause2:
;	movlw		0x01		;
;	subwf		COUNT3,F
;	btfss		CARRY
;	    decf	COUNT4,F
;	incf		COUNT3,W
;	btfsc		ZERO
;	    incf	COUNT4,W
;	btfss		ZERO
;	    goto	pause2
;	bcf		RA2
;	bcf		RB3
;	bcf		RB2
;	bsf		RB1
;	bcf		RB0		; bsf | bcf ?
;	bsf		RA3
;	bcf		RA3
;	movlw		0x74		;
;	movwf		COUNT3
;	movlw		0x01		;
;	movwf		COUNT4
;pause3:
;	movlw		0x01		;
;	subwf		COUNT3,F
;	movlw		0x00		;
;	btfss		CARRY
;	    decf	COUNT4,F
;	subwf		COUNT4,F
;	incf		COUNT3,W
;	btfsc		ZERO
;	    incf	COUNT4,W
;	btfss		ZERO
;	    goto	pause3
;	movlw		0x2B		;
;	call		out_w_lcd
;	movlw		0x13		;
;	call		out_w_lcd
;	movlw		0x0C		;
;	call		out_w_lcd
;	movlw		0x04		;
;	call		out_w_lcd
;	call		fill_CGRAM	; запись своих символов в CGRAM
;	goto		disp_off
;*******************************************************************************
print_word_from_EEPROM:
	movwf		BIT_POSITION
	clrf		COUNT3
	clrf		CURSOR_POSITION_LCD
simbol_counter:
	movf		BIT_POSITION,W
	xorwf		COUNT3,W
	btfsc		ZERO
	    goto	end_phrase
	movf		CURSOR_POSITION_LCD,W
;	bsf		RP0
	BANKSEL		EEADR
	movwf		EEADR
	bsf		EECON1,0
	movf		EEDATA,F
;	bcf		RP0
	BANKSEL		COUNT3
	btfsc		ZERO
	    incf	COUNT3,F
;	bcf		RP0
	BANKSEL		CURSOR_POSITION_LCD
	incf		CURSOR_POSITION_LCD,F
	goto		simbol_counter
end_phrase:
	clrf		COUNT3
print_word:
	movf		CURSOR_POSITION_LCD,W
;	bsf		RP0
	BANKSEL		EEADR
	movwf		EEADR
	bsf		EECON1,0
	movf		EEDATA,W
	BANKSEL		_PKG_LCD
;	movwf		_PKG_LCD
	call		_print_smb
;	call		out_w_lcd
	incf		CURSOR_POSITION_LCD,F
	movf		CURSOR_POSITION_LCD,W
;	bsf		RP0
	BANKSEL		EEADR
	movwf		EEADR
	bsf		EECON1,0
	movf		EEDATA,F
	btfss		ZERO
	    goto	end_phrase_
	movlw		0x10		;b'0001 0000',' ',.16
;	bcf		RP0
	BANKSEL		COUNT3
	movwf		COUNT3
end_phrase_:
;	bcf		RP0
	BANKSEL		COUNT3
	incf		COUNT3,F
	movlw		0x10		;b'0001 0000',' ',.16
	subwf		COUNT3,W
	btfsc		CARRY
	    return	
	goto		print_word
;*******************************************************************************
space_line_LCD:
	movwf		BIT_POSITION
	decfsz		BIT_POSITION,W
	    goto	L_041E
;	bcf		RA2
	bcf		CTRL_LCD, RS_LCD
;	movlw		0x80		;b'1000 0000','Ђ',.128
	movlw		DDRADDR|0x00
;	call		out_w_lcd
;	movwf		_PKG_LCD
	call		_print_smb
;	bsf		RA2
	bsf		CTRL_LCD, RS_LCD    
	clrf		CURSOR_POSITION_LCD
space_to_position:
;	movlw		0x20		;b'0010 0000',' ',.32
	movlw		SPACE?
;	call		out_w_lcd
;	movwf		_PKG_LCD
	call		_print_smb
	incf		CURSOR_POSITION_LCD,F
	movlw		0x10		;b'0001 0000',' ',.16
	subwf		CURSOR_POSITION_LCD,W
	btfss		CARRY
	    goto	space_to_position
;	bcf		RA2
	bcf		CTRL_LCD, RS_LCD
;	movlw		0x80		;b'1000 0000','Ђ',.128
	movlw		DDRADDR|0x00
;	call		out_w_lcd
;	movwf		_PKG_LCD
	call		_print_smb
;	bsf		RA2
	bsf		CTRL_LCD, RS_LCD
L_041E:
	movf		BIT_POSITION,W
	xorlw		0x02		;b'0000 0010',' ',.02
	btfss		ZERO
	    return	
;	bcf		RA2
	bcf		CTRL_LCD, RS_LCD
;	movlw		0xC0		;b'1100 0000','А',.192
	movlw		DDRADDR|0x40
;	call		out_w_lcd
;	movwf		_PKG_LCD
	call		_print_smb
;	bsf		RA2
	bsf		CTRL_LCD, RS_LCD
	clrf		CURSOR_POSITION_LCD
sp_to_position:
;	movlw		0x20		;b'0010 0000',' ',.32
	movlw		SPACE?
;	call		out_w_lcd
;	movwf		_PKG_LCD
	call		_print_smb
	incf		CURSOR_POSITION_LCD,F
	movlw		0x10		;b'0001 0000',' ',.16
	subwf		CURSOR_POSITION_LCD,W
	btfss		CARRY
	    goto	sp_to_position
;	bcf		RA2
	bcf		CTRL_LCD, RS_LCD
;	movlw		0xC0		;b'1100 0000','А',.192
	movlw		DDRADDR|0x40
;	call		out_w_lcd
;	movwf		_PKG_LCD
	call		_print_smb
;	bsf		RA2
	bsf		CTRL_LCD, RS_LCD
	return
;*******************************************************************************
up_line_LCD:
	movwf		CURSOR_POSITION_LCD
	movlw		0x30		;b'0011 0000','0',.48
	movwf		COUNT3
	movwf		BIT_POSITION
L_0437:
	movlw		0x0A		;b'0000 1010',' ',.10
	subwf		CURSOR_POSITION_LCD,W
	btfss		CARRY
	    goto	L_043F
	incf		COUNT3,F
	movlw		0xF6		;b'1111 0110','ц',.246
	addwf		CURSOR_POSITION_LCD,F
	goto		L_0437
L_043F:
	movf		CURSOR_POSITION_LCD,W
	addwf		BIT_POSITION,F
;	bcf		RA2
	bcf			CTRL_LCD, RS_LCD
;	movlw		0x8B		;b'1000 1011','‹',.139
	movlw		DDRADDR|0x0B
;	call		out_w_lcd
;	movwf		_PKG_LCD
	call		_print_smb
;	bsf		RA2
	bsf			CTRL_LCD, RS_LCD
	movf		COUNT3,W
	xorlw		0x30		;b'0011 0000','0',.48
	btfss		ZERO
		goto	L_044B
;	movlw		0x20		;b'0010 0000',' ',.32
	movlw		SPACE?
	movwf		COUNT3
L_044B:
	movf		COUNT3,W
;	movwf		_PKG_LCD
;	call		out_w_lcd
	call		_print_smb
	movf		BIT_POSITION,W
;	movwf		_PKG_LCD
;	call		out_w_lcd
	call		_print_smb
;	movlw		0x20		;b'0010 0000',' ',.32
	movlw		SPACE?
;	movwf		_PKG_LCD
;	call		out_w_lcd
	call		_print_smb
	movlw		0x00		;b'0000 0000',' ',.00
;	movwf		_PKG_LCD
;	call		out_w_lcd
	call		_print_smb
	decfsz		REG03A,W
	    goto	L_0457
;	movlw		0x78		;b'0111 1000','x',.120
	movlw		x?
;	movwf		_PKG_LCD
;	goto		out_w_lcd
	goto		_print_smb
L_0457:
	movf		CNL_TMP,W
;	addlw		0x04		;b'0000 0100',' ',.04
	addlw		0x04
;	movwf		_PKG_LCD
;	goto		out_w_lcd
	goto		_print_smb
;*******************************************************************************
balance_scale:
	movwf		REG036
	clrf		REG037
L_045C:
	incf		REG037,F
	movf		REG036,W
	movwf		COUNT4
	bcf			CARRY
	rrf			COUNT4,F
	bcf			CARRY
	rrf			COUNT4,F
	movf		COUNT4,W
	subwf		REG037,W
	btfsc		CARRY
		goto	L_046A
	movlw		0xFF		;b'1111 1111','я',.255
;	call		out_w_lcd
;	movwf		_PKG_LCD
	call		_print_smb
	goto		L_045C
L_046A:
;	movlw		0x3E		;b'0011 1110','>',.62
	movlw		RIGHT?
;	call		out_w_lcd
;	movwf		_PKG_LCD
;	movlw		0x3C		;b'0011 1100','<',.60
	movlw		LEFT?
;	call		out_w_lcd
	call		_print_smb
	movf		REG036,W
	movwf		COUNT4
	bcf		CARRY
	rrf		COUNT4,F
	bcf		CARRY
	rrf		COUNT4,F
	movf		COUNT4,W
	movwf		REG037
L_0476:
	movlw		0x10		;b'0001 0000',' ',.16
	subwf		REG037,W
	btfsc		CARRY
	goto		L_047E
	movlw		0xFF		;b'1111 1111','я',.255
;	call		out_w_lcd
	call		_print_smb
	incf		REG037,F
	goto		L_0476
L_047E:
	movf		REG036,W
	goto		up_line_LCD
;*******************************************************************************
;_iic_send_byte:
;	movwf		PKG_lcd
;	movlw		0x08		;b'0000 1000',' ',.08
;	movwf		BIT_POSITION
;bit_to_SP:
;	movf		BIT_POSITION,F
;	btfsc		ZERO
;	    goto	stop_bit
;	decf		BIT_POSITION,F
;	movf		PKG_lcd,W
;	movwf		TIME_pl1
;	incf		BIT_POSITION,W
;	goto		L_048D
;next_bit:
;	bcf		CARRY
;	rrf		TIME_pl1,F
;L_048D:
;	addlw		0xFF		;
;	btfss		ZERO		;
;	    goto	next_bit
;	btfss		TIME_pl1,0	; передаваемый бит единица?
;	    goto	L_0496		; нет
;;	bcf		RP0
;;	bcf		RP1
;	BANKSEL		PORTA
;	bsf		RA6		; up SDA
;	goto		p_SCL
;L_0496:
;;	bcf		RP0
;;	bcf		RP1
;	BANKSEL		PORTA
;	bcf		RA6		; down SDA
;p_SCL:
;	call		_iic_pulse_SCL
;	goto		bit_to_SP
;;*******************************************************************************
;stop_bit:
;;	bsf		RP0
;	BANKSEL		TRISA
;	bsf		TRISA6
;	call		_short_pause
;	call		_iic_pulse_SCL
;;	bsf		RP0
;	BANKSEL		TRISA
;	bcf		TRISA6
;	return
;*******************************************************************************
check_KEY:
;	bcf		RP0
	BANKSEL		PRESSED_KEY
	clrf		PRESSED_KEY
;	bsf		RP0
	BANKSEL		TRISB
	bsf		TRISB0
;	bcf		RP0
	BANKSEL		PORTB
	btfsc		RB0
	    goto	check_NEXT
	clrf		PRESSED_KEY
	incf		PRESSED_KEY,F
check_NEXT:
;	bsf		RP0
	BANKSEL		TRISB
	bcf		TRISB0
	bsf		TRISB1
;	bcf		RP0
	BANKSEL		PORTB
	btfsc		RB1
	    goto	check_PREV
	movlw		0x02		;b'0000 0010',' ',.02
	movwf		PRESSED_KEY
check_PREV:
;	bsf		RP0
	BANKSEL		TRISB
	bcf		TRISB1
	bsf		TRISB2
;	bcf		RP0
	BANKSEL		PORTB
	btfsc		RB2
	    goto	check_ON_OFF
	movlw		0x03		;b'0000 0011',' ',.03
	movwf		PRESSED_KEY
check_ON_OFF:
;	bsf		RP0
	BANKSEL		TRISB
	bcf		TRISB2
;	bcf		RP0
	BANKSEL		PORTB
	btfsc		RB5
	    return
	movlw		0x04		;b'0000 0100',' ',.04
	movwf		PRESSED_KEY
	return
;*******************************************************************************
L_04C3:
	movwf		REG036
	clrf		REG037
L_04C5:
	movlw		0x05		;b'0000 0101',' ',.05
	movwf		TIME_pl1
	movf		REG036,W
	call		L_04E1
	subwf		REG037,W
	btfsc		CARRY
	    goto	L_04D0
	movlw		0xFF		;b'1111 1111','я',.255
;	call		out_w_lcd
	call		_print_smb
	incf		REG037,F
	goto		L_04C5
L_04D0:
	movlw		0xFB		;b'1111 1011','ы',.251
	movwf		TIME_pl1
	movf		REG037,W
	call		L_0554
	movwf		COUNT4
	movf		REG036,W
	addwf		COUNT4,W
	movwf		REG037
	movf		REG037,F
	btfss		ZERO
	    goto	L_04DD
	movlw		0x20		;b'0010 0000',' ',.32
	movwf		REG037
L_04DD:
	movf		REG037,W
;	call		out_w_lcd
	call		_print_smb
	movf		REG036,W
	goto		up_line_LCD
;*******************************************************************************
L_04E1:
	movwf		PKG_lcd
	clrf		CURSOR_POSITION_LCD
	movf		TIME_pl1,W
	btfsc		ZERO
		goto	L_04FA
	clrf		BIT_POSITION
L_04E7:
	incf		BIT_POSITION,F
	btfsc		TIME_pl1,7
		goto	L_04ED
	bcf			CARRY
	rlf			TIME_pl1,F
	goto		L_04E7
L_04ED:
	bcf			CARRY
	rlf			CURSOR_POSITION_LCD,F
	movf		TIME_pl1,W
	subwf		PKG_lcd,W
	btfss		CARRY
		goto	L_04F7
	movf		TIME_pl1,W
	subwf		PKG_lcd,F
	bsf			CURSOR_POSITION_LCD,0
	bcf			CARRY
L_04F7:
	rrf			TIME_pl1,F
	decfsz		BIT_POSITION,F
		goto		L_04ED
L_04FA:
	movf		CURSOR_POSITION_LCD,W
	return
;*******************************************************************************
; настройка портов
init_ports:
	clrf		INTCON
	movlw		0x10		;b'0001 0000',' ',.16
;	bsf		RP0
	BANKSEL		TRISA
	movwf		TRISA
	movlw		0xE0		;b'1110 0000','а',.224
	movwf		TRISB
	
	bsf		OSCF		; частота внутреннего генератора 4 MHz
	
	movlw		0x07		;b'0000 0111',' ',.07
;	bcf		RP0
	BANKSEL		CMCON
	movwf		CMCON		; отключить компараторы
	clrf		PORTA
	clrf		PORTB
;	bsf		RP0
	BANKSEL		OPTION_REG
	bcf		nRBPU		; включить подтягивающие резисторы
	bsf		PEIE		; прерывания от переферии разрешить
	bsf		T0CS		; тактовый сигнал внешний (от IR)
	bsf		T0SE		; приращение по заднему фронту
	bsf		PSA		; предделитель перед WDT
	movlw		0xFF		;b'1111 1111','я',.255
;	bcf		RP0
	BANKSEL		TMR0
	movwf		TMR0
	bsf		T0IE		; разрешить прерывания пр TMR0
	bcf		T0IF		; сбросить флаг прерывания по TMR0
	bsf		RBIE		; разрешить прерывания по RB7:RB4
	bcf		RBIF		; сбросить флаг прерывания по RB7:RB4
	bsf		GIE		; разрешить все указанные прерывания
	return
;*******************************************************************************
; Вывод символа или команды из аккумулятора в LCD
;out_w_lcd:
;	BANKSEL		_PKG_LCD
;	movwf		_PKG_LCD
;	call		_print_smb
;	return
    
;	bcf		RP0
;	BANKSEL		PKG_lcd
;	movwf		PKG_lcd
;	movlw		0x0A		;
;	movwf		TIME_pl1
;	movlw		0xF0		;
;	andwf		PORTB,F
;	swapf		PKG_lcd,W
;	andlw		0x0F		;
;	addwf		PORTB,F
;	bsf		RA3
;	bcf		RA3
;	movlw		0xF0		;
;	andwf		PORTB,F
;	movf		PKG_lcd,W
;	andlw		0x0F		;
;	addwf		PORTB,F
;	bsf		RA3
;	bcf		RA3
;*******************************************************************************
; короткая пауза заданная в TIME_pl1
;pause_l1:
;	decf		TIME_pl1,F
;	movf		TIME_pl1,W
;	xorlw		0xFF		;
;	btfsc		ZERO
;		return
;	goto		pause_l1
;*******************************************************************************
disp_off:
	movlw		0x96		;b'1001 0110','–',.150
	movwf		BIT_POSITION
	clrf		CURSOR_POSITION_LCD
;	bcf		RA2
	bcf		CTRL_LCD, RS_LCD
;	movlw		0x01		; очистить дисплей
	movlw		CLRDISP
;	movwf		_PKG_LCD
;	call		out_w_lcd
	call		_print_smb	;
;	call		p1562mks	;
L_0534:
	movlw		0x01		;b'0000 0001',' ',.01
	subwf		BIT_POSITION,F
	movlw		0x00		;b'0000 0000',' ',.00
	btfss		CARRY
	    decf	CURSOR_POSITION_LCD,F
	subwf		CURSOR_POSITION_LCD,F
	incf		BIT_POSITION,W
	btfsc		ZERO
	    incf	CURSOR_POSITION_LCD,W
	btfss		ZERO
	    goto	L_0534
;	bcf		RA2
	bcf		CTRL_LCD, RS_LCD
;	movlw		0x80		;
	movlw		DDRADDR|0x00
;	movwf		_PKG_LCD
;	call		out_w_lcd
	call		_print_smb
;	bsf		RA2		; режим вывода символов
	bsf		CTRL_LCD, RS_LCD
	return
;*******************************************************************************
set_DDRAM_ADDR:
	movwf		CURSOR_POSITION_LCD
;	bcf		RA2
	bcf			CTRL_LCD, RS_LCD
	decfsz		CURSOR_POSITION_LCD,W
	    goto	line_2_LCD
	movf		BIT_POSITION,W
	addlw		0x7F		;b'0111 1111','',.127
;	call		out_w_lcd
;	movwf		_PKG_LCD
	call		_print_smb
line_2_LCD:
	movf		CURSOR_POSITION_LCD,W
	xorlw		0x02		;b'0000 0010',' ',.02
	btfss		ZERO
	    goto	L_0552
	movf		BIT_POSITION,W
	addlw		0xBF		;b'1011 1111','ї',.191
;	call		out_w_lcd
;	movwf		_PKG_LCD
	call		_print_smb
L_0552:
;	bsf		RA2
	bsf			CTRL_LCD, RS_LCD
	return
;*******************************************************************************
L_0554:
	movwf		BIT_POSITION
	clrf		PKG_lcd
L_0556:
	movf		TIME_pl1,W
	btfsc		BIT_POSITION,0
	    addwf	PKG_lcd,F
	bcf			CARRY
	rlf			TIME_pl1,F
	bcf			CARRY
	rrf			BIT_POSITION,F
	movf		BIT_POSITION,F
	btfss		ZERO
	    goto	L_0556
	movf		PKG_lcd,W
	return
;*******************************************************************************
fill_skale:
	movwf		COUNT4
	clrf		REG036
L_0564:
	movf		COUNT4,W
	subwf		REG036,W
	btfsc		CARRY
		goto	L_056C
	movlw		0xFF		;b'1111 1111','я',.255
;	call		out_w_lcd
;	movwf		_PKG_LCD
	call		_print_smb
	incf		REG036,F
	goto		L_0564
L_056C:
	movf		REG036,W
	goto		up_line_LCD
;*******************************************************************************
L_056E:
	call		disp_off
	movf		WH8REG,F
	btfss		ZERO
		goto	L_0576
	movlw		0x05		;b'0000 0101',' ',.05
	movwf		BIT_POSITION
	movlw		0x01		;b'0000 0001',' ',.01
	call		set_DDRAM_ADDR
L_0576:
	movf		WH8REG,W
	call		print_word_from_EEPROM
	goto		L_0380
;*******************************************************************************
clrregs:				;очиситка регистов
	clrwdt				;сброс сторожевого таймера
clrrr:					;очистка диапозона регистпров
	clrf		INDF
	incf		FSR,F
	xorwf		FSR,W
	btfsc		ZERO
	    retlw	0x01		;
	xorwf		FSR,W
	goto		clrrr
;*******************************************************************************
wheel_8:
	incf		WH8REG,F
	movlw		0x07		;b'0000 0111',' ',.07
	subwf		WH8REG,W
	btfss		CARRY
	    return	
	clrf		WH8REG
	incf		WH8REG,F
	return
;*******************************************************************************
;_iic_start_condition:
;	bsf		RA6		; SDA up
;	bsf		RA7		; SCL up
;	call		_short_pause
;	bcf		RA6		; SDA down
;	call		_short_pause
;	bcf		RA7		; SCL down
;	return
;*******************************************************************************
invertor:
	decfsz		REG03A,W
	    goto	not_ZERO
	clrf		REG03A
	return	
not_ZERO:
	clrf		REG03A
	incf		REG03A,F
	return
;*******************************************************************************
;_iic_pulse_SCL:
;	call		_short_pause
;;	bcf		RP0
;	BANKSEL		PORTA
;	bsf		RA7
;	call		_short_pause
;	bcf		RA7
;	return
;*******************************************************************************
;_iic_stop_condition:
;;	bcf		RP0
;	BANKSEL		PORTA
;	bsf		RA7		    ; up SCL
;	call		_short_pause
;	bsf		RA6		    ; up SDA
;	return
;*******************************************************************************
L_05AC:
	decfsz		WH8REG,F
		return	
	movlw		0x06		;b'0000 0110',' ',.06
	movwf		WH8REG
	return
;*******************************************************************************
;_short_pause:
;	nop		
;	nop		
;	return
;*******************************************************************************
	end	; directive 'end of program'



