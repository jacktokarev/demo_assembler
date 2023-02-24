#include	<xc.inc>
#include	"Lcd.inc"
#include	"TDA7439.inc"
#include	"Encoder.inc"
#include	"Keyboard.inc"
#include	"Irrc.inc"
	
	EXTRN	init_lcd, print_lcd, clear_LCD, set_DDRAM_ADDR, space_line_LCD
	EXTRN	LINE_NUM, LINE_POS

	EXTRN	pause

	EXTRN	iic_start_condition, iic_pulse_SCL, iic_stop_condition
	EXTRN	iic_send_byte, init_iic

	EXTRN	init_encoder

	EXTRN	PRESSED_KEY
	EXTRN	check_key
