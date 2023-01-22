#include		"Time.inc"

;*******************************************************************************
PSECT			udata_bank0
;*******************************************************************************			
TIME_L:			DS		1		; счетчик циклов первого порядка
TIME_M:			DS		1		; счетчик циклов второго порядка
TIME_H:			DS		1		; счетчик циклов третьего порядка

;*******************************************************************************
PSECT			code
;*******************************************************************************	
pause:
;	(TIME_H*326405)+(TIME_M*1280)+(TIME_L*5)+20
;	использование: перед вызовом устанавливаем регистры TIME_H и TIME_M (опцио- 
;	нально, по умолчанию - 0), в аккамуляторе значение для TIME_L
	movwf		TIME_L			;
pause_1:						;
	movlw		0x01			;
	subwf		TIME_L,F		;
	btfsc		CARRY			;
		goto	pause_1			;
	nop
	subwf		TIME_M, F		;
	btfsc		CARRY			;
		goto	pause_1			;
	nop
	subwf		TIME_H, F		;
	btfsc		CARRY			;
		goto	pause_1
	clrf		TIME_L			;
	clrf		TIME_M			;
	clrf		TIME_H			;
	return
	
_short_pause:
	nop		
	nop		
	return		
	GLOBAL		pause, _short_pause;
	GLOBAL		TIME_M, TIME_H	;

    END					;
