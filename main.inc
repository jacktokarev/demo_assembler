#include	<xc.inc>
#include	"Lcd.inc"
#include	"TDA7439.inc"
#include	"Encoder.inc"
#include	"Keyboard.inc"
#include	"Irrc.inc"
	
	EXTRN	_init_lcd, _print_smb, p1545us, set_DDRAM_ADDR, space_line_LCD
	EXTRN	LINE_NUM, LINE_POS

	EXTRN	_short_pause
	EXTRN	_iic_start_condition, _iic_pulse_SCL, _iic_stop_condition
	EXTRN	_iic_send_byte, _init_iic
	EXTRN	_init_encoder
	EXTRN	PRESSED_KEY
	EXTRN	check_key
