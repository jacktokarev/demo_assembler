;***********************************
; disassembled by HellFire v4.00.0 b00
;       13 Dec 22 11:02:21
;***********************************
; Input file HEX_7313.hex
; Processor pic16xxxx

;==========================================================================
;
;       Register Definitions
;
;==========================================================================
#include "main.inc"
	
; CONFIG
CONFIG  FOSC = INTOSCIO       ; Oscillator Selection bits (INTOSC oscillator: I/O function on RA6/OSC2/CLKOUT pin, I/O function on RA7/OSC1/CLKIN)
CONFIG  WDTE = OFF            ; Watchdog Timer Enable bit (WDT disabled)
CONFIG  PWRTE = ON            ; Power-up Timer Enable bit (PWRT enabled)
CONFIG  MCLRE = OFF           ; RA5/MCLR/VPP Pin Function Select bit (RA5/MCLR/VPP pin function is digital input, MCLR internally tied to VDD)
CONFIG  BOREN = ON            ; Brown-out Detect Enable bit (BOD enabled)
CONFIG  LVP = OFF             ; Low-Voltage Programming Enable bit (RB4/PGM pin has digital I/O function, HV on MCLR must be used for programming)
CONFIG  CPD = OFF             ; Data EE Memory Code Protection bit (Data memory code protection off)
CONFIG  CP = OFF              ; Flash Program Memory Code Protection bit (Code protection off)



; Used Registers
	
REG00A	equ	00Ah
REG00B	equ	00Bh
REG01F	equ	01Fh
REG020	equ	020h
REG021	equ	021h
REG022	equ	022h
REG023	equ	023h
REG024	equ	024h
REG025	equ	025h
REG026	equ	026h
REG027	equ	027h
REG028	equ	028h
REG029	equ	029h
REG02A	equ	02Ah
REG02B	equ	02Bh
REG02C	equ	02Ch
REG02D	equ	02Dh
REG02E	equ	02Eh
REG02F	equ	02Fh
REG030	equ	030h
REG031	equ	031h
REG032	equ	032h
REG033	equ	033h
REG034	equ	034h
REG035	equ	035h
REG036	equ	036h
REG037	equ	037h
COUNT1	equ	038h
COUNT2	equ	039h
REG03A	equ	03Ah
REG03B	equ	03Bh
REG070	equ	070h
REG071	equ	071h
REG072	equ	072h
REG073	equ	073h
REG074	equ	074h
REG075	equ	075h
REG076	equ	076h
REG077	equ	077h
REG078	equ	078h
REG079	equ	079h
REG07A	equ	07Ah
REG07B	equ	07Bh
REG07C	equ	07Ch
REG07D	equ	07Dh
REG07E	equ	07Eh
REG081	equ	081h
REG083	equ	083h
REG085	equ	085h
REG086	equ	086h
REG08B	equ	08Bh
REG09A	equ	09Ah
REG09B	equ	09Bh
REG09C	equ	09Ch
REG09D	equ	09Dh



psect ResVect,class=CODE,abs,delta=2
	org	0x0000
ResetVector:
	goto		start
	org	0x0004
HighInterruptVector:
	movwf		REG07E
	movf		STATUS,W
	movwf		REG074
	movf		REG00A,W
	movwf		REG075
	goto		intrpt
start:
	goto		start1
L_000B:
	movlw		0x00		;b'0000 0000',' ',.00
	movwf		REG00A
	movf		FSR,W
	incf		FSR,F
	addwf		PCL,F
	retlw		0x00		;b'0000 0000',' ',.00
	retlw		0x00		;b'0000 0000',' ',.00
	retlw		0x00		;b'0000 0000',' ',.00
	retlw		0x01		;b'0000 0001',' ',.01
	retlw		0x02		;b'0000 0010',' ',.02
	retlw		0x03		;b'0000 0011',' ',.03
	retlw		0x04		;b'0000 0100',' ',.04
	retlw		0x05		;b'0000 0101',' ',.05
	retlw		0x06		;b'0000 0110',' ',.06
	retlw		0x07		;b'0000 0111',' ',.07
	retlw		0x0F		;b'0000 1111',' ',.15
	retlw		0x0E		;b'0000 1110',' ',.14
	retlw		0x0D		;b'0000 1101',' ',.13
	retlw		0x0C		;b'0000 1100',' ',.12
	retlw		0x0B		;b'0000 1011',' ',.11
	retlw		0x0A		;b'0000 1010',' ',.10
	retlw		0x09		;b'0000 1001',' ',.09
	retlw		0x08		;b'0000 1000',' ',.08
start2:
	movlw		0xFF		;b'1111 1111','я',.255
	movwf		COUNT1
	movwf		COUNT2
pause1:
	movlw		0x01		;b'0000 0001',' ',.01
	subwf		COUNT1,F
	movlw		0x00		;b'0000 0000',' ',.00
	btfss		CARRY
	    decf	COUNT2,F
	subwf		COUNT2,F
	incf		COUNT1,W
	btfsc		ZERO
	    incf	COUNT2,W
	btfss		ZERO
	    goto	pause1
	call		L_04FC
	call		L_03B3
	movlw		0x78		;b'0111 1000','x',.120
	bsf		RP0
	movwf		REG09B
	bsf		REG09C,0
	movf		REG09A,W
	bcf		REG083,5
	movwf		REG02F
	movlw		0x79		;b'0111 1001','y',.121
	bsf		RP0
	movwf		REG09B
	bsf		REG09C,0
	movf		REG09A,W
	bcf		REG083,5
	movwf		REG02E
	movlw		0x7A		;b'0111 1010','z',.122
	bsf		RP0
	movwf		REG09B
	bsf		REG09C,0
	movf		REG09A,W
	bcf		REG083,5
	movwf		REG026
	movlw		0x7B		;b'0111 1011','{',.123
	bsf		RP0
	movwf		REG09B
	bsf		REG09C,0
	movf		REG09A,W
	bcf		REG083,5
	movwf		REG025
	movlw		0x7C		;b'0111 1100','|',.124
	bsf		RP0
	movwf		REG09B
	bsf		REG09C,0
	movf		REG09A,W
	bcf		REG083,5
	movwf		REG02B
	movlw		0x7D		;b'0111 1101','}',.125
	bsf		RP0
	movwf		REG09B
	bsf		REG09C,0
	movf		REG09A,W
	bcf		REG083,5
	movwf		REG027
	call		L_028F
	call		L_056E
L_005E:
	call		L_04A2
	movf		REG02C,W
	btfsc		ZERO
	goto		L_0096
	movf		REG02C,W
	xorlw		0x04		;b'0000 0100',' ',.04
	btfss		ZERO
	goto		L_006C
	call		L_034C
L_0067:
	movf		REG02C,F
	btfsc		ZERO
	goto		L_006C
	call		L_04A2
	goto		L_0067
L_006C:
	movf		REG03B,F
	btfsc		ZERO
	goto		L_007A
	goto		L_0084
L_0070:
	call		L_059A
L_0071:
	movf		REG02C,F
	btfsc		ZERO
	goto		L_0084
	call		L_04A2
	goto		L_0071
L_0076:
	call		L_058B
	goto		L_0084
L_0078:
	call		L_05AC
	goto		L_0084
L_007A:
	movf		REG02C,W
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
	goto		L_0070
	xorlw		0x03		;b'0000 0011',' ',.03
	btfsc		ZERO
	goto		L_0076
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
	goto		L_0078
L_0084:
	call		L_056E
	movlw		0xFF		;b'1111 1111','я',.255
	movwf		REG022
	movwf		REG023
	movwf		COUNT1
	movlw		0x8F		;b'1000 1111','Џ',.143
	movwf		COUNT2
L_008B:
	movlw		0x01		;b'0000 0001',' ',.01
	subwf		COUNT1,F
	movlw		0x00		;b'0000 0000',' ',.00
	btfss		CARRY
	decf		COUNT2,F
	subwf		COUNT2,F
	incf		COUNT1,W
	btfsc		ZERO
	incf		COUNT2,W
	btfss		ZERO
	goto		L_008B
L_0096:
	decfsz	REG028,W
	goto		L_00A2
	clrf		REG028
	decfsz	REG02A,W
	goto		L_009D
	call		L_02D4
	goto		L_009E
L_009D:
	call		L_0317
L_009E:
	movlw		0xFF		;b'1111 1111','я',.255
	movwf		REG022
	movwf		REG023
	call		L_0380
L_00A2:
	movf		REG024,W
	btfsc		ZERO
	goto		L_010D
	movf		REG024,W
	xorlw		0x0C		;b'0000 1100',' ',.12
	btfss		ZERO
	goto		L_00AE
	movf		REG021,W
	iorwf		REG020,W
	btfss		ZERO
	goto		L_00AE
	call		L_034C
L_00AE:
	movf		REG03B,F
	btfsc		ZERO
	goto		L_00DC
	goto		L_0104
L_00B2:
	clrf		REG027
	incf		REG027,F
	goto		L_0104
L_00B5:
	movlw		0x02		;b'0000 0010',' ',.02
	goto		L_00B8
L_00B7:
	movlw		0x03		;b'0000 0011',' ',.03
L_00B8:
	movwf		REG027
	goto		L_0104
L_00BA:
	movf		REG021,W
	iorwf		REG020,W
	btfss		ZERO
	goto		L_0104
	call		L_059A
	goto		L_0104
L_00C0:
	movf		REG021,W
	iorwf		REG020,W
	btfss		ZERO
	goto		L_0104
	call		L_058B
	goto		L_0104
L_00C6:
	movf		REG021,W
	iorwf		REG020,W
	btfss		ZERO
	goto		L_0104
	call		L_05AC
	goto		L_0104
L_00CC:
	call		L_0317
	goto		L_0104
L_00CE:
	call		L_02D4
	goto		L_0104
L_00D0:
	clrf		REG02D
	incf		REG02D,F
	goto		L_0104
L_00D3:
	movlw		0x02		;b'0000 0010',' ',.02
	goto		L_00DA
L_00D5:
	movlw		0x03		;b'0000 0011',' ',.03
	goto		L_00DA
L_00D7:
	movlw		0x04		;b'0000 0100',' ',.04
	goto		L_00DA
L_00D9:
	movlw		0x05		;b'0000 0101',' ',.05
L_00DA:
	movwf		REG02D
	goto		L_0104
L_00DC:
	movf		REG024,W
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
	goto		L_00B2
	xorlw		0x03		;b'0000 0011',' ',.03
	btfsc		ZERO
	goto		L_00B5
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
	goto		L_00B7
	xorlw		0x0E		;b'0000 1110',' ',.14
	btfsc		ZERO
	goto		L_00BA
	xorlw		0x1D		;b'0001 1101','',.29
	btfsc		ZERO
	goto		L_00C0
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
	goto		L_00C6
	xorlw		0x04		;b'0000 0100',' ',.04
	btfsc		ZERO
	goto		L_00CC
	xorlw		0x03		;b'0000 0011',' ',.03
	btfsc		ZERO
	goto		L_00CE
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
	goto		L_00D0
	xorlw		0x3C		;b'0011 1100','<',.60
	btfsc		ZERO
	goto		L_00D3
	xorlw		0x07		;b'0000 0111',' ',.07
	btfsc		ZERO
	goto		L_00D5
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
	goto		L_00D7
	xorlw		0x03		;b'0000 0011',' ',.03
	btfsc		ZERO
	goto		L_00D9
L_0104:
	clrf		REG024
	call		L_056E
	movlw		0xFF		;b'1111 1111','я',.255
	movwf		REG020
	movlw		0x04		;b'0000 0100',' ',.04
	movwf		REG021
	movlw		0xFF		;b'1111 1111','я',.255
	movwf		REG022
	movwf		REG023
L_010D:
	movf		REG021,W
	iorwf		REG020,W
	btfsc		ZERO
	goto		L_0117
	movlw		0x01		;b'0000 0001',' ',.01
	subwf		REG020,F
	movlw		0x00		;b'0000 0000',' ',.00
	btfss		CARRY
	decf		REG021,F
	subwf		REG021,F
L_0117:
	movf		REG023,W
	iorwf		REG022,W
	btfsc		ZERO
	goto		L_0124
	movf		REG02D,W
	btfsc		ZERO
	goto		L_0124
	movlw		0x01		;b'0000 0001',' ',.01
	subwf		REG022,F
	movlw		0x00		;b'0000 0000',' ',.00
	btfss		CARRY
	decf		REG023,F
	subwf		REG023,F
L_0124:
	decf		REG022,W
	iorwf		REG023,W
	btfss		ZERO
	goto		L_005E
	clrf		REG02D
	incf		REG02D,F
	call		L_056E
L_012B:
	bsf		RP0
	btfsc		REG09C,1
	goto		L_012B
	movlw		0x78		;b'0111 1000','x',.120
	movwf		REG09B
	bcf		REG083,5
	movf		REG02F,W
	bsf		RP0
	movwf		REG09A
	bcf		REG083,0
	btfsc		REG08B,7
	bsf		REG083,0
	bcf		REG08B,7
	bsf		REG09C,2
	movlw		0x55		;b'0101 0101','U',.85
	movwf		REG09D
	movlw		0xAA		;b'1010 1010','Є',.170
	movwf		REG09D
	bsf		REG09C,1
	bcf		REG09C,2
	btfsc		REG083,0
	bsf		REG08B,7
L_0141:
	btfsc		REG09C,1
	goto		L_0141
	movlw		0x79		;b'0111 1001','y',.121
	movwf		REG09B
	bcf		REG083,5
	movf		REG02E,W
	bsf		RP0
	movwf		REG09A
	bcf		REG083,0
	btfsc		REG08B,7
	bsf		REG083,0
	bcf		REG08B,7
	bsf		REG09C,2
	movlw		0x55		;b'0101 0101','U',.85
	movwf		REG09D
	movlw		0xAA		;b'1010 1010','Є',.170
	movwf		REG09D
	bsf		REG09C,1
	bcf		REG09C,2
	btfsc		REG083,0
	bsf		REG08B,7
L_0156:
	btfsc		REG09C,1
	goto		L_0156
	movlw		0x7A		;b'0111 1010','z',.122
	movwf		REG09B
	bcf		REG083,5
	movf		REG026,W
	bsf		RP0
	movwf		REG09A
	bcf		REG083,0
	btfsc		REG08B,7
	bsf		REG083,0
	bcf		REG08B,7
	bsf		REG09C,2
	movlw		0x55		;b'0101 0101','U',.85
	movwf		REG09D
	movlw		0xAA		;b'1010 1010','Є',.170
	movwf		REG09D
	bsf		REG09C,1
	bcf		REG09C,2
	btfsc		REG083,0
	bsf		REG08B,7
L_016B:
	btfsc		REG09C,1
	goto		L_016B
	movlw		0x7B		;b'0111 1011','{',.123
	movwf		REG09B
	bcf		REG083,5
	movf		REG025,W
	bsf		RP0
	movwf		REG09A
	bcf		REG083,0
	btfsc		REG08B,7
	bsf		REG083,0
	bcf		REG08B,7
	bsf		REG09C,2
	movlw		0x55		;b'0101 0101','U',.85
	movwf		REG09D
	movlw		0xAA		;b'1010 1010','Є',.170
	movwf		REG09D
	bsf		REG09C,1
	bcf		REG09C,2
	btfsc		REG083,0
	bsf		REG08B,7
L_0180:
	btfsc		REG09C,1
	goto		L_0180
	movlw		0x7C		;b'0111 1100','|',.124
	movwf		REG09B
	bcf		REG083,5
	movf		REG02B,W
	bsf		RP0
	movwf		REG09A
	bcf		REG083,0
	btfsc		REG08B,7
	bsf		REG083,0
	bcf		REG08B,7
	bsf		REG09C,2
	movlw		0x55		;b'0101 0101','U',.85
	movwf		REG09D
	movlw		0xAA		;b'1010 1010','Є',.170
	movwf		REG09D
	bsf		REG09C,1
	bcf		REG09C,2
	btfsc		REG083,0
	bsf		REG08B,7
L_0195:
	btfsc		REG09C,1
	goto		L_0195
	movlw		0x7D		;b'0111 1101','}',.125
	movwf		REG09B
	bcf		REG083,5
	movf		REG027,W
	bsf		RP0
	movwf		REG09A
	bcf		REG083,0
	btfsc		REG08B,7
	bsf		REG083,0
	bcf		REG08B,7
	bsf		REG09C,2
	movlw		0x55		;b'0101 0101','U',.85
	movwf		REG09D
	movlw		0xAA		;b'1010 1010','Є',.170
	movwf		REG09D
	bsf		REG09C,1
	bcf		REG09C,2
	btfss		REG083,0
	goto		L_005E
	bsf		REG08B,7
	goto		L_005E
intrpt:
	movlw		0x01		;b'0000 0001',' ',.01
	btfss		REG00B,0
	andlw		0x00		;b'0000 0000',' ',.00
	btfss		REG00B,3
	andlw		0x00		;b'0000 0000',' ',.00
	iorlw		0x00		;b'0000 0000',' ',.00
	btfsc		ZERO
	goto		L_01D0
	bcf		REG00B,0
	movlw		0x00		;b'0000 0000',' ',.00
	bcf		RP0
	bcf		RP1
	btfsc		RB7
	movlw		0x01		;b'0000 0001',' ',.01
	movwf		REG077
	movlw		0x00		;b'0000 0000',' ',.00
	btfsc		RB6
	movlw		0x01		;b'0000 0001',' ',.01
	movwf		REG07D
	xorwf		REG029,W
	btfsc		ZERO
	goto		L_01CE
	decf		REG07D,W
	btfsc		ZERO
	goto		L_01CE
	decf		REG077,W
	btfsc		ZERO
	goto		L_01CB
	clrf		REG02A
	incf		REG02A,F
	goto		L_01CC
L_01CB:
	clrf		REG02A
L_01CC:
	clrf		REG028
	incf		REG028,F
L_01CE:
	movf		REG07D,W
	movwf		REG029
L_01D0:
	movlw		0x01		;b'0000 0001',' ',.01
	btfss		REG00B,2
	andlw		0x00		;b'0000 0000',' ',.00
	btfss		REG00B,5
	andlw		0x00		;b'0000 0000',' ',.00
	iorlw		0x00		;b'0000 0000',' ',.00
	btfsc		ZERO
	goto		L_0224
	bcf		REG00B,2
	clrf		REG078
	incf		REG078,F
	clrf		REG079
	clrf		REG07A
L_01DD:
	movlw		0xA0		;b'1010 0000',' ',.160
	movwf		REG07B
	clrf		REG07C
L_01E0:
	movlw		0x01		;b'0000 0001',' ',.01
	subwf		REG07B,F
	btfss		CARRY
	decf		REG07C,F
	incf		REG07B,W
	btfsc		ZERO
	incf		REG07C,W
	btfss		ZERO
	goto		L_01E0
	bcf		CARRY
	bcf		RP0
	bcf		RP1
	btfsc		RA4
	bsf		CARRY
	movlw		0x00		;b'0000 0000',' ',.00
	btfsc		CARRY
	movlw		0x01		;b'0000 0001',' ',.01
	movwf		REG070
	clrf		REG071
	movf		REG079,W
	movwf		REG073
	movf		REG078,W
	movwf		REG072
	bcf		CARRY
	rlf		REG072,F
	rlf		REG073,F
	movf		REG070,W
	addwf		REG072,W
	movwf		REG078
	movf		REG071,W
	btfsc		CARRY
	incf		REG071,W
	addwf		REG073,W
	movwf		REG079
	movlw		0x00		;b'0000 0000',' ',.00
	btfsc		RA4
	movlw		0x01		;b'0000 0001',' ',.01
	movwf		REG076
	movlw		0x32		;b'0011 0010','2',.50
	movwf		REG07B
L_0208:
	clrf		REG07C
L_0209:
	movf		REG07C,W
	iorwf		REG07B,W
	btfsc		ZERO
	goto		L_0219
	movlw		0x01		;b'0000 0001',' ',.01
	subwf		REG07B,F
	movlw		0x00		;b'0000 0000',' ',.00
	btfss		CARRY
	decf		REG07C,F
	btfsc		RA4
	movlw		0x01		;b'0000 0001',' ',.01
	xorwf		REG076,W
	btfsc		ZERO
	goto		L_0209
	clrf		REG07B
	goto		L_0208
L_0219:
	incf		REG07A,F
	movlw		0x0D		;b'0000 1101',' ',.13
	subwf		REG07A,W
	btfss		CARRY
	goto		L_01DD
	movf		REG078,W
	movwf		REG024
	movlw		0x3F		;b'0011 1111','?',.63
	andwf		REG024,F
	movlw		0xFF		;b'1111 1111','я',.255
	movwf		TMR0
L_0224:
	movf		REG075,W
	movwf		REG00A
	movf		REG074,W
	movwf		STATUS
	swapf		REG07E,F
	swapf		REG07E,W
	retfie	
L_022B:
	bcf		RA2
	movlw		0x7F		;b'0111 1111','',.127
	call		L_0516
	bsf		RA2
	movlw		0x1F		;b'0001 1111','',.31
	call		L_0516
	movlw		0x11		;b'0001 0001','',.17
	call		L_0516
	movlw		0x1D		;b'0001 1101','',.29
	call		L_0516
	movlw		0x19		;b'0001 1001','',.25
	call		L_0516
	movlw		0x1D		;b'0001 1101','',.29
	call		L_0516
	movlw		0x11		;b'0001 0001','',.17
	call		L_0516
	movlw		0x1F		;b'0001 1111','',.31
	call		L_0516
	movlw		0x00		;b'0000 0000',' ',.00
	call		L_0516
	movlw		0x1F		;b'0001 1111','',.31
	call		L_0516
	movlw		0x11		;b'0001 0001','',.17
	call		L_0516
	movlw		0x17		;b'0001 0111','',.23
	call		L_0516
	movlw		0x11		;b'0001 0001','',.17
	call		L_0516
	movlw		0x1D		;b'0001 1101','',.29
	call		L_0516
	movlw		0x11		;b'0001 0001','',.17
	call		L_0516
	movlw		0x1F		;b'0001 1111','',.31
	call		L_0516
	movlw		0x00		;b'0000 0000',' ',.00
	call		L_0516
	movlw		0x1F		;b'0001 1111','',.31
	call		L_0516
	movlw		0x11		;b'0001 0001','',.17
	call		L_0516
	movlw		0x1B		;b'0001 1011','',.27
	call		L_0516
	movlw		0x1B		;b'0001 1011','',.27
	call		L_0516
	movlw		0x13		;b'0001 0011','',.19
	call		L_0516
	movlw		0x1B		;b'0001 1011','',.27
	call		L_0516
	movlw		0x1F		;b'0001 1111','',.31
	call		L_0516
	movlw		0x00		;b'0000 0000',' ',.00
	call		L_0516
	clrf		REG032
L_0260:
	movlw		0x1E		;b'0001 1110','',.30
	call		L_0516
	incf		REG032,F
	movlw		0x08		;b'0000 1000',' ',.08
	subwf		REG032,W
	btfss		CARRY
	goto		L_0260
	clrf		REG032
L_0268:
	movlw		0x1C		;b'0001 1100','',.28
	call		L_0516
	incf		REG032,F
	movlw		0x08		;b'0000 1000',' ',.08
	subwf		REG032,W
	btfss		CARRY
	goto		L_0268
	clrf		REG032
L_0270:
	movlw		0x18		;b'0001 1000','',.24
	call		L_0516
	incf		REG032,F
	movlw		0x08		;b'0000 1000',' ',.08
	subwf		REG032,W
	btfss		CARRY
	goto		L_0270
	clrf		REG032
L_0278:
	movlw		0x10		;b'0001 0000',' ',.16
	call		L_0516
	incf		REG032,F
	movlw		0x08		;b'0000 1000',' ',.08
	subwf		REG032,W
	btfss		CARRY
	goto		L_0278
	movlw		0x01		;b'0000 0001',' ',.01
	call		L_0516
	movlw		0x03		;b'0000 0011',' ',.03
	call		L_0516
	movlw		0x1D		;b'0001 1101','',.29
	call		L_0516
	movlw		0x15		;b'0001 0101','',.21
	call		L_0516
	movlw		0x1D		;b'0001 1101','',.29
	call		L_0516
	movlw		0x03		;b'0000 0011',' ',.03
	call		L_0516
	movlw		0x01		;b'0000 0001',' ',.01
	call		L_0516
	movlw		0x00		;b'0000 0000',' ',.00
	goto		L_0516
L_028F:
	call		L_0593
	movlw		0x88		;b'1000 1000','€',.136
	call		L_0480
	bcf		REG083,5
	movf		REG02F,W
	sublw		0x40		;b'0100 0000','@',.64
	call		L_0480
	bcf		REG083,5
	decfsz	REG03A,W
	goto		L_029B
	movlw		0x43		;b'0100 0011','C',.67
	goto		L_02D2
L_029B:
	clrf		REG034
	movlw		0x21		;b'0010 0001','!',.33
	subwf		REG025,W
	btfsc		CARRY
	goto		L_02A3
	movf		REG025,W
	sublw		0x20		;b'0010 0000',' ',.32
	movwf		REG034
L_02A3:
	clrf		REG035
	movlw		0x21		;b'0010 0001','!',.33
	subwf		REG025,W
	btfss		CARRY
	goto		L_02AB
	movf		REG025,W
	addlw		0xDF		;b'1101 1111','Я',.223
	movwf		REG035
L_02AB:
	movf		REG035,W
	addlw		0x80		;b'1000 0000','Ђ',.128
	call		L_0480
	bcf		REG083,5
	movf		REG034,W
	addlw		0xA0		;b'1010 0000',' ',.160
	call		L_0480
	bcf		REG083,5
	movf		REG035,W
	addlw		0xC0		;b'1100 0000','А',.192
	call		L_0480
	bcf		REG083,5
	movf		REG034,W
	addlw		0xE0		;b'1110 0000','а',.224
	call		L_0480
	bcf		REG083,5
	movf		REG027,W
	addlw		0x3F		;b'0011 1111','?',.63
	movwf		REG033
	movf		REG02B,F
	btfss		ZERO
	goto		L_02C3
	movlw		0x18		;b'0001 1000','',.24
	addwf		REG033,F
L_02C3:
	movf		REG033,W
	call		L_0480
	bcf		REG083,5
	movf		REG026,W
	addlw		0x01		;b'0000 0001',' ',.01
	movwf		FSR
	call		L_000B
	addlw		0x60		;b'0110 0000','`',.96
	call		L_0480
	bcf		REG083,5
	movf		REG02E,W
	addlw		0x01		;b'0000 0001',' ',.01
	movwf		FSR
	call		L_000B
	addlw		0x70		;b'0111 0000','p',.112
L_02D2:
	call		L_0480
	goto		L_05A7
L_02D4:
	goto		L_0303
L_02D5:
	incf		REG02F,F
	movlw		0x41		;b'0100 0001','A',.65
	subwf		REG02F,W
	btfss		CARRY
	return	
	movlw		0x40		;b'0100 0000','@',.64
	movwf		REG02F
	return	
L_02DD:
	incf		REG02E,F
	movlw		0x11		;b'0001 0001','',.17
	subwf		REG02E,W
	btfss		CARRY
	return	
	movlw		0x10		;b'0001 0000',' ',.16
	movwf		REG02E
	return	
L_02E5:
	incf		REG026,F
	movlw		0x11		;b'0001 0001','',.17
	subwf		REG026,W
	btfss		CARRY
	return	
	movlw		0x10		;b'0001 0000',' ',.16
	movwf		REG026
	return	
L_02ED:
	incf		REG025,F
	movlw		0x41		;b'0100 0001','A',.65
	subwf		REG025,W
	btfss		CARRY
	return	
	movlw		0x40		;b'0100 0000','@',.64
	movwf		REG025
	return	
L_02F5:
	clrf		REG02B
	incf		REG02B,F
	return	
L_02F8:
	movf		REG021,W
	iorwf		REG020,W
	btfsc		ZERO
	incf		REG027,F
	movlw		0x04		;b'0000 0100',' ',.04
	subwf		REG027,W
	btfss		CARRY
	return	
	clrf		REG027
	incf		REG027,F
	return	
L_0303:
	movf		REG02D,W
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
	goto		L_02D5
	xorlw		0x03		;b'0000 0011',' ',.03
	btfsc		ZERO
	goto		L_02DD
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
	goto		L_02E5
	xorlw		0x07		;b'0000 0111',' ',.07
	btfsc		ZERO
	goto		L_02ED
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
	goto		L_02F5
	xorlw		0x03		;b'0000 0011',' ',.03
	btfss		ZERO
	return	
	goto		L_02F8
L_0317:
	goto		L_0338
L_0318:
	decfsz	REG02F,F
	return	
	clrf		REG02F
	incf		REG02F,F
	return	
L_031D:
	decfsz	REG02E,F
	return	
	clrf		REG02E
	incf		REG02E,F
	return	
L_0322:
	decfsz	REG026,F
	return	
	clrf		REG026
	incf		REG026,F
	return	
L_0327:
	decfsz	REG025,F
	return	
	clrf		REG025
	incf		REG025,F
	return	
L_032C:
	clrf		REG02B
	return	
L_032E:
	movf		REG021,W
	iorwf		REG020,W
	btfsc		ZERO
	decf		REG027,F
	movf		REG027,F
	btfss		ZERO
	return	
	movlw		0x03		;b'0000 0011',' ',.03
	movwf		REG027
	return	
L_0338:
	movf		REG02D,W
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
	goto		L_0318
	xorlw		0x03		;b'0000 0011',' ',.03
	btfsc		ZERO
	goto		L_031D
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
	goto		L_0322
	xorlw		0x07		;b'0000 0111',' ',.07
	btfsc		ZERO
	goto		L_0327
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
	goto		L_032C
	xorlw		0x03		;b'0000 0011',' ',.03
	btfss		ZERO
	return	
	goto		L_032E
L_034C:
	decfsz	REG03B,W
	goto		L_0353
	clrf		REG03B
	clrf		REG03A
	clrf		REG02D
	incf		REG02D,F
	goto		L_0358
L_0353:
	clrf		REG03B
	incf		REG03B,F
	clrf		REG03A
	incf		REG03A,F
	clrf		REG02D
L_0358:
	bcf		REG00B,7
	movlw		0xFF		;b'1111 1111','я',.255
	movwf		REG031
L_035B:
	decf		REG031,F
	movf		REG031,W
	xorlw		0xFF		;b'1111 1111','я',.255
	btfsc		ZERO
	goto		L_037E
	movf		REG031,W
	movwf		REG030
	btfss		REG03B,0
	goto		L_0368
	bcf		RP0
	bcf		RP1
	bsf		RB4
	goto		L_036B
L_0368:
	bcf		RP0
	bcf		RP1
	bcf		RB4
L_036B:
	decf		REG030,F
	movf		REG030,W
	xorlw		0xFF		;b'1111 1111','я',.255
	btfss		ZERO
	goto		L_036B
	movf		REG031,W
	movwf		REG030
	btfsc		REG03B,0
	goto		L_0378
	bcf		RP0
	bcf		RP1
	bsf		RB4
	goto		L_037B
L_0378:
	bcf		RP0
	bcf		RP1
	bcf		RB4
L_037B:
	incfsz	REG030,F
	goto		L_037B
	goto		L_035B
L_037E:
	bsf		REG00B,7
	return	
L_0380:
	movlw		0x02		;b'0000 0010',' ',.02
	call		L_040B
	goto		L_039F
L_0383:
	movf		REG02F,W
	call		L_04C3
	goto		L_03B2
L_0386:
	movf		REG02E,W
	call		L_0562
	goto		L_03B2
L_0389:
	movf		REG026,W
	call		L_0562
	goto		L_03B2
L_038C:
	movf		REG025,W
	call		L_045A
	goto		L_03B2
L_038F:
	movlw		0x10		;b'0001 0000',' ',.16
	movwf		REG032
	movlw		0x01		;b'0000 0001',' ',.01
	call		L_0544
	movf		REG02B,W
	addlw		0x30		;b'0011 0000','0',.48
	call		L_0516
	goto		L_03B2
L_0397:
	movlw		0x10		;b'0001 0000',' ',.16
	movwf		REG032
	movlw		0x01		;b'0000 0001',' ',.01
	call		L_0544
	movf		REG027,W
	addlw		0x04		;b'0000 0100',' ',.04
	call		L_0516
	goto		L_03B2
L_039F:
	movf		REG02D,W
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
	goto		L_0383
	xorlw		0x03		;b'0000 0011',' ',.03
	btfsc		ZERO
	goto		L_0386
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
	goto		L_0389
	xorlw		0x07		;b'0000 0111',' ',.07
	btfsc		ZERO
	goto		L_038C
	xorlw		0x01		;b'0000 0001',' ',.01
	btfsc		ZERO
	goto		L_038F
	xorlw		0x03		;b'0000 0011',' ',.03
	btfsc		ZERO
	goto		L_0397
L_03B2:
	goto		L_028F
L_03B3:
	movlw		0x53		;b'0101 0011','S',.83
	movwf		REG034
	movlw		0x05		;b'0000 0101',' ',.05
	movwf		REG035
L_03B7:
	movlw		0x01		;b'0000 0001',' ',.01
	subwf		REG034,F
	btfss		CARRY
	decf		REG035,F
	incf		REG034,W
	btfsc		ZERO
	incf		REG035,W
	btfss		ZERO
	goto		L_03B7
	bcf		RA2
	bcf		RB3
	bcf		RB2
	bsf		RB1
	bcf		RB0
	bsf		RA3
	bcf		RA3
	movlw		0x74		;b'0111 0100','t',.116
	movwf		REG034
	movlw		0x01		;b'0000 0001',' ',.01
	movwf		REG035
L_03CB:
	movlw		0x01		;b'0000 0001',' ',.01
	subwf		REG034,F
	movlw		0x00		;b'0000 0000',' ',.00
	btfss		CARRY
	decf		REG035,F
	subwf		REG035,F
	incf		REG034,W
	btfsc		ZERO
	incf		REG035,W
	btfss		ZERO
	goto		L_03CB
	movlw		0x2B		;b'0010 1011','+',.43
	call		L_0516
	movlw		0x13		;b'0001 0011','',.19
	call		L_0516
	movlw		0x0C		;b'0000 1100',' ',.12
	call		L_0516
	movlw		0x04		;b'0000 0100',' ',.04
	call		L_0516
	call		L_022B
	goto		L_052E
L_03E0:
	movwf		REG032
	clrf		REG034
	clrf		REG033
L_03E3:
	movf		REG032,W
	xorwf		REG034,W
	btfsc		ZERO
	goto		L_03F2
	movf		REG033,W
	bsf		RP0
	movwf		REG09B
	bsf		REG09C,0
	movf		REG09A,F
	bcf		REG083,5
	btfsc		ZERO
	incf		REG034,F
	bcf		RP0
	incf		REG033,F
	goto		L_03E3
L_03F2:
	clrf		REG034
L_03F3:
	movf		REG033,W
	bsf		RP0
	movwf		REG09B
	bsf		REG09C,0
	movf		REG09A,W
	call		L_0516
	incf		REG033,F
	movf		REG033,W
	bsf		RP0
	movwf		REG09B
	bsf		REG09C,0
	movf		REG09A,F
	btfss		REG083,2
	goto		L_0404
	movlw		0x10		;b'0001 0000',' ',.16
	bcf		REG083,5
	movwf		REG034
L_0404:
	bcf		RP0
	incf		REG034,F
	movlw		0x10		;b'0001 0000',' ',.16
	subwf		REG034,W
	btfsc		CARRY
	return	
	goto		L_03F3
L_040B:
	movwf		REG032
	decfsz	REG032,W
	goto		L_041E
	bcf		RA2
	movlw		0x80		;b'1000 0000','Ђ',.128
	call		L_0516
	bsf		RA2
	clrf		REG033
L_0413:
	movlw		0x20		;b'0010 0000',' ',.32
	call		L_0516
	incf		REG033,F
	movlw		0x10		;b'0001 0000',' ',.16
	subwf		REG033,W
	btfss		CARRY
	goto		L_0413
	bcf		RA2
	movlw		0x80		;b'1000 0000','Ђ',.128
	call		L_0516
	bsf		RA2
L_041E:
	movf		REG032,W
	xorlw		0x02		;b'0000 0010',' ',.02
	btfss		ZERO
	return	
	bcf		RA2
	movlw		0xC0		;b'1100 0000','А',.192
	call		L_0516
	bsf		RA2
	clrf		REG033
L_0427:
	movlw		0x20		;b'0010 0000',' ',.32
	call		L_0516
	incf		REG033,F
	movlw		0x10		;b'0001 0000',' ',.16
	subwf		REG033,W
	btfss		CARRY
	goto		L_0427
	bcf		RA2
	movlw		0xC0		;b'1100 0000','А',.192
	call		L_0516
	bsf		RA2
	return	
L_0433:
	movwf		REG033
	movlw		0x30		;b'0011 0000','0',.48
	movwf		REG034
	movwf		REG032
L_0437:
	movlw		0x0A		;b'0000 1010',' ',.10
	subwf		REG033,W
	btfss		CARRY
	goto		L_043F
	incf		REG034,F
	movlw		0xF6		;b'1111 0110','ц',.246
	addwf		REG033,F
	goto		L_0437
L_043F:
	movf		REG033,W
	addwf		REG032,F
	bcf		RA2
	movlw		0x8B		;b'1000 1011','‹',.139
	call		L_0516
	bsf		RA2
	movf		REG034,W
	xorlw		0x30		;b'0011 0000','0',.48
	btfss		ZERO
	goto		L_044B
	movlw		0x20		;b'0010 0000',' ',.32
	movwf		REG034
L_044B:
	movf		REG034,W
	call		L_0516
	movf		REG032,W
	call		L_0516
	movlw		0x20		;b'0010 0000',' ',.32
	call		L_0516
	movlw		0x00		;b'0000 0000',' ',.00
	call		L_0516
	decfsz	REG03A,W
	goto		L_0457
	movlw		0x78		;b'0111 1000','x',.120
	goto		L_0516
L_0457:
	movf		REG027,W
	addlw		0x04		;b'0000 0100',' ',.04
	goto		L_0516
L_045A:
	movwf		REG036
	clrf		REG037
L_045C:
	incf		REG037,F
	movf		REG036,W
	movwf		REG035
	bcf		CARRY
	rrf		REG035,F
	bcf		CARRY
	rrf		REG035,F
	movf		REG035,W
	subwf		REG037,W
	btfsc		CARRY
	goto		L_046A
	movlw		0xFF		;b'1111 1111','я',.255
	call		L_0516
	goto		L_045C
L_046A:
	movlw		0x3E		;b'0011 1110','>',.62
	call		L_0516
	movlw		0x3C		;b'0011 1100','<',.60
	call		L_0516
	movf		REG036,W
	movwf		REG035
	bcf		CARRY
	rrf		REG035,F
	bcf		CARRY
	rrf		REG035,F
	movf		REG035,W
	movwf		REG037
L_0476:
	movlw		0x10		;b'0001 0000',' ',.16
	subwf		REG037,W
	btfsc		CARRY
	goto		L_047E
	movlw		0xFF		;b'1111 1111','я',.255
	call		L_0516
	incf		REG037,F
	goto		L_0476
L_047E:
	movf		REG036,W
	goto		L_0433
L_0480:
	movwf		REG031
	movlw		0x08		;b'0000 1000',' ',.08
	movwf		REG032
L_0483:
	movf		REG032,F
	btfsc		ZERO
	goto		L_049B
	decf		REG032,F
	movf		REG031,W
	movwf		REG030
	incf		REG032,W
	goto		L_048D
L_048B:
	bcf		CARRY
	rrf		REG030,F
L_048D:
	addlw		0xFF		;b'1111 1111','я',.255
	btfss		ZERO
	goto		L_048B
	btfss		REG030,0
	goto		L_0496
	bcf		RP0
	bcf		RP1
	bsf		RA6
	goto		L_0499
L_0496:
	bcf		RP0
	bcf		RP1
	bcf		RA6
L_0499:
	call		L_05A1
	goto		L_0483
L_049B:
	bsf		RP0
	bsf		REG085,6
	call		L_05B1
	call		L_05A1
	bsf		RP0
	bcf		REG085,6
	return	
L_04A2:
	bcf		RP0
	clrf		REG02C
	bsf		RP0
	bsf		REG086,0
	bcf		REG083,5
	btfsc		RB0
	goto		L_04AB
	clrf		REG02C
	incf		REG02C,F
L_04AB:
	bsf		RP0
	bcf		REG086,0
	bsf		REG086,1
	bcf		REG083,5
	btfsc		RB1
	goto		L_04B3
	movlw		0x02		;b'0000 0010',' ',.02
	movwf		REG02C
L_04B3:
	bsf		RP0
	bcf		REG086,1
	bsf		REG086,2
	bcf		REG083,5
	btfsc		RB2
	goto		L_04BB
	movlw		0x03		;b'0000 0011',' ',.03
	movwf		REG02C
L_04BB:
	bsf		RP0
	bcf		REG086,2
	bcf		REG083,5
	btfsc		RB5
	return	
	movlw		0x04		;b'0000 0100',' ',.04
	movwf		REG02C
	return	
L_04C3:
	movwf		REG036
	clrf		REG037
L_04C5:
	movlw		0x05		;b'0000 0101',' ',.05
	movwf		REG030
	movf		REG036,W
	call		L_04E1
	subwf		REG037,W
	btfsc		CARRY
	goto		L_04D0
	movlw		0xFF		;b'1111 1111','я',.255
	call		L_0516
	incf		REG037,F
	goto		L_04C5
L_04D0:
	movlw		0xFB		;b'1111 1011','ы',.251
	movwf		REG030
	movf		REG037,W
	call		L_0554
	movwf		REG035
	movf		REG036,W
	addwf		REG035,W
	movwf		REG037
	movf		REG037,F
	btfss		ZERO
	goto		L_04DD
	movlw		0x20		;b'0010 0000',' ',.32
	movwf		REG037
L_04DD:
	movf		REG037,W
	call		L_0516
	movf		REG036,W
	goto		L_0433
L_04E1:
	movwf		REG031
	clrf		REG033
	movf		REG030,W
	btfsc		ZERO
	goto		L_04FA
	clrf		REG032
L_04E7:
	incf		REG032,F
	btfsc		REG030,7
	goto		L_04ED
	bcf		CARRY
	rlf		REG030,F
	goto		L_04E7
L_04ED:
	bcf		CARRY
	rlf		REG033,F
	movf		REG030,W
	subwf		REG031,W
	btfss		CARRY
	goto		L_04F7
	movf		REG030,W
	subwf		REG031,F
	bsf		REG033,0
	bcf		CARRY
L_04F7:
	rrf		REG030,F
	decfsz	REG032,F
	goto		L_04ED
L_04FA:
	movf		REG033,W
	return	
L_04FC:
	clrf		REG00B
	movlw		0x10		;b'0001 0000',' ',.16
	bsf		RP0
	movwf		REG085
	movlw		0xE0		;b'1110 0000','а',.224
	movwf		REG086
	movlw		0x07		;b'0000 0111',' ',.07
	bcf		REG083,5
	movwf		REG01F
	clrf		PORTA
	clrf		PORTB
	bsf		RP0
	bcf		REG081,7
	bsf		REG08B,6
	bsf		REG081,5
	bsf		REG081,4
	bsf		REG081,3
	movlw		0xFF		;b'1111 1111','я',.255
	bcf		REG083,5
	movwf		TMR0
	bsf		REG00B,5
	bcf		REG00B,2
	bsf		REG00B,3
	bcf		REG00B,0
	bsf		REG00B,7
	return	
L_0516:
	bcf		RP0
	movwf		REG031
	movlw		0x0A		;b'0000 1010',' ',.10
	movwf		REG030
	movlw		0xF0		;b'1111 0000','р',.240
	andwf		PORTB,F
	swapf		REG031,W
	andlw		0x0F		;b'0000 1111',' ',.15
	addwf		PORTB,F
	bsf		RA3
	bcf		RA3
	movlw		0xF0		;b'1111 0000','р',.240
	andwf		PORTB,F
	movf		REG031,W
	andlw		0x0F		;b'0000 1111',' ',.15
	addwf		PORTB,F
	bsf		RA3
	bcf		RA3
L_0528:
	decf		REG030,F
	movf		REG030,W
	xorlw		0xFF		;b'1111 1111','я',.255
	btfsc		ZERO
	return	
	goto		L_0528
L_052E:
	movlw		0x96		;b'1001 0110','–',.150
	movwf		REG032
	clrf		REG033
	bcf		RA2
	movlw		0x01		;b'0000 0001',' ',.01
	call		L_0516
L_0534:
	movlw		0x01		;b'0000 0001',' ',.01
	subwf		REG032,F
	movlw		0x00		;b'0000 0000',' ',.00
	btfss		CARRY
	decf		REG033,F
	subwf		REG033,F
	incf		REG032,W
	btfsc		ZERO
	incf		REG033,W
	btfss		ZERO
	goto		L_0534
	bcf		RA2
	movlw		0x80		;b'1000 0000','Ђ',.128
	call		L_0516
	bsf		RA2
	return	
L_0544:
	movwf		REG033
	bcf		RA2
	decfsz	REG033,W
	goto		L_054B
	movf		REG032,W
	addlw		0x7F		;b'0111 1111','',.127
	call		L_0516
L_054B:
	movf		REG033,W
	xorlw		0x02		;b'0000 0010',' ',.02
	btfss		ZERO
	goto		L_0552
	movf		REG032,W
	addlw		0xBF		;b'1011 1111','ї',.191
	call		L_0516
L_0552:
	bsf		RA2
	return	
L_0554:
	movwf		REG032
	clrf		REG031
L_0556:
	movf		REG030,W
	btfsc		REG032,0
	addwf		REG031,F
	bcf		CARRY
	rlf		REG030,F
	bcf		CARRY
	rrf		REG032,F
	movf		REG032,F
	btfss		ZERO
	goto		L_0556
	movf		REG031,W
	return	
L_0562:
	movwf		REG035
	clrf		REG036
L_0564:
	movf		REG035,W
	subwf		REG036,W
	btfsc		CARRY
	goto		L_056C
	movlw		0xFF		;b'1111 1111','я',.255
	call		L_0516
	incf		REG036,F
	goto		L_0564
L_056C:
	movf		REG036,W
	goto		L_0433
L_056E:
	call		L_052E
	movf		REG02D,F
	btfss		ZERO
	goto		L_0576
	movlw		0x05		;b'0000 0101',' ',.05
	movwf		REG032
	movlw		0x01		;b'0000 0001',' ',.01
	call		L_0544
L_0576:
	movf		REG02D,W
	call		L_03E0
	goto		L_0380
start1:
	bcf		STATUS,7
	movlw		0x20		;адрес первого регистра диапозона
	movwf		FSR
	movlw		0x30		;адрес последнего регистра диапозона
	call		clrregs		;очистка диапазона регистров
	movlw		0x01		;b'0000 0001',' ',.01
	movwf		REG03A
	movwf		REG03B
	clrf		STATUS
	goto		start2
clrregs:				;очиситка регистов
	clrwdt				;сброс сторожевого таймера
clrrr:					;очистка диапозона регистпров
	clrf		INDF
	incf		FSR,F
	xorwf		FSR,W
	btfsc		ZERO
	    retlw	0x00		;b'0000 0000',' ',.00
	xorwf		FSR,W
	goto		clrrr
L_058B:
	incf		REG02D,F
	movlw		0x07		;b'0000 0111',' ',.07
	subwf		REG02D,W
	btfss		CARRY
	return	
	clrf		REG02D
	incf		REG02D,F
	return	
L_0593:
	bsf		RA6
	bsf		RA7
	call		L_05B1
	bcf		RA6
	call		L_05B1
	bcf		RA7
	return	
L_059A:
	decfsz	REG03A,W
	goto		L_059E
	clrf		REG03A
	return	
L_059E:
	clrf		REG03A
	incf		REG03A,F
	return	
L_05A1:
	call		L_05B1
	bcf		RP0
	bsf		RA7
	call		L_05B1
	bcf		RA7
	return	
L_05A7:
	bcf		RP0
	bsf		RA7
	call		L_05B1
	bsf		RA6
	return	
L_05AC:
	decfsz	REG02D,F
	return	
	movlw		0x06		;b'0000 0110',' ',.06
	movwf		REG02D
	return	
L_05B1:
	nop		
	nop		
	return	

	end	; directive 'end of program'



