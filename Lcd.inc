#include	"Global.inc"

; Внешние переменные

	EXTRN	pause, TIME_M, TIME_H	;

;*******************************************************************************

; Подключение сигналов управления ЖКИ к портам контроллера

CTRL_LCD	EQU	PORTA		; порт сигналов управления
TS_CTRL_LCD	EQU	TRISA		; регистр настройки порта управ.

RS_LCD		EQU	PORTA_RA2_POSN	; сигнал RS
#define		RS_L	BANKMASK(CTRL_LCD), RS_LCD	
;RW_LCD		EQU	PORTA_RA1_POSN	; сигнал RW
;#define		RW_L	BANKMASK(CTRL_LCD), RW_LCD
E_LCD		EQU	PORTA_RA3_POSN	; сигнал E
#define		E_L		BANKMASK(CTRL_LCD), E_LCD

; Подключение сигналов данных ЖКИ к портам контроллера

DATA_LCD	EQU	PORTB		; порт данных
TS_DATA_LCD	EQU	TRISB		; регстр настройки порта данных
	
LCD_LED_POSN	equ			BIT4
#define			LCD_LED		BANKMASK(DATA_LCD), LCD_LED_POSN

DB4_LCD		EQU	PORTB_RB0_POSN	; сигнал DB4
#define		DB4_L	BANKMASK(DATA_LCD), DB4_LCD
DB5_LCD		EQU	PORTB_RB1_POSN	; сигнал DB5
#define		DB5_L	BANKMASK(DATA_LCD), DB5_LCD
DB6_LCD		EQU	PORTB_RB2_POSN	; сигнал DB6
#define		DB6_L	BANKMASK(DATA_LCD), DB6_LCD
DB7_LCD		EQU	PORTB_RB3_POSN	; сигнал DB7
#define		DB7_L	BANKMASK(DATA_LCD), DB7_LCD

; Флаги работы с LCD

LPKGH		EQU	BIT7		; флаг работы со старшим полубайтом
LSHLR		EQU	BIT6		; флаг направления сдвига окна LCD

;*******************************************************************************
; Символы дисплея
;*******************************************************************************
 
SPACE?		EQU	00100000B	; пробел
SH1?		EQU	00100001B	; !
SH2?		EQU	00100010B	; "
SH3?		EQU	00100011B	; #
SH4?		EQU	00100100B	; $
SH5?		EQU	00100101B	; %
SH7?		EQU	00100110B	; &
CWOTE?		EQU	00100111B	; '
SH9?		EQU	00101000B	; (
SH0?		EQU	00101001B	; )
SH8?		EQU	00101010B	; *
PLUS?		EQU	00101011B	; +
COMA?		EQU	00101100B	; ,
MINUS?		EQU	00101101B	; -
DOT?		EQU	00101110B	; .
RSLASH?		EQU	00101111B	; /
_0?		EQU	00110000B	; 0
_1?		EQU	00110001B	; 1
_2?		EQU	00110010B	; 2
_3?		EQU	00110011B	; 3
_4?		EQU	00110100B	; 4
_5?		EQU	00110101B	; 5
_6?		EQU	00110110B	; 6
_7?		EQU	00110111B	; 7
_8?		EQU	00111000B	; 8
_9?		EQU	00111001B	; 9
TWO_DOT?	EQU	00111010B	; :
DOT_COMA?	EQU	00111011B	; ;
LEFT?		EQU	00111100B	; <
RAVNO?		EQU	00111101B	; =
RIGHT?		EQU	00111110B	; >
_??		EQU	00111111B	; ?
SOBAKA?		EQU	01000000B	; &
A?		EQU	01000001B	; A
B?		EQU	01000010B	; B
C?		EQU	01000011B	; C
D?		EQU	01000100B	; D
E?		EQU	01000101B	; E
F?		EQU	01000110B	; F
G?		EQU	01000111B	; G
H?		EQU	01001000B	; H
I?		EQU	01001001B	; I
J?		EQU	01001010B	; J
K?		EQU	01001011B	; K
L?		EQU	01001100B	; L
M?		EQU	01001101B	; M
N?		EQU	01001110B	; N
O?		EQU	01001111B	; O
P?		EQU	01010000B	; P
Q?		EQU	01010001B	; Q
R?		EQU	01010010B	; R
S?		EQU	01010011B	; S
T?		EQU	01010100B	; T
U?		EQU	01010101B	; U
V?		EQU	01010110B	; V
W?		EQU	01010111B	; W
X?		EQU	01011000B	; X
Y?		EQU	01011001B	; Y
Z?		EQU	01011010B	; Z
X_RUS?		EQU	01011011B	; [
LSLASH?		EQU	01011100B	; \
TbRUS?		EQU	01011101B	; ]
SH6?		EQU	01011110B	; ^
SHMINUS?	EQU	01011111B	; _
a?		EQU	01100001B	; a
b?		EQU	01100010B	; b
c?		EQU	01100011B	; C
d?		EQU	01100100B	; d
e?		EQU	01100101B	; e
f?		EQU	01100110B	; f
g?		EQU	01100111B	; g
h?		EQU	01101000B	; h
i?		EQU	01101001B	; i
j?		EQU	01101010B	; j
k?		EQU	01101011B	; k
l?		EQU	01101100B	; l
m?		EQU	01101101B	; m
n?		EQU	01101110B	; n
o?		EQU	01101111B	; o
p?		EQU	01110000B	; p
q?		EQU	01110001B	; q
r?		EQU	01110010B	; r
s?		EQU	01110011B	; s
t?		EQU	01110100B	; t
u?		EQU	01110101B	; u
v?		EQU	01110110B	; v
w?		EQU	01110111B	; w
x?		EQU	01111000B	; x
y?		EQU	01111001B	; y
z?		EQU	01111010B	; z

;*******************************************************************************
;   Инструкции управления дисплеем
;*******************************************************************************

CLRDISP		EQU	00000001B	; команда очистки дисплея
		
RETHOME		EQU	00000010B	; команда возврата курсора (адрес 00H)
		
EMSET		EQU	00000100B	; команда управл. автосмещением курсора/окна дисплея
EMSETSH		EQU	00000001B	; смещать видимое окно дисплея при записи в DDRAM 
EMSETID		EQU	00000010B	; увеличивать DDRAM адрес

DISPCTRL	EQU	00001000B	; команда управл. вкл/выкл дисплея/курсора/мигания		
DISPCTRLB	EQU	00000001B	; включить мигание
DISPCTRLC	EQU	00000010B	; включить курсор
DISPCTRLD	EQU	00000100B	; включить дисплей

CDSHIFT		EQU	00010000B	; смещение позиции курсора/окна диспл. без r/w DDRAM
CDSHIFTRL	EQU	00000100B	; смещение вправо (с увеличением указателя адреса)
CDSHIFTSC	EQU	00001000B	; смещение окна дисплея вместе с курсором
		
FUNCSET		EQU	00100000B	; команда задания размеров строк/шрифта диспл.
FUNCSETF	EQU	00000100B	; включает 5х11 шрифт
FUNCSETN	EQU	00001000B	; включает одностроковый режим
FUNCSETDL	EQU	00010000B	; включает 8-ми битный режим
	
CGRADDR		EQU	01000000B	; команда задания адреса CGRAM

DDRADDR		EQU	10000000B	; команда задания адреса DDRAM
		
LCD_LINE_ONE		equ		00000000B
LCD_LINE_TWO		equ		01000000B
