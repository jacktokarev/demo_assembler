#include	<xc.inc>
#include	"Lcd.inc"
#include	"TDA7313.inc"
#include	"Encoder.inc"
#include	"Keyboard.inc"
#include	"Irrc.inc"
	
	EXTRN	init_lcd, print_lcd, clear_LCD, set_DDRAM_ADDR, space_line_LCD
	EXTRN	LINE_NUM, LINE_POS

	EXTRN	pause

	EXTRN	_iic_start_condition, _iic_pulse_SCL, _iic_stop_condition
	EXTRN	_iic_send_byte, _init_iic

	EXTRN	_init_encoder

	EXTRN	PRESSED_KEY
	EXTRN	check_key
