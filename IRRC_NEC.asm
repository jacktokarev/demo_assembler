#include		"Irrc.inc"

;*******************************************************************************
psect			udata_bank0
	
IRDATA_:		DS	1	;
IRDATA:			DS	1	;
IRADDR_:		DS	1	;
IRADDR:			DS	1	;
;IRDATA_CP:		DS	1	;
;IRDATACP:		DS	1	;
;IRADDR_CP:		DS	1	;
;IRADDRCP:		DS	1	;

;*******************************************************************************
psect			udata_shr

TIMECOUNT:		DS	2	;
BITCOUNT:		DS	1	;
TMPIRBIT:		DS	1	;
TIMESCRAP:		DS	2	;

;*******************************************************************************
psect			code

irread:
	BANKSEL		IRRC_PORT
	movlw		0x02
	movwf		TIMESCRAP
	movlw		0x27
	movwf		TIMESCRAP+1
	swapf		TIMESCRAP+1,F
	call		waitstate		; высокий уровень стартовrой последовательности
	xorlw		0x01			; ждем примерно 9930 микросекунд.
	btfsc		ZERO
		return					; возврат если более 9930 мкс
	movlw		0x01
	movwf		TIMESCRAP
	movlw		0x0F
	movwf		TIMESCRAP+1
	swapf		TIMESCRAP+1,F
	call		waitstate		; низкий уровень стартовой последовательности
	xorlw		0x01			; ждем примерно 4890 микросекунд
	btfsc		ZERO
		return					; возврат если более 4890 мкс
;*******************************************************************************
startcond:
	movlw		0x00			;
	subwf		TIMECOUNT,W
	movlw		0x90			;
	btfsc		ZERO			; проверка стартовой последовательности:
		subwf	TIMECOUNT+1,W	; переход из "1" в "0" и обратно более чем 
	btfsc		CARRY			; 2600 мкс
		goto	readaddr		; переход на чтение адреса
;*******************************************************************************
	movlw		0x75			; проверка последовательности повтора
;	btfsc		ZERO
		subwf	TIMECOUNT+1,W	; комманды при зажатой кнопке пульта
	btfsc		CARRY			;
		goto	repeatcond		;
;	movf		IRADDR_CP,W		; при сбое приема восстанавливаем
;	movwf		IRADDR_			; предыдущие данные
;	movf		IRADDRCP,W
;	movwf		IRADDR
;	movf		IRDATACP,W
;	movwf		IRDATA
;	movf		IRDATA_CP,W
;	movwf		IRDATA_
bugcommand:
;	movlw		0x00			; при сбое возвращаем непригодные
;	movwf		IRADDR			; к декодированию значения адреса
	clrf		IRADDR
	movlw		0x11			; и
	movwf		IRDATA			; данных (в данной конфигурации)
	return						; возврат при сбое на стартовой последоват.
repeatcond:
;	movlw		0x80			; адрес 0x80 при приеме последовательности
;	movwf		IRADDR			; повтора команды при зажатой кнопке
	movlw		0xEE			; пульта и данные (команда) 0xEE
	movwf		IRDATA			; (в данной конфигурации)
	return						; возврат при повторе команды
;*******************************************************************************
readaddr:
	clrf		BITCOUNT
readbit:
	movlw		0x20			;b'0010 0000',' ',.32
	subwf		BITCOUNT,W
	btfsc		CARRY
;		goto	copyirpkg		; переход при считывании 32 бит пакета
		return					; выход при считывании 32 бит пакета
;*******************************************************************************
	movlw		0x00
	movwf		TIMESCRAP
;	movlw		0x29
	movlw		0x23			; 640 мкс
	movwf		TIMESCRAP+1
	swapf		TIMESCRAP+1,F
	call		waitstate
	xorlw		0x01
	btfsc		ZERO
;		return					; возврат если более 745 мкс
		goto	bugcommand		; возврат если более 745 мкс
;	movlw		0x6F
	movlw		0x67			; 1865 мкс
	movwf		TIMESCRAP+1
	swapf		TIMESCRAP+1,F
	call		waitstate
	xorlw		0x01
	btfsc		ZERO
;		return					; возврат если более 2005 мкс
		goto	bugcommand		; возврат если более 2005 мкс
;*******************************************************************************
;fixbit:
	bcf			CARRY			; сбросить флаг переноса
	rlf			IRDATA_,F		; сдвиг влево 
	rlf			IRDATA,F		; ...
	rlf			IRADDR_,F		; ...
	rlf			IRADDR,F		; ...
	movlw		0x00			;b'0000 0000',' ',.00
	subwf		TIMECOUNT,W
;	movlw		0x24			;b'0010 0100','$',.36
	movlw		0x30			; 875 мкс
	btfsc		ZERO
		subwf	TIMECOUNT+1,W
	btfsc		CARRY			; >650 мкс (значение считанного бита равно 0)
		bsf		IRDATA_,BIT0	; значеение считанного бита равно 1
	incf		BITCOUNT,F		; увеличить счетчик считанных бит
	goto		readbit
;*******************************************************************************
;copyirpkg:
;	movf		IRADDR,W
;	movwf		IRADDRCP
;	movf		IRADDR_,W
;	movwf		IRADDR_CP
;	movf		IRDATA,W
;	movwf		IRDATACP
;	movf		IRDATA_,W
;	movwf		IRDATA_CP
;	return	
;*******************************************************************************
;irstate:
;	btfsc		IRRC
;		movlw	0x01		;b'0000 0001',' ',.01
;	movwf		TMPIRBIT	; состаяние IR приемника в BIT0 W и TMPIRBIT
;	clrf		TIMECOUNT
;	clrf		TIMECOUNT+1
;	return
;*******************************************************************************
;irchange:
;	movlw		0x00		;b'0000 0000',' ',.00
;	btfsc		IRRC
;		movlw	0x01		;b'0000 0001',' ',.01
;	xorwf		TMPIRBIT,W	; если состояние IR прм. изменилось -> 1 в BIT0 W
;	return
;*******************************************************************************
waitstate:
	movlw		0x00		;b'0000 0000',' ',.00
;	call		irstate
	btfsc		IRRC
		movlw	0x01		;b'0000 0001',' ',.01
	movwf		TMPIRBIT	; состаяние IR приемника в BIT0 W и TMPIRBIT
	clrf		TIMECOUNT
	clrf		TIMECOUNT+1
waitchange:
;	call		irchange
	movlw		0x00		;b'0000 0000',' ',.00
	btfsc		IRRC
		movlw	0x01		;b'0000 0001',' ',.01
	xorwf		TMPIRBIT,W	; если состояние IR прм. изменилось -> 1 в BIT0 W
	btfss		ZERO
		retlw	0x00			; возврат при иззмнении состояния IR прм.
	incf		TIMECOUNT+1,F	; считаем пока состояние IR прм. не меняется
	btfsc		ZERO
		incf	TIMECOUNT,F
	movf		TIMESCRAP,W
	subwf		TIMECOUNT,W
	swapf		TIMESCRAP+1,W
	btfsc		ZERO
		subwf	TIMECOUNT+1,W
	btfsc		CARRY
		retlw	0x01			; возврат если превышено время ожидания
	goto		waitchange
;*******************************************************************************
irdecode:
	return
;*******************************************************************************
	GLOBAL		irread, irdecode, IRDATA, IRADDR

	end
