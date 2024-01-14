#include		"Irrc.inc"

;*******************************************************************************
psect			udata_bank0
	
IRDATA:			DS	2	;
IRADDR:			DS	2	;
;*******************************************************************************
psect			udata_shr

TIMECOUNT:		DS	1	;
BITCOUNT:		DS	1	;
TMPIRBIT:		DS	1	;
TIMESCRAP:		DS	1	;

;*******************************************************************************
psect			code

irread:
	BANKSEL		IRRC_PORT
	movlw		0xFA
	movwf		TIMESCRAP
	call		waitstate		; высокий уровень стартовrой последовательности
	xorlw		0x01			; ждем примерно 5010 микросекунд.
	btfss		ZERO
		goto	waitlow			;
	call		waitstate		; высокий уровень стартовrой последовательности
	xorlw		0x01			; ждем примерно 5010 микросекунд.
	btfsc		ZERO			;
		return					; возврат если более 10020 мкс
waitlow:
	call		waitstate		; низкий уровень стартовой последовательности
	xorlw		0x01			; ждем примерно 5010 микросекунд
	btfsc		ZERO
		return					; возврат если более 5010 мкс
;*******************************************************************************
startcond:
	movlw		0x82			; проверка стартовой последовательности:
	subwf		TIMECOUNT,W		; переход из "0" в "1" более чем 
	btfsc		CARRY			; 2609 мкс
		goto	readaddr		; переход на чтение адреса
;*******************************************************************************
	movlw		0x69			; проверка последовательности повтора
	subwf		TIMECOUNT,W		; комманды при зажатой кнопке пульта
	btfsc		CARRY			; переход из "0" в "1" более чем
		goto	repeatcond		; 2109 мкс
bugcommand:
	clrf		IRADDR			; при сбое возвращаем непригодные
	movlw		0x11			; к декодированию значения адреса
	movwf		IRDATA			; и данных (в данной конфигурации)
	return						; возврат при сбое
repeatcond:
	movlw		0xEE			; данные (команда) 0xEE (в данной конфигурации)
	movwf		IRDATA			; при приеме сигнала повтора при зажатой кнопке
	return						; возврат при повторе команды
;*******************************************************************************
readaddr:
	clrf		BITCOUNT
readbit:
	movlw		0x20			;
	subwf		BITCOUNT,W
	btfsc		CARRY
		return					; выход при считывании 32 бит пакета
;*******************************************************************************
	movlw		0x20			; 650 мкс
	movwf		TIMESCRAP
	call		waitstate
	xorlw		0x01
	btfsc		ZERO
		goto	bugcommand		; возврат если более 650 мкс
	movlw		0x62			; 1875 мкс
	movwf		TIMESCRAP
	call		waitstate
	xorlw		0x01
	btfsc		ZERO
		goto	bugcommand		; возврат если более 1875 мкс
;*******************************************************************************
;fixbit:
	bcf			CARRY			; сбросить флаг переноса
	rlf			IRDATA+1,F		; сдвиг влево 
	rlf			IRDATA,F		; ...
	rlf			IRADDR+1,F		; ...
	rlf			IRADDR,F		; ...
	movlw		0x2E			; 885 мкс
	subwf		TIMECOUNT,W
	btfsc		CARRY			; >885 мкс (значение считанного бита равно 0)
		bsf		IRDATA+1,BIT0	; значеение считанного бита равно 1
	incf		BITCOUNT,F		; увеличить счетчик считанных бит
	goto		readbit
;*******************************************************************************
waitstate:
	movlw		0x00		;b'0000 0000',' ',.00
	btfsc		IRRC
		movlw	0x01		;b'0000 0001',' ',.01
	movwf		TMPIRBIT	; состаяние IR приемника в BIT0 W и TMPIRBIT
	nop
	clrf		TIMECOUNT
waitchange:
	nop
	movlw		0x00		;b'0000 0000',' ',.00
	nop
	btfsc		IRRC
		movlw	0x01		;b'0000 0001',' ',.01
	nop
	xorwf		TMPIRBIT,W	; если состояние IR прм. изменилось -> 1 в BIT0 W
	btfss		ZERO
		retlw	0x00		; возврат при иззмнении состояния IR прм.
	nop
	incf		TIMECOUNT,F	; считаем пока состояние IR прм. не меняется
	nop
	movf		TIMESCRAP,W
	nop
	subwf		TIMECOUNT,W
	btfsc		CARRY
		retlw	0x01			; возврат если превышено время ожидания
	nop
	goto		waitchange
;*******************************************************************************
irdecode:
	return
;*******************************************************************************
	GLOBAL		irread, irdecode, IRDATA, IRADDR

	end
