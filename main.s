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
MODE_NUM:	DS	1	;		equ	02Dh
TRBL_TMP:	DS	1	;		equ	02Eh
VOL_TMP:	DS	1	;		equ	02Fh
TMP_PKG1:	DS	1	;		equ	030h
TMP_PKG:	DS	1	;		equ	031h
COUNT3:		DS	1	;		equ	034h
COUNT4:		DS	1	;		equ	035h
REG036:		DS	1	;		equ	036h
REG037:		DS	1	;		equ	037h
COUNT1:		DS	1	;		equ	038h
COUNT2:		DS	1	;		equ	039h
MUTE_REG:	DS	1	;		equ	03Ah
ON_OFF:		DS	1	;		equ	03Bh
MDL_TMP:	DS	1	;
	
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
	DW	M?,i?,d?,d?,l?,e?,0
	DW	B?,a?,s?,s?,0
	DW	B?,a?,l?,a?,n?,c?,e?,0
	DW	G?,a?,i?,n?,0
	DW	C?,h?,a?,n?,n?,e?,l?,0
	DW	0xff,0xff,0xff,0xff,0xff,0xff,0xff
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
	org			0x0000
ResetVector:
	goto		start
	org			0x0004
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
	call		print_mode
;*******************************************************************************
read_keys:
	call		check_key
	movf		PRESSED_KEY,W
	btfsc		ZERO
	    goto	read_enc
	movf		PRESSED_KEY,W
	xorlw		0x04		;b'0000 0100',' ',.04
	btfss		ZERO
	    goto	on_off_key
	call		on_off_dev
release_key:
	movf		PRESSED_KEY,F
	btfsc		ZERO
	    goto	on_off_key
	call		check_key
	goto		release_key
on_off_key:
	movf		ON_OFF,F
	btfsc		ZERO
	    goto	other_key
	goto		in_mode
;*******************************************************************************
mute_key:
	call		mute_on_off
rls_key:
	movf		PRESSED_KEY,F
	btfsc		ZERO
	    goto	in_mode
	call		check_key
	goto		rls_key
next_key:
	call		mode_next
	goto		in_mode
prev_key:
	call		mode_prev
	goto		in_mode
;*******************************************************************************
other_key:
	movf		PRESSED_KEY,W
	xorlw		0x01		; 1 - "MUTE" key
	btfsc		ZERO
	    goto	mute_key
	xorlw		0x03		; 2 - "NEXT" key
	btfsc		ZERO
	    goto	next_key
	xorlw		0x01		; 3 - "PREV" key
	btfsc		ZERO
	    goto	prev_key
;*******************************************************************************
in_mode:
	call		print_mode
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
;*******************************************************************************
read_enc:
	decfsz		ENC_ACTIV,W
	    goto	decode_irrc	; энкодер не активен
	clrf		ENC_ACTIV
	decfsz		ENC_R_L,W
	    goto	e_m
	call		encoder_plus
	goto		e_n
e_m:
	call		encoder_minus
e_n:
	movlw		0xFF		;b'1111 1111','я',.255
	movwf		REG022
	movwf		REG023
	call		to_line_2
;*******************************************************************************
decode_irrc:
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
	call		on_off_dev
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
	call		mute_on_off
	goto		L_0104
L_00C0:
	movf		REG021,W
	iorwf		REG020,W
	btfss		ZERO
	    goto	L_0104
	call		mode_next
	goto		L_0104
L_00C6:
	movf		REG021,W
	iorwf		REG020,W
	btfss		ZERO
	    goto	L_0104
	call		mode_prev
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
;*******************************************************************************
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
;*******************************************************************************
L_0104:
	clrf		REG024
	call		print_mode
	movlw		0x04		;b'0000 0100',' ',.04
	movwf		REG021
	movlw		0xFF		;b'1111 1111','я',.255
	movwf		REG020
	movwf		REG022
	movwf		REG023

;	movlw		0xFF		;b'1111 1111','я',.255

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
	    goto	read_keys
	clrf		MODE_NUM
	incf		MODE_NUM,F
	call		print_mode
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
	goto		read_keys
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
; Проврка прерывания по TMR0 (irrc)
int_tmr:
	movlw		0x01		;b'0000 0001',' ',.01
	btfss		T0IF
	    andlw	0x00		; нет прерывания по TMR0
	btfss		T0IE
	    andlw	0x00		; рерывание по TMR0 запрещено
	iorlw		0x00		; для проверки на 0
	btfsc		ZERO
	    goto	int_end		; не требуется интерпритация irrc
	bcf			T0IF		; сброс флага прерывания по TMR0
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
ir_st_p:
	movlw		0x01		;b'0000 0001',' ',.01
	subwf		REG07B,F
	btfss		CARRY
	    decf	REG07C,F
	incf		REG07B,W
	btfsc		ZERO
	    incf	REG07C,W
	btfss		ZERO
	    goto	ir_st_p
	bcf			CARRY
	BANKSEL		IRRC_PORT
	btfsc		IRRC
	    bsf		CARRY		; копируем состояние IR приемника в CARRY
	movlw		0x00		;
	btfsc		CARRY
	    movlw	0x01		; затем в BIT0 регистра W
	movwf		REG070		; запоминаем
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
	btfsc		IRRC
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
	btfsc		IRRC
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
on_off_dev:
	decfsz		ON_OFF,W
	    goto	on_dev
	clrf		ON_OFF
	clrf		MUTE_REG
	clrf		MODE_NUM
	incf		MODE_NUM,F
	goto		pause_bl1
on_dev:
	clrf		ON_OFF
	incf		ON_OFF,F
	clrf		MUTE_REG
	incf		MUTE_REG,F
	clrf		MODE_NUM
pause_bl1:
	bcf			GIE
	movlw		0xFF
	movwf		TMP_PKG
bl_cycle:
	decf		TMP_PKG,F
	movf		TMP_PKG,W
	xorlw		0xFF
	btfsc		ZERO
	    goto	cont_on_off
	movf		TMP_PKG,W
	movwf		TMP_PKG1
	btfss		ON_OFF,0
	    goto	off_led1
	BANKSEL		DATA_LCD
	bsf			LCD_LED
	goto		pause_bl2
off_led1:
	BANKSEL		DATA_LCD
	bcf			LCD_LED
pause_bl2:
	decf		TMP_PKG1,F
	movf		TMP_PKG1,W
	xorlw		0xFF		;b'1111 1111','я',.255
	btfss		ZERO
	    goto	pause_bl2
	movf		TMP_PKG,W
	movwf		TMP_PKG1
	btfsc		ON_OFF,0
	    goto	off_led2
	BANKSEL		DATA_LCD
	bsf			LCD_LED
	goto		pause_bl3
off_led2:
	BANKSEL		DATA_LCD
	bcf			LCD_LED
pause_bl3:
	incfsz		TMP_PKG1,F
	    goto	pause_bl3
	goto		bl_cycle
cont_on_off:
	bsf			GIE
	return
;*******************************************************************************
to_line_2:
	movlw		0x02		; строка для очистки
	call		space_line_LCD
	goto		select_mode
vol_mode:
	movf		VOL_TMP,W
	call		vol_scale
	goto		iic_msg
trbl_mode:
	movf		TRBL_TMP,W
	call		freq_scale
	goto		iic_msg
bass_mode:
	movf		BASS_TMP,W
	call		freq_scale
	goto		iic_msg
bal_mode:
	movf		BAL_TMP,W
	call		bal_scale
	goto		iic_msg
pamp_mode:
	movlw		0x10		;b'0001 0000',' ',.16
	movwf		LINE_POS
	movlw		0x01		;b'0000 0001',' ',.01
	call		set_DDRAM_ADDR
	movf		PAMP_TMP,W
	addlw		_0?			; '0'
	call		_print_smb
	goto		iic_msg
cnl_mode:
	movlw		0x10		;b'0001 0000',' ',.16
	movwf		LINE_POS
	movlw		0x01		;b'0000 0001',' ',.01
	call		set_DDRAM_ADDR
	movf		CNL_TMP,W
	addlw		0x04		;b'0000 0100',' ',.04
	call		_print_smb
	goto		iic_msg
;*******************************************************************************
select_mode:
	movf		MODE_NUM,W
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
		goto	vol_mode
	xorlw		0x03		;b'0000 0011',' ',.03
	btfsc		ZERO
		goto	trbl_mode
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
		goto	bass_mode
	xorlw		0x07		;b'0000 0111',' ',.07
	btfsc		ZERO
		goto	bal_mode
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
		goto	pamp_mode
	xorlw		0x03		;b'0000 0011',' ',.03
	btfsc		ZERO
		goto	cnl_mode
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
; пересчет и вывод уровня в десятичном виде, символов динамика и номера канала
end_up_line:
	movwf		LINE_NUM	; шестнадцатиричное значение уровня
	movlw		_0?			; '0'
	movwf		COUNT3		; счетчик десятков (в символах LCD)
	movwf		LINE_POS	; единицы в (символах LCD)
tens_counter:
	movlw		0x0A		; 10
	subwf		LINE_NUM,W
	btfss		CARRY
	    goto	units
	incf		COUNT3,F
	movlw		not 0x09	; -9
	addwf		LINE_NUM,F
	goto		tens_counter
units:
	movf		LINE_NUM,W
	addwf		LINE_POS,F
	bcf			CTRL_LCD, RS_LCD
	movlw		DDRADDR|0x0B
	call		_print_smb
	bsf			CTRL_LCD, RS_LCD
	movf		COUNT3,W
	xorlw		_0?			; '0'
	btfss		ZERO
		goto	print_units
	movlw		SPACE?
	movwf		COUNT3
print_units:
	movf		COUNT3,W	; число десятков (пробел при ноле)
	call		_print_smb
	movf		LINE_POS,W	; единицы
	call		_print_smb
	movlw		SPACE?		; пробел
	call		_print_smb
	movlw		0x00		; символ динамика
	call		_print_smb
	decfsz		MUTE_REG,W
	    goto	cnl_num
	movlw		x?			; включено приглушение (MUTE)
	goto		_print_smb	;
cnl_num:
	movf		CNL_TMP,W
	addlw		0x04		; символ номера канала
	goto		_print_smb
;*******************************************************************************
bal_scale:
	movwf		REG036
	movlw		0x04
	movwf		TMP_PKG1
	movf		REG036, W
	sublw		0x04
	btfsc		CARRY
		goto	pr_lt
	goto		pr_rt
pr_rt:
	movlw		0x01
	subwf		REG036, W
	call		full_segs
	movlw		RIGHT?
	call		_print_smb
	movf		REG036, W
	sublw		0x40
	movwf		TMP_PKG
	sublw		0x01
	btfsc		CARRY
		goto	e_u_l
pr_lt:
	movlw		LEFT?
	call		_print_smb
	movlw		0x01
	subwf		TMP_PKG, W
	call		full_segs
	goto		e_u_l
;*******************************************************************************
vol_scale:
	movwf		REG036
	movlw		0x05
	movwf		TMP_PKG1
	movf		REG036, W
	call		full_segs
	btfsc		ZERO
		movlw	SPACE?
	call		_print_smb
	goto		e_u_l
;*******************************************************************************
freq_scale:
	movwf		REG036
	movlw		0x01
	movwf		TMP_PKG1
	movf		REG036, W
	call		full_segs
;*******************************************************************************
e_u_l:
	movf		REG036, W
	goto		end_up_line
;*******************************************************************************
full_segs:
	movwf		TMP_PKG
	movf		TMP_PKG1, W
	subwf		TMP_PKG,F
	btfsc		CARRY
		goto	full_seg
	movf		TMP_PKG1
	addwf		TMP_PKG, W
	return
full_seg:	
	movlw		0xFF
	call		_print_smb
	goto		full_segs+1
;*******************************************************************************
; настройка портов
init_ports:
	clrf		INTCON
	movlw		0xFF
	BANKSEL		TRISA
	movwf		TRISA
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
	bsf			T0IE		; разрешить прерывания по TMR0
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
	call		p1545us
	movlw		DDRADDR|0x00
	call		_print_smb
	bsf			CTRL_LCD, RS_LCD
	return
;*******************************************************************************
print_mode:
	call		clear_LCD
	movf		MODE_NUM,F
	btfss		ZERO
		goto	activ_modes
	movlw		0x05		; режим "ожидание"
	movwf		LINE_POS	; позиция в строке
	movlw		0x01		; строка для вывода
	call		set_DDRAM_ADDR
activ_modes:
	movf		MODE_NUM,W
	call		print_word_from_EEPROM
;*******************************************************************************
	goto		to_line_2
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
mode_next:
	incf		MODE_NUM,F
	movlw		0x07		;b'0000 0111',' ',.07
	subwf		MODE_NUM,W
	btfss		CARRY
	    return	
	clrf		MODE_NUM
	incf		MODE_NUM,F
	return
;*******************************************************************************
mode_prev:
	decfsz		MODE_NUM,F
		return	
	movlw		0x06		;b'0000 0110',' ',.06
	movwf		MODE_NUM
	return
;*******************************************************************************
mute_on_off:
	decfsz		MUTE_REG,W
	    goto	mute_on
	clrf		MUTE_REG
	return	
mute_on:
	clrf		MUTE_REG
	incf		MUTE_REG,F
	return
;*******************************************************************************

	end	; directive 'end of program'
