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
REG020:		DS	1	;		equ	020h
REG021:		DS	1	;		equ	021h
REG022:		DS	1	;		equ	022h
REG023:		DS	1	;		equ	023h
REG024:		DS	1	;		equ	024h
BAL_TMP:	DS	1	;		equ	025h
BASS_TMP:	DS	1	;		equ	026h
CNL_TMP:	DS	1	;		equ	027h
ENC_ACTIV:	DS	1	;		equ	028h
ENC_OLD_A:	DS	1	;		equ	029h
ENC_R_L:	DS	1	;		equ	02Ah
PAMP_TMP:	DS	1	;		equ	02Bh
PRESSED_KEY:DS	1	;		equ	02Ch
MODE_NUM:	DS	1	;		equ	02Dh
TRBL_TMP:	DS	1	;		equ	02Eh
VOL_TMP:	DS	1	;		equ	02Fh
TIME_pl1:	DS	1	;		equ	030h
TMP_PKG:	DS	1	;		equ	031h
LINE_POS:	DS	1	;		equ	032h
LINE_NUM:	DS	1	;		equ	033h
COUNT3:		DS	1	;		equ	034h
COUNT4:		DS	1	;		equ	035h
REG036:		DS	1	;		equ	036h
REG037:		DS	1	;		equ	037h
COUNT1:		DS	1	;		equ	038h
COUNT2:		DS	1	;		equ	039h
MUTE_REG:	DS	1	;		equ	03Ah
ON_OFF:		DS	1	;		equ	03Bh
	
psect		udata_shr
REG070:		DS	1	;		equ	070h
REG071:		DS	1	;		equ	071h
REG072:		DS	1	;		equ	072h
REG073:		DS	1	;		equ	073h
TMP_STATUS:	DS	1	;		equ	074h
TMP_PCLATH:	DS	1	;		equ	075h
REG076:		DS	1	;		equ	076h
TMP_ENC_B:	DS	1	;		equ	077h
REG078:		DS	1	;		equ	078h
REG079:		DS	1	;		equ	079h
REG07A:		DS	1	;		equ	07Ah
REG07B:		DS	1	;		equ	07Bh
REG07C:		DS	1	;		equ	07Ch
TMP_ENC_A:	DS	1	;		equ	07Dh
TMP_W:		DS	1	;		equ	07Eh
	
psect	edata
	DW	S?,t?,a?,n?,d?,SPACE?,b?,y?,0
	DW	V?,o?,l?,u?,m?,e?,0
	DW	T?,r?,e?,b?,l?,e?,0
	DW	B?,a?,s?,s?,0
	DW	B?,a?,l?,a?,n?,c?,e?,0
	DW	P?,r?,e?,a?,m?,p?,l?,i?,f?,e?,r?,0
	DW	C?,h?,a?,n?,e?,l?,0,0xff
	DW	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff
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
get_freq_shcale:
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
	bcf			STATUS,7	;банки 0, 1 при косвенной адресации 
	movlw		0x20		;адрес первого регистра диапозона
	movwf		FSR
	movlw		0x7F
	call		clrregs		;очистка диапазона регистров
	movwf		MUTE_REG
	movwf		ON_OFF
	clrf		STATUS
	call		init_ports	; настойка портов
	call		_init_lcd
	call		_init_iic
	call		_init_encoder
	call		fill_CGRAM	; запись своих символов в CGRAM
	call		clear_LCD
;*******************************************************************************
; Чтение настроек из EEPROM
COPYEEDT    MACRO   EADR, FREG
	movlw		EADR
	BANKSEL		EEADR
	movwf		EEADR
	bsf			EECON1, 0
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
;*******************************************************************************
	call		iic_msg
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
	movf		ON_OFF,F
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
	decfsz		ENC_ACTIV,W
	    goto	L_00A2
	clrf		ENC_ACTIV
	decfsz		ENC_R_L,W
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
	movf		ON_OFF,F
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
	clrf		MODE_NUM
	incf		MODE_NUM,F
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
	movwf		MODE_NUM
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
	movf		MODE_NUM,W
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
	clrf		MODE_NUM
	incf		MODE_NUM,F
	call		L_056E
;*******************************************************************************
;Сохранение значений регулируемых параметров в EEPROM
	goto		save_fregs
save_freg:
	BANKSEL		EECON1
	btfsc		WR
		goto	save_freg
	BANKSEL		TMP_PKG
	movf		TMP_PKG, W
	BANKSEL		EEADR
	movwf		EEADR
	BANKSEL		INDF
	movf		INDF,W
	incf		TMP_PKG, F
	BANKSEL		EEDATA
	movwf		EEDATA
	bcf			CARRY
	btfsc		GIE
	    bsf		CARRY
	bcf			GIE
	bsf			WREN
	movlw		0x55		; 0101 0101B
	movwf		EECON2
	movlw		0xAA		; 1010 1010B
	movwf		EECON2
	bsf			WR
	bcf			WREN
	btfsc		CARRY
	    bsf		GIE
	return
save_fregs:
	movlw		0x78		; адрес первого байта в EEPROM для сохранения 
	BANKSEL		TMP_PKG
	movwf		TMP_PKG
IRP	FREG, VOL_TMP, TRBL_TMP, BASS_TMP, BAL_TMP, PAMP_TMP, CNL_TMP
	BANKSEL		FSR
	movlw		FREG
	movwf		FSR
	call		save_freg
	ENDM
;*******************************************************************************
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
	    goto	int_tmr		;   не обнаружена
;*******************************************************************************
; обнаружено прерывание по энкодеру
	bcf			RBIF		; сброс флага прерывания по энкодеру
	movlw		0x00		; 0 в аккумулятор
	BANKSEL		ENC_PORT	;
	btfsc		ENC_B		; энкодер вправо?
	    movlw	0x01		;   нет, влево
	movwf		TMP_ENC_B	;
	movlw		0x00		; 0 в аккумулятор
	btfsc		ENC_A		; сброшен импульс изменения значения?
	    movlw	0x01		;   нет, активен
	movwf		TMP_ENC_A	;
	xorwf		ENC_OLD_A,W	;
	btfsc		ZERO		; есть изменение уровня А энкодера?  
	    goto	enc_state	;   нет
	decf		TMP_ENC_A,W	; 
	btfsc		ZERO		; 
	    goto	enc_state	;
	decf		TMP_ENC_B,W	;
	btfsc		ZERO		;
	    goto	enc_left	;
	clrf		ENC_R_L		;
	incf		ENC_R_L,F	;
	goto		enc_act		;
enc_left:
	clrf		ENC_R_L		;
enc_act:
	clrf		ENC_ACTIV	;
	incf		ENC_ACTIV,F	;
enc_state:
	movf		TMP_ENC_A,W	; сохранить текущее значение 
	movwf		ENC_OLD_A	; на выводе А энкодера
;*******************************************************************************
; Проврка прерывания по TMR0
int_tmr:
	movlw		0x01		;b'0000 0001',' ',.01
	btfss		T0IF
	    andlw	0x00		;b'0000 0000',' ',.00
	btfss		T0IE
	    andlw	0x00		;b'0000 0000',' ',.00
	iorlw		0x00		;b'0000 0000',' ',.00
	btfsc		ZERO
	    goto	int_end		;
	bcf			T0IF
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
	bcf			CARRY
	bcf			RP0
	bcf			RP1
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
	bcf			CARRY
	rlf			REG072,F
	rlf			REG073,F
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
int_end:
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
	call		_print_smb
	ENDM
	
fill_CGRAM:
	bcf			CTRL_LCD, RS_LCD
	BYTE_CGRAM	CGRADDR|0x00
	bsf			CTRL_LCD, RS_LCD
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
;*******************************************************************************
iic_msg:					; отправка сообщения по шине I2C
	call		_iic_start_condition	; условие пуск
	movlw		SLAVEADDR				; адрес устройства
	call		_iic_send_byte			; отправка первого байта
	BANKSEL		VOL_TMP					
	decf		VOL_TMP,W
	sublw		AP_VOL_70|AP_VOL_8c75	; уровень громкости
	call		_iic_send_byte			; отправка по I2C
	BANKSEL		MUTE_REG
	decfsz		MUTE_REG,W
	    goto	mute_off				; отключить режим приглушения
	movlw		AP_ASW|AP_ASW_CNL_4		; физически отключенный канал
	goto		icc_msg_end				; окончить передачу сообщения
mute_off:
	clrf		COUNT3
	movlw		0x21
	subwf		BAL_TMP,W
	btfsc		CARRY
	    goto	bal_in_right			; баланс смещен вправо
	movf		BAL_TMP,W
	sublw		0x20
	movwf		COUNT3					; сохранить смещение вправо
bal_in_right:
	clrf		COUNT4
	movlw		0x21
	subwf		BAL_TMP,W
	btfss		CARRY
		goto	send_bal				; баланс по центру
	movf		BAL_TMP,W
	addlw		not 0x20
	movwf		COUNT4					; сохранить смещение влево
send_bal:
	movf		COUNT4,W
	addlw		AP_ATT_LF				; аттенюатор левый передний
	call		_iic_send_byte
	BANKSEL		COUNT3
	movf		COUNT3,W
	addlw		AP_ATT_RF				; аттенюатор правый передний
	call		_iic_send_byte
	BANKSEL		COUNT4
	movf		COUNT4,W
	addlw		AP_ATT_LR				; аттенюатор левый задний
	call		_iic_send_byte
	BANKSEL		COUNT3
	movf		COUNT3,W
	addlw		AP_ATT_RR				; аттенюатор правый задний
	call		_iic_send_byte
	BANKSEL		CNL_TMP
	decf		CNL_TMP,W
	addlw		AP_ASW					; аудио переключатели - канал
	movwf		LINE_NUM
	movf		PAMP_TMP,F
	btfss		ZERO
		goto	gain_on					; ! предусиление на полную (+11,25 dB)
	movlw		AP_ASW_G_0				; аудио переключатели - предусиление
	addwf		LINE_NUM,F
gain_on:
	movf		LINE_NUM,W
	call		_iic_send_byte
	BANKSEL		BASS_TMP
	movf		BASS_TMP,W
	addlw		0x01
	movwf		FSR
	call		get_freq_shcale
	addlw		AP_FRQ|AP_FRQ_B			; тембр - бас
	call		_iic_send_byte
	BANKSEL		TRBL_TMP
	movf		TRBL_TMP,W
	addlw		0x01
	movwf		FSR
	call		get_freq_shcale
	addlw		AP_FRQ|AP_FRQ_T			; тембр - высокие
icc_msg_end:
	call		_iic_send_byte			; отправка боследнего байта сообщения
	goto		_iic_stop_condition		; условие стоп
;*******************************************************************************
volume_plus:
	incf		VOL_TMP,F	; пробуем прибавить громкость
	movlw		0x41		;
	subwf		VOL_TMP,W
	btfss		CARRY		
	    return	
	movlw		0x40		; если громкость максимальная
	movwf		VOL_TMP		; оставляем без изменений
	return
;*******************************************************************************
treble_plus:
	incf		TRBL_TMP,F	; пробуем прибавить тембр высоких
	movlw		0x11		; 
	subwf		TRBL_TMP,W
	btfss		CARRY
	    return	
	movlw		0x10		; если высокие на максимуме
	movwf		TRBL_TMP	; отавляем без изменений
	return
;*******************************************************************************
bass_plus:
	incf		BASS_TMP,F	; пробуем прибавить тембр низких
	movlw		0x11		;
	subwf		BASS_TMP,W
	btfss		CARRY
	    return	
	movlw		0x10		; если низкие на максимуме
	movwf		BASS_TMP	; отавляем без изменений
	return
;*******************************************************************************
balance_plus:
	incf		BAL_TMP,F	; пробуем сместить баланс вправо
	movlw		0x41		;
	subwf		BAL_TMP,W
	btfss		CARRY
	    return	
	movlw		0x40		; если баланс вправо на максимуме
	movwf		BAL_TMP		; отавляем без изменений
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
	movf		MODE_NUM,W
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
	movf		MODE_NUM,W
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
	decfsz		ON_OFF,W
	    goto	on_dev
	clrf		ON_OFF
	clrf		MUTE_REG
	clrf		MODE_NUM
	incf		MODE_NUM,F
	goto		L_0358
on_dev:
	clrf		ON_OFF
	incf		ON_OFF,F
	clrf		MUTE_REG
	incf		MUTE_REG,F
	clrf		MODE_NUM
L_0358:
	bcf			GIE
	movlw		0xFF		;b'1111 1111','я',.255
	movwf		TMP_PKG
L_035B:
	decf		TMP_PKG,F
	movf		TMP_PKG,W
	xorlw		0xFF		;b'1111 1111','я',.255
	btfsc		ZERO
	    goto	L_037E
	movf		TMP_PKG,W
	movwf		TIME_pl1
	btfss		ON_OFF,0
	    goto	L_0368
	BANKSEL		PORTB
	bsf			LCD_LED
	goto		L_036B
L_0368:
	BANKSEL		PORTB
	bcf			LCD_LED
L_036B:
	decf		TIME_pl1,F
	movf		TIME_pl1,W
	xorlw		0xFF		;b'1111 1111','я',.255
	btfss		ZERO
	    goto	L_036B
	movf		TMP_PKG,W
	movwf		TIME_pl1
	btfsc		ON_OFF,0
	    goto	L_0378
	BANKSEL		PORTB
	bsf			LCD_LED
	goto		L_037B
L_0378:
	BANKSEL		PORTB
	bcf			LCD_LED
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
	movwf		LINE_POS
	movlw		0x01		;b'0000 0001',' ',.01
	call		set_DDRAM_ADDR
	movf		PAMP_TMP,W
	addlw		0x30		;b'0011 0000','0',.48
	call		_print_smb
	goto		L_03B2
L_0397:
	movlw		0x10		;b'0001 0000',' ',.16
	movwf		LINE_POS
	movlw		0x01		;b'0000 0001',' ',.01
	call		set_DDRAM_ADDR
	movf		CNL_TMP,W
	addlw		0x04		;b'0000 0100',' ',.04
	call		_print_smb
	goto		L_03B2
L_039F:
	movf		MODE_NUM,W
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
	goto		iic_msg
;*******************************************************************************
print_word_from_EEPROM:
	movwf		LINE_POS
	clrf		COUNT3
	clrf		LINE_NUM
simbol_counter:
	movf		LINE_POS,W
	xorwf		COUNT3,W
	btfsc		ZERO
	    goto	end_phrase
	movf		LINE_NUM,W
	BANKSEL		EEADR
	movwf		EEADR
	bsf			EECON1,0
	movf		EEDATA,F
	BANKSEL		COUNT3
	btfsc		ZERO
	    incf	COUNT3,F
	BANKSEL		LINE_NUM
	incf		LINE_NUM,F
	goto		simbol_counter
end_phrase:
	clrf		COUNT3
print_word:
	movf		LINE_NUM,W
	BANKSEL		EEADR
	movwf		EEADR
	bsf			EECON1,0
	movf		EEDATA,W
;	BANKSEL		_PKG_LCD
	call		_print_smb
	incf		LINE_NUM,F
	movf		LINE_NUM,W
	BANKSEL		EEADR
	movwf		EEADR
	bsf			EECON1,0
	movf		EEDATA,F
	btfss		ZERO
	    goto	end_phrase_
	movlw		0x10		;b'0001 0000',' ',.16
	BANKSEL		COUNT3
	movwf		COUNT3
end_phrase_:
	BANKSEL		COUNT3
	incf		COUNT3,F
	movlw		0x10		;b'0001 0000',' ',.16
	subwf		COUNT3,W
	btfsc		CARRY
	    return	
	goto		print_word
;*******************************************************************************
space_line_LCD:
	movwf		LINE_POS
	decfsz		LINE_POS,W
	    goto	L_041E
	bcf			CTRL_LCD, RS_LCD
	movlw		DDRADDR|0x00
	call		_print_smb
	bsf			CTRL_LCD, RS_LCD    
	clrf		LINE_NUM
space_to_position:
	movlw		SPACE?
	call		_print_smb
	incf		LINE_NUM,F
	movlw		0x10		;b'0001 0000',' ',.16
	subwf		LINE_NUM,W
	btfss		CARRY
	    goto	space_to_position
	bcf			CTRL_LCD, RS_LCD
	movlw		DDRADDR|0x00
	call		_print_smb
	bsf			CTRL_LCD, RS_LCD
L_041E:
	movf		LINE_POS,W
	xorlw		0x02		;b'0000 0010',' ',.02
	btfss		ZERO
	    return	
	bcf			CTRL_LCD, RS_LCD
	movlw		DDRADDR|0x40
	call		_print_smb
	bsf			CTRL_LCD, RS_LCD
	clrf		LINE_NUM
sp_to_position:
	movlw		SPACE?
	call		_print_smb
	incf		LINE_NUM,F
	movlw		0x10		;b'0001 0000',' ',.16
	subwf		LINE_NUM,W
	btfss		CARRY
	    goto	sp_to_position
	bcf			CTRL_LCD, RS_LCD
	movlw		DDRADDR|0x40
	call		_print_smb
	bsf			CTRL_LCD, RS_LCD
	return
;*******************************************************************************
up_line_LCD:
	movwf		LINE_NUM
	movlw		0x30		;b'0011 0000','0',.48
	movwf		COUNT3
	movwf		LINE_POS
L_0437:
	movlw		0x0A		;b'0000 1010',' ',.10
	subwf		LINE_NUM,W
	btfss		CARRY
	    goto	L_043F
	incf		COUNT3,F
	movlw		0xF6		;b'1111 0110','ц',.246
	addwf		LINE_NUM,F
	goto		L_0437
L_043F:
	movf		LINE_NUM,W
	addwf		LINE_POS,F
	bcf			CTRL_LCD, RS_LCD
	movlw		DDRADDR|0x0B
	call		_print_smb
	bsf			CTRL_LCD, RS_LCD
	movf		COUNT3,W
	xorlw		0x30		;b'0011 0000','0',.48
	btfss		ZERO
		goto	L_044B
	movlw		SPACE?
	movwf		COUNT3
L_044B:
	movf		COUNT3,W
	call		_print_smb
	movf		LINE_POS,W
	call		_print_smb
	movlw		SPACE?
	call		_print_smb
	movlw		0x00		;b'0000 0000',' ',.00
	call		_print_smb
	decfsz		MUTE_REG,W
	    goto	cnl_num
	movlw		x?
	goto		_print_smb
cnl_num:
	movf		CNL_TMP,W
	addlw		0x04		;b'0000 0100',' ',.04
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
	call		_print_smb
	goto		L_045C
L_046A:
	movlw		RIGHT?
	call		_print_smb
	movlw		LEFT?
	call		_print_smb
	movf		REG036,W
	movwf		COUNT4
	bcf			CARRY
	rrf			COUNT4,F
	bcf			CARRY
	rrf			COUNT4,F
	movf		COUNT4,W
	movwf		REG037
L_0476:
	movlw		0x10		;b'0001 0000',' ',.16
	subwf		REG037,W
	btfsc		CARRY
	goto		L_047E
	movlw		0xFF		;b'1111 1111','я',.255
	call		_print_smb
	incf		REG037,F
	goto		L_0476
L_047E:
	movf		REG036,W
	goto		up_line_LCD
;*******************************************************************************
check_KEY:
	BANKSEL		PRESSED_KEY
	clrf		PRESSED_KEY
;	BANKSEL		TRISB
;	bsf			TRISB0
;	BANKSEL		PORTB
;	btfsc		RB0
	BANKSEL		TS_KEYS_PORT
	bsf			TS_KEYS_PORT, MUTE_KEY_POSN
	BANKSEL		KEYS_PORT
	btfsc		MUTE_KEY
		goto	check_NEXT
	clrf		PRESSED_KEY
	incf		PRESSED_KEY,F
check_NEXT:
;	BANKSEL		TRISB
;	bcf			TRISB0
;	bsf			TRISB1
;	BANKSEL		PORTB
;
;	btfsc		RB1
	BANKSEL		TS_KEYS_PORT
	bcf			TS_KEYS_PORT, MUTE_KEY_POSN
	bsf			TS_KEYS_PORT, NEXT_KEY_POSN
	BANKSEL		KEYS_PORT
	btfsc		NEXT_KEY
		goto	check_PREV
	movlw		0x02		;b'0000 0010',' ',.02
	movwf		PRESSED_KEY
check_PREV:
;	BANKSEL		TRISB
;	bcf			TRISB1
;	bsf			TRISB2
;	BANKSEL		PORTB
;	btfsc		RB2
	BANKSEL		TS_KEYS_PORT
	bcf			TS_KEYS_PORT, NEXT_KEY_POSN
	bsf			TS_KEYS_PORT, PREV_KEY_POSN
	BANKSEL		KEYS_PORT
	btfsc		PREV_KEY
		goto	check_ON_OFF
	movlw		0x03		;b'0000 0011',' ',.03
	movwf		PRESSED_KEY
check_ON_OFF:
;	BANKSEL		TRISB
;	bcf			TRISB2
	BANKSEL		TS_KEYS_PORT
	bcf			TS_KEYS_PORT, PREV_KEY_POSN
	BANKSEL		ENC_PORT
	btfsc		ENC_KEY
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
	call		_print_smb
	movf		REG036,W
	goto		up_line_LCD
;*******************************************************************************
L_04E1:
	movwf		TMP_PKG
	clrf		LINE_NUM
	movf		TIME_pl1,W
	btfsc		ZERO
		goto	L_04FA
	clrf		LINE_POS
L_04E7:
	incf		LINE_POS,F
	btfsc		TIME_pl1,7
		goto	L_04ED
	bcf			CARRY
	rlf			TIME_pl1,F
	goto		L_04E7
L_04ED:
	bcf			CARRY
	rlf			LINE_NUM,F
	movf		TIME_pl1,W
	subwf		TMP_PKG,W
	btfss		CARRY
		goto	L_04F7
	movf		TIME_pl1,W
	subwf		TMP_PKG,F
	bsf			LINE_NUM,0
	bcf			CARRY
L_04F7:
	rrf			TIME_pl1,F
	decfsz		LINE_POS,F
		goto	L_04ED
L_04FA:
	movf		LINE_NUM,W
	return
;*******************************************************************************
; настройка портов
init_ports:
	clrf		INTCON
;	movlw		0x10		;b'0001 0000',' ',.16
	movlw		0xFF
	BANKSEL		TRISA
	movwf		TRISA
;	movlw		0xE0		;b'1110 0000','а',.224
	movwf		TRISB
	bsf			OSCF		; частота внутреннего генератора 4 MHz
	movlw		0x07		;b'0000 0111',' ',.07
	BANKSEL		CMCON
	movwf		CMCON		; отключить компараторы
	clrf		PORTA
	clrf		PORTB
	BANKSEL		OPTION_REG
	bcf			nRBPU		; включить подтягивающие резисторы
	bsf			PEIE		; прерывания от переферии разрешить
	bsf			T0CS		; тактовый сигнал внешний (от IR)
	bsf			T0SE		; приращение по заднему фронту
	bsf			PSA			; предделитель перед WDT
	movlw		0xFF		;b'1111 1111','я',.255
	BANKSEL		TMR0
	movwf		TMR0
	bsf			T0IE		; разрешить прерывания пр TMR0
	bcf			T0IF		; сбросить флаг прерывания по TMR0
	bsf			RBIE		; разрешить прерывания по RB7:RB4
	bcf			RBIF		; сбросить флаг прерывания по RB7:RB4
	bsf			GIE			; разрешить все указанные прерывания
	return
;*******************************************************************************
clear_LCD:
	bcf			CTRL_LCD, RS_LCD
	movlw		CLRDISP
	call		_print_smb	;
	call		p1562mks
	movlw		DDRADDR|0x00
	call		_print_smb
	bsf			CTRL_LCD, RS_LCD
	return
;*******************************************************************************
set_DDRAM_ADDR:
	movwf		LINE_NUM
	bcf			CTRL_LCD, RS_LCD
	decfsz		LINE_NUM,W
	    goto	line_2_LCD
	decf		LINE_POS,W
	iorlw		DDRADDR|LCD_LINE_ONE
	call		_print_smb
line_2_LCD:
	movf		LINE_NUM,W
	xorlw		0x02
	btfss		ZERO
	    goto	smb_mode
	decf		LINE_POS,W
	iorlw		DDRADDR|LCD_LINE_TWO
	call		_print_smb
smb_mode:
	bsf			CTRL_LCD, RS_LCD
	return
;*******************************************************************************
L_0554:
	movwf		LINE_POS
	clrf		TMP_PKG
L_0556:
	movf		TIME_pl1,W
	btfsc		LINE_POS,0
	    addwf	TMP_PKG,F
	bcf			CARRY
	rlf			TIME_pl1,F
	bcf			CARRY
	rrf			LINE_POS,F
	movf		LINE_POS,F
	btfss		ZERO
	    goto	L_0556
	movf		TMP_PKG,W
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
	call		_print_smb
	incf		REG036,F
	goto		L_0564
L_056C:
	movf		REG036,W
	goto		up_line_LCD
;*******************************************************************************
L_056E:
	call		clear_LCD
	movf		MODE_NUM,F
	btfss		ZERO
		goto	L_0576
	movlw		0x05		;b'0000 0101',' ',.05
	movwf		LINE_POS
	movlw		0x01		;b'0000 0001',' ',.01
	call		set_DDRAM_ADDR
L_0576:
	movf		MODE_NUM,W
	call		print_word_from_EEPROM
	goto		L_0380
;*******************************************************************************
clrregs:					;очиситка регистов
	clrwdt					;сброс сторожевого таймера
clrrr:						;очистка диапозона регистпров
	clrf		INDF
	incf		FSR,F
	xorwf		FSR,W
	btfsc		ZERO
	    retlw	0x01		;
	xorwf		FSR,W
	goto		clrrr
;*******************************************************************************
wheel_8:
	incf		MODE_NUM,F
	movlw		0x07		;b'0000 0111',' ',.07
	subwf		MODE_NUM,W
	btfss		CARRY
	    return	
	clrf		MODE_NUM
	incf		MODE_NUM,F
	return
;*******************************************************************************
invertor:
	decfsz		MUTE_REG,W
	    goto	not_ZERO
	clrf		MUTE_REG
	return	
not_ZERO:
	clrf		MUTE_REG
	incf		MUTE_REG,F
	return
;*******************************************************************************
L_05AC:
	decfsz		MODE_NUM,F
		return	
	movlw		0x06		;b'0000 0110',' ',.06
	movwf		MODE_NUM
	return
;*******************************************************************************
	end	; directive 'end of program'
