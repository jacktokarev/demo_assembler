#include "Global.inc"
PSECT	udata_bank0
			
_TIME_LOW:			DS		1	; количество циклов первого порядка
_TIME_MIDLE:		DS		1	; количество циклов второго порядка
_TIME_HIEGHT:		DS		1	; количество циклов третьего порядка
TM_COUNT_LOW:		DS		1	; счетчик циклов первого порядка
TM_COUNT_MIDLE:		DS		1	; счетчик циклов второго порядка
TM_COUNT_HIEGHT:	DS		1	; счетчик циклов третьего порядка
	GLOBAL	_TIME_LOW, _TIME_MIDLE, _TIME_HIEGHT	;
