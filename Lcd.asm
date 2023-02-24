#include	"Lcd.inc"

;*******************************************************************************
; Резервирование памяти
PSECT udata_bank0			;
	
FLAGS_LCD:		DS	1		; регистр флагов работы с LCD
PKG_LCD:		DS	1		; пакет для отправки в LCD
	
LINE_NUM:		DS	1		;
LINE_POS:		DS	1		;

;*******************************************************************************
PSECT	code 
init_lcd:	; инициализация ЖКИ
	BANKSEL		TS_CTRL_LCD			;
	bcf			TS_CTRL_LCD, RS_LCD	;
;	bcf			TS_CTRL_LCD, RW_LCD	;
	bcf			TS_CTRL_LCD, E_LCD	;

	bcf			TS_DATA_LCD, DB4_LCD;
	bcf			TS_DATA_LCD, DB5_LCD;
	bcf			TS_DATA_LCD, DB6_LCD;
	bcf			TS_DATA_LCD, DB7_LCD;
	
	bcf			TS_DATA_LCD, LCD_LED_POSN

	BANKSEL		CTRL_LCD			;
	bcf			FLAGS_LCD, LPKGH	;

;*******************************************************************************
; инициализация
	call		p15000us		; пауза после подачи питания
	movlw		FUNCSET|FUNCSETDL	; восьмипроводный режим 
	movwf		PKG_LCD		;
	bcf			RS_L	;
;	bcf			CTRL_LCD, RW_LCD	;
	call		pkg_in_port		;
	call		p4100us
	call		pkg_in_port		;
	call		p100us
	call		pkg_in_port		;
	call		p40us		;
	movlw		FUNCSET		;  четырехпроводный режим
	movwf		PKG_LCD		;
	call		pkg_in_port		; далее работаем в четырехпроводном
	call		p40us		; режиме
 ; настройка функций ЖКИ
	movlw		FUNCSET|FUNCSETN;|FUNCSETF	;
	call		print_lcd		; двухстрочный режим

;******** Продолжение инициализации DISPLAY ON/OFF MODE ************************
	movlw		DISPCTRL|DISPCTRLD;|DISPCTRLC|DISPCTRLB;
	call		print_lcd		; запись в порт

;******** Продолжение инициализации DISPLAY CLEAR ******************************
	movlw		CLRDISP		;
	call		send_lcd		; запись в порт

;******** Пауза более 1,53 мс **************************************************
	call		p1590us		;

;******** Продолжение инициализации ENTRY MODE SET *****************************
	movlw		EMSET|EMSETID	;
	call		print_lcd		; запись в порт

;******** Инициализация дисплея закончена **************************************
	return

;*******************************************************************************
print_lcd:
	BANKSEL		PKG_LCD
	movwf		PKG_LCD
;******** Вывод информации *****************************************************
	call		send_lcd
	goto		p40us

;*******************************************************************************
send_lcd:
	bsf			FLAGS_LCD, LPKGH	; поднимаем флаг работы со старшим п-б
pkg_in_port:	; выставление уровней на выводах LCD в соответствии
		; с данными отсылаемого пакета (полубайт пакета)
	bcf			DATA_LCD, DB7_LCD	;
	BTFSC		PKG_LCD, BIT7	;
		bsf		DATA_LCD, DB7_LCD	;
	bcf			DATA_LCD, DB6_LCD	;
	BTFSC		PKG_LCD, BIT6	;
		bsf		DATA_LCD, DB6_LCD	;
	bcf			DATA_LCD, DB5_LCD	;
	BTFSC		PKG_LCD, BIT5	;
		bsf		DATA_LCD, DB5_LCD	;
	bcf			DATA_LCD, DB4_LCD	;
	BTFSC		PKG_LCD, BIT4	;
		bsf		DATA_LCD, DB4_LCD	;

write_lcd:	; отсылка команды записи данных в LCD
	bsf			E_L	; синхроимпульс в LCD
	bcf			E_L	;
	btfss		FLAGS_LCD, LPKGH	; пропуск, если передан старший и
		return				; выход, если передан младший полубайт
	SWAPF		PKG_LCD, F		; смена мест полубайтов
	bcf			FLAGS_LCD, LPKGH	; сброс флага работы со старшим п-байтом
	goto		pkg_in_port		; младший полубайт в порт

;*******************************************************************************
;shift_lcd:				;
;	bcf			RS_L	; поднимаем флаг передачи команды
;	BTFSC		FLAGS_LCD,	LSHLR	; проверка флага направления сдвига
;	goto		shift_left		;
;	movlw		CDSHIFT|CDSHIFTSC|CDSHIFTRL	; сдвиг видимого окна  вправо
;	call		print_lcd
;shift_left:
;	btfss		FLAGS_LCD, LSHLR	; проверка флага направления сдвига
;	goto		shifted		;
;	movlw		CDSHIFT|CDSHIFTSC	; сдвиг видимосго окна влево
;	call		print_lcd
;shifted:	
;	bsf			RS_L	; сброс флага передачи команды
;	return

;*******************************************************************************
set_DDRAM_ADDR:
	movwf		LINE_NUM

	decf		LINE_POS, W
	iorlw		DDRADDR|LCD_LINE_ONE
	btfsc		LINE_NUM, BIT1
		iorlw	LCD_LINE_TWO
	bcf			RS_L
	call		print_lcd
	bsf			RS_L
	return
	
;*******************************************************************************
clear_LCD:
	movlw		CLRDISP
	bcf			RS_L
	call		print_lcd	;
	call		p1590us
	bsf			RS_L
	return

;*******************************************************************************
space_line_LCD:
	movwf		LINE_POS
	movlw		DDRADDR|0x00
	btfsc		LINE_POS, BIT1
		movlw	DDRADDR|0x40
	bcf			RS_L
	call		print_lcd
	bsf			RS_L
	clrf		LINE_NUM
next_pos:
	movlw		SPACE?
	call		print_lcd
	incf		LINE_NUM, F
	movlw		16
	subwf		LINE_NUM, W
	btfss		CARRY
		goto	next_pos
	movlw		DDRADDR|0x00
	btfsc		LINE_POS, BIT1
		movlw	DDRADDR|0x40
	bcf			RS_L
	call		print_lcd
	bsf			RS_L
	return

;*******************************************************************************
p15000us:
	movlw		11					;
	movwf		TIME_M				;
	movlw		180
	goto		pause				;
p4100us:							;
	movlw		3					;
	movwf		TIME_M				;
	movlw		48					;
	goto		pause				;
p1590us:
	movlw		1					;
	movwf		TIME_M				;
	movlw		58					;
	goto		pause				;
p100us:
	movlw		16					;
	goto		pause				;
p40us:
	movlw		4					;
	goto		pause				;

;*******************************************************************************
	GLOBAL		init_lcd		; инициализация LCD
	GLOBAL		print_lcd		;
;	GLOBAL		shift_lcd		;
;	GLOBAL		FLAGS_LCD, PKG_LCD
	GLOBAL		clear_LCD		;
	GLOBAL		LINE_NUM, LINE_POS;
	GLOBAL		set_DDRAM_ADDR, space_line_LCD
;*******************************************************************************

	END
