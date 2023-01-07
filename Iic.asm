#include	"Iic.inc"

;*******************************************************************************
psect			udata_bank0
	
IIC_DATA:		DS	1
BIT_COUNTER:	DS	1

;*******************************************************************************

psect			code

;*******************************************************************************
_init_iic:
	BANKSEL		TS_IIC_PORT
	bcf			TS_IIC_PORT, SDA_POSN
	bcf			TS_IIC_PORT, SCL_POSN
	return
;*******************************************************************************			
_iic_send_byte:
	BANKSEL		IIC_DATA
	movwf		IIC_DATA
	movlw		0x08		;
	movwf		BIT_COUNTER	;
iic_send_bit:
	movf		BIT_COUNTER,F
	btfsc		ZERO
	    goto	_iic_ack_bit; закончена передача байта
	BANKSEL		IIC_DATA
	decf		BIT_COUNTER,F
	rlf			IIC_DATA
	btfss		CARRY
		goto	down_SDA
	bsf			SDA
	goto		p_SCL
down_SDA:
	bcf			SDA
p_SCL:
	call		_iic_pulse_SCL
	goto		iic_send_bit
;*******************************************************************************
_iic_start_condition:
	BANKSEL		IIC_PORT
	bsf			SCL
	bsf			SDA			; SDA up
	bsf			SCL			; SCL up
	call		_short_pause
	bcf			SDA			; SDA down
	call		_short_pause
	bcf			SCL			; SCL down
	return
;*******************************************************************************	
_iic_pulse_SCL:
	call		_short_pause
	BANKSEL		IIC_PORT
	bsf			SCL
	call		_short_pause
	bcf			SCL
	return
;*******************************************************************************
_iic_ack_bit:
	BANKSEL		TS_IIC_PORT
	bsf			TS_IIC_PORT, SDA_POSN
	call		_short_pause
	call		_iic_pulse_SCL
	BANKSEL		TS_IIC_PORT
	bcf			TS_IIC_PORT, SDA_POSN
	BANKSEL		IIC_PORT
	return
;*******************************************************************************	
_iic_stop_condition:
	BANKSEL		IIC_PORT
	bsf			SCL		    ; up SCL
	call		_short_pause
	bsf			SDA		    ; up SDA
	return
;*******************************************************************************	
GLOBAL	_iic_start_condition, _iic_pulse_SCL, _iic_stop_condition
GLOBAL	_iic_send_byte
GLOBAL	_init_iic

;*******************************************************************************	
	end
