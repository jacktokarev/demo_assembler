#include		"Global.inc"

EXTRN	_short_pause

; Настройка подключения линий шины I2C к портам микроконтроллера
IIC_PORT		equ		PORTA
CTRL_IIC_PORT	equ		TRISA
SDA_POS			equ		BIT6
SCL_POS			equ		BIT7
	
	
#define			SDA		BANKMASK(IIC_PORT), SDA_POS; линия данных
#define			SCL		BANKMASK(IIC_PORT), SCL_POS; линия синхроимпульсов

IIC_RW			equ		0					; флаг направления (чтение/запись)
											; в регистре адреса
IIC_ACK			equ		0					; он же флаг подтверждения 
