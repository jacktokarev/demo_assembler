#include "main.inc"

;*******************************************************************************
; CONFIG
CONFIG	FOSC = INTOSCIO		; Oscillator Selection bits (INTOSC oscillator: I/O function on RA6/OSC2/CLKOUT pin, I/O function on RA7/OSC1/CLKIN)
CONFIG	WDTE = OFF			; Watchdog Timer Enable bit (WDT disabled)
CONFIG	PWRTE = ON			; Power-up Timer Enable bit (PWRT enabled)
CONFIG	MCLRE = OFF			; RA5/MCLR/VPP Pin Function Select bit (RA5/MCLR/VPP pin function is digital input, MCLR internally tied to VDD)
CONFIG	BOREN = ON			; Brown-out Detect Enable bit (BOD enabled)
CONFIG	LVP = OFF			; Low-Voltage Programming Enable bit (RB4/PGM pin has digital I/O function, HV on MCLR must be used for programming)
CONFIG	CPD = OFF			; Data EE Memory Code Protection bit (Data memory code protection off)
CONFIG	CP = OFF			; Flash Program Memory Code Protection bit (Code protection off)

;*******************************************************************************
;
;		Register Definitions
;
;*******************************************************************************
; Used Registers
psect	udata_bank0
	
REG020:		DS	1	;
REG021:		DS	1	;
REG022:		DS	1	;
REG023:		DS	1	;
BAL_TMP:	DS	1	;
BASS_TMP:	DS	1	;
CNL_TMP:	DS	1	;
PAMP_TMP:	DS	1	;
MODE_NUM:	DS	1	;
TRBL_TMP:	DS	1	;
VOL_TMP:	DS	1	;
TMP_PKG1:	DS	1	;
TMP_PKG:	DS	1	;
COUNT3:		DS	1	;
COUNT4:		DS	1	;
LEVEL_REG:	DS	1	;
REG037:		DS	1	;
COUNT1:		DS	1	;
COUNT2:		DS	1	;
MUTE_REG:	DS	1	;
ON_OFF:		DS	1	;
MDL_TMP:	DS	1	;
OLD_IRDATA:	DS	1	;
	
;*******************************************************************************
psect		udata_shr

TMP_W:		DS	1	;
TMP_FSR:	DS	1	;
TMP_STATUS:	DS	1	;
TMP_PCLATH:	DS	1	;
TMP_ENC:	DS	1	;
	
;*******************************************************************************
psect	edata
modes:
	DW	S?,t?,a?,n?,d?,SPACE?,b?,y?,0
	DW	V?,o?,l?,u?,m?,e?,0
	DW	B?,a?,s?,s?,0
	DW	M?,i?,d?,d?,l?,e?,0
	DW	T?,r?,e?,b?,l?,e?,0
	DW	B?,a?,l?,a?,n?,c?,e?,0
	DW	G?,a?,i?,n?,0
	DW	C?,h?,a?,n?,n?,e?,l?,0
parameters:
	DW	0x01,0x01,0x05,0x08,0x08,0x08,0x10,0xff	
;*******************************************************************************
psect ResVect, class=CODE, abs, delta=2
	org			0x0000
ResetVector:
	goto		start
;*******************************************************************************
	org			0x0004
HighInterruptVector:
	movwf		TMP_W		; сохранить значение аккумулятора
	swapf		STATUS, W	; сохранить
	movwf		TMP_STATUS	; состояние регистра STATUS
	swapf		PCLATH, W	; сохранить
	movwf		TMP_PCLATH	; значение PCLATH
	swapf		FSR, W		; сохранить
	movwf		TMP_FSR		; значение FSR
;	goto		intrpt		; переход на обработку прерывания
;*******************************************************************************
; обработчик прерываний
;intrpt:
	movlw		0x01		; 1 в аккумулятор
	btfss		RBIF		; изменения энкодера
		andlw	0x00		;	нет
	btfss		RBIE		; прерывания по энкодеру
		andlw	0x00		;	запрещены
	iorlw		0x00		;
	btfsc		ZERO		; работа энкодера
		goto	int_tmr		;	не обнаружена
;*******************************************************************************
; обнаружено прерывание по энкодеру
	BANKSEL		ENC_PORT	;
	bcf			TMP_ENC,BIT0; очистка предыдущего
	bcf			TMP_ENC,BIT1; состояния энкодера
	btfsc		ENC_B		; сохраняем текущее
		bsf		TMP_ENC,BIT0; состояние энкодера
	btfsc		ENC_A		; в битах 0, 1 
		bsf		TMP_ENC,BIT1; регистра TMP_ENC
	goto		int_end		;
;*******************************************************************************
; Проверка прерывания по TMR0 (irrc)
int_tmr:
	movlw		0x01		;b'0000 0001',' ',.01
	btfss		T0IF
		andlw	0x00		; нет прерывания по TMR0
	btfss		T0IE
		andlw	0x00		; прерывание по TMR0 запрещено
	iorlw		0x00		; для проверки на 0
	btfsc		ZERO
		goto	int_end		; не требуется интерпритация irrc
;*******************************************************************************
	call		irread
;*******************************************************************************
; Восстановление состояния при выходе из прарывания
int_end:
	bcf			T0IF		; сброс флага прерывания по TMR0
	bcf			RBIF		; сброс флага прерывания по энкодеру
	movlw		0xFF		;
	movwf		TMR0		;
	swapf		TMP_PCLATH,W
	movwf		PCLATH
	swapf		TMP_FSR,W
	movwf		FSR
	swapf		TMP_STATUS,W
	movwf		STATUS
	swapf		TMP_W,F
	swapf		TMP_W,W
	retfie
;*******************************************************************************
get_freq_scale:
	movlw		high(get_freq_scale)
	movwf		PCLATH
	movf		FSR, W
	incf		FSR, F
	addwf		PCL, F
IRP fsp, 0x00, 0x00, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07
	retlw		fsp
	ENDM
IRP	fsp, 0x0F, 0x0E, 0x0D, 0x0C, 0x0B, 0x0A, 0x09, 0x08
	retlw		fsp
	ENDM
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
	BANKSEL		EEADR
	movwf		EEADR
IRP	FREG, CNL_TMP, PAMP_TMP, VOL_TMP, BASS_TMP, MDL_TMP, TRBL_TMP, BAL_TMP
	COPYEEDT	FREG
	ENDM
;*******************************************************************************
	call		iic_msg
	call		mode_print
	bcf			T0IF
	bcf			RBIF
	movlw		0x03
	movwf		TMP_ENC
	bsf			GIE
;*******************************************************************************
read_keys:
	call		check_key
	movf		PRESSED_KEY,W
	btfsc		ZERO
		goto	read_enc
	movf		PRESSED_KEY,W
	xorlw		0x04		;
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
	xorlw		0x01			; 1 - "MUTE" key
	btfsc		ZERO
		goto	mute_key
	xorlw		0x02 ^ 0x01		; 2 - "NEXT" key
	btfsc		ZERO
		goto	next_key
	xorlw		0x03 ^ 0x02		; 3 - "PREV" key
	btfsc		ZERO
		goto	prev_key
;*******************************************************************************
in_mode:
	call		mode_print
	movlw		0xFF		;
	movwf		REG022
	movwf		REG023
	movwf		COUNT1
	movlw		0x8F		;
	movwf		COUNT2
pause_mode:
	movlw		0x01		;
	subwf		COUNT1,F
	movlw		0x00		;
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
	movf		TMP_ENC,W		;
	andlw		0x03			;
	btfsc		ZERO			; энкодер в среднем положении между позициями?
		bsf		TMP_ENC,BIT7	; да, установим флаг
	btfss		TMP_ENC,BIT7	; установлен флаг перехода через среднее полож.?
		goto	decode_irrc		; нет, - выход
	xorlw		0x01			; проверка на вращение
	btfsc		ZERO			; по часовой?
		bsf		TMP_ENC,BIT6	; да, установим флаг вращения по часовой
	xorlw		0x02			; проверка на переход
	btfss		ZERO			; в следущую позицию
		goto	decode_irrc		; нет, - выход
	btfsc		TMP_ENC,BIT6	; вращение энкодера по часовой?
		goto	e_m				; нет, - переход к уменьшению параметра
	call		encoder_plus	; да, - переход к увеличению параметра
	goto		e_n
e_m:
	call		encoder_minus
e_n:
	bcf			TMP_ENC,BIT7	;
	bcf			TMP_ENC,BIT6	;	
	movlw		0xFF			;
	movwf		REG022
	movwf		REG023
	call		to_line_2
;*******************************************************************************
decode_irrc:
	BANKSEL		IRADDR
	movf		IRADDR,W
	xorlw		0x80		;адрес устройства
	btfss		ZERO
		goto	p_to_v_mode
	movf		IRDATA,W
	xorlw		0x11		;
	btfsc		ZERO
		goto	p_to_v_mode	;
	xorlw		0xEE ^ 0x11	; повтор команды при зажатой кнопке ДУ
	btfsc		ZERO
		goto	repeat_command
	xorlw		0x80 ^ 0xEE	; код кнопки включения
	btfsc		ZERO
		call	on_off_dev
	BANKSEL		ON_OFF
	movf		ON_OFF,F
	btfsc		ZERO
		goto	decode_command
	goto		auto_vol_mode
repeat_command:
	movf		OLD_IRDATA,W
	movwf		IRDATA
	goto		decode_command
;*******************************************************************************
ch_one:
	movf		REG021,W
	iorwf		REG020,W
	btfss		ZERO
		goto	auto_vol_mode
	movlw		0x01		;
	goto		ch_setup
ch_two:
	movf		REG021,W
	iorwf		REG020,W
	btfss		ZERO
		goto	auto_vol_mode
	movlw		0x02		;b'0000 0010',' ',.02
	goto		ch_setup
ch_three:
	movf		REG021,W
	iorwf		REG020,W
	btfss		ZERO
		goto	auto_vol_mode
	movlw		0x03		;b'0000 0011',' ',.03
	goto		ch_setup
ch_four:
	movf		REG021,W
	iorwf		REG020,W
	btfss		ZERO
		goto	auto_vol_mode
	movlw		0x04
ch_setup:
	movwf		CNL_TMP
	goto		auto_vol_mode
rc_mute:
	movf		REG021,W
	iorwf		REG020,W
	btfss		ZERO
		goto	auto_vol_mode
	call		mute_on_off
	goto		auto_vol_mode
rc_mode_next:
	movf		REG021,W
	iorwf		REG020,W
	btfss		ZERO
		goto	auto_vol_mode
	call		mode_next
	goto		auto_vol_mode
rc_mode_prev:
	movf		REG021,W
	iorwf		REG020,W
	btfss		ZERO
		goto	auto_vol_mode
	call		mode_prev
	goto		auto_vol_mode
rc_param_minus:
	call		encoder_minus
	goto		auto_vol_mode
rc_param_plus:
	call		encoder_plus
	goto		auto_vol_mode
;*******************************************************************************
decode_command:
	BANKSEL		IRDATA
	movf		IRDATA,W
	movwf		OLD_IRDATA
	xorlw		0x42		; код кнопки "влево" ("V-")
	btfsc		ZERO
		goto	rc_param_minus
	xorlw		0x82 ^ 0x42	; код кнопки "вправо" ("V+")
	btfsc		ZERO
		goto	rc_param_plus
	BANKSEL		REG021	
	xorlw		0x00 ^ 0x82	; код кнопки "1"
	btfsc		ZERO
		goto	ch_one	
	xorlw		0xE0 ^ 0x00	; код кнопки "2"
	btfsc		ZERO
		goto	ch_two	
	xorlw		0x60 ^ 0xE0	; код кнопки "3"
	btfsc		ZERO
		goto	ch_three	
	xorlw		0x20 ^ 0x60	; код кнопки "4"
	btfsc		ZERO
		goto	ch_four
	xorlw		0x48 ^ 0x20	; код кнопки "mute"
	btfsc		ZERO
		goto	rc_mute
	xorlw		0xE8 ^ 0x48	; код кнопки "вверх" ("CH+")
	btfsc		ZERO
		goto	rc_mode_next
	xorlw		0x58 ^ 0xE8	; код кнопки "вниз" ("CH-")
	btfsc		ZERO
		goto	rc_mode_prev
;*******************************************************************************
; Автоматический переход в режим регулировки громкости
auto_vol_mode:
	call		mode_print
	movlw		0x04		;b'0000 0100',' ',.04
	movwf		REG021
	movlw		0xFF		;b'1111 1111','я',.255
	movwf		REG020
	movwf		REG022
	movwf		REG023
p_to_v_mode:
	BANKSEL		IRDATA

	movlw		0x11
	movwf		IRDATA
	BANKSEL		REG021
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
	BANKSEL		OLD_IRDATA
	movlw		0x11
	movwf		OLD_IRDATA
	call		mode_print
;*******************************************************************************
	goto		read_keys	;
;*******************************************************************************
;Сохранение значений регулируемых параметров в EEPROM
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
	BANKSEL		TMP_PKG
	movwf		TMP_PKG
IRP	FREG, CNL_TMP, PAMP_TMP, VOL_TMP, BASS_TMP, MDL_TMP, TRBL_TMP, BAL_TMP
	BANKSEL		FSR
	movlw		FREG
	movwf		FSR
	call		save_freg
	ENDM
	return
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
	BYTE_CGRAM	0x14	; две через одну вертикальных полосы слева 
	ENDM
REPT	8
	BYTE_CGRAM	0x15	; три через одну вертикальных полосы слева
	ENDM
IRP	BT, 0x1F, 0x1B, 0x13, 0x1B, 0x1B, 0x11, 0x1F, 0x00
	BYTE_CGRAM	BT		; 1-ый канал
	ENDM
IRP	BT, 0x1F, 0x11, 0x1D, 0x11, 0x17, 0x11, 0x1F, 0x00
	BYTE_CGRAM	BT		; 2-ой канал
	ENDM
IRP	BT, 0x1F, 0x11, 0x1D, 0x19, 0x1D, 0x11, 0x1F, 0x00
	BYTE_CGRAM	BT		; 3-ий канал
	ENDM
IRP	BT, 0x1F, 0x15, 0x15, 0x11, 0x1D, 0x1D, 0x1F, 0x00
	BYTE_CGRAM	BT		; 4-ый канал
	ENDM
	return
;*******************************************************************************
iic_msg:								; отправка сообщения по шине I2C
	call		iic_start_condition		; условие пуск
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
IRP PARAM_REG, BASS_TMP, MDL_TMP, TRBL_TMP
	BANKSEL		PARAM_REG
	movf		PARAM_REG, W
	addlw		0x01
	movwf		FSR
	call		get_freq_scale
	call		iic_send_byte
	ENDM
	movf		BAL_TMP, W
	sublw		AP_ATT32
	movwf		COUNT4
	sublw		AP_ATT32
	movwf		COUNT3
send_bal:
	movf		COUNT4,W				; аттенюатор правый
	call		iic_send_byte
	BANKSEL		COUNT3					; аттенюатор правый
	movf		COUNT3,W
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
	fsr_reg_plus	BAL_TMP, 32
;*******************************************************************************
gain_plus:
	fsr_reg_plus	PAMP_TMP, 16
;*******************************************************************************
encoder_plus:
	movf		MODE_NUM,W
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
		goto	volume_plus
	xorlw		0x03		;b'0000 0011',' ',.03
	btfsc		ZERO
		goto	bass_plus
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
		goto	middle_plus
	xorlw		0x07		;b'0000 0111',' ',.07
	btfsc		ZERO
		goto	treble_plus
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
		goto	balance_plus
	xorlw		0x03		;b'0000 0011',' ',.03
	btfsc		ZERO
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
	movlw		0x05		;
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
;*******************************************************************************
encoder_minus:
	movf		MODE_NUM,W
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
		goto	volume_minus
	xorlw		0x03		;b'0000 0011',' ',.03
	btfsc		ZERO
		goto	bass_minus
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
		goto	middle_minus
	xorlw		0x07		;b'0000 0111',' ',.07
	btfsc		ZERO
		goto	treble_minus
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
		goto	balance_minus
	xorlw		0x03		;b'0000 0011',' ',.03
	btfsc		ZERO
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
	movlw		0x04		; после первого включаем четвертый
	movwf		CNL_TMP
	return
;*******************************************************************************
on_off_dev:
	BANKSEL		ON_OFF			;
	decfsz		ON_OFF,W
		goto	off_dev
	clrf		ON_OFF
	clrf		MUTE_REG
	clrf		MODE_NUM
	incf		MODE_NUM,F
	goto		on_off_led
off_dev:
	call		save_fregs		;
	BANKSEL		ON_OFF			;
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
bass_mode:
	movf		BASS_TMP,W
	call		freq_scale
	goto		iic_msg
mdl_mode:
	movf		MDL_TMP, W
	call		freq_scale
	goto		iic_msg
trbl_mode:
	movf		TRBL_TMP,W
	call		freq_scale
	goto		iic_msg
bal_mode:
	movf		BAL_TMP,W
	call		bal_scale
	goto		iic_msg
gain_mode:
	movf		PAMP_TMP, W
	call		freq_scale
	goto		iic_msg
cnl_mode:
	movlw		0x10		;b'0001 0000',' ',.16
	movwf		LINE_POS
	movlw		0x01		;b'0000 0001',' ',.01
	call		set_DDRAM_ADDR
	movf		CNL_TMP,W
	addlw		0x03		;
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
		goto	bass_mode
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
		goto	mdl_mode
	xorlw		0x07		;b'0000 0111',' ',.07
	btfsc		ZERO
		goto	trbl_mode
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
		goto	bal_mode
	xorlw		0x03		;b'0000 0011',' ',.03
	btfsc		ZERO
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
	addlw		0x03		; символ номера канала
	goto		print_lcd
;*******************************************************************************
bal_scale:
	movwf		LEVEL_REG
	movlw		0x02		; вес полного сегмента шкалы
	movwf		TMP_PKG1
	movf		LEVEL_REG, W
	sublw		0x02
	btfsc		CARRY
		goto	pr_lt
	movlw		0x02
	subwf		LEVEL_REG, W
	call		full_segs
	movlw		RIGHT?
	call		print_lcd
pr_lt:
	movf		LEVEL_REG, W
	sublw		0x20
	movwf		TMP_PKG
	btfsc		ZERO
		goto	e_u_l
	movlw		LEFT?
	call		print_lcd
	movlw		0x01
	subwf		TMP_PKG, W
	call		full_segs
	goto		e_u_l
;*******************************************************************************
vol_scale:
	movwf		LEVEL_REG
	movlw		0x03		; вес полного сегмента шкалы
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
; на входе: в аккумуляторе значение шкалы, в TMP_PKG1 вес сегмента шкалы
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
	movlw		0x03
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
	BANKSEL		TMR0
	movlw		0xFF		;b'1111 1111','я',.255
	movwf		TMR0
	bsf			T0IE		; разрешить прерывания по TMR0
;	bcf			T0IF		; сбросить флаг прерывания по TMR0
	bsf			RBIE		; разрешить прерывания по RB7:RB4
;	bcf			RBIF		; сбросить флаг прерывания по RB7:RB4
;	bsf			GIE			; разрешить все указанные прерывания
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
	end			ResetVector	; directive 'end of program'
