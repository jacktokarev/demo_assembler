#include	"Iic.inc"

;*******************************************************************************
psect			udata_bank0
	
IIC_DATA:		DS	1
BIT_COUNTER:	DS	1
ROTATED_BYTE:	DS	1

;*******************************************************************************

psect			code

;*******************************************************************************			
_iic_send_byte:
	BANKSEL		IIC_DATA
	movwf		IIC_DATA
	movwf		ROTATED_BYTE
	movlw		0x08		;
	movwf		BIT_COUNTER	;
;	movf		IIC_DATA,W	;
;	movwf		ROTATED_BYTE;
iic_send_bit:
	movf		BIT_COUNTER,F
	btfsc		ZERO
	    goto	_iic_ack_bit; закончена передача байта
	BANKSEL		IIC_DATA
	decf		BIT_COUNTER,F
	rlf			ROTATED_BYTE,F
	btfss		CARRY
		goto	down_SDA
	bsf			SDA
	goto		p_SCL
down_SDA:
	bcf			SDA
p_SCL:
	call		_iic_pulse_SCL
	goto		iic_send_bit
	

		
;	decf		BIT_COUNTER,F
;	movf		IIC_DATA,W
;	movwf		ROTATED_BYTE
;	incf		BIT_COUNTER,W
;	goto		continue
;next_bit:
;	bcf			CARRY
;	rrf			ROTATED_BYTE,F
;continue:
;	addlw		0xFF		;
;	btfss		ZERO		;
;	    goto	next_bit
;	btfss		ROTATED_BYTE,0	; передаваемый бит единица?
;	    goto	down_SDA		; нет
;	BANKSEL		IIC_DATA
;	bsf			SDA		; up SDA
;	goto		p_SCL
;down_SDA:
;	BANKSEL		IIC_DATA
;	bcf			SDA		; down SDA
;p_SCL:
;	call		_iic_pulse_SCL
;	goto		iic_send_bit
			
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
	BANKSEL		CTRL_IIC_PORT
	bsf			CTRL_IIC_PORT, SDA_BIT
	call		_short_pause
	call		_iic_pulse_SCL
	BANKSEL		CTRL_IIC_PORT
	bcf			CTRL_IIC_PORT, SDA_BIT
	BANKSEL		IIC_PORT
	;bcf			SDA
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

;*******************************************************************************	
	end
	
