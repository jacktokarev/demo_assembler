#include		"Encoder.inc"

psect			code

_init_encoder:
	BANKSEL		TS_ENC_PORT
	bsf			TS_ENC_PORT, ENC_A_POSN
	bsf			TS_ENC_PORT, ENC_B_POSN
	bsf			TS_ENC_PORT, ENC_KEY_POSN
	return

GLOBAL		_init_encoder
