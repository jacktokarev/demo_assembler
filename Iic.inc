#include		"Global.inc"
#include		"TDA7313.inc"

EXTRN	_short_pause

; Настройка подключения линий шины I2C к портам микроконтроллера
IIC_PORT		equ		PORTA
CTRL_IIC_PORT	equ		TRISA
SDA_BIT			equ		BIT6
SCL_BIT			equ		BIT7
	
	
#define			SDA		BANKMASK(IIC_PORT), SDA_BIT; линия данных
#define			SCL		BANKMASK(IIC_PORT), SCL_BIT; линия синхроимпульсов

IIC_RW			equ		0					; флаг направления (чтение/запись)
											; в регистре адреса
IIC_ACK			equ		0					; он же флаг подтверждения

