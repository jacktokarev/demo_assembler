#include		"Irrc.inc"

;*******************************************************************************
psect			udata_bank0
	
IRDATA_:		DS	1	;
IRDATA:			DS	1	;
IRADDR_:		DS	1	;
IRADDR:			DS	1	;
IRDATA_CP:		DS	1	;
IRDATACP:		DS	1	;
IRADDR_CP:		DS	1	;
IRADDRCP:		DS	1	;

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
	call		waitstate		; высокий уровень стартовой последовательности
	xorlw		0x01
	btfsc		ZERO
		return					; возврат если более 11030 мкс
	movlw		0x01
	movwf		TIMESCRAP
	movlw		0x0F
	movwf		TIMESCRAP+1
	swapf		TIMESCRAP+1,F
	call		waitstate		; низкий уровень стартовой последовательности
	xorlw		0x01
	btfsc		ZERO
		return					; возврат если более 7350 мкс
;*******************************************************************************
startcond:
	movlw		0x00			;b'0000 0000',' ',.00
	subwf		TIMECOUNT,W
	movlw		0x87			;b'1000 0111','‡',.135
	btfsc		ZERO			; проверка стартовой последовательности:
		subwf	TIMECOUNT+1,W	; переход из "1" в "0" и обратно более чем 
	btfsc		CARRY			; 4350 мкс
		goto	readaddr		; переход на чтение адреса
;*******************************************************************************
	movf		IRADDR_CP,W		; при сбое приема восстанавливаем
	movwf		IRADDR_			; предыдущие данные
	movf		IRADDRCP,W
	movwf		IRADDR
	movf		IRDATACP,W
	movwf		IRDATA
	movf		IRDATA_CP,W
	movwf		IRDATA_
	return						; возврат при сбое на стартовой последоват.
;*******************************************************************************
readaddr:
	clrf		BITCOUNT
readbit:
	movlw		0x20			;b'0010 0000',' ',.32
	subwf		BITCOUNT,W
	btfsc		CARRY
		goto	copyirpkg		; переход при считывании 32 бит пакета
;*******************************************************************************
	movlw		0x00
	movwf		TIMESCRAP
	movlw		0x29
	movwf		TIMESCRAP+1
	swapf		TIMESCRAP+1,F
	call		waitstate
	xorlw		0x01
	btfsc		ZERO
		return					; возврат если более 830 мкс
	movlw		0x6F
	movwf		TIMESCRAP+1
	swapf		TIMESCRAP+1,F
	call		waitstate
	xorlw		0x01
	btfsc		ZERO
		return					; возврат если более 2230 мкс
;*******************************************************************************
fixbit:
	bcf			CARRY			; сбросить флаг переноса
	rlf			IRDATA_,F		; сдвиг влево 
	rlf			IRDATA,F		; ...
	rlf			IRADDR_,F		; ...
	rlf			IRADDR,F		; ...
	movlw		0x00			;b'0000 0000',' ',.00
	subwf		TIMECOUNT,W
	movlw		0x24			;b'0010 0100','$',.36
	btfsc		ZERO
		subwf	TIMECOUNT+1,W
	btfsc		CARRY			; >1150 мкс (значение считанного бита равно 0)
		bsf		IRDATA_,BIT0	; значеение считанного бита равно 1
	incf		BITCOUNT,F		; увеличить счетчик считанных бит
	goto		readbit
;*******************************************************************************
copyirpkg:
	movf		IRADDR,W
	movwf		IRADDRCP
	movf		IRADDR_,W
	movwf		IRADDR_CP
	movf		IRDATA,W
	movwf		IRDATACP
	movf		IRDATA_,W
	movwf		IRDATA_CP
	return	
;*******************************************************************************
irstate:
	btfsc		IRRC
		movlw	0x01		;b'0000 0001',' ',.01
	movwf		TMPIRBIT	; состаяние IR приемника в BIT0 W и TMPIRBIT
	clrf		TIMECOUNT
	clrf		TIMECOUNT+1
	return
;*******************************************************************************
irchange:
	movlw		0x00		;b'0000 0000',' ',.00
	btfsc		IRRC
		movlw	0x01		;b'0000 0001',' ',.01
	xorwf		TMPIRBIT,W	; если состояние IR прм. изменилось -> 1 в BIT0 W
	return
;*******************************************************************************
waitstate:
	movlw		0x00		;b'0000 0000',' ',.00
	call		irstate
waitchange:
	call		irchange
	btfss		ZERO
		retlw	0x00			; возврат при иззмнении состояния IR прм.
	incf		TIMECOUNT+1,F		; считаем пока состояние IR прм. не меняется
	btfsc		ZERO
		incf	TIMECOUNT,F
	movf		TIMESCRAP,W
	subwf		TIMECOUNT,W
	swapf		TIMESCRAP+1,W
	btfsc		ZERO
		subwf	TIMECOUNT+1,W
	btfsc		CARRY
		retlw	0x01				; возврат если превышено время ожидания
	goto		waitchange
;*******************************************************************************
irdecode:
	return
;*******************************************************************************
	GLOBAL		irread, irdecode, IRDATA, IRADDR

	end