#include "main.inc"
	
; CONFIG
CONFIG	FOSC = INTOSCIO		; Oscillator Selection bits (INTOSC oscillator: I/O function on RA6/OSC2/CLKOUT pin, I/O function on RA7/OSC1/CLKIN)
CONFIG	WDTE = OFF			; Watchdog Timer Enable bit (WDT disabled)
CONFIG	PWRTE = ON			; Power-up Timer Enable bit (PWRT enabled)
CONFIG	MCLRE = OFF			; RA5/MCLR/VPP Pin Function Select bit (RA5/MCLR/VPP pin function is digital input, MCLR internally tied to VDD)
CONFIG	BOREN = ON			; Brown-out Detect Enable bit (BOD enabled)
CONFIG	LVP = OFF			; Low-Voltage Programming Enable bit (RB4/PGM pin has digital I/O function, HV on MCLR must be used for programming)
CONFIG	CPD = OFF			; Data EE Memory Code Protection bit (Data memory code protection off)
CONFIG	CP = OFF			; Flash Program Memory Code Protection bit (Code protection off)


;==========================================================================
;
;		Register Definitions
;
;==========================================================================
; Used Registers
psect	udata_bank0
REG020:		DS	1	;		equ	020h
REG021:		DS	1	;		equ	021h
REG022:		DS	1	;		equ	022h
REG023:		DS	1	;		equ	023h
IRRC_COM:	DS	1	;		equ	024h
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
LEVEL_REG:	DS	1	;		equ	036h
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
modes:
	DW	S?,t?,a?,n?,d?,SPACE?,b?,y?,0
	DW	V?,o?,l?,u?,m?,e?,0
	DW	T?,r?,e?,b?,l?,e?,0
	DW	M?,i?,d?,d?,l?,e?,0
	DW	B?,a?,s?,s?,0
	DW	B?,a?,l?,a?,n?,c?,e?,0
	DW	G?,a?,i?,n?,0
	DW	C?,h?,a?,n?,n?,e?,l?,0
;	DW	0xff,0xff,0xff,0xff,0xff,0xff,0xff
;	DW	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff
;	DW	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff
;	DW	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff
;	DW	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff
;	DW	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff
;	DW	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff
;	DW	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff
parameters:
	DW	0x09,0x08,0x08,0x08,0x20,0x10,0x01,0xff	

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
get_freq_scale:
;	movlw		0x00		;b'0000 0000',' ',.00
	movlw		high(get_freq_scale)
	movwf		PCLATH
	movf		FSR, W
	incf		FSR, F
	addwf		PCL, F
IRP fsp, 0x00, 0x00, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07
	retlw		fsp
	ENDM
IRP	fsp, 0x0F, 0x0E, 0x0E, 0x0D, 0x0C, 0x0B, 0x0A, 0x09, 0x08
	retlw		fsp
	ENDM
	
;	retlw		0x00		;b'0000 0000',' ',.00
;	retlw		0x00		;b'0000 0000',' ',.00
;	retlw		0x00		;b'0000 0000',' ',.00
;	retlw		0x01		;b'0000 0001',' ',.01
;	retlw		0x02		;b'0000 0010',' ',.02
;	retlw		0x03		;b'0000 0011',' ',.03
;	retlw		0x04		;b'0000 0100',' ',.04
;	retlw		0x05		;b'0000 0101',' ',.05
;	retlw		0x06		;b'0000 0110',' ',.06
;	retlw		0x07		;b'0000 0111',' ',.07
;	retlw		0x0F		;b'0000 1111',' ',.15
;	retlw		0x0E		;b'0000 1110',' ',.14
;	retlw		0x0D		;b'0000 1101',' ',.13
;	retlw		0x0C		;b'0000 1100',' ',.12
;	retlw		0x0B		;b'0000 1011',' ',.11
;	retlw		0x0A		;b'0000 1010',' ',.10
;	retlw		0x09		;b'0000 1001',' ',.09
;	retlw		0x08		;b'0000 1000',' ',.08
;*******************************************************************************
start:
	bcf			STATUS,7	; банки 0, 1 при косвенной адресации 
	movlw		0x20		; адрес первого регистра диапозона
	movwf		FSR
	movlw		0x7F		; адрес последнего регистра диапозона
	call		clrregs		; очистка диапазона регистров
	movwf		MUTE_REG
	movwf		ON_OFF
	clrf		STATUS
	call		init_ports	; настойка портов
	call		init_lcd
	call		init_iic
	call		init_encoder
	call		fill_CGRAM	; запись своих символов в CGRAM
	call		clear_LCD
;*******************************************************************************
; Чтение настроек из EEPROM
COPYEEDT	MACRO	FREG
	call		get_from_EEPROM
	movwf		FREG
	ENDM
	movlw		parameters
;	movlw		0x78		; начальный адрес для чтения
	BANKSEL		EEADR
	movwf		EEADR
IRP	FREG, VOL_TMP, TRBL_TMP, MDL_TMP, BASS_TMP, BAL_TMP, PAMP_TMP, CNL_TMP
	COPYEEDT	FREG
	ENDM
;*******************************************************************************
	call		iic_msg
	call		mode_print
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
	call		mode_print
	movlw		0xFF		;b'1111 1111','я',.255
	movwf		REG022
	movwf		REG023
	movwf		COUNT1
	movlw		0x8F		;b'1000 1111','Џ',.143
	movwf		COUNT2
pause_mode:
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
		goto	pause_mode
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
	movf		IRRC_COM,W
	btfsc		ZERO
		goto	p_to_v_mode
	movf		IRRC_COM,W
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
	goto		auto_vol_mode
L_00B2:
	clrf		CNL_TMP
	incf		CNL_TMP,F
	goto		auto_vol_mode
L_00B5:
	movlw		0x02		;b'0000 0010',' ',.02
	goto		L_00B8
L_00B7:
	movlw		0x03		;b'0000 0011',' ',.03
L_00B8:
	movwf		CNL_TMP
	goto		auto_vol_mode
L_00BA:
	movf		REG021,W
	iorwf		REG020,W
	btfss		ZERO
		goto	auto_vol_mode
	call		mute_on_off
	goto		auto_vol_mode
L_00C0:
	movf		REG021,W
	iorwf		REG020,W
	btfss		ZERO
		goto	auto_vol_mode
	call		mode_next
	goto		auto_vol_mode
L_00C6:
	movf		REG021,W
	iorwf		REG020,W
	btfss		ZERO
		goto	auto_vol_mode
	call		mode_prev
	goto		auto_vol_mode
L_00CC:
	call		encoder_minus
	goto		auto_vol_mode
L_00CE:
	call		encoder_plus
	goto		auto_vol_mode
L_00D0:
	clrf		MODE_NUM
	incf		MODE_NUM,F
	goto		auto_vol_mode
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
	goto		auto_vol_mode
;*******************************************************************************
L_00DC:
	movf		IRRC_COM,W
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
; Автоматический переход в режим регулировки громкости
auto_vol_mode:
	clrf		IRRC_COM
	call		mode_print
	movlw		0x04		;b'0000 0100',' ',.04
	movwf		REG021
	movlw		0xFF		;b'1111 1111','я',.255
	movwf		REG020
	movwf		REG022
	movwf		REG023
p_to_v_mode:
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
		goto	in_vol_mode
	movf		MODE_NUM,W
	btfsc		ZERO
		goto	in_vol_mode
	movlw		0x01		;b'0000 0001',' ',.01
	subwf		REG022,F
	movlw		0x00		;b'0000 0000',' ',.00
	btfss		CARRY
		decf	REG023,F
	subwf		REG023,F
in_vol_mode:
	decf		REG022,W
	iorwf		REG023,W
	btfss		ZERO
		goto	read_keys
	clrf		MODE_NUM
	incf		MODE_NUM,F
	call		mode_print
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
	movlw		parameters
;	movlw		0x78		; адрес первого байта в EEPROM для сохранения 
	BANKSEL		TMP_PKG
	movwf		TMP_PKG
IRP	FREG, VOL_TMP, TRBL_TMP, MDL_TMP, BASS_TMP, BAL_TMP, PAMP_TMP, CNL_TMP
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
		andlw	0x00		;	нет
	btfss		RBIE		; прерывания по энкодеру
		andlw	0x00		;	запрещены
	iorlw		0x00		;
	btfsc		ZERO		; работа энкодера
		goto	int_tmr		;	не обнаружена
;*******************************************************************************
; обнаружено прерывание по энкодеру
	bcf			RBIF		; сброс флага прерывания по энкодеру
	movlw		0x00		; 0 в аккумулятор
	BANKSEL		ENC_PORT	;
	btfsc		ENC_B		; энкодер вправо?
		movlw	0x01		;	нет, влево
	movwf		TMP_ENC_B	;
	movlw		0x00		; 0 в аккумулятор
	btfsc		ENC_A		; сброшен импульс изменения значения?
		movlw	0x01		;	нет, активен
	movwf		TMP_ENC_A	;
	xorwf		ENC_OLD_A,W	;
	btfsc		ZERO		; есть изменение уровня А энкодера?
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
		andlw	0x00		; прерывание по TMR0 запрещено
	iorlw		0x00		; для проверки на 0
	btfsc		ZERO
		goto	int_end		; не требуется интерпритация irrc
	bcf			T0IF		; сброс флага прерывания по TMR0
;*******************************************************************************
; Опрос ДУ
	clrf		REG078
	incf		REG078,F
	clrf		REG079
	clrf		REG07A		; счетчик принятых бит в пакете
ir_read_bit:
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
		goto	ir_read_bit
	movf		REG078,W
	movwf		IRRC_COM
	movlw		0x3F		;b'0011 1111','?',.63
	andwf		IRRC_COM,F	; выделяем команду из принятого пакета
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
BYTE_CGRAM	MACRO	BT
	movlw		BT
	call		print_lcd
	ENDM
	
fill_CGRAM:
	bcf			RS_L
	BYTE_CGRAM	CGRADDR|0x00
	bsf			RS_L
IRP	BT, 0x01, 0x03, 0x1D, 0x15, 0x1D, 0x03, 0x01, 0x00
	; динамик
	BYTE_CGRAM	BT
	ENDM
REPT	8
	BYTE_CGRAM	0x10	; одна вертикальная полоса слева
	ENDM
REPT	8
	BYTE_CGRAM	0x18	; две вертикальных полосы слева
	ENDM
REPT	8
	BYTE_CGRAM	0x1C	; три вертикальных полосы слева
	ENDM
REPT	8
	BYTE_CGRAM	0x1E	; четыре вертикальных полосы слева
	ENDM
IRP	BT, 0x1F, 0x1B, 0x13, 0x1B, 0x1B, 0x11, 0x1F, 0x00
	; 3-ий канал
	BYTE_CGRAM	BT
	ENDM
IRP	BT, 0x1F, 0x11, 0x1D, 0x11, 0x17, 0x11, 0x1F, 0x00
	; 2-ой канал
	BYTE_CGRAM	BT
	ENDM
IRP	BT, 0x1F, 0x11, 0x1D, 0x19, 0x1D, 0x11, 0x1F, 0x00
	; 1-ый канал
	BYTE_CGRAM	BT
	ENDM
	return
;*******************************************************************************
iic_msg:					; отправка сообщения по шине I2C
	call		iic_start_condition	; условие пуск
	movlw		SLAVEADDR				; адрес устройства
	call		iic_send_byte			; отправка первого байта

	BANKSEL		CNL_TMP
	movlw		SUBADDRAI|SUBADDRIN
	call		iic_send_byte
	BANKSEL		CNL_TMP
	decf		CNL_TMP, W
	sublw		AP_IN1
	call		iic_send_byte
	BANKSEL		PAMP_TMP
	decf		PAMP_TMP, W
	call		iic_send_byte
	BANKSEL		MUTE_REG
	decfsz		MUTE_REG, W
		goto	mute_off
	movlw		AP_VOLMUTE
	goto		icc_msg_end
	
	
mute_off:					
	decf		VOL_TMP,W
	sublw		AP_VOL40|AP_VOL7		; уровень громкости
vol_iic:
	call		iic_send_byte			; отправка по I2C
;	BANKSEL		MUTE_REG
; 	decfsz		MUTE_REG, W
; 		goto	mute_off				; отключить режим приглушения
; 	movlw		AP_ASW|AP_ASW_CNL_4		; физически отключенный канал
; 	goto		icc_msg_end				; окончить передачу сообщения
; mute_off:

	BANKSEL		BASS_TMP
	movf		BASS_TMP,W
	addlw		0x01
	movwf		FSR
	call		get_freq_scale
;	addlw		AP_FRQ|AP_FRQ_B			; тембр - бас
	call		iic_send_byte
	BANKSEL		MDL_TMP
	movf		MDL_TMP, W
	addlw		0x01
	movwf		FSR
	call		get_freq_scale
	call		iic_send_byte
	BANKSEL		TRBL_TMP
	movf		TRBL_TMP, W
	addlw		0x01
	movwf		FSR
	call		get_freq_scale
;	addlw		AP_FRQ|AP_FRQ_T			; тембр - высокие
	call		iic_send_byte

;	clrf		COUNT3
	movlw		AP_ATT16
	movwf		COUNT3
	movwf		COUNT4
; 	movlw		0x21
; 	subwf		BAL_TMP,W
; 	btfsc		CARRY
; 		goto	bal_in_right			; баланс смещен вправо
; 	movf		BAL_TMP,W
; 	sublw		0x20
; 	movwf		COUNT3					; сохранить смещение вправо
; bal_in_right:
; 	clrf		COUNT4
; 	movlw		0x21
; 	subwf		BAL_TMP,W
; 	btfss		CARRY
; 		goto	send_bal				; баланс по центру
; 	movf		BAL_TMP,W
; 	addlw		not 0x20
; 	movwf		COUNT4					; сохранить смещение влево
send_bal:
	movf		COUNT4,W
;	addlw		AP_ATT_LF				; аттенюатор левый передний
	call		iic_send_byte
	BANKSEL		COUNT3
	movf		COUNT3,W
;	addlw		AP_ATT_RF				; аттенюатор правый передний
;	call		iic_send_byte
; 	BANKSEL		COUNT4
; 	movf		COUNT4,W
; 	addlw		AP_ATT_LR				; аттенюатор левый задний
; 	call		iic_send_byte
; 	BANKSEL		COUNT3
; 	movf		COUNT3,W
; 	addlw		AP_ATT_RR				; аттенюатор правый задний
; 	call		iic_send_byte
; 
; 	BANKSEL		PAMP_TMP
; 	movf		PAMP_TMP, W
; 	andlw		00000011B
; 	sublw		00000011B
; 	movwf		LINE_NUM
; 	bcf			CARRY
; REPT	3
; 	rlf			LINE_NUM, F				; аудио переключатели - предусиление
; 	ENDM
; 	btfss		PAMP_TMP, BIT4			;
; 		bsf		LINE_NUM, BIT2			; аудио переключатели - тонкомпенсация
; 	decf		CNL_TMP,W
; 	iorlw		AP_ASW					; аудио переключатели - канал
; 	iorwf		LINE_NUM, W
; 	call		iic_send_byte

icc_msg_end:
	call		iic_send_byte			; отправка боследнего байта сообщения
	goto		iic_stop_condition		; условие стоп
;*******************************************************************************
fsr_reg_plus	MACRO	REG, SCALE_MAX
	movlw		REG
	movwf		FSR
	movlw		SCALE_MAX
	goto		param_plus
	ENDM
;*******************************************************************************
param_plus:
	xorwf		INDF, W
	btfsc		ZERO
		return
	incf		INDF, F
	return
;*******************************************************************************
volume_plus:
;	fsr_reg_plus	VOL_TMP, 64
	fsr_reg_plus	VOL_TMP, 48
;*******************************************************************************
treble_plus:
	fsr_reg_plus	TRBL_TMP, 16
;*******************************************************************************
middle_plus:
	fsr_reg_plus	MDL_TMP, 16
;*******************************************************************************
bass_plus:
	fsr_reg_plus	BASS_TMP, 16
;*******************************************************************************
balance_plus:
	fsr_reg_plus	BAL_TMP, 64
;*******************************************************************************
gain_plus:
	fsr_reg_plus	PAMP_TMP, 16
; 	movf		PAMP_TMP, W
; 	andlw		00000011B
; 	xorlw		00000011B
; 	btfss		ZERO
; 		incf	PAMP_TMP, F
; 	return
;*******************************************************************************
; loud_on:
; 	bsf			PAMP_TMP, BIT4
; 	return
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
;		goto	bass_plus
		goto	middle_plus
	xorlw		0x07		;b'0000 0111',' ',.07
	btfsc		ZERO
;		goto	balance_plus
		goto	bass_plus
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
;		goto	gain_plus
		goto	balance_plus
	xorlw		0x03		;b'0000 0011',' ',.03
	btfsc		ZERO
;		goto	loud_on
		goto	gain_plus
	xorlw		0x01
	btfss		ZERO
		return
;*******************************************************************************
channel_wheel:
	movf		REG021, W
	iorwf		REG020, W
	btfsc		ZERO
		incf	CNL_TMP, F
	movlw		0x04		;b'0000 0100',' ',.04
	subwf		CNL_TMP,W
	btfss		CARRY
		return	
	clrf		CNL_TMP
	incf		CNL_TMP, F
	return
;*******************************************************************************
fsr_reg_minus	MACRO	REG
	movlw		REG
	movwf		FSR
	goto		param_minus
	ENDM
;*******************************************************************************
param_minus:
	decfsz		INDF, F		; уменьшаем параметр
		return
	incf		INDF		; минимальное значение - один
	return
;*******************************************************************************
volume_minus:
	fsr_reg_minus	VOL_TMP
;*******************************************************************************
treble_minus:
	fsr_reg_minus	TRBL_TMP
;*******************************************************************************
middle_minus:
	fsr_reg_minus	MDL_TMP
;*******************************************************************************
bass_minus:
	fsr_reg_minus	BASS_TMP
;*******************************************************************************
balance_minus:
	fsr_reg_minus	BAL_TMP
;*******************************************************************************	
gain_minus:
	fsr_reg_minus	PAMP_TMP
; 	movf		PAMP_TMP, W
; 	andlw		00000011B
; 	btfsc		ZERO
; 		return
; 	decf		PAMP_TMP, F
; 	return
;*******************************************************************************
; loud_off:
; 	bcf			PAMP_TMP, BIT4
; 	return
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
;		goto	bass_minus
		goto	middle_minus
	xorlw		0x07		;b'0000 0111',' ',.07
	btfsc		ZERO
;		goto	balance_minus
		goto	bass_minus
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
;		goto	gain_minus
		goto	balance_minus
	xorlw		0x03		;b'0000 0011',' ',.03
	btfsc		ZERO
;		goto	loud_off
		goto	gain_minus
	xorlw		0x01
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
		goto	off_dev
	clrf		ON_OFF
	clrf		MUTE_REG
	clrf		MODE_NUM
	incf		MODE_NUM,F
	goto		on_off_led
off_dev:
	clrf		ON_OFF
	incf		ON_OFF,F
	clrf		MUTE_REG
	incf		MUTE_REG,F
	clrf		MODE_NUM
on_off_led:
	bcf			GIE				; запретить все прерывания
	movlw		234				; старший разряд счетчика паузы
	movwf		TIME_M
	btfss		ON_OFF, BIT0
		bsf		LCD_LED
	movlw		92				; младший разряд счетчика паузы
	call		pause			; пауза 0,3 сек
	btfsc		ON_OFF, BIT0
		bcf		LCD_LED
	bsf			GIE
	return
;*******************************************************************************
to_line_2:
	movlw		0x02		; строка для очистки
	call		space_line_LCD
	goto		select_mode
;*******************************************************************************
vol_mode:
	movf		VOL_TMP,W
	call		vol_scale
	goto		iic_msg
trbl_mode:
	movf		TRBL_TMP,W
	call		freq_scale
	goto		iic_msg
mdl_mode:
	movf		MDL_TMP, W
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
gain_mode:
	movf		PAMP_TMP, W
	call		vol_scale
	goto		iic_msg

;	movlw		0x10		;b'0001 0000',' ',.16
; 	movwf		LINE_POS
; 	movlw		0x01		;b'0000 0001',' ',.01
; 	call		set_DDRAM_ADDR
; 	movf		PAMP_TMP,W
; 	andlw		00000011B
; 	addlw		_0?			; '0'
; 	call		print_lcd
; 	goto		iic_msg
; loud_mode:
; 	movlw		0x10
; 	movwf		LINE_POS
; 	call		set_DDRAM_ADDR
; 	movlw		_0?
; 	btfsc		PAMP_TMP, BIT4
; 		addlw	0x01
; 	call		print_lcd
; 	goto		iic_msg
cnl_mode:
	movlw		0x10		;b'0001 0000',' ',.16
	movwf		LINE_POS
	movlw		0x01		;b'0000 0001',' ',.01
	call		set_DDRAM_ADDR
	movf		CNL_TMP,W
	addlw		0x04		;b'0000 0100',' ',.04
	call		print_lcd
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
;		goto	bass_mode
		goto	mdl_mode
	xorlw		0x07		;b'0000 0111',' ',.07
	btfsc		ZERO
;		goto	bal_mode
		goto	bass_mode
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
;		goto	gain_mode
		goto	bal_mode
	xorlw		0x03		;b'0000 0011',' ',.03
	btfsc		ZERO
;		goto	loud_mode
		goto	gain_mode
	xorlw		0x01
	btfsc		ZERO
		goto	cnl_mode
	goto		iic_msg
;*******************************************************************************
print_word_from_EEPROM:
	movwf		LINE_POS
	clrf		COUNT3
	clrf		LINE_NUM
simbol_counter:
	movf		LINE_POS, W
	xorwf		COUNT3, W
	btfsc		ZERO
		goto	end_phrase
	movf		LINE_NUM, W
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
	call		print_lcd
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
	bcf			RS_L
	movlw		DDRADDR|0x0B
	call		print_lcd
	bsf			RS_L
	movf		COUNT3,W
	xorlw		_0?			; '0'
	btfss		ZERO
		goto	print_units
	movlw		SPACE?
	movwf		COUNT3
print_units:
	movf		COUNT3,W	; число десятков (пробел при ноле)
	call		print_lcd
	movf		LINE_POS,W	; единицы
	call		print_lcd
	movlw		SPACE?		; пробел
	call		print_lcd
	movlw		0x00		; символ динамика
	call		print_lcd
	decfsz		MUTE_REG,W
		goto	cnl_num
	movlw		x?			; включено приглушение (MUTE)
	goto		print_lcd	;
cnl_num:
	movf		CNL_TMP,W
	addlw		0x04		; символ номера канала
	goto		print_lcd
;*******************************************************************************
bal_scale:
	movwf		LEVEL_REG
	movlw		0x04			; вес полного сегмента шкалы
	movwf		TMP_PKG1
	movf		LEVEL_REG, W
	sublw		0x04
	btfsc		CARRY
		goto	pr_lt
	goto		pr_rt
pr_rt:
	movlw		0x01
	subwf		LEVEL_REG, W
	call		full_segs
	movlw		RIGHT?
	call		print_lcd
	movf		LEVEL_REG, W
	sublw		0x40
	movwf		TMP_PKG
	sublw		0x01
	btfsc		CARRY
		goto	e_u_l
pr_lt:
	movlw		LEFT?
	call		print_lcd
	movlw		0x01
	subwf		TMP_PKG, W
	call		full_segs
	goto		e_u_l
;*******************************************************************************
vol_scale:
	movwf		LEVEL_REG
;	movlw		0x05			; вес полного сегмента шкалы
	movlw		0x03
	movwf		TMP_PKG1
	movf		LEVEL_REG, W
	call		full_segs
	btfsc		ZERO
		movlw	SPACE?
	call		print_lcd
	goto		e_u_l
;*******************************************************************************
freq_scale:
	movwf		LEVEL_REG
	movlw		0x01
	movwf		TMP_PKG1
	movf		LEVEL_REG, W
	call		full_segs
;*******************************************************************************
e_u_l:
	movf		LEVEL_REG, W
	goto		end_up_line
;*******************************************************************************
; функция заполняет шкалу полными сегментами
; и возвращает в аккумуляторе остаток
; на входе: в аккумуляторе значение шкалы, в TMP_PKG1 размер сегмента шкалы
full_segs:
	movwf		TMP_PKG
	movf		TMP_PKG1, W
	subwf		TMP_PKG, F
	btfsc		CARRY
		goto	full_seg
	movf		TMP_PKG1, W
	addwf		TMP_PKG, W
	return
full_seg:	
	movlw		0xFF
	call		print_lcd
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
get_from_EEPROM:
	BANKSEL		EECON1
	bsf			EECON1, 0
	movf		EEDATA, W
	incf		EEADR, F
	BANKSEL		VOL_TMP
	return
;*******************************************************************************
mode_print:
	call		clear_LCD
	movf		MODE_NUM,F
	btfss		ZERO
		goto	activ_modes
	movlw		5			; позиция первого символа
	movwf		LINE_POS	; в строке
	movlw		1			; строка для вывода
	call		set_DDRAM_ADDR
activ_modes:
	movf		MODE_NUM,W
	call		print_word_from_EEPROM
	goto		to_line_2
;*******************************************************************************
clrregs:					;очиситка регистов
	clrwdt					;сброс сторожевого таймера
clrrr:						;очистка диапозона регистров
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
	movlw		0x08
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
	movlw		0x07
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
