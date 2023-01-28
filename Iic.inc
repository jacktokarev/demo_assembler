#include		"Global.inc"

EXTRN	short_pause

; Настройка подключения линий шины I2C к портам микроконтроллера
IIC_PORT		equ		PORTA
TS_IIC_PORT		equ		TRISA
SDA_POSN		equ		BIT6
SCL_POSN		equ		BIT7
	
	
#define			SDA		BANKMASK(IIC_PORT), SDA_POSN; линия данных
#define			SCL		BANKMASK(IIC_PORT), SCL_POSN; линия синхроимпульсов

IIC_RW			equ		0					; флаг направления (чтение/запись)
											; в регистре адреса
IIC_ACK			equ		0					; он же флаг подтверждения 
