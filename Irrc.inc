#include		"Global.inc"

IRRC_PORT		equ		PORTA
TS_IRRC_PORT		equ		TRISA

IRRC_POSN		equ		BIT4
#define	IRRC	BANKMASK(IRRC_PORT), IRRC_POSN