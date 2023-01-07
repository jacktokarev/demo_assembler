#include	<xc.inc>
#include	"Lcd.inc"
#include	"TDA7313.inc"
#include	"Encoder.inc"
	
	EXTRN	_init_lcd, _print_smb, _PKG_LCD, p1562mks
	EXTRN	_short_pause
	EXTRN	_iic_start_condition, _iic_pulse_SCL, _iic_stop_condition
	EXTRN	_iic_send_byte, _init_iic
	EXTRN	_init_encoder

LCD_LINE_ONE		equ		00000000B
LCD_LINE_TWO		equ		01000000B
