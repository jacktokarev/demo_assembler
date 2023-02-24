#include	"Iic.inc"

;*******************************************************************************
psect			udata_bank0
	
IIC_DATA:		DS	1
BIT_COUNTER:	DS	1

;*******************************************************************************

psect			code

;*******************************************************************************
init_iic:
	BANKSEL		TS_IIC_PORT
	bcf			TS_IIC_PORT, SDA_POSN
	bcf			TS_IIC_PORT, SCL_POSN
	return
;*******************************************************************************			
iic_send_byte:
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
	call		iic_pulse_SCL
	goto		iic_send_bit
;*******************************************************************************
iic_start_condition:
	BANKSEL		IIC_PORT
	bsf			SCL
	bsf			SDA			; SDA up
	bsf			SCL			; SCL up
	call		short_pause
	bcf			SDA			; SDA down
	call		short_pause
	bcf			SCL			; SCL down
	return
;*******************************************************************************	
iic_pulse_SCL:
	call		short_pause
	BANKSEL		IIC_PORT
	bsf			SCL
	call		short_pause
	bcf			SCL
	return
;*******************************************************************************
_iic_ack_bit:
	BANKSEL		TS_IIC_PORT
	bsf			TS_IIC_PORT, SDA_POSN
	call		short_pause
	call		iic_pulse_SCL
	BANKSEL		TS_IIC_PORT
	bcf			TS_IIC_PORT, SDA_POSN
	BANKSEL		IIC_PORT
	return
;*******************************************************************************	
iic_stop_condition:
	BANKSEL		IIC_PORT
	bsf			SCL			; up SCL
	call		short_pause
	bsf			SDA			; up SDA
	return
;*******************************************************************************	
GLOBAL	iic_start_condition, iic_pulse_SCL, iic_stop_condition
GLOBAL	iic_send_byte
GLOBAL	init_iic

;*******************************************************************************	
	end
