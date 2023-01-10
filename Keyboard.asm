#include		"Keyboard.inc"

psect			udata_bank0
PRESSED_KEY:	DS		1

psect			code

check_key:
	BANKSEL		PRESSED_KEY
	clrf		PRESSED_KEY
	BANKSEL		TS_KEYS_PORT
	bsf			TS_KEYS_PORT, MUTE_KEY_POSN
	BANKSEL		KEYS_PORT
	btfsc		MUTE_KEY
		goto	check_next
;	clrf		PRESSED_KEY
	incf		PRESSED_KEY,F		; 01 - MUTE
check_next:
	BANKSEL		TS_KEYS_PORT
	bcf			TS_KEYS_PORT, MUTE_KEY_POSN
	bsf			TS_KEYS_PORT, NEXT_KEY_POSN
	BANKSEL		KEYS_PORT
	btfsc		NEXT_KEY
		goto	check_prev
	movlw		0x02
	movwf		PRESSED_KEY			; 02 - NEXT
check_prev:
	BANKSEL		TS_KEYS_PORT
	bcf			TS_KEYS_PORT, NEXT_KEY_POSN
	bsf			TS_KEYS_PORT, PREV_KEY_POSN
	BANKSEL		KEYS_PORT
	btfsc		PREV_KEY
		goto	check_on_off
	movlw		0x03
	movwf		PRESSED_KEY			; 03 - PREV
check_on_off:
	BANKSEL		TS_KEYS_PORT
	bcf			TS_KEYS_PORT, PREV_KEY_POSN
	BANKSEL		ENC_PORT
	btfsc		ENC_KEY
		return
	movlw		0x04
	movwf		PRESSED_KEY			; 04 - ON/OFF
	return
;*******************************************************************************

GLOBAL			PRESSED_KEY
GLOBAL			check_key
	end
