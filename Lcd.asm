#include	"Lcd.inc"

;*******************************************************************************
; Резервирование памяти
PSECT udata_bank0			;
	
_LCD_FLAGS:	    DS	1		; регистр флагов работы с LCD
_PKG_LCD:	    DS	1		; пакет для отправки в LCD
	
LINE_NUM:		DS	1		;
LINE_POS:		DS	1		;

;*******************************************************************************
PSECT	code 
_init_lcd:	; инициализация ЖКИ
    BANKSEL	    TS_CTRL_LCD			;
    BCF		    TS_CTRL_LCD, RS_LCD	;
    BCF		    TS_CTRL_LCD, RW_LCD	;
    BCF		    TS_CTRL_LCD, E_LCD	;

    BCF		    TS_DATA_LCD, DB4_LCD;
    BCF		    TS_DATA_LCD, DB5_LCD;
    BCF		    TS_DATA_LCD, DB6_LCD;
    BCF		    TS_DATA_LCD, DB7_LCD;
	
	BCF			TS_DATA_LCD, LCD_LED_POSN

    BANKSEL	    CTRL_LCD			;
    BCF		    _LCD_FLAGS, LPKGH	;

;*******************************************************************************
; инициализация
    CALL	    p20000us		; пауза после подачи питания
    MOVLW	    FUNCSET|FUNCSETDL	; восьмипроводный режим 
    MOVWF	    _PKG_LCD		;
    BCF		    CTRL_LCD, RS_LCD	;
    BCF		    CTRL_LCD, RW_LCD	;
    CALL	    pkg_in_port		;
    CALL	    pkg_in_port		;
REPT		    3			;
    CALL	    p40us		; пауза более 100 мкс
    ENDM				;
    CALL	    pkg_in_port		;
    CALL	    p40us		;
    MOVLW	    FUNCSET		;  четырехпроводный режим
    MOVWF	    _PKG_LCD		;
    CALL	    pkg_in_port		; далее работаем в четырехпроводном
    CALL	    p40us		; режиме
 ; настройка функций ЖКИ
    MOVLW	    FUNCSET|FUNCSETN;|FUNCSETF	;
;    MOVWF	    _PKG_LCD		;
    CALL	    _print_smb		; двухстрочный режим

;******** Продолжение инициализации DISPLAY ON/OFF MODE ************************
    MOVLW	    DISPCTRL|DISPCTRLD;|DISPCTRLC|DISPCTRLB;
 ;   MOVWF	    _PKG_LCD		; записать это значение в байт сообщения
    CALL	    _print_smb		; запись в порт

;******** Продолжение инициализации DISPLAY CLEAR ******************************
    MOVLW	    CLRDISP		;
;    MOVWF	    _PKG_LCD		; записать это значение в байт сообщения
    CALL	    _send_lcd		; запись в порт

;******** Пауза более 1,53 мс **************************************************
    CALL	    p1545us		;

;******** Продолжение инициализации ENTRY MODE SET *****************************
    MOVLW	    EMSET|EMSETID	;
;    MOVWF	    _PKG_LCD		; записать это значение в байт сообщения
    CALL	    _print_smb		; запись в порт

;******** Инициализация дисплея закончена **************************************
    RETURN

;*******************************************************************************
_print_smb:
	BANKSEL		_PKG_LCD
	MOVWF		_PKG_LCD
;******** Вывод информации *****************************************************
    CALL	    _send_lcd
	goto		p40us

;*******************************************************************************
_send_lcd:
    BSF		    _LCD_FLAGS, LPKGH	; поднимаем флаг работы со старшим п-б
pkg_in_port:	; выставление уровней на выводах LCD в соответствии
		; с данными отсылаемого пакета (полубайт пакета)
    BCF		    DATA_LCD, DB7_LCD	;
    BTFSC	    _PKG_LCD, BIT7	;
		BSF	    DATA_LCD, DB7_LCD	;
    BCF		    DATA_LCD, DB6_LCD	;
    BTFSC	    _PKG_LCD, BIT6	;
		BSF	    DATA_LCD, DB6_LCD	;
    BCF		    DATA_LCD, DB5_LCD	;
    BTFSC	    _PKG_LCD, BIT5	;
		BSF	    DATA_LCD, DB5_LCD	;
    BCF		    DATA_LCD, DB4_LCD	;
    BTFSC	    _PKG_LCD, BIT4	;
		BSF	    DATA_LCD, DB4_LCD	;

write_lcd:	; отсылка команды записи данных в LCD
    BSF		    CTRL_LCD, E_LCD	; синхроимпульс в LCD
    BCF		    CTRL_LCD, E_LCD	;
    BTFSS	    _LCD_FLAGS, LPKGH	; пропуск, если передан старший и
		RETURN				; выход, если передан младший полубайт
    SWAPF	    _PKG_LCD, F		; смена мест полубайтов
    BCF		    _LCD_FLAGS, LPKGH	; сброс флага работы со старшим п-байтом
    GOTO	    pkg_in_port		; младший полубайт в порт

;*******************************************************************************
_shift_lcd:				;
    BCF		    CTRL_LCD, RS_LCD	; поднимаем флаг передачи команды
    BTFSC	    _LCD_FLAGS,	LSHLR	; проверка флага направления сдвига
	GOTO	    shift_left		;
    movlw	    CDSHIFT|CDSHIFTSC|CDSHIFTRL	; сдвиг видимого окна  вправо
	call		_print_smb
shift_left:
    BTFSS	    _LCD_FLAGS, LSHLR	; проверка флага направления сдвига
	GOTO	    shifted		;
    movlw	    CDSHIFT|CDSHIFTSC	; сдвиг видимосго окна влево
	call		_print_smb
shifted:	
    BSF		    CTRL_LCD, RS_LCD	; сброс флага передачи команды
    RETURN

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
space_line_LCD:
	movwf		LINE_POS
	decfsz		LINE_POS,W
	    goto	line_2
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
line_2:
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
p20000us:
	movlw		15					;
	movwf		TIME_M				;
	movlw		156
	goto		pause				;
p1545us:
	movlw		1					;
	movwf		TIME_M				;
	movlw		52					;
	goto		pause				;		
p40us:
	movlw		4					;
	goto		pause				;

;*******************************************************************************
;*******************************************************************************
    GLOBAL	    _init_lcd		; инициализация LCD
    GLOBAL	    _send_lcd		; отправка пакета в LCD
    GLOBAL	    _print_smb		;
    GLOBAL	    _shift_lcd		;
    GLOBAL	    _LCD_FLAGS, _PKG_LCD, LINE_NUM, LINE_POS;
	GLOBAL		set_DDRAM_ADDR, space_line_LCD
    GLOBAL	    p1545us		;
;*******************************************************************************

    END
