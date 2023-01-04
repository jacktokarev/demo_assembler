#include		"Time.inc"
PSECT	code

;******** Процедура заданной паузы *********************************************
_pause:
;t= (_TIME_HIEGHT+1)*(5+((TIME_MIDLE+1)*(6+(TIME_LOW+1)*4)))+7 мкс

    MOVF	_TIME_HIEGHT, W		; загружаем число циклов третьего
    MOVWF	TM_COUNT_HIEGHT		; порядка в счетчик циклов 3-го пор.
    INCF	TM_COUNT_HIEGHT, F	; плюс 1 для единственного прохода при 0
tim1:
    MOVF	_TIME_MIDLE, W		; то же для
    MOVWF	TM_COUNT_MIDLE		; счетчика второго
    INCF	TM_COUNT_MIDLE, F	; порядка
tim2:
    MOVF	_TIME_LOW, W		; тоже для
    MOVWF	TM_COUNT_LOW		; счетчика первого
    INCF	TM_COUNT_LOW, F		; порядка
    NOP					;
tim3:		
    NOP					; простой 3 маш. цикла
    NOP					;
    DECFSZ	TM_COUNT_LOW, F		; 
	GOTO	tim3			;
    DECFSZ	TM_COUNT_MIDLE, F	;
	GOTO	tim2			;
    DECFSZ	TM_COUNT_HIEGHT, F	;
	GOTO	tim1			;
    RETURN				;
	
_short_pause:
	nop		
	nop		
	return

    GLOBAL	_pause, _short_pause;

    END					;
