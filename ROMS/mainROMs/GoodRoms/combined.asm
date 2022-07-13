
; Segment type:	Pure code

sub_0:

; FUNCTION CHUNK AT 0540 SIZE 00000009 BYTES

di
lxi	sp, 9000h
mvi	a, 1Fh
jmp	loc_540
; End of function sub_0

xra	a
sta	8DFAh
call	sub_268B
cpi	2
rnz
call	sub_268E
di
jm	loc_8AC
mov	d, a
ani	7
jz	loc_8AC
xra	a
sta	8DEDh
out	3Fh
mov	a, d
push	d
jmp	loc_8B8
nop
push	psw
jmp	loc_3AA



sub_30:

; FUNCTION CHUNK AT 04CE SIZE 00000072 BYTES

nop
nop
nop
nop
push	psw
jmp	loc_4CE
; End of function sub_30




sub_38:

; FUNCTION CHUNK AT 020D SIZE 0000001B BYTES

nop
nop
nop
nop
push	psw
push	h
push	b
push	d
rim
push	psw
ani	7
ori	0Dh
sim
in	32h
ei
rrc
jc	loc_F5
xra	a
sta	8D7Dh
lda	8D7Eh
ora	a
jz	loc_11A
cpi	0Bh
jz	loc_11A
dcr	a
sta	8D7Eh
lda	8D4Fh
ora	a
jnz	loc_7D
lhld	8DAEh
mov	a, m
ani	20h
jz	loc_79
lda	8D7Eh
rrc
jc	loc_92

loc_79:
inr	m
jmp	loc_92

loc_7D:
lhld	8DAAh
mov	e, m
inx	h
mov	d, m
xchg
mov	a, m
ani	20h
jz	loc_91
lda	8D7Eh
rrc
jnc	loc_92

loc_91:
dcr	m

loc_92:
lda	8D7Eh
ora	a
jz	loc_20D

loc_99:
lda	8D4Fh
ora	a
jnz	loc_189
lda	8D7Dh
rlc
mov	l, a
lda	8DAAh
cmp	l
jnz	loc_D9

loc_AC:
lhld	8DAEh
lda	8D7Eh
dcr	a

loc_B3:
ani	0Fh
rlc
rlc
rlc
rlc
mov	c, a
mov	a, h
ani	0Fh
ora	c
out	3Ch
mov	a, l
out	3Bh
lxi	h, 8E00h
lda	8D7Dh
rlc
mov	l, a
mov	a, m
out	20h
inx	h
mov	a, m
ani	0Fh
ori	90h
out	1Fh
jmp	loc_12D

loc_D9:
lda	8DACh
cmp	l
jnz	loc_11A
rrc
inr	a
sta	8D7Dh
lhld	8DACh
mov	a, m
inx	h
mov	h, m
mov	l, a
lda	8D7Eh
cma
adi	0Ah
jmp	loc_B3

loc_F5:
lda	8D7Eh
cpi	0Bh
jz	loc_146
ora	a
jnz	loc_99
lda	8D9Ch
ora	a
jz	loc_11A
lda	8D7Dh
cpi	18h
jc	loc_11A
xra	a
sta	8D9Ch
call	sub_1B7
jmp	loc_139

loc_11A:
lxi	h, 8E00h
lda	8D7Dh
rlc
mov	l, a
mov	a, m
out	3Bh
inx	h
mov	a, m
ani	0Fh
ori	90h
out	3Ch

loc_12D:
lda	8D7Dh
inr	a
sta	8D7Dh
cpi	1
cz	sub_228

loc_139:
di
pop	psw
ani	7
ori	8
sim
pop	d
pop	b
pop	h
pop	psw
ei
ret

loc_146:
lda	8D7Dh
cpi	18h
jc	loc_11A
lda	8D7Eh
dcr	a
sta	8D7Eh
call	sub_1B7
lda	8D4Fh
ora	a
jnz	loc_176
lhld	8DAEh
mov	a, m
ori	40h
mov	m, a
lhld	8DACh
mov	a, m
inx	h
mov	h, m
mov	l, a
mov	a, m
ani	30h
ori	40h
mov	m, a
jmp	loc_139

loc_176:
lhld	8DAAh
mov	a, m
inx	h
mov	h, m
mov	l, a
mvi	m, 4Ah ; 'J'
lhld	8DAEh
mov	a, m
ori	40h
mov	m, a
jmp	loc_139

loc_189:
lda	8D7Dh
rlc
mov	l, a
lda	8DAAh
cmp	l
jnz	loc_1AB
lxi	h, 8E00h
mov	l, a
rrc
inr	a
sta	8D7Dh
lda	8D7Eh
cma
adi	0Ah
mov	b, m
inx	h
mov	h, m
mov	l, b
jmp	loc_B3

loc_1AB:
lda	8DACh
adi	2
cmp	l
jz	loc_AC
jmp	loc_11A
; End of function sub_38




sub_1B7:
lhld	8DAEh
push	h
lxi	h, 8E00h
lda	8D4Fh
ora	a
jnz	loc_1EA
lda	8DAAh
mov	l, a
mov	c, l
mov	b, h
mov	e, m
inx	h
mov	d, m
xchg
shld	8DAEh
inx	d
lda	8DACh
mov	l, a

loc_1D7:
ldax	d
stax	b
inx	d
inx	b
ldax	d
stax	b
inx	b
inx	d
mov	a, l
cmp	c
jnz	loc_1D7
mov	h, b

loc_1E5:
pop	b
mov	m, c
inx	h
mov	m, b
ret

loc_1EA:
lda	8DACh
mov	l, a
mov	b, h
mov	e, m
inx	h
mov	d, m
mov	c, l
xchg
shld	8DAEh
dcx	d
lda	8DAAh
mov	l, a

loc_1FC:
dcx	d
ldax	d
stax	b
dcx	d
dcx	b
ldax	d
stax	b
dcx	b
mov	a, e
cmp	l
jnz	loc_1FC
xchg
jmp	loc_1E5
; End of function sub_1B7

; START	OF FUNCTION CHUNK FOR sub_38

loc_20D:
lda	8D4Fh
ora	a
jnz	loc_21A
lhld	8DACh
jmp	loc_21D

loc_21A:
lhld	8DAAh

loc_21D:
mov	a, m
inx	h
mov	h, m
mov	l, a
mov	a, m
ani	0BFh
mov	m, a
jmp	loc_11A
; END OF FUNCTION CHUNK	FOR sub_38



sub_228:

; FUNCTION CHUNK AT 029E SIZE 0000010C BYTES

mvi	a, 8
sim
lhld	8DB4h
xchg
call	sub_2664
lda	8DB8h
ani	10h
jz	loc_23E
mov	a, h
adi	10h
mov	h, a

loc_23E:
lda	8DB7h
dcr	a
sta	8DB7h
jnz	loc_265
mvi	a, 1Eh
sta	8DB7h
lda	8D9Ah
ora	a
jnz	loc_25B
lda	8DA1h
ani	7Fh
out	38h

loc_25B:
xra	a
sta	8D9Ah
call	sub_272
jmp	loc_29E

loc_265:
mov	a, l
cmp	e
jnz	loc_26C
mov	a, h
cmp	d

loc_26C:
cnz	sub_283
jmp	loc_29E
; End of function sub_228




sub_272:
lda	8DB8h
ani	10h
ldax	d
jnz	loc_27F
xri	80h
stax	d
ret

loc_27F:
xri	2
stax	d
ret
; End of function sub_272




sub_283:
lda	8DB6h
stax	d
shld	8DB4h
lda	8DB8h
ani	10h
mov	a, m
sta	8DB6h
jz	loc_29A
xri	2
mov	m, a
ret

loc_29A:
ori	80h
mov	m, a
ret
; End of function sub_283

; START	OF FUNCTION CHUNK FOR sub_228

loc_29E:
lda	8DB8h
ani	40h
jz	loc_317
mvi	a, 9
sim
lxi	h, 8D8Bh
lxi	d, 8D8Eh
lda	8D91h
ani	2
jnz	loc_2B8
xchg

loc_2B8:
mov	a, m
ani	2
jz	loc_313
inx	h
inx	h
mov	a, m
ora	a
jnz	loc_313
lda	8D99h
dcx	h
ora	a
jz	loc_2D1
cmp	m
jz	loc_2DD

loc_2D1:
mov	a, m
sta	8D99h
mvi	a, 1Eh
sta	8D76h
jmp	loc_317

loc_2DD:
lda	8D76h
ora	a
jm	loc_30C
dcr	a
sta	8D76h
jp	loc_317
lda	8D86h
ora	a
jnz	loc_317
mvi	b, 6
lxi	d, 39BEh
lda	8D99h
ori	80h
xchg

loc_2FD:
cmp	m
jz	loc_313
inx	h
dcr	b
jnz	loc_2FD
xchg
mvi	m, 0
jmp	loc_317

loc_30C:
xra	a
sta	8D76h
jmp	loc_317

loc_313:
xra	a
sta	8D99h

loc_317:
mvi	a, 8
sim
lda	8D98h
dcr	a
jp	loc_33A
lda	8D94h
dcr	a
jm	loc_347
sta	8D94h
mvi	a, 7
sta	8D98h
lda	8DBBh
ani	1Fh
ori	20h
jmp	loc_345

loc_33A:
sta	8D98h
jnz	loc_347
lda	8DBBh
ani	1Fh

loc_345:
out	3Ah

loc_347:
lda	8DF2h
dcr	a
jnz	loc_376
lda	8DBAh
rrc
lda	8DEDh
jnc	loc_36B
mov	c, a
lhld	8D6Ch
mov	a, l
ora	h
mov	a, c
jnz	loc_367
ani	77h
jmp	loc_372

loc_367:
dcx	h
shld	8D6Ch

loc_36B:
ori	8
xri	1
sta	8DEDh

loc_372:
out	3Fh
mvi	a, 0Fh

loc_376:
sta	8DF2h
lda	8D93h
ora	a
rz
cpi	0FEh ; '˛'
rnc
dcr	a
sta	8D93h
jz	loc_39F
lda	8DA9h
ani	8
rnz
in	1
ani	4
rz
di
lda	8DA9h
ori	8

loc_399:
sta	8DA9h
out	1
ret

loc_39F:
di
lda	8DA9h
ani	0F7h
ori	1
jmp	loc_399
; END OF FUNCTION CHUNK	FOR sub_228

loc_3AA:
push	h
push	b
push	d
rim
push	psw
ani	7
ori	0Dh
sim
ei
in	31h
ani	20h
jz	loc_3F0
lxi	h, 8D8Bh
lxi	d, 8D8Eh
lda	8D91h
ani	2
jz	loc_3CB
xchg

loc_3CB:
in	30h
mov	b, a
rlc
cpi	0C0h ; '¿'
mvi	a, 0FFh
sta	8D9Ah
lda	8D8Ah
jnc	loc_4AA
inr	a
sta	8D8Ah
cpi	3
jnc	loc_139
cpi	1
inx	h
jz	loc_3EC
inx	h

loc_3EC:
mov	m, b
jmp	loc_139

loc_3F0:
in	1
rrc
jnc	loc_474
lda	8D88h
ora	a
jnz	loc_43A
di
lda	8DA9h
rlc
jnc	loc_410
rrc
ani	7Fh
sta	8DA9h
out	1
jmp	loc_139

loc_410:
ei
rrc
rrc
jnc	loc_474
lda	8D93h
ora	a
jnz	loc_45B
lda	8D7Bh
ora	a
jnz	loc_446
lhld	8DA7h
mov	a, m
ora	a
jz	loc_443
dcr	m
lhld	8D48h
mov	a, m
inx	h
shld	8D48h

loc_435:
out	0
jmp	loc_139

loc_43A:
mov	b, a
xra	a
sta	8D88h
mov	a, b
jmp	loc_435

loc_443:
sta	8D89h

loc_446:
di
lda	8D88h
ora	a
jnz	loc_43A
lda	8DA9h
ani	0FEh
out	1
sta	8DA9h
jmp	loc_139

loc_45B:
lxi	h, 39C4h
cpi	0FEh ; '˛'
jnz	loc_464
inx	h

loc_464:
lda	8DB9h
rrc
jnc	loc_46D
inx	h
inx	h

loc_46D:
mov	a, m
sta	8D93h
jmp	loc_446

loc_474:
lda	8DB3h
rrc
jnc	loc_139
in	9
rrc
jnc	loc_139
di
lda	8D78h
dcr	a
jm	loc_49C
sta	8D78h
lhld	8D6Eh
mov	a, m
jz	loc_497
inx	h
shld	8D6Eh

loc_497:
out	8
jmp	loc_139

loc_49C:
di
lda	8DB3h
ani	0FEh
sta	8DB3h
out	9
jmp	loc_139

loc_4AA:
mov	c, a
mvi	a, 8
sim
ei
call	sub_10DD
jmp	loc_139



sub_4B5:
sta	8D88h
cpi	13h
jz	loc_4BE
xra	a

loc_4BE:
sta	8D7Ch
lda	8DA9h
ori	80h
sta	8DA9h
ori	1
out	1
ret
; End of function sub_4B5

; START	OF FUNCTION CHUNK FOR sub_30

loc_4CE:
push	h
push	b
in	1
rrc
rrc
jc	loc_4DB
lhld	8DF8h
pchl

loc_4DB:
lxi	h, 2580h
shld	8D6Ch
ani	0Eh
in	0
jnz	loc_534
ani	7Fh
ora	a
jz	loc_529
cpi	7Fh ; ''
jz	loc_529

loc_4F3:
mov	b, a
lda	8D77h
cpi	40h ; '@'
jz	loc_52E
inr	a
sta	8D77h
lhld	8D9Dh
mov	m, b
mov	a, l
inr	a
ani	3Fh
sta	8D9Dh
lda	8DB8h
rrc
jnc	loc_529
lda	8D7Ch
ora	a
jnz	loc_529
lda	8D77h
cpi	20h ; ' '
jnz	loc_529
mvi	a, 13h
sta	8D7Ch
call	sub_4B5

loc_529:
pop	b
pop	h
pop	psw
ei
ret

loc_52E:
sta	8D79h
jmp	loc_529

loc_534:
lda	8DA9h
ori	10h
out	1
mvi	a, 7Fh ; ''
jmp	loc_4F3
; END OF FUNCTION CHUNK	FOR sub_30
; START	OF FUNCTION CHUNK FOR sub_0

loc_540:
out	3Ah
call	sub_5CC
mov	d, a
jmp	loc_7AE
; END OF FUNCTION CHUNK	FOR sub_0
; START	OF FUNCTION CHUNK FOR sub_772

loc_549:
di
lxi	sp, 9000h
xra	a
sta	8DA1h
call	sub_662

loc_554:
lxi	h, 8D77h
lxi	b, 26h ; '&'

loc_55A:
mov	m, b
inx	h
dcr	c
jnz	loc_55A
mvi	a, 0Fh
sta	8DF2h
sta	8DB7h
lxi	h, 2580h
shld	8D6Ch
lxi	h, 8D00h
shld	8D9Dh
shld	8D9Fh
mvi	a, 1
sta	8DA6h
lxi	h, 8D86h
shld	8DA7h
lda	8DBBh
ora	a
jm	loc_59D
mvi	a, 11h
sta	8D88h
sta	8D89h
lda	8DA9h
ori	5
sta	8DA9h
out	1
in	0

loc_59D:
call	sub_1B5B
lda	8DFAh
lxi	h, 8DA1h
ora	a
push	psw
jp	loc_5AF
ani	7Fh
ora	m
mov	m, a

loc_5AF:
mov	a, m
out	38h
pop	psw
jz	loc_5C1
jp	loc_5BB
mvi	a, 80h ; 'Ä'

loc_5BB:
lxi	h, 8001h
call	sub_244A

loc_5C1:
mvi	a, 18h
sim
ei
call	sub_5D6
lhld	word_3DCE
pchl
; END OF FUNCTION CHUNK	FOR sub_772



sub_5CC:
call	sub_5D6
xra	a
out	38h
call	sub_5D6
ret
; End of function sub_5CC




sub_5D6:
lxi	h, 8D91h
mov	a, m
ani	40h
mov	c, a
mvi	b, 4

loc_5DF:
lxi	d, 136h

loc_5E2:
dcx	d
mov	a, e
ora	d
jz	loc_609
rim
ani	8
jz	loc_5F8
mov	a, m
ani	40h
xra	c
jnz	loc_607
jmp	loc_5E2

loc_5F8:
in	31h
ani	20h
jz	loc_5E2
in	30h
rlc
cpi	0C0h ; '¿'
jc	loc_5DF

loc_607:
mvi	b, 0

loc_609:
di
lxi	h, 8D40h
shld	8DA4h
shld	8DA2h
xra	a
sta	8D87h
ret
; End of function sub_5D6




sub_618:

; FUNCTION CHUNK AT 0E76 SIZE 00000029 BYTES

mvi	a, 36h ; '6'
out	13h
lda	8DBCh
mov	b, a
rlc
call	sub_765
out	10h
mov	a, l
out	10h
mvi	a, 76h ; 'v'
out	13h
mov	a, b
call	sub_762
out	11h
mov	a, l
out	11h
mvi	a, 0B6h	; '∂'
out	13h
lda	8DBDh
rlc
call	sub_765
out	12h
mov	a, l
out	12h
lda	8DBAh
mov	b, a
rlc
ani	1
mov	c, a
mov	a, b
ani	40h
mov	a, c
jz	loc_657
ori	2

loc_657:
out	3Eh
sta	8DF5h
call	sub_E2E
jmp	loc_E76
; End of function sub_618




sub_662:
call	sub_13B3
; End of function sub_662




sub_665:
call	sub_618
lxi	h, 8E00h
shld	8DAAh
mvi	l, 2Eh ; '.'
shld	8DACh
lxi	h, 101h
shld	8DB0h
mov	a, l
sta	8DB7h
lda	8DB8h
ani	10h
lxi	h, 8001h
mvi	a, 20h ; ' '
jz	loc_68E
mvi	h, 90h ; 'ê'
mvi	a, 0F1h	; 'Ò'

loc_68E:
sta	8DB6h
shld	8DB4h
lda	8DBBh
ani	40h
mvi	a, 50h ; 'P'
jz	loc_6A0
adi	34h ; '4'

loc_6A0:
sta	8DB2h
mvi	c, 18h
lda	8DB8h
ani	20h
jz	loc_6AF
mvi	c, 98h ; 'ò'

loc_6AF:
lda	8DB9h
rrc
mov	b, a
jc	loc_6BB
mov	a, c
ori	20h
mov	c, a

loc_6BB:
mov	a, b
ani	8
jz	loc_6C5
mov	a, c
ori	4
mov	c, a

loc_6C5:
lda	8DBBh
ani	40h
jnz	loc_6D1
mov	a, c
ori	40h
mov	c, a

loc_6D1:
mov	a, c
sta	8DEDh
call	sub_720
lxi	h, 8C78h
shld	8DAEh
lda	8DBBh
ani	1Fh
out	3Ah
lda	8DA1h
ani	1Fh
mov	b, a
lda	8DBBh
rlc
jc	loc_6F7
mvi	a, 40h ; '@'
jmp	loc_6F9

loc_6F7:
mvi	a, 20h ; ' '

loc_6F9:
ora	b
mov	b, a
lda	8DB8h
ani	4
jz	loc_707
mvi	a, 80h ; 'Ä'
ora	b
mov	b, a

loc_707:
mov	a, b
sta	8DA1h

loc_70B:
xra	a
sta	8D9Bh
lda	8DB9h
ora	a
mvi	a, 41h ; 'A'
jm	loc_719
inr	a

loc_719:
sta	8DF3h
sta	8DF4h
ret
; End of function sub_665




sub_720:
lda	8DB2h
lxi	h, 8000h
lxi	b, 8E00h
mov	e, a
mvi	d, 20h ; ' '

loc_72C:
mov	a, l
stax	b
inx	b
mov	a, h
stax	b
inx	b
mvi	m, 0
mov	a, e

loc_735:
inx	h
mov	m, d
dcr	a
jnz	loc_735
inx	h
mov	a, c
cpi	30h ; '0'
jnz	loc_72C
mov	a, h
ori	10h
mov	h, a
mvi	b, 0F1h	; 'Ò'

loc_748:
dcx	h
mov	m, b
mov	a, l
ora	a
jnz	loc_748
mov	a, h
ani	0Fh
jnz	loc_748
lxi	h, 8E00h
shld	8DAAh
lxi	h, 8E2Eh
shld	8DACh
ret
; End of function sub_720




sub_762:
rrc
rrc
rrc
; End of function sub_762




sub_765:
lxi	h, 3A04h
ani	1Eh
mvi	d, 0
mov	e, a
dad	d
mov	a, m
inx	h
mov	l, m
ret
; End of function sub_765




sub_772:

; FUNCTION CHUNK AT 0549 SIZE 00000083 BYTES
; FUNCTION CHUNK AT 0959 SIZE 00000023 BYTES

mov	m, c
mov	a, h
dcr	e
jz	loc_77D
add	b
mov	h, a
jmp	sub_772

loc_77D:
mov	e, b

loc_77E:
mov	a, c
ani	0A0h
mov	a, m
jnz	loc_787
ani	0Fh

loc_787:
cmp	c
jnz	loc_793
dcr	e
rz
mov	a, h
sub	b
mov	h, a
jmp	loc_77E

loc_793:
mov	a, c
ani	0A0h
mvi	a, 1
jnz	loc_7C2
mvi	a, 0Fh
jmp	loc_7A3

loc_7A0:
mov	a, e
rrc
inr	a

loc_7A3:
ori	80h
sta	8DFAh
call	sub_5CC
jmp	loc_549

loc_7AE:
lxi	h, 8000h
lxi	b, 4AAh
mov	e, b
call	sub_772
lxi	h, 9000h
mvi	c, 5
mov	e, b
call	sub_772
xra	a

loc_7C2:
sta	8DFAh
lxi	sp, 9000h
push	d
mvi	a, 0Fh
sim
mvi	a, 0Eh

loc_7CE:
push	psw
lxi	h, 3DD0h
mvi	d, 0
mov	e, a
dad	d
mov	a, m
cpi	0FFh
jnz	loc_7E0
pop	psw
jmp	loc_809

loc_7E0:
inx	h
mov	h, m
mov	l, a
lxi	b, 0
lxi	d, 800h

loc_7E9:
mov	a, m
add	c
mov	c, a
jnc	loc_7F0
inr	b

loc_7F0:
inx	h
dcx	d
mov	a, e
ora	d
jnz	loc_7E9
pop	psw
lxi	h, 3DE0h
mov	e, a
dad	d
mov	a, m
cmp	c
jnz	loc_7A0
inx	h
mov	a, m
cmp	b
jnz	loc_7A0
mov	a, e

loc_809:
dcr	a
dcr	a
jp	loc_7CE
call	sub_13B3
jnz	loc_84B
xra	a
sta	8DEDh
lhld	8DC2h
push	h
lxi	h, 0AA55h
shld	8DC2h
call	sub_141A
lxi	h, 0
shld	8DC2h
call	sub_13B3
jnz	loc_83E
lda	8DC2h
cpi	55h ; 'U'
jnz	loc_83E
lda	8DC3h
cpi	0AAh ; '™'

loc_83E:
pop	h
push	psw
shld	8DC2h
call	sub_141A
di
pop	psw
jz	loc_871

loc_84B:
lda	8DFAh
ori	2
sta	8DFAh
lxi	b, 1F06h

loc_856:
push	b
call	sub_5D6
pop	b
mov	a, b
xri	20h
mov	b, a
out	3Ah
xra	a
out	38h
lxi	h, 5D00h

loc_867:
dcx	h
mov	a, l
ora	h
jnz	loc_867
dcr	c
jnz	loc_856

loc_871:
call	sub_5CC
lda	8DFAh
ora	b
sta	8DFAh
mvi	e, 0

loc_87D:
pop	psw
mov	d, a
push	d
mov	a, e
rrc
jc	loc_88F
rrc
jc	loc_895
mvi	a, 2
ana	d
jnz	loc_8C3

loc_88F:
mvi	a, 4
ana	d
jnz	loc_959

loc_895:
mov	a, d
ana	a
jz	loc_549
lda	8DFAh
ana	a
jnz	loc_8AC
mov	a, d
ani	8
mov	a, d
jnz	loc_8B8
rrc
jc	loc_549

loc_8AC:
call	sub_5CC
call	sub_665
lxi	sp, 9000h
jmp	loc_554

loc_8B8:
rrc
jc	loc_7AE
rrc
jc	loc_8C3
jmp	loc_959

loc_8C3:
lxi	h, 8DB8h
mvi	a, 3

loc_8C8:
inx	h
mov	b, m
inx	h
mov	c, m
push	b
dcr	a
jnz	loc_8C8
dcx	h
mvi	m, 0EEh	; 'Ó'
dcx	h
mvi	m, 0EEh	; 'Ó'
dcx	h
mvi	m, 0
dcx	h
mov	a, m
ani	0C0h
ori	2
mov	m, a
dcx	h
mvi	m, 2
call	sub_618
lda	8DFAh
ori	8
mov	c, a
call	sub_910
mov	a, c
ani	8
cnz	sub_953
mov	a, c
sta	8DFAh
lxi	h, 8DBFh
mvi	a, 3

loc_8FF:
dcx	h
pop	b
mov	m, c
dcx	h
mov	m, b
dcr	a
jnz	loc_8FF
call	sub_618
mvi	e, 1
jmp	loc_87D
; End of function sub_772




sub_910:
lxi	h, 0FA0h
mvi	a, 5
out	1
out	9
mvi	a, 0AAh	; '™'
out	0
out	8

loc_91F:
in	1
ani	72h
jnz	loc_92D
dcx	h
mov	a, l
ora	a
jnz	loc_91F
ret

loc_92D:
ani	70h
rnz
in	0
cpi	0AAh ; '™'
rnz
mov	a, c
xri	8
ori	20h

loc_93A:
mov	c, a

loc_93B:
mov	a, l
ora	h
dcx	h
jnz	loc_93B
in	9
ani	72h
rz
ani	70h
rnz
in	8
cpi	0AAh ; '™'
rnz
mov	a, c
ani	9Fh
mov	c, a
ret
; End of function sub_910




sub_953:
mvi	a, 20h ; ' '
ora	c
jmp	loc_93A
; End of function sub_953

; START	OF FUNCTION CHUNK FOR sub_772

loc_959:
xra	a
out	3Eh
lxi	b, 1018h
lxi	d, 90Fh
lxi	h, 8080h
mvi	a, 22h ; '"'
call	sub_97C
lxi	b, 400h
mvi	d, 6
mov	a, c
mov	h, c
call	sub_97C
call	sub_618
mvi	e, 2
jmp	loc_87D
; END OF FUNCTION CHUNK	FOR sub_772



sub_97C:
out	1
out	9
in	1
ana	l
cmp	h
cnz	sub_9A1
in	9
ana	l
cmp	h
cnz	sub_9AA
mov	a, c
out	3Eh
in	31h
ana	e
cmp	d
cnz	sub_9A1
in	33h
ani	14h
cmp	b
jnz	sub_9AA
ret
; End of function sub_97C




sub_9A1:
lda	8DFAh
ori	10h

loc_9A6:
sta	8DFAh
ret
; End of function sub_9A1




sub_9AA:
lda	8DFAh
ori	40h
jmp	loc_9A6
; End of function sub_9AA

pop	psw
pop	psw
pop	psw
pop	psw

loc_9B6:
lda	8D7Eh
ora	a
jnz	loc_9B6
lda	8DEDh
ani	0F7h
out	3Fh
xra	a
di
lhld	8DA7h
mov	m, a
ei
sta	8D87h
lda	8DA1h
ani	0EFh
sta	8DA1h
lda	8D84h
sta	8DE6h
mvi	a, 0FFh
sta	8D84h
lda	8D91h
ori	0Dh
ani	0EFh
sta	8D91h
lxi	h, 0C26h
shld	8D69h
lxi	h, 8E30h
shld	8DE7h
mvi	m, 10h
inx	h
xchg
lxi	h, 3AACh
mvi	b, 42h ; 'B'
call	sub_DA4
xchg
inx	h
shld	8DEBh
mvi	m, 80h ; 'Ä'
lxi	b, 42F0h
mov	a, h
ori	10h
mov	h, a

loc_A11:
dcx	h
mov	m, c
dcr	b
jnz	loc_A11
lhld	8DAEh
shld	8DE9h
mov	a, h
ori	10h
mov	h, a
lda	8DB2h
mov	b, a
mvi	c, 0F1h	; 'Ò'

loc_A27:
inx	h
mov	m, c
dcr	b
jnz	loc_A27
lhld	8DB0h
shld	8DE3h
lda	8DA6h
sta	8DE5h
lda	8DB6h
lhld	8DB4h
mov	m, a
call	sub_A86
call	sub_C83
lxi	h, 8D8Bh
lxi	d, 8D8Eh
lda	8D91h
ani	2
jz	loc_A55
xchg

loc_A55:
inx	d
call	loc_1132
lda	8DEDh
out	3Fh
ei

loc_A5F:
lda	8D91h
ani	4
jnz	loc_A5F
sta	8D7Bh
mvi	a, 9
sim
call	sub_A86
lhld	8DE3h
shld	8DB0h
lda	8DE5h
sta	8DA6h
mvi	a, 8
sim
lda	8DE6h
sta	8D84h
ret



sub_A86:
lhld	8E00h
xchg
lhld	8DE7h
shld	8E00h
xchg
shld	8DE7h
lhld	8E02h
xchg
lhld	8DE9h
shld	8E02h
xchg
shld	8DE9h
lhld	8E04h
xchg
lhld	8DEBh
shld	8E04h
xchg
shld	8DEBh
ret
; End of function sub_A86




sub_AB1:
mvi	a, 41h ; 'A'
sta	8E38h
lhld	8E02h
lda	8DB2h
mov	b, a
mvi	m, 0
call	sub_182C

loc_AC2:
call	sub_1671
lda	8DB0h
mov	b, a
lda	8DB2h
cmp	b
jz	loc_AD8
call	sub_2664
mvi	m, 54h ; 'T'
jmp	loc_AC2

loc_AD8:
cpi	50h ; 'P'
jnz	loc_AE8
lda	8DC2h
ani	1
jnz	loc_AF0
jmp	loc_AF5

loc_AE8:
lda	8DBDh
ani	10h
jz	loc_AF5

loc_AF0:
call	sub_2664
mvi	m, 54h ; 'T'

loc_AF5:
mvi	a, 1
sta	8DB0h
lhld	8E04h
mvi	b, 84h ; 'Ñ'
mvi	a, 31h ; '1'

loc_B01:
inx	h
mov	m, a
inr	a
cpi	3Ah ; ':'
jc	loc_B0B
mvi	a, 30h ; '0'

loc_B0B:
dcr	b
jnz	loc_B01
lxi	b, 8402h
mov	a, h
ori	10h
mov	h, a
mvi	a, 3

loc_B18:
mov	m, a
dcr	c
jnz	loc_B21
xri	2
mvi	c, 0Ah

loc_B21:
dcx	h
dcr	b
jnz	loc_B18
ret
; End of function sub_AB1




sub_B27:
lxi	h, 8E38h
mvi	m, 42h ; 'B'
lhld	8E02h
lda	8DB2h
mov	b, a
mvi	m, 0
call	sub_182C
lhld	8E04h
mvi	b, 84h ; 'Ñ'
call	sub_182C
lhld	8E04h
lxi	d, 8
inx	h
mvi	a, 31h ; '1'

loc_B49:
mov	m, a
inr	a
cpi	37h ; '7'
jz	loc_B54
dad	d
jmp	loc_B49

loc_B54:
lhld	8DB0h
push	h
lxi	h, 341h
shld	8DB0h
lda	8DBCh
call	sub_D70
mvi	a, 36h ; '6'
sta	8DB0h
lda	8DBCh
rrc
rrc
rrc
rrc
call	sub_D70
mvi	a, 4Ch ; 'L'
sta	8DB0h
lda	8DBDh
call	sub_D70
pop	h
shld	8DB0h
lhld	8E04h
lxi	d, 32h ; '2'
dad	d
lxi	d, 9
mvi	b, 3

loc_B8E:
mvi	m, 53h ; 'S'
inx	h
mvi	m, 50h ; 'P'
inx	h
mvi	m, 44h ; 'D'
dad	d
dcr	b
jnz	loc_B8E
lhld	8E04h
lxi	d, 3
dad	d
lxi	d, 4
lda	8DB8h
call	sub_BFD
lda	8DB9h
call	sub_BFD
lda	8DBAh
call	sub_BFD
lhld	8E04h
lxi	d, 31h ; '1'
dad	d
lxi	d, 0Bh
mvi	m, 54h ; 'T'
dad	d
mvi	m, 52h ; 'R'
dad	d
mvi	m, 41h ; 'A'
lxi	b, 205h
lhld	8E04h
mov	a, h
ori	10h
mov	h, a
mvi	e, 2Eh ; '.'

loc_BD5:
mvi	a, 1

loc_BD7:
inx	h
mov	m, a
dcr	e
jz	loc_BF2
dcr	b
jnz	loc_BD5
dcr	c
jz	loc_BEC
mvi	b, 1
mvi	a, 3
jmp	loc_BD7

loc_BEC:
lxi	b, 405h
jmp	loc_BD5

loc_BF2:
mvi	b, 56h ; 'V'
mvi	a, 1

loc_BF6:
inx	h
mov	m, a
dcr	b
rz
jmp	loc_BF6
; End of function sub_B27




sub_BFD:
mvi	b, 2

loc_BFF:
mvi	c, 4

loc_C01:
rlc
jc	loc_C12
mvi	m, 30h ; '0'

loc_C07:
inx	h
dcr	c
jnz	loc_C01
dad	d
dcr	b
jnz	loc_BFF
ret

loc_C12:
mvi	m, 31h ; '1'
jmp	loc_C07
; End of function sub_BFD


loc_C17:
lda	8D91h
ani	0F2h
sta	8D91h
lhld	8DA2h
shld	8DA4h
ret
mov	b, a
lda	8D91h
ori	80h
sta	8D91h
mov	a, b
sta	8D70h
ani	7Fh
cpi	6
jc	loc_C65
sbi	6
cpi	0Ch
jc	loc_C73

loc_C41:
sbi	8
cpi	13h
jc	loc_C7B

loc_C48:
cpi	2Dh ; '-'
jz	loc_FA8
cpi	2Ch ; ','
jz	loc_186B
cpi	37h ; '7'
jz	loc_FA2
cpi	42h ; 'B'
jz	loc_1415
lda	8D91h
ani	7Fh
sta	8D91h
ret

loc_C65:
lxi	h, 39C6h
lxi	d, 0
add	a
mov	e, a
dad	d
mov	e, m
inx	h
mov	d, m
xchg
pchl

loc_C73:
cpi	6
jc	loc_C41
jmp	loc_C65

loc_C7B:
cpi	0Ch
jc	loc_C48
jmp	loc_C65



sub_C83:
lxi	h, 201h
shld	8DB0h
call	sub_2488
lda	8D91h
xri	8
sta	8D91h
ani	8
jz	loc_C9F
call	sub_B27
jmp	loc_CA2

loc_C9F:
call	sub_AB1

loc_CA2:
mvi	a, 1
sta	8DF2h
ret
; End of function sub_C83


loc_CA8:
lda	8DBBh
mov	e, a
ani	1Fh
cpi	1Fh
rz
inr	a
out	3Ah
mov	d, a
mov	a, e
ani	0E0h
ora	d
sta	8DBBh
ret

loc_CBD:
lda	8DBBh
mov	e, a
ani	1Fh
rz
dcr	a
out	3Ah
mov	d, a
mov	a, e
ani	0E0h
ora	d
sta	8DBBh
ret
lda	8DBBh
xri	80h
sta	8DBBh
lda	8DA1h
xri	60h
sta	8DA1h
jmp	sub_E2E
call	sub_D8D
mvi	a, 36h ; '6'
out	13h
lxi	h, 8DBCh
call	sub_D65
lhld	8DB0h
push	h
lxi	h, 341h
shld	8DB0h
call	sub_D70
rlc
call	sub_765
out	10h
mov	a, l
out	10h
pop	h
shld	8DB0h
ret
call	sub_D8D
lda	8D70h
rlc
jnc	loc_D40
mvi	a, 76h ; 'v'
out	13h
lda	8DBCh
adi	10h
sta	8DBCh
lhld	8DB0h
push	h
lxi	h, 336h
shld	8DB0h
rrc
rrc
rrc
rrc
call	sub_D70
rlc
call	sub_765
out	11h
mov	a, l
out	11h
pop	h
shld	8DB0h
ret

loc_D40:
mvi	a, 0B6h	; '∂'
out	13h
lxi	h, 8DBDh
call	sub_D65
lhld	8DB0h
push	h
lxi	h, 34Ch
shld	8DB0h
call	sub_D70
rlc
call	sub_765
out	12h
mov	a, l
out	12h
pop	h
shld	8DB0h
ret



sub_D65:
mov	a, m
ani	0F0h
mov	b, a
mov	a, m
inr	a
ani	0Fh
ora	b
mov	m, a
ret
; End of function sub_D65




sub_D70:
push	psw
call	sub_D95
call	sub_2664
mvi	b, 5

loc_D79:
push	h
push	d
push	b
ldax	d
mvi	c, 1
call	sub_25F3
pop	b
pop	d
pop	h
inx	h
inx	d
dcr	b
jnz	loc_D79
pop	psw
ret
; End of function sub_D70




sub_D8D:
lda	8D91h
ani	8
rnz
pop	b
ret
; End of function sub_D8D




sub_D95:
ani	0Fh
mov	d, a
rlc
rlc
add	d
mov	e, a
mvi	d, 0
lxi	h, 3A24h
dad	d
xchg
ret
; End of function sub_D95




sub_DA4:
mov	a, m
stax	d
dcr	b
rz
inx	h
inx	d
jmp	sub_DA4
; End of function sub_DA4

lda	8D91h
ani	8
rz
lda	8DB0h
ani	7
cpi	7
rnc
cpi	3
rc
lda	8DB0h
cpi	23h ; '#'
jnc	loc_E01
cpi	13h
jnc	loc_E0C
mvi	c, 0
lxi	h, 8DB8h

loc_DD0:
lda	8DB0h
ani	0Fh
cpi	8
jc	loc_E14
sbi	7

loc_DDC:
cma
ani	7
mov	b, a
push	b
push	h
mov	a, m
push	psw
mov	a, b
call	sub_F5F
call	sub_F6F
pop	b
pop	h
mov	m, b
pop	b
lxi	h, 3A74h
mvi	a, 0Fh
ana	b
add	a
ora	c
lxi	d, 0
mov	e, a
dad	d
mov	e, m
inx	h
mov	d, m
xchg
pchl

loc_E01:
cpi	2Fh ; '/'
rnc
lxi	h, 8DBAh
mvi	c, 20h ; ' '
jmp	loc_DD0

loc_E0C:
lxi	h, 8DB9h
mvi	c, 10h
jmp	loc_DD0

loc_E14:
cmc
sbi	3
jmp	loc_DDC
lda	8DA1h
xri	80h
sta	8DA1h
ret
lda	8DEDh
xri	80h
sta	8DEDh
out	3Fh
ret



sub_E2E:
xra	a
mvi	b, 4

loc_E31:
out	1
dcr	b
jnz	loc_E31
mvi	a, 40h ; '@'
out	1
mvi	b, 0CAh	; ' '
lda	8DB9h
rlc
mov	c, a
rlc
ani	30h
ora	b
mov	b, a
mov	a, c
ani	4
ora	b
out	1
lda	8DBBh
rlc
mvi	a, 32h ; '2'
jc	loc_E58
mvi	a, 36h ; '6'

loc_E58:
out	1
ani	26h
sta	8DA9h
in	0
ret
; End of function sub_E2E

lda	8DB9h
ani	4
rz
jmp	sub_E2E
lda	8DEDh
xri	4
sta	8DEDh
out	3Fh
ret
; START	OF FUNCTION CHUNK FOR sub_618

loc_E76:
xra	a
mvi	b, 4

loc_E79:
out	9
dcr	b
jnz	loc_E79
mvi	a, 40h ; '@'
out	9
mvi	b, 0CAh	; ' '
lda	8DBAh
rlc
mov	c, a
rlc
ani	30h
ora	b
mov	b, a
mov	a, c
ani	4
ora	b
out	9
mvi	a, 32h ; '2'
out	9
mvi	a, 22h ; '"'
sta	8DB3h
ret
; END OF FUNCTION CHUNK	FOR sub_618
lda	8DBAh
ani	4
rz
jmp	loc_E76
lda	8DF5h
xri	2
sta	8DF5h
out	3Eh
ret
lda	8DF5h
xri	1
sta	8DF5h
out	3Eh
ret
xra	a
sta	8D99h
ret
lda	8DEDh
xri	20h
sta	8DEDh
out	3Fh
ret
lda	8D91h
ani	8
rnz
lda	8DBBh
xri	40h
sta	8DBBh
ani	40h
mvi	a, 50h ; 'P'
jz	loc_EE5
adi	34h ; '4'

loc_EE5:
sta	8DB2h
call	sub_A86
ei
call	sub_720
di
lda	8DEDh
xri	40h
sta	8DEDh
out	3Fh
lxi	h, 8C78h
shld	8DAEh
shld	8DE9h
call	sub_A86
lhld	8E02h
mov	a, h
ori	10h
mov	h, a
lda	8DB2h
mov	b, a
mvi	c, 0F1h	; 'Ò'

loc_F13:
inx	h
mov	m, c
dcr	b
jnz	loc_F13
lxi	h, 101h
shld	8DE3h
inr	h
shld	8DB0h
ei
jmp	sub_AB1
lda	8D91h
ani	8
rnz
lda	8DB0h
dcr	a
rz
call	sub_2664
mov	a, m
ani	7Fh
cpi	20h ; ' '
jz	loc_F46
mvi	b, 20h ; ' '
call	sub_F4F
call	sub_1748
ret

loc_F46:
mvi	b, 54h ; 'T'
call	sub_F4F
call	sub_173D
ret



sub_F4F:
lda	8DB8h
ani	10h
mvi	a, 1
jnz	loc_F5A
mov	a, b

loc_F5A:
sta	8DB6h
mov	m, b
ret
; End of function sub_F4F




sub_F5F:
lxi	h, 3AA4h
lxi	d, 0
mov	e, a
dad	d
mov	a, m
pop	d
pop	b
xra	b
push	psw
push	psw
push	d
ret
; End of function sub_F5F




sub_F6F:
lhld	8E04h
mvi	d, 0
lda	8DB0h
mov	e, a
dad	d
pop	d
pop	psw
cmp	b
jc	loc_F83
mvi	m, 31h ; '1'
push	d
ret

loc_F83:
mvi	m, 30h ; '0'
push	d
ret
; End of function sub_F6F

lda	8D91h
ani	8
rnz
call	sub_1754
lda	8DB2h
push	psw
mvi	a, 84h ; 'Ñ'
sta	8DB2h
ei
call	sub_1F62
pop	psw
sta	8DB2h
ret

loc_FA2:
mvi	a, 1
sta	8DB0h
ret

loc_FA8:
mov	a, b
rlc
rc
lda	8D91h
ani	8
rz
mvi	a, 1
sta	8DB0h
call	sub_2664
mvi	a, 41h ; 'A'
mvi	c, 1
call	sub_25F3
call	sub_2664
mvi	a, 3Dh ; '='
mvi	c, 1
call	sub_25F3
lxi	h, 0FD9h
shld	8D69h
lda	8D91h
ori	10h
sta	8D91h
ret
mov	d, a
ani	7Fh
mvi	e, 18h
lxi	h, 39ECh
call	sub_10B8
jnz	loc_FEE
mov	a, c
ani	7Fh
sta	8D91h
ret

loc_FEE:
cpi	2
jz	loc_CBD
cpi	3
jz	loc_CA8
cpi	1
jz	loc_C17
cpi	1Bh
jz	loc_10C1
cpi	50h ; 'P'
jz	loc_10C1

loc_1007:
mov	a, d
ora	a
mvi	e, 0
ral
jnc	loc_1011
inr	e
cmc

loc_1011:
ral
mvi	d, 0
jnc	loc_1018
inr	d

loc_1018:
add	e
mov	e, a
lxi	h, 37FCh
dad	d
mov	a, b
ani	2
jnz	loc_1026
inx	h
inx	h

loc_1026:
mov	a, m
cpi	80h ; 'Ä'
jc	loc_103E
sui	0B0h ; '∞'
mov	e, a
mvi	d, 0
lxi	h, 397Ch
dad	d
mov	c, m
mov	a, b
rrc
jc	loc_103F
mov	a, c
xri	20h

loc_103E:
mov	c, a

loc_103F:
lda	8D91h
ani	10h
jz	loc_105A
xra	a
sta	8DCEh
lda	8D91h
ani	0EFh
sta	8D91h
mov	a, c
sta	8D40h
jmp	loc_1070

loc_105A:
lda	8D40h
cmp	c
jz	loc_10AA
lda	8DCEh
mov	e, a
inr	a
sta	8DCEh
mvi	d, 0
lxi	h, 8DCFh
dad	d
mov	m, c

loc_1070:
mov	a, c
cpi	20h ; ' '
jnc	sub_108B
cpi	0Dh
mvi	c, 0
jnz	sub_108B
call	sub_108B
lda	8DB9h
ani	20h
rz
mvi	c, 0Ah
jmp	loc_105A



sub_108B:
call	sub_2664
mov	a, c
cpi	23h ; '#'
jnz	loc_109F
lda	8DB9h
ani	80h
mov	a, c
jz	loc_109F
mvi	a, 14h

loc_109F:
mvi	c, 1
call	sub_25F3
lda	8DCEh
cpi	14h
rnz

loc_10AA:
mvi	a, 1
sta	8DB0h
lxi	h, 0C26h
shld	8D69h
jmp	sub_1F21
; End of function sub_108B




sub_10B8:
cmp	m
rz
inx	h
dcr	e
jnz	sub_10B8
ora	a
ret
; End of function sub_10B8


loc_10C1:
mov	e, a
mov	a, b
ani	2
jnz	loc_1007
mov	a, e
cpi	1Bh
mvi	a, 11h
jz	loc_103E
adi	2
jmp	loc_103E
xra	a
sta	8D92h
sta	8DE6h
ret



sub_10DD:
lda	8D91h
xri	40h
sta	8D91h
mov	a, c
ora	a
jz	loc_1157
cpi	3
jnc	loc_1163
cpi	2
push	psw
mov	a, b
ani	3
mov	m, a
pop	psw
jnz	loc_10FF
ldax	d
cmp	m
jnz	loc_1163

loc_10FF:
inx	h
inx	d
ldax	d
xra	m
ani	7Fh
inx	d
jz	loc_1119
ldax	d
xra	m
ani	7Fh
jz	loc_1119
push	d
push	h
push	b
call	sub_116B
pop	b
pop	h
pop	d

loc_1119:
inx	h
ldax	d
xra	m
ani	7Fh
dcx	d
jz	loc_1132
ldax	d
xra	m
ani	7Fh
jz	loc_1132
push	d
push	h
push	b
call	sub_116B
pop	b
pop	h
pop	d

loc_1132:
lda	8D91h
xri	2
sta	8D91h
xra	a
xchg
mov	m, a
inx	h
mov	m, a

loc_113F:
sta	8D8Ah
lda	8D91h
mov	c, a
ori	7Fh
mov	b, a
lda	8DA1h
ana	b
di
out	38h
mov	a, c
ani	7Fh
sta	8D91h
ret

loc_1157:
lxi	h, 0
shld	8D8Ch
shld	8D8Fh
jmp	loc_113F

loc_1163:
inx	h
xra	a
mov	m, a
inx	h
mov	m, a
jmp	loc_113F
; End of function sub_10DD




sub_116B:
lda	8D91h
mov	c, a
mov	a, m
ora	a
rz
mov	a, c
rrc
mov	a, m
lxi	h, 2580h
shld	8D6Ch
jnc	loc_1182
lhld	8D69h
pchl

loc_1182:
mvi	e, 0
ral
jnc	loc_118A
inr	e
cmc

loc_118A:
ral
mvi	d, 0
jnc	loc_1191
inr	d

loc_1191:
add	e
mov	e, a
lxi	h, 37FCh
dad	d
mov	a, b
ani	2
jnz	loc_119F
inx	h
inx	h

loc_119F:
mov	a, c
ori	80h
sta	8D91h
mov	a, m
mov	c, a
cpi	0FFh
jz	loc_11EE
cpi	80h ; 'Ä'
jc	loc_11C2
lxi	h, 39A6h

loc_11B4:
ani	70h
rrc
rrc
rrc
mvi	d, 0
mov	e, a
dad	d
mov	e, m
inx	h
mov	d, m
xchg
pchl

loc_11C2:
lda	8D87h
cpi	7
jz	loc_11EE
inr	a
sta	8D87h
cpi	7
lda	8DA1h
mvi	b, 10h
jnz	loc_11DC
ora	b
jmp	loc_11DF

loc_11DC:
mvi	b, 0EFh	; 'Ô'
ana	b

loc_11DF:
sta	8DA1h
lhld	8DA2h
mov	m, c
mov	a, l
inr	a
ani	0F7h
sta	8DA2h
ret

loc_11EE:
lda	8D91h
ani	7Fh
sta	8D91h
ret
; End of function sub_116B

lxi	h, 397Ch
mov	a, c
sui	0B0h ; '∞'
mov	e, a
mvi	d, 0
dad	d
mov	c, m
mov	a, b
rrc
jc	loc_11C2
mov	a, c
xri	20h
mov	c, a
jmp	loc_11C2
mov	a, c
ani	0Fh
rlc
mov	e, a
mvi	d, 0
lxi	h, 3966h
dad	d
mov	e, m
inx	h
mov	d, m
xchg
pchl



sub_121E:
sta	8D87h
lhld	8DA4h
mov	c, m
mov	a, l
inr	a
ani	0F7h
sta	8DA4h
lda	8DA1h
ani	0EFh
sta	8DA1h
mov	a, c
cpi	80h ; 'Ä'
jc	loc_1240
lxi	h, 39B2h
jmp	loc_11B4

loc_1240:
lda	8DB8h
ani	8
jz	loc_124B
sta	8D95h

loc_124B:
mov	a, c
cpi	0Dh
jnz	loc_1263
lda	8DB9h
ani	20h
jz	loc_1263
mvi	a, 0Ah
sta	8CFEh
mvi	a, 2
jmp	loc_1265

loc_1263:
mvi	a, 1

loc_1265:
sta	8D86h
mov	a, c
sta	8CFDh
ret
; End of function sub_121E

mov	a, c
ani	0Fh
mov	e, a
mvi	d, 0
lxi	h, 3950h
dad	d
mov	a, m
sta	8CFEh
sta	8CFFh
mvi	a, 1Bh
sta	8CFDh
lda	8DB8h
ani	2
mvi	a, 2
sta	8D86h
rz
inr	a
sta	8D86h
mov	a, e
cpi	4
jnc	loc_12A6
lda	8D96h
ani	2
jnz	loc_12A6
mvi	a, 5Bh ; '['
sta	8CFEh
ret

loc_12A6:
mvi	a, 4Fh ; 'O'
sta	8CFEh
ret
mov	a, c
ani	0Fh
mov	e, a
mvi	d, 0
lxi	h, 3958h
dad	d
mov	c, m
lda	8D96h
rrc
jc	loc_12C5
mov	a, c
ani	3Fh
mov	c, a
jmp	loc_1240

loc_12C5:
lda	8DB8h
ani	2
mvi	a, 3Fh ; '?'
jz	loc_12D1
adi	10h

loc_12D1:
lxi	h, 8CFDh
mvi	m, 1Bh
inx	h
mov	m, a
inx	h
mov	m, c
mvi	a, 3
sta	8D86h
ret
mov	a, c
ani	0Fh
rlc
mov	e, a
mvi	d, 0
lxi	h, 399Ch
dad	d
mov	a, m
inx	h
mov	h, m
mov	l, a
pchl
lda	8DB8h
rrc
rnc
lda	8D92h
cma

loc_12F9:
sta	8D92h
sta	8D84h
mov	b, a
di
lda	8D7Ch
ora	a
jz	loc_130E
lda	8D77h
cpi	11h
rnc

loc_130E:
mov	a, b
ora	a
mvi	a, 11h
jz	loc_1317

loc_1315:
mvi	a, 13h

loc_1317:
call	sub_4B5
ei
ret
mvi	a, 0FFh
sta	8D92h
di
jmp	loc_1315
xra	a
jmp	loc_12F9
mvi	b, 0FFh
jmp	loc_1330
mvi	b, 0FEh	; '˛'

loc_1330:
lda	8DBBh
ora	a
rm
lda	8DA1h
ani	10h
rnz
lda	8D93h
ora	a
rnz
mov	a, b
sta	8D93h
lda	8DA9h
ori	1
sta	8DA9h
out	1
sta	8D89h
ret
lda	8DBBh
ora	a
rm
mvi	b, 0
jmp	sub_22B2



sub_135C:
lxi	d, 8D41h
mvi	b, 6

loc_1361:
ldax	d
mov	c, b

loc_1363:
ora	a
rar
dcr	c
jnz	loc_1363
mov	m, a
inx	h
inx	d
dcr	b
jnz	loc_1361
ldax	d
mov	m, a
dcx	d
mvi	b, 7

loc_1375:
ldax	d
mov	c, b

loc_1377:
ora	a
ral
dcr	c
jnz	loc_1377
ora	m
mov	m, a
dcx	d
dcx	h
dcr	b
jnz	loc_1375
ret
; End of function sub_135C




sub_1386:
lxi	h, 8D40h
mvi	m, 0
inx	h
mvi	b, 6

loc_138E:
ldax	d
mov	c, b

loc_1390:
ora	a
ral
dcr	c
jnz	loc_1390
mov	m, a
inx	h
inx	d
dcr	b
jnz	loc_138E
ldax	d
mov	m, a
dcx	h
mvi	b, 7

loc_13A2:
ldax	d
mov	c, b

loc_13A4:
ora	a
rar
dcr	c
jnz	loc_13A4
ora	m
mov	m, a
dcx	h
dcx	d
dcr	b
jnz	loc_13A2
ret
; End of function sub_1386




sub_13B3:
lda	8DEDh
ani	0F7h
out	3Fh
lxi	h, 8DB8h
lxi	d, 0
lxi	b, 700h

loc_13C3:
push	d
push	b
push	h
call	sub_14FC
pop	h
pop	b
dcr	b
jz	loc_13F0
push	b
call	sub_135C
pop	b
pop	d
mov	a, c
mvi	c, 7

loc_13D8:
inx	h
add	m
dcr	c
jnz	loc_13D8
inx	h
mov	c, a
mov	a, d
adi	4
daa
cpi	10h
jc	loc_13EC
inr	e
ani	0Fh

loc_13EC:
mov	d, a
jmp	loc_13C3

loc_13F0:
pop	d
lda	8D40h
ani	7Fh
rlc
mov	b, a
lda	8D41h
ani	7Fh
rlc
ral
jnc	loc_1403
inr	b

loc_1403:
mov	e, a
lda	8D42h
rlc
rlc
rlc
ani	3
add	e
mov	e, a
mov	a, b
sta	8DE2h
add	c
cmp	e

locret_1414:
ret
; End of function sub_13B3


loc_1415:
lda	8D70h
ora	a
rm



sub_141A:
di
lda	8DEDh
ani	0F7h
out	3Fh
call	sub_14D9
lxi	d, 8DB8h
lxi	h, 0
lxi	b, 700h

loc_142E:
push	b
push	h
call	sub_1386
xchg
pop	d
push	d
push	h
call	sub_14AD
pop	d
pop	h
pop	b
dcr	b
jz	loc_1469
xchg
mov	a, c
mvi	c, 7

loc_1445:
inx	h
add	m
dcr	c
jnz	loc_1445
inx	h
mov	c, b
dcr	c
jnz	loc_1457
add	m
inx	h
mov	c, m
push	b
mov	m, a
dcx	h

loc_1457:
mov	c, a
xchg
mov	a, h
adi	4
daa
cpi	10h
jc	loc_1465
inr	l
ani	0Fh

loc_1465:
mov	h, a
jmp	loc_142E

loc_1469:
pop	b
mov	a, c
sta	8DE3h
lda	8DEDh
out	3Fh
ei
ret
; End of function sub_141A

lda	8D70h
ana	a
rm
di
mvi	a, 3Ch ; '<'
sta	8DF2h
lhld	8DB4h
lda	8DB6h
mov	m, a
call	sub_A86
call	sub_662
lhld	8DB0h
shld	8DE3h
lda	8DA6h
sta	8DE5h
lda	8D91h
xri	8
sta	8D91h
call	sub_A86
lhld	8DAEh
shld	8E02h
jmp	sub_C83



sub_14AD:
lxi	h, 8D40h
mvi	b, 4

loc_14B2:
push	b
push	d
call	sub_1523
call	sub_15FE
mov	d, m
inx	h
mov	e, m
inx	h
push	h
call	sub_15BB
mvi	b, 1Ch
call	sub_1639
pop	h
pop	d
inr	d
mov	a, d
cpi	0Ah
jc	loc_14D3
mvi	d, 0
inr	e

loc_14D3:
pop	b
dcr	b
jnz	loc_14B2
ret
; End of function sub_14AD




sub_14D9:
lxi	d, 0
mvi	b, 1Ch

loc_14DE:
push	b
push	d
call	sub_1523
call	sub_15FE
mvi	b, 1Dh
call	sub_1639
pop	d
inr	d
mov	a, d
cpi	0Ah
jc	loc_14F6
mvi	d, 0
inr	e

loc_14F6:
pop	b
dcr	b
jnz	loc_14DE
ret
; End of function sub_14D9




sub_14FC:
lxi	h, 8D40h
mvi	b, 4

loc_1501:
push	b
push	d
push	h
call	sub_1523
call	sub_15FE
call	sub_152E
pop	h
mov	m, d
inx	h
mov	m, e
inx	h
pop	d
inr	d
mov	a, d

loc_1515:
cpi	0Ah
jc	loc_151D
mvi	d, 0
inr	e

loc_151D:
pop	b
dcr	b
jnz	loc_1501
ret
; End of function sub_14FC




sub_1523:
mov	a, d
cma
adi	0Bh
mov	d, a
mov	a, e
cma
adi	0Bh
mov	e, a
ret
; End of function sub_1523




sub_152E:
mvi	d, 0
lxi	b, 702h
mvi	a, 0Fh
out	39h
call	nullsub_1
call	nullsub_1
call	nullsub_1
xri	10h
out	39h
mvi	a, 1Eh
out	39h
call	nullsub_1
call	nullsub_1
jmp	loc_1551

loc_1551:
xri	10h
out	39h
call	nullsub_1
call	nullsub_1
call	nullsub_1
xri	10h
out	39h
mvi	a, 1Ah
out	39h
call	nullsub_1
call	nullsub_1
jmp	loc_156F

loc_156F:
xri	10h
out	39h
xri	10h
mov	h, a
in	31h
cma
ani	10h
rrc
rrc
rrc
rrc
ora	d
rlc
mov	d, a
mvi	a, 0
mov	a, h
jmp	loc_1588

loc_1588:
jmp	loc_158B

loc_158B:
out	39h
dcr	b
jnz	loc_15A1
mvi	b, 7
dcr	c
jz	loc_15B2
mov	e, d
mvi	d, 0
mvi	d, 0
mvi	d, 0
jmp	loc_15AC

loc_15A1:
jmp	loc_15A4

loc_15A4:
jmp	loc_15A7

loc_15A7:
cz	nullsub_1
push	psw
pop	psw

loc_15AC:
cz	nullsub_1
jmp	loc_156F

loc_15B2:
mov	a, d
rrc
mov	d, a
mov	a, e
rrc
mov	e, a
jmp	loc_1663
; End of function sub_152E




sub_15BB:
lxi	b, 802h
mov	a, d
rlc
rlc
rlc
rlc
rlc
mov	d, a
mov	a, e
rlc
rlc
rlc
rlc
mov	e, a
mvi	a, 1Fh

loc_15CD:
xri	10h
out	39h
xri	10h
mov	h, a
mov	a, e
rlc
mov	e, a
call	nullsub_1
call	nullsub_1
ani	0
mov	a, h
out	39h
dcr	b
jnz	loc_15F0
mvi	b, 7
mov	e, d
dcr	c
jnz	loc_15F2
jmp	loc_1663

loc_15F0:
push	psw
pop	psw

loc_15F2:
mov	a, e
ani	18h
ori	10h
out	39h
nop
nop
jmp	loc_15CD
; End of function sub_15BB




sub_15FE:
mvi	a, 1Fh
lxi	b, 0A02h

loc_1603:
jmp	loc_1606

loc_1606:
xri	10h
out	39h
call	nullsub_1
call	nullsub_1
call	nullsub_1
xri	10h
out	39h
mvi	a, 19h
nop
nop
dcr	e
jnz	loc_1621
ani	0F7h

loc_1621:
out	39h
dcr	b
jnz	loc_1631
mvi	b, 0Bh
mov	e, d
dcr	c
jnz	loc_1603
jmp	loc_1663

loc_1631:
nop
nop
jmp	loc_1636

loc_1636:
jmp	loc_1606
; End of function sub_15FE




sub_1639:
mvi	a, 1Fh
lxi	d, 0E4h	; '‰'

loc_163E:
xri	10h
out	39h
call	nullsub_1
call	nullsub_1
call	nullsub_1
xri	10h
out	39h
mov	a, b
out	39h
dcx	d
mov	a, e
ora	d
call	nullsub_1
mvi	c, 0
mvi	c, 0
mov	a, b
jnz	loc_163E
jmp	loc_1663

loc_1663:
mvi	a, 1Fh
out	39h
call	nullsub_1
call	nullsub_1
call	nullsub_1
; End of function sub_1639

; [00000001 BYTES: COLLAPSED FUNCTION nullsub_1. PRESS CTRL-NUMPAD+ TO EXPAND]



sub_1671:
xra	a
sta	8D97h

loc_1675:
call	sub_1709
jp	loc_1694
cpi	83h ; 'É'
rz
ani	7
inr	a
mov	c, a
cma
adi	5
call	sub_16FA
jc	loc_16EC
lda	8DB2h
sta	8DB0h
jmp	loc_16C3

loc_1694:
cpi	7Fh ; ''
jz	loc_16DC
ani	7
cpi	7
jz	loc_16A6
call	sub_16F5
jc	loc_16EC

loc_16A6:
mov	a, e
cma
adi	10h
mov	d, a

loc_16AB:
inx	h
inr	e
mov	a, m
dcr	d
jm	loc_16DC
ora	a
jz	loc_16AB
mov	a, e
rlc
rlc
rlc
inr	a
sta	8DB0h
mov	a, m
rlc
jnc	loc_1675

loc_16C3:
lda	8DB2h
mov	b, a
rrc
mov	c, a
call	sub_1A5F
ani	10h
mov	a, b
jz	loc_16D3
mov	a, c

loc_16D3:
lxi	h, 8DB0h
cmp	m
rnc
sta	8DB0h
ret

loc_16DC:
mvi	a, 81h ; 'Å'
sta	8DB0h
lda	8DBDh
ani	80h
jz	loc_1675
jmp	loc_16C3

loc_16EC:
mov	a, c
lxi	h, 8DB0h
add	m
mov	m, a
jmp	loc_16C3
; End of function sub_1671




sub_16F5:
inr	a
mov	c, a
cma
adi	9
; End of function sub_16F5




sub_16FA:
mov	d, a
mov	a, b

loc_16FC:
rlc
dcr	c
jnz	loc_16FC

loc_1701:
rlc
inr	c
rc
dcr	d
jnz	loc_1701
ret
; End of function sub_16FA




sub_1709:
lda	8DB0h
dcr	a
lxi	h, 8DBDh
jm	loc_1722
lxi	h, 8DBEh
lxi	d, 0
push	psw
rrc
rrc
rrc
ani	0Fh
mov	e, a
pop	psw
dad	d

loc_1722:
mov	b, m
ret
; End of function sub_1709




sub_1724:
ani	7
lxi	h, 1730h
lxi	d, 0
mov	e, a
dad	d
mov	a, m
ret
; End of function sub_1724

add	b
mov	b, b
rim
arhl
dsub
inr	b
stax	b
lxi	b, 683Ah
adc	l
ora	a
rnz



sub_173D:
call	sub_1709
push	h
call	sub_1724
pop	h
ora	b
mov	m, a
ret
; End of function sub_173D




sub_1748:
call	sub_1709
push	h
call	sub_1724
pop	h
cma
ana	b
mov	m, a
ret
; End of function sub_1748




sub_1754:
lxi	h, 8DBDh
mov	a, m
ani	0Fh
mov	m, a
mvi	b, 10h
xra	a

loc_175E:
inx	h
mov	m, a
dcr	b
jnz	loc_175E
ret
; End of function sub_1754

lda	8D68h
ora	a
rnz
jmp	loc_1775



sub_176D:
lda	8DB9h
ani	20h
cnz	sub_181E

loc_1775:
xra	a
sta	8D97h
sta	8D95h
lda	8DACh
rrc
inr	a
mov	b, a
lda	8DB1h
cmp	b
jnz	loc_17AB
mvi	b, 0
lda	8DB8h
ral
jc	loc_17B8

loc_1792:
mov	a, b
sta	8D4Fh
lhld	8DAEh
call	sub_1C28
mvi	a, 1
sta	8D9Ch

loc_17A1:
lda	8D9Ch
ora	a
jnz	loc_17A1
jmp	sub_1C13

loc_17AB:
jc	loc_17B1
cpi	18h
rz

loc_17B1:
inr	a

loc_17B2:
sta	8DB1h
jmp	sub_1C13

loc_17B8:
lda	8D7Eh
ora	a
jnz	loc_17B8
mov	a, b
sta	8D4Fh
lhld	8DAEh
call	sub_1C28
mvi	a, 0Bh
sta	8D7Eh

loc_17CE:
lda	8D7Eh
cpi	0Bh
jz	loc_17CE
jmp	sub_1C13
; End of function sub_176D


loc_17D9:
xra	a
sta	8D68h
inr	a
sta	8D82h
ret

loc_17E2:
xra	a
sta	8D82h
jmp	loc_251D
lda	8DB8h
rrc
rnc

loc_17EE:
sta	8D7Bh
ret
xra	a
jmp	loc_17EE
mvi	a, 80h ; 'Ä'
sta	8D82h
xra	a
sta	8D68h
ret
lda	8D68h
ora	a
rnz
call	sub_181E
jmp	loc_1775

loc_180B:
lda	8D97h
ora	a
mvi	a, 0
sta	8D97h
rnz
lda	8DB0h
dcr	a
rz
sta	8DB0h
ret



sub_181E:
mvi	a, 1
sta	8DB0h
xra	a
sta	8D97h
ret
; End of function sub_181E




sub_1828:
lda	8DB2h
mov	b, a
; End of function sub_1828




sub_182C:
inx	h
mvi	c, 20h ; ' '

loc_182F:
mov	m, c
inx	h
dcr	b
jnz	loc_182F
ret
; End of function sub_182C


loc_1836:
xra	a
sta	8D97h
lda	8DAAh
rrc
mov	b, a
lda	8DB1h
dcr	a
cmp	b
rz
ora	a
jnz	loc_184A
inr	a

loc_184A:
sta	8DB1h
jmp	sub_1C13

loc_1850:
xra	a
sta	8D97h
lda	8DACh
rrc
inr	a
mov	b, a
lda	8DB1h
cmp	b
rz
cpi	18h
jz	loc_1865
inr	a

loc_1865:
sta	8DB1h
jmp	sub_1C13

loc_186B:
call	sub_1A5F
ani	10h
jz	loc_187A
lda	8DB2h
rrc
jmp	loc_187D

loc_187A:
lda	8DB2h

loc_187D:
mov	b, a
lda	8DB0h
cmp	b
rz
inr	a
sta	8DB0h
ret
xra	a
sta	8D97h
call	sub_268B
jm	loc_1836
ora	a
jz	loc_1836
lda	8DB1h
mov	c, a
sub	b
jnc	loc_18A0
mvi	a, 1

loc_18A0:
mov	b, a
lda	8DAAh
rrc
inr	a
cmp	b
jc	loc_18AF
inr	c
cmp	c
jc	loc_18B7

loc_18AF:
mov	a, b
cpi	1
jnc	loc_18B7
mvi	a, 1

loc_18B7:
sta	8DB1h
jmp	sub_1C13
xra	a
sta	8D97h
call	sub_268B
jm	loc_1850
ora	a
jz	loc_1850
lda	8DB1h
mov	c, a
add	b
jnc	loc_18D5
mvi	a, 18h

loc_18D5:
mov	b, a
lda	8DACh
rrc
inr	a
cmp	b
jnc	loc_18E3
cmp	c
jnc	loc_18EB

loc_18E3:
mov	a, b
cpi	19h
jc	loc_18EB
mvi	a, 18h

loc_18EB:
sta	8DB1h
jmp	sub_1C13
xra	a
sta	8D97h
call	sub_268B
jm	loc_19BD
ora	a
jnz	loc_1900
inr	b

loc_1900:
lda	8D96h
ora	a
jm	loc_192B
mov	a, b
cpi	19h
jc	loc_190F
mvi	a, 18h

loc_190F:
sta	8DB1h
call	sub_268E
jm	loc_1944
ora	a
jz	loc_1944
lda	8DB2h
cmp	b
jc	loc_1924
mov	a, b

loc_1924:
sta	8DB0h
call	sub_1C13
ret

loc_192B:
mov	a, b
cpi	19h
jnc	loc_1937
lda	8DAAh
rrc
add	b
mov	b, a

loc_1937:
lda	8DACh
rrc
inr	a
cmp	b
jc	loc_190F
mov	a, b
jmp	loc_190F

loc_1944:
mvi	a, 1
jmp	loc_1924
mvi	a, 80h ; 'Ä'
sta	8DF4h
mvi	a, 1
sta	8D7Fh
lxi	h, 195Ah
shld	8D80h
ret
mov	a, b
cpi	20h ; ' '
jc	loc_19A6
cpi	38h ; '8'
jnc	loc_196A
sui	1Fh
sta	8DF4h

loc_196A:
mvi	a, 1
sta	8D7Fh
lxi	h, 1976h
shld	8D80h
ret
mov	a, b
cpi	20h ; ' '
jc	loc_19A6
xra	a
sta	8D97h
lda	8DF4h
ora	a
jm	loc_198A
sta	8DB1h

loc_198A:
mov	a, b
cpi	70h ; 'p'
rnc
sui	1Fh
mov	b, a
call	sub_1A5F
ani	10h
jz	loc_19A1
lda	8DB2h
rrc
cmp	b
jc	loc_19A2

loc_19A1:
mov	a, b

loc_19A2:
sta	8DB0h
ret

loc_19A6:
cpi	1Bh
jz	loc_24C7
cpi	18h
jz	loc_2518
cpi	1Ah
jz	loc_2518
mvi	a, 1
sta	8D7Fh
jmp	loc_24C7

loc_19BD:
xra	a
sta	8D97h
lda	8D96h

loc_19C4:
ora	a
jm	loc_19CF
lxi	h, 101h
shld	8DB0h
ret

loc_19CF:
lda	8DAAh
rrc
inr	a
sta	8DB1h
mvi	a, 1
sta	8DB0h
ret
call	sub_268B
jm	loc_180B
cpi	2
jc	loc_180B
lda	8D97h
ora	a
jz	loc_19F0
dcr	b

loc_19F0:
lda	8DB0h
sub	b
jc	loc_19FA
jnz	loc_19FC

loc_19FA:
mvi	a, 1

loc_19FC:
sta	8DB0h
xra	a
sta	8D97h
ret
call	sub_268B
jm	loc_186B
ora	a
jz	loc_186B
cpi	85h ; 'Ö'
lda	8DB0h
jnc	loc_1A18
add	b
mov	b, a

loc_1A18:
call	sub_1A5F
ani	10h
lda	8DB2h
jz	loc_1A24
rrc

loc_1A24:
cmp	b
jc	loc_1A29
mov	a, b

loc_1A29:
sta	8DB0h
ret
lda	8D68h
ora	a
rnz
xra	a
sta	8D97h
lda	8DAAh
rrc
inr	a
mov	b, a
lda	8DB1h
cmp	b
jnz	loc_1A4D
lda	8DB8h
ral
jc	loc_17B8
jmp	loc_1792

loc_1A4D:
jnc	loc_1A53
cpi	1
rz

loc_1A53:
dcr	a
jmp	loc_17B2
mvi	c, 4
lxi	h, 3D6Eh
jmp	loc_1FE9



sub_1A5F:
push	d
push	h
lxi	h, 8E00h
lda	8DB1h
dcr	a
add	a
mov	e, a
mvi	d, 0
dad	d
mov	e, m
inx	h
mov	d, m
xchg
shld	8D71h
mov	a, m
pop	h
pop	d
ret
; End of function sub_1A5F


loc_1A78:
lda	8D7Eh
ora	a
jnz	loc_1A78
call	sub_268B
jm	loc_1AA8
push	psw
call	sub_268E
jm	loc_1AB4
pop	psw
cmp	b
rnc
rz
dcr	a
rlc
jp	loc_1A97
mvi	a, 0

loc_1A97:
mov	c, a
mov	a, b
dcr	a
rlc
cpi	2Fh ; '/'
rnc
sta	8DACh
mov	a, c
sta	8DAAh
jmp	loc_19BD

loc_1AA8:
xra	a
sta	8DAAh

loc_1AAC:
mvi	a, 2Eh ; '.'
sta	8DACh
jmp	loc_19BD

loc_1AB4:
pop	psw
dcr	a
rlc
jp	loc_1ABC
mvi	a, 0

loc_1ABC:
cpi	2Dh ; '-'
rnc
sta	8DAAh
jmp	loc_1AAC
mvi	c, 8
lxi	h, 3D82h
jmp	loc_1FE9
lda	8DA6h
ani	8
ori	1

loc_1AD4:
sta	8DA6h
ret
lda	8DA6h
ani	0FEh
jmp	loc_1AD4
mvi	a, 80h ; 'Ä'
jmp	loc_1AEC
mvi	a, 4
jmp	loc_1AEC
mvi	a, 2

loc_1AEC:
lxi	h, 8DA6h
ora	m
mov	m, a
ret



sub_1AF2:
lhld	8D71h
mov	m, b
lda	8DB2h
rrc
mov	c, a
lda	8DB0h
cmp	c
jc	loc_1B03
mov	a, c

loc_1B03:
push	psw
mov	a, c
inr	a
sta	8DB0h
call	sub_2488
call	sub_1F21
pop	psw
sta	8DB0h
ret
; End of function sub_1AF2




sub_1B14:
lda	8D68h
dcr	a
rnz
lda	8D53h
cpi	23h ; '#'
rnz
call	sub_24B7
call	sub_1A5F
xra	a
ret
; End of function sub_1B14

call	sub_1B14
rnz
mvi	b, 30h ; '0'
call	sub_1AF2
ret
call	sub_1B14
rnz
mvi	b, 35h ; '5'
call	sub_1AF2
ret
call	sub_1B14
rnz
lhld	8D71h
mov	a, m
ani	30h
rz
xra	a
mov	m, a
sta	8D97h
ret
call	sub_1B14
rnz
mvi	b, 10h
call	sub_1AF2
ret
lda	8D68h
ora	a
rnz



sub_1B5B:
lhld	8DB0h
lda	8D97h
ora	a
jz	loc_1B69
mov	a, h
ori	80h
mov	h, a

loc_1B69:
shld	8DEEh
lda	8DA6h
sta	8DF0h
lda	8D9Bh
ora	a
jz	loc_1B81
lda	8DF4h
ori	80h
jmp	loc_1B84

loc_1B81:
lda	8DF3h

loc_1B84:
sta	8DF1h
ret
; End of function sub_1B5B

lda	8D68h
dcr	a
jm	loc_1BB7
rnz
lda	8D53h
cpi	23h ; '#'
rnz
call	sub_1EE2
xra	a
sta	8DAAh
mvi	a, 2Eh ; '.'
sta	8DACh
lxi	h, 101h
shld	8DB0h
call	sub_2488
mvi	a, 45h ; 'E'
jnc	loc_1BB3
sta	8DB6h

loc_1BB3:
mov	b, a
jmp	loc_1F75

loc_1BB7:
lhld	8DEEh
mov	a, h
ana	a
jp	loc_1BC7
ani	7Fh
mov	h, a
mvi	a, 0FFh
jmp	loc_1BC8

loc_1BC7:
xra	a

loc_1BC8:
sta	8D97h
mvi	a, 50h ; 'P'
cmp	l
jp	loc_1BDB
lda	8DBBh
ani	40h
jnz	loc_1BDB
mvi	l, 50h ; 'P'

loc_1BDB:
shld	8DB0h
dcr	h
lda	8DACh
rrc
sub	h
jm	loc_1BF0
lda	8DAAh
rrc
inr	h
sub	h
jm	loc_1BF3

loc_1BF0:
call	sub_1EE2

loc_1BF3:
call	sub_1C13
lda	8DF0h
sta	8DA6h
lda	8DF1h
mov	b, a
ani	80h
sta	8D9Bh
mov	a, b
jz	loc_1C0F
ani	7Fh
sta	8DF4h
ret

loc_1C0F:
sta	8DF3h
ret



sub_1C13:
call	sub_1A5F
ani	10h
rz
lda	8DB2h
rrc
mov	b, a
lda	8DB0h
cmp	b
rc
mov	a, b
sta	8DB0h
ret
; End of function sub_1C13




sub_1C28:
mvi	m, 0
call	sub_1828
mov	b, a
mov	a, h
ori	10h
mov	h, a
mvi	c, 0F1h	; 'Ò'

loc_1C34:
dcx	h
mov	m, c
dcr	b
jnz	loc_1C34
ret
; End of function sub_1C28

di
lxi	h, 8D94h
inr	m
ei
ret
call	sub_1CAC
cpi	28h ; '('
mvi	a, 30h ; '0'

loc_1C49:
jz	loc_1C57
sta	8DF4h
lda	8D9Bh
ora	a
jnz	loc_1C5F
ret

loc_1C57:
sta	8DF3h
lda	8D9Bh
ora	a
rnz

loc_1C5F:
lda	8DA6h
ani	0F7h
sta	8DA6h
ret
call	sub_1CAC
cpi	28h ; '('
mvi	a, 31h ; '1'

loc_1C6F:
jz	loc_1C7D
sta	8DF4h
lda	8D9Bh
ora	a
jnz	loc_1C85
ret

loc_1C7D:
sta	8DF3h
lda	8D9Bh
ora	a
rnz

loc_1C85:
lda	8DA6h
ori	8
sta	8DA6h
ret
call	sub_1CAC
cpi	28h ; '('
mvi	a, 32h ; '2'
jmp	loc_1C6F
call	sub_1CAC
cpi	28h ; '('
mvi	a, 41h ; 'A'
jmp	loc_1C49
call	sub_1CAC
cpi	28h ; '('
mvi	a, 42h ; 'B'
jmp	loc_1C49



sub_1CAC:
lda	8D68h
dcr	a
jnz	loc_1CBC
lda	8D53h
cpi	28h ; '('
rz
cpi	29h ; ')'
rz

loc_1CBC:
pop	psw
ret
; End of function sub_1CAC

lda	8DB8h
ani	2
rz
xra	a
sta	8D9Bh
lda	8DF3h
jmp	loc_1CDA
lda	8DB8h
ani	2
rz
sta	8D9Bh
lda	8DF4h

loc_1CDA:
cpi	33h ; '3'
jnc	loc_1CED
cpi	30h ; '0'
jz	loc_1CED
lda	8DA6h
ori	8
sta	8DA6h
ret

loc_1CED:
lda	8DA6h
ani	0F7h
sta	8DA6h
ret
lda	8DB8h
ori	2
sta	8DB8h
jmp	loc_70B
mvi	a, 30h ; '0'
sta	8DF3h
ret
lda	8DB9h
ora	a
mvi	a, 41h ; 'A'
jm	loc_1D11
inr	a

loc_1D11:
sta	8DF3h
ret
lda	8D96h
ani	0FEh

loc_1D1A:
sta	8D96h
ret
lda	8D96h
ori	1
jmp	loc_1D1A
mvi	c, 5
lxi	h, 3D92h
jmp	loc_1FE9
di
lxi	h, 8DA1h
mov	a, m
ani	0F0h
mov	m, a
ei
ret
mvi	a, 8
jmp	loc_1D49
mvi	a, 4
jmp	loc_1D49
mvi	a, 2
jmp	loc_1D49
mvi	a, 1

loc_1D49:
lxi	h, 8DA1h
di
ora	m
mov	m, a
ei
ret
lda	8D68h
ora	a
rz
lda	8D53h
cpi	3Ah ; ':'
jc	loc_1D6D
sui	39h ; '9'
rlc
mov	e, a
mvi	d, 0
lxi	h, 3D3Ch
dad	d
mov	a, m
inx	h
mov	h, m
mov	l, a
pchl

loc_1D6D:
lhld	word_3D3C
pchl
lxi	h, 8D53h

loc_1D74:
call	sub_268E
rm
cpi	14h
jnz	loc_1D74
lda	8DB9h
ori	20h
sta	8DB9h
ret
lxi	h, 3D4Ah
shld	8DF6h
lxi	b, 0FF0Ah
lxi	h, 8D68h
dcr	m
lxi	h, 8D54h
jmp	loc_1FF1
lda	8D96h
ori	2
sta	8D96h
ret
push	h
mvi	a, 0Dh
sim
lda	8DBBh
ori	40h
sta	8DBBh
lda	8DEDh
ani	0BFh
sta	8DEDh
out	3Fh
mvi	a, 84h ; 'Ñ'

loc_1DBA:
sta	8DB2h
lxi	h, 101h
shld	8DB0h
lda	8DB8h
ani	10h
jnz	loc_1DD3
lxi	h, 8001h
mvi	a, 20h ; ' '
jmp	loc_1DD8

loc_1DD3:
lxi	h, 9001h
mvi	a, 1

loc_1DD8:
sta	8DB6h
shld	8DB4h
lxi	h, 8C78h
shld	8DAEh
xra	a
sta	8D7Eh
call	sub_720
mvi	a, 8
sim
pop	h
ret
lda	8DB8h
ori	80h
sta	8DB8h
ret
lda	8DB8h
ori	20h
sta	8DB8h
lda	8DEDh
ori	80h
sta	8DEDh
out	3Fh
ret
lda	8D96h
ori	80h
sta	8D96h
jmp	loc_19CF
lda	8DB9h
ori	40h
sta	8DB9h
ret
di
lda	8DB8h
ori	40h
sta	8DB8h
xra	a
sta	8D99h
ei
ret
lda	8DEDh
ori	4
sta	8DEDh
out	3Fh
lda	8DB9h
ori	10h
sta	8DB9h
ret
lda	8D68h
ora	a
rz
lda	8D53h
cpi	3Ah ; ':'
jc	loc_1E5E
sui	39h ; '9'
rlc
mov	e, a
mvi	d, 0
lxi	h, 3D1Ah
dad	d
mov	a, m
inx	h
mov	h, m
mov	l, a
pchl

loc_1E5E:
lhld	word_3D1A
pchl
lxi	h, 8D53h

loc_1E65:
call	sub_268E
rm
cpi	14h
jnz	loc_1E65
lda	8DB9h
ani	0DFh
sta	8DB9h
ret
lxi	h, 3D28h
shld	8DF6h
lxi	b, 0FF0Ah
lxi	h, 8D68h
dcr	m
lxi	h, 8D54h
jmp	loc_1FF1
lda	8D96h
ani	0FDh
sta	8D96h
ret
push	h
mvi	a, 0Dh
sim
lda	8DBBh
ani	0BFh
sta	8DBBh
lda	8DEDh
ori	40h
sta	8DEDh
out	3Fh
mvi	a, 50h ; 'P'
jmp	loc_1DBA
lda	8DB8h
ani	0FDh
sta	8DB8h
jmp	loc_70B

loc_1EB9:
lda	8D7Eh
ora	a
jnz	loc_1EB9
lda	8DB8h
ani	7Fh
sta	8DB8h
ret
lda	8DB8h
ani	0DFh
sta	8DB8h
lda	8DEDh
ani	7Fh
sta	8DEDh
out	3Fh
ret
call	sub_1EE2
jmp	loc_19C4



sub_1EE2:
lxi	h, 8D96h
mov	a, m
ani	7Fh
mov	m, a
ret
; End of function sub_1EE2

lxi	h, 8DB9h
mov	a, m
ani	0BFh
mov	m, a
ret
lxi	h, 8DB8h
mov	a, m
ani	0BFh
mov	m, a
ret
lda	8DB9h
ani	0EFh
sta	8DB9h
lda	8DEDh
ani	0FBh
sta	8DEDh
out	3Fh
ret
call	sub_2488
lxi	h, 3D0Eh

loc_1F13:
mvi	c, 3
jmp	loc_1FE9
call	sub_2488
lxi	h, 3D14h
jmp	loc_1F13



sub_1F21:
mvi	b, 20h ; ' '

loc_1F23:
call	sub_2664
lda	8DB0h
mov	c, a
lda	8DB2h
sub	c
inr	a
mov	c, a
; End of function sub_1F21




sub_1F30:
call	sub_1F3E
mvi	a, 0F1h	; 'Ò'

loc_1F35:
mov	m, b
stax	d
inx	h
inx	d
dcr	c
jnz	loc_1F35
ret
; End of function sub_1F30




sub_1F3E:
mov	a, h
adi	10h
mov	d, a
mov	e, l
ret
; End of function sub_1F3E


loc_1F44:
mvi	b, 20h ; ' '
call	sub_1F55
mov	e, m
inx	h
mov	d, m
xchg
inx	h
lda	8DB0h
mov	c, a
jmp	sub_1F30



sub_1F55:
lda	8DB1h
dcr	a
rlc
mov	e, a
mvi	d, 0
lxi	h, 8E00h
dad	d
ret
; End of function sub_1F55




sub_1F62:
mvi	b, 20h ; ' '
call	sub_1F55
mov	e, m
inx	h
mov	d, m
xchg
inx	h
lda	8DB2h
mov	c, a
jmp	sub_1F30
; End of function sub_1F62

mvi	b, 20h ; ' '

loc_1F75:
lda	8DB1h
cpi	18h
jz	loc_1F86
lxi	h, 8E2Eh
cma
adi	19h
call	sub_1FD0

loc_1F86:
lda	8DB0h
dcr	a
jnz	loc_1F23
call	sub_1FBD
jmp	loc_1F23
mvi	b, 20h ; ' '
lda	8DB1h
cpi	1
jz	loc_1FA9
call	sub_1F55
dcx	h
dcx	h
lda	8DB1h
dcr	a
call	sub_1FD0

loc_1FA9:
lda	8DB1h
dcr	a
call	sub_2268
lda	8DB0h
cmp	d
jnz	loc_1F44
call	sub_1FBD
jmp	loc_1F44



sub_1FBD:
call	sub_1A5F
lhld	8D71h
mvi	m, 0
ret
; End of function sub_1FBD

mvi	b, 20h ; ' '
lxi	h, 8E2Eh
mvi	a, 18h
jmp	sub_1FD0



sub_1FD0:
push	h
push	psw
mov	e, m
inx	h
mov	d, m
xchg
mvi	m, 0
inx	h
lda	8DB2h
mov	c, a
call	sub_1F30
pop	psw
pop	h
dcx	h
dcx	h
dcr	a
jnz	sub_1FD0
ret
; End of function sub_1FD0


loc_1FE9:
mvi	b, 0FFh
shld	8DF6h
lxi	h, 8D53h

loc_1FF1:
mov	d, c
call	sub_268E
mov	c, d
jm	loc_2053
cmp	c
jnc	loc_1FF1
sta	8D53h
push	b
lda	8D68h
mov	e, l
mov	d, h

loc_2006:
mov	c, m
inx	h
dcr	a
mov	b, m
push	b
inx	h
dcr	a
jz	loc_2013
jp	loc_2006

loc_2013:
lda	8D68h
push	psw
push	d
lhld	8DF6h
lda	8D53h
rlc
mvi	d, 0
mov	e, a
dad	d
mov	e, m
inx	h
mov	d, m
xchg
call	sub_205E
pop	h
pop	psw
sta	8D68h
mvi	d, 0
mov	e, a
dcr	e
dad	d
pop	b
ora	a
jz	loc_204D
rrc
lda	8D68h
jc	loc_2043

loc_2040:
mov	m, b
dcx	h
dcr	a

loc_2043:
mov	m, c
dcr	a
jz	loc_204D
dcx	h
pop	b
jmp	loc_2040

loc_204D:
pop	b
mvi	b, 0
jmp	loc_1FF1

loc_2053:
mov	a, b
cpi	0FFh
rnz
lhld	8DF6h
mov	a, m
inx	h
mov	h, m
mov	l, a



sub_205E:
pchl
; End of function sub_205E

lxi	h, 3D5Eh
mvi	c, 8
jmp	loc_1FE9
mvi	a, 1
sta	8D7Fh
lda	8DB8h
ani	2
mov	a, b
jnz	loc_2096
cpi	1Bh
jz	loc_17D9
lda	8D82h
ana	a
jz	sub_2123
mov	a, b
cpi	58h ; 'X'
jz	loc_20E3
push	b
mvi	b, 1Bh
call	sub_2123
pop	b
call	sub_2123
xra	a
sta	8D82h
ret

loc_2096:
cpi	20h ; ' '
jnc	loc_20AD
cpi	18h
jz	loc_17E2
cpi	1Ah
jz	loc_17E2
cpi	1Bh
jz	loc_17D9
jmp	sub_2123

loc_20AD:
lda	8D82h
ora	a
jz	sub_2123
mov	a, b
jm	loc_20C5
cpi	30h ; '0'
jc	loc_24C7
cpi	5Bh ; '['
jz	loc_24C7
jmp	loc_20F8

loc_20C5:
cpi	40h ; '@'
jc	loc_24C7
cpi	69h ; 'i'
jnz	loc_20F8
lda	8D68h
mov	c, a
lxi	h, 8D53h

loc_20D6:
push	b
call	sub_268E
pop	b
jm	loc_20F4
cpi	4
jnz	loc_20D6

loc_20E3:
xra	a
sta	8D7Fh
sta	8D82h
lxi	h, 8DB3h
mov	a, m
ani	0FBh
mov	m, a
out	9
ret

loc_20F4:
mov	a, c
sta	8D68h

loc_20F8:
push	b
mvi	b, 1Bh
call	sub_2123
lda	8D82h
rlc
jnc	loc_210A
mvi	b, 5Bh ; '['
call	sub_2123

loc_210A:
lda	8D68h
mov	c, a
lxi	d, 8D53h

loc_2111:
ldax	d
mov	b, a
inx	d
dcr	c
jm	loc_211E
call	sub_2123
jmp	loc_2111

loc_211E:
pop	b
xra	a
sta	8D82h



sub_2123:
lda	8DB3h
rlc
jc	sub_2123

loc_212A:
lda	8D78h
ora	a
jnz	loc_212A
di
inr	a
sta	8D78h
lxi	h, 8D6Bh
shld	8D6Eh
mov	m, b
lda	8DB3h
ori	1
sta	8DB3h
out	9
ei
ret
; End of function sub_2123

mvi	a, 1
sta	8D7Fh
lxi	h, 2067h
shld	8D80h
in	8
lxi	h, 2169h
shld	8DF8h
di
lda	8DB3h
ori	4
sta	8DB3h
out	9
ei
ret
in	8
ani	7Fh
cpi	11h
jz	loc_217F
cpi	13h
jnz	loc_529
lda	8DB3h
ori	80h
jmp	loc_2184

loc_217F:
lda	8DB3h
ani	7Fh

loc_2184:
sta	8DB3h
jmp	loc_529
lxi	h, 2169h
lxi	d, 8D6Bh
call	sub_21C4
call	sub_229F
jz	loc_21B7
mov	c, a
xra	a
mov	b, a

loc_219C:
push	b
call	sub_2268
call	sub_2281
inr	b
dcr	b
jz	loc_21AD
mvi	c, 0
call	sub_21F3

loc_21AD:
call	sub_2253
pop	b
inr	b
mov	a, b
dcr	c
jp	loc_219C

loc_21B7:
di
lda	8DB3h
ani	0FBh
sta	8DB3h
out	9
ei
ret



sub_21C4:
lda	8D78h
ora	a
jnz	sub_21C4
in	8
di
shld	8DF8h
lda	8DB3h
ori	4
sta	8DB3h
out	9
ei
xchg
shld	8D6Eh
ret
; End of function sub_21C4

lxi	h, 2169h
lxi	d, 8D6Bh
call	sub_21C4
lda	8DB1h
dcr	a
mvi	c, 0
jmp	loc_219C



sub_21F3:
lda	8DB3h
rlc
jc	sub_21F3

loc_21FA:
lda	8D78h
ora	a
jnz	loc_21FA
mov	a, m
ani	7Fh
inr	c
dcr	c
cz	sub_2223
di
sta	8D6Bh
mvi	a, 1
sta	8D78h
lda	8DB3h
ori	1
sta	8DB3h
out	9
ei
inx	h
dcr	b
jnz	sub_21F3
ret
; End of function sub_21F3




sub_2223:
cpi	20h ; ' '
rnc

loc_2226:
cpi	14h
mov	c, a
jnz	loc_2234
lda	8DB9h
ani	80h
mvi	a, 23h ; '#'
rnz

loc_2234:
call	sub_1F3E
ldax	d
ani	8
mov	a, c
mvi	c, 0
jz	loc_2248
ori	60h
cpi	7Fh ; ''
rnz
mvi	a, 5Fh ; '_'
ret

loc_2248:
push	h
lxi	h, 3D9Ch
mvi	d, 0
mov	e, a
dad	d
mov	a, m
pop	h
ret
; End of function sub_2223




sub_2253:
lxi	h, 225Ch
lxi	b, 0CF0h
jmp	sub_21F3
; End of function sub_2253

dcr	c
ldax	b
mov	a, a
mov	a, a
mov	a, a
mov	a, a
mov	a, a
mov	a, a
mov	a, a
mov	a, a
mov	a, a
mov	a, a



sub_2268:
rlc
mov	e, a
mvi	d, 0
lxi	h, 8E00h
dad	d
mov	e, m
inx	h
mov	d, m
xchg
mov	a, m
ani	10h
lda	8DB2h
jz	loc_227E
rrc

loc_227E:
mov	d, a
inx	h
ret
; End of function sub_2268




sub_2281:
push	h
lxi	b, 0

loc_2285:
mov	a, m
ani	7Fh
cpi	20h ; ' '
jz	loc_229A
mov	a, c
add	b
mov	b, a
inr	b
mvi	c, 0
inx	h

loc_2294:
dcr	d
jnz	loc_2285
pop	h
ret

loc_229A:
inr	c
inx	h
jmp	loc_2294
; End of function sub_2281




sub_229F:
mvi	a, 17h

loc_22A1:
push	psw
call	sub_2268
call	sub_2281
pop	psw
inr	b
dcr	b
rnz
dcr	a
jp	loc_22A1
xra	a
ret
; End of function sub_229F




sub_22B2:
lda	8D7Ah
ora	a
jnz	loc_22C2
inr	a
sta	8D7Ah
mov	a, b
sta	8D4Ah
ret

loc_22C2:
mov	a, b
cpi	6
jz	loc_22CD
cpi	8
jnz	loc_22EA

loc_22CD:
lda	8D7Ah
mov	e, a
lxi	h, 8D4Ah
mvi	d, 0
dad	d
dcx	h

loc_22D8:
mov	a, m
cpi	8
jz	loc_22E3
cpi	6
jnz	loc_22E5

loc_22E3:
mov	m, b
ret

loc_22E5:
dcx	h
dcr	e
jnz	loc_22D8

loc_22EA:
lda	8D7Ah
mov	e, a
mvi	d, 0
lxi	h, 8D4Ah

loc_22F3:
mov	a, m
cmp	b
rz
jnc	loc_2306
inr	d
mov	a, d
inx	h
cmp	e
jnz	loc_22F3

loc_2300:
mov	m, b
inr	a
sta	8D7Ah
ret

loc_2306:
mov	a, e
sub	d
lxi	h, 8D4Ah
mvi	d, 0
dad	d

loc_230E:
dcx	h
mov	d, m
inx	h
mov	m, d
dcx	h
dcr	a
jnz	loc_230E
mov	a, e
jmp	loc_2300
; End of function sub_22B2

lxi	h, 8DCFh
lda	8DCEh
jmp	loc_239C
mvi	b, 0
jmp	sub_22B2
lda	8D68h
ora	a
rnz

loc_232E:
mvi	b, 4
jmp	sub_22B2
call	sub_268B
jm	loc_232E
ora	a
jz	loc_232E
ret
call	sub_268B
jm	loc_2350
ora	a
jz	loc_2350
cpi	1
rnz
mvi	b, 8
jmp	sub_22B2

loc_2350:
mvi	b, 6
jmp	sub_22B2
lxi	h, 8D53h

loc_2358:
call	sub_268E
rm
cpi	5
jz	loc_2370
cpi	6
jnz	loc_2358
mvi	b, 0Ah

loc_2368:
push	h
call	sub_22B2
pop	h
jmp	loc_2358

loc_2370:
mvi	b, 2
jmp	loc_2368
lda	8DFAh
ora	a
mvi	a, 4
lxi	h, 3DC6h
jz	loc_239C
lxi	h, 3DCAh
jmp	loc_239C
lda	8DB8h
ani	2
jz	loc_2397
lxi	h, 3DBCh
mvi	a, 7
jmp	loc_239C

loc_2397:
lxi	h, 3DC3h
mvi	a, 3

loc_239C:
shld	8D48h

loc_239F:
lxi	h, 8D86h
mov	m, a
shld	8DA7h
mvi	a, 0FFh
sta	8D89h
lda	8DA9h
ori	1
sta	8DA9h
out	1
ret
call	sub_24AA
mvi	m, 32h ; '2'
jmp	loc_23C3
call	sub_24AA
mvi	m, 33h ; '3'

loc_23C3:
call	sub_2445
lda	8DB9h
mov	b, a
ani	4
jz	loc_23DB
mov	a, b
ani	8
mvi	a, 34h ; '4'
jz	loc_23DD
inr	a
jmp	loc_23DD

loc_23DB:
mvi	a, 31h ; '1'

loc_23DD:
call	sub_2444
mov	a, b
ani	2
mvi	a, 31h ; '1'
jnz	loc_23E9
inr	a

loc_23E9:
call	sub_2444
lda	8DBCh
mov	e, a
ani	0F0h
rrc
call	sub_244A
mvi	m, 3Bh ; ';'
inx	h
mov	a, e
mov	e, c
ani	0Fh
rlc
rlc
rlc
call	sub_244A
mvi	m, 3Bh ; ';'
inx	h
mvi	m, 31h ; '1'
call	sub_2445
mvi	m, 30h ; '0'
inx	h
mvi	m, 78h ; 'x'
mov	a, e
add	c
adi	0Eh
jmp	loc_239F
call	sub_24AA
lda	8DB1h
mov	b, a
lda	8D96h
ora	a
jp	loc_242D
lda	8DAAh
rar
mov	c, a
mov	a, b
sub	c
mov	b, a

loc_242D:
mov	a, b
call	sub_244A
mov	e, c
mvi	m, 3Bh ; ';'
inx	h
lda	8DB0h
call	sub_244A
mov	a, c
add	e
adi	4
mvi	m, 52h ; 'R'
jmp	loc_239F



sub_2444:
mov	m, a
; End of function sub_2444




sub_2445:
inx	h
mvi	m, 3Bh ; ';'
inx	h
ret
; End of function sub_2445




sub_244A:
lxi	b, 0

loc_244D:
cpi	64h ; 'd'
jc	loc_2458
sui	64h ; 'd'
inr	b
jmp	loc_244D

loc_2458:
dcr	b
jm	loc_2464
mov	d, a
mov	a, b
adi	31h ; '1'
mov	m, a
inx	h
inr	c
mov	a, d

loc_2464:
mvi	b, 0

loc_2466:
cpi	0Ah
jc	loc_2471
sui	0Ah
inr	b
jmp	loc_2466

loc_2471:
mov	d, a
dcr	b
jp	loc_247B
mov	a, c
ora	a
jz	loc_2481

loc_247B:
mov	a, b
adi	31h ; '1'
mov	m, a
inx	h
inr	c

loc_2481:
mov	a, d
adi	30h ; '0'
mov	m, a
inx	h
inr	c
ret
; End of function sub_244A




sub_2488:
call	sub_24B7
di
lhld	8DB4h
xchg
call	sub_2664
mov	a, d
ani	10h
add	h
mov	h, a
call	sub_283
mov	a, h
cpi	90h ; 'ê'
mvi	a, 20h ; ' '
jc	loc_24A5
mvi	a, 0F1h	; 'Ò'

loc_24A5:
sta	8DB6h
ei
ret
; End of function sub_2488




sub_24AA:
lxi	h, 8E30h
shld	8D48h
mvi	m, 1Bh
inx	h
mvi	m, 5Bh ; '['
inx	h
ret
; End of function sub_24AA




sub_24B7:
ei

loc_24B8:
lda	8D7Eh
ora	a
jnz	loc_24B8
ret
; End of function sub_24B7




sub_24C0:

; FUNCTION CHUNK AT 2518 SIZE 00000064 BYTES

lda	8D7Fh
ora	a
jnz	loc_256B

loc_24C7:
mov	a, b
cpi	7Fh ; ''
jz	loc_2518
cpi	20h ; ' '
jc	loc_2563
lda	8D82h
ora	a
jz	sub_257C
mov	c, a
lda	8DB8h
ani	2
jz	loc_2557
mov	a, c
ora	a
jm	loc_2504
mov	a, b
sui	30h ; '0'
jm	loc_253C
lxi	h, 3BCEh

loc_24F0:
rlc
mov	c, a
lda	8D83h
ora	a
jnz	sub_2510
sta	8D82h

loc_24FC:
mvi	b, 0
dad	b
mov	a, m
inx	h
mov	h, m
mov	l, a
pchl

loc_2504:
mov	a, b
sbi	40h ; '@'
jm	loc_2525
lxi	h, 3C6Eh
jmp	loc_24F0
; End of function sub_24C0




sub_2510:
xra	a
sta	8D82h
sta	8D83h
ret
; End of function sub_2510

; START	OF FUNCTION CHUNK FOR sub_24C0

loc_2518:
lda	8DBBh
ora	a
rm

loc_251D:
call	sub_2510
mvi	b, 1
jmp	sub_257C

loc_2525:
mov	a, b
cpi	30h ; '0'
jc	loc_2551
cpi	3Ah ; ':'
jc	loc_253C
cpi	3Bh ; ';'
jz	loc_253C
lda	8D68h
ora	a
jnz	loc_2551

loc_253C:
lda	8D68h
cpi	15h
jz	loc_2551
mov	e, a
inr	a
sta	8D68h
mvi	d, 0
lxi	h, 8D53h
dad	d
mov	m, b
ret

loc_2551:
mvi	a, 0FFh
sta	8D83h
ret

loc_2557:
lxi	h, 3B2Eh
mov	a, b
sui	30h ; '0'
jp	loc_24F0
jmp	loc_2551

loc_2563:
lxi	h, 3AEEh
rlc
mov	c, a
jmp	loc_24FC

loc_256B:
lxi	h, 8D50h
mvi	d, 0
dcr	a
mov	e, a
dad	d
mov	m, b
sta	8D7Fh
rnz
lhld	8D80h
pchl
; END OF FUNCTION CHUNK	FOR sub_24C0



sub_257C:

; FUNCTION CHUNK AT 267B SIZE 00000010 BYTES

lda	8DB9h
ani	40h
jz	loc_25B3
lda	8D97h
ora	a
jz	loc_25B3
lda	8DB0h
mov	c, a
call	sub_1A5F
ani	10h
jz	loc_259E
lda	8DB2h
rrc
jmp	loc_25A1

loc_259E:
lda	8DB2h

loc_25A1:
cmp	c
jnz	loc_25AF
push	b
call	sub_176D
mvi	a, 1
sta	8DB0h
pop	b

loc_25AF:
xra	a
sta	8D97h

loc_25B3:
call	sub_2664
lda	8D9Bh
ora	a
lda	8DF3h
jz	loc_25C3
lda	8DF4h

loc_25C3:
cpi	41h ; 'A'
jz	loc_25E4
jnc	loc_25EC
mov	d, a
mov	a, b
cpi	5Fh ; '_'
jc	loc_25EC
mov	a, d
cpi	30h ; '0'
jz	loc_267B
cpi	32h ; '2'
jnz	loc_25EC
mov	a, b
ani	1Fh
mov	b, a
jmp	loc_25EC

loc_25E4:
mov	a, b
cpi	23h ; '#'
jnz	loc_25EC
mvi	b, 14h

loc_25EC:
lda	8DA6h
mov	c, a
ani	80h
ora	b
; End of function sub_257C




sub_25F3:
di
mov	m, a
mov	b, a
lda	8DB4h
cmp	l
jnz	loc_2612
lda	8DB5h
ani	0EFh
cmp	h
jnz	loc_2612
lda	8DB8h
ani	10h
jnz	loc_262D
mov	a, b

loc_260F:
sta	8DB6h

loc_2612:
mov	a, h
ori	10h
mov	h, a
mov	m, c
ei
lda	8DB0h
mov	b, a
lda	8DB2h
cmp	b
jnz	loc_2631

loc_2623:
lda	8DB9h
ani	40h
rz
sta	8D97h
ret

loc_262D:
mov	a, c
jmp	loc_260F

loc_2631:
rrc
cmp	b
jnz	loc_2641
call	sub_1A5F
ani	10h
jz	loc_265C
jmp	loc_2623

loc_2641:
rlc
sbi	8
cmp	b
jnz	loc_265C
di
lda	8D95h
ora	a
jz	loc_265B
lda	8D94h
inr	a
sta	8D94h
xra	a
sta	8D95h

loc_265B:
ei

loc_265C:
lda	8DB0h
inr	a
sta	8DB0h
ret
; End of function sub_25F3




sub_2664:
lxi	h, 8E00h
lda	8DB1h
dcr	a
rlc
mov	l, a
mov	a, m
inx	h
mov	h, m
mov	l, a
lda	8DB0h
add	l
jnc	loc_2679
inr	h

loc_2679:
mov	l, a
ret
; End of function sub_2664

; START	OF FUNCTION CHUNK FOR sub_257C

loc_267B:
xchg
mov	a, b
sui	5Fh ; '_'
lxi	h, 3CEEh
mov	c, a
mvi	b, 0
dad	b
mov	b, m
xchg
jmp	loc_25EC
; END OF FUNCTION CHUNK	FOR sub_257C



sub_268B:
lxi	h, 8D53h
; End of function sub_268B




sub_268E:
lda	8D68h
dcr	a
rm
mvi	b, 0

loc_2695:
mov	a, m
inx	h
cpi	3Bh ; ';'
jz	loc_26BD
sui	30h ; '0'
mov	c, a
mov	a, b
cpi	19h
jnc	loc_26B8
rlc
mov	b, a
rlc
rlc
add	b
add	c
mov	b, a

loc_26AC:
lda	8D68h
dcr	a
sta	8D68h
jnz	loc_2695
mov	a, b
ret

loc_26B8:
mvi	b, 0FFh
jmp	loc_26AC

loc_26BD:
lda	8D68h
dcr	a
sta	8D68h
mov	a, b
ret
; End of function sub_268E


loc_26C6:
ei

loc_26C7:
lda	8D7Bh
ora	a
jnz	loc_26F4
lda	8D89h
ora	a
jnz	loc_26F4
lda	8D7Ah
dcr	a
jm	loc_276A
sta	8D7Ah
lxi	h, 8D4Ah
mov	e, a
mvi	d, 0
dad	d
mov	e, m
lxi	h, 3D76h
dad	d
mov	e, m
inx	h
mov	h, m
mov	l, e
lxi	d, 26F4h
push	d
pchl

loc_26F4:
lda	8D85h
ora	a
jnz	loc_2758
lda	8D77h
ora	a
jz	loc_26C7
lda	8D79h
ora	a
jnz	loc_274B
di

loc_270A:
lda	8D77h
dcr	a
sta	8D77h
lhld	8D9Fh
ei
mov	b, m
mov	a, l

loc_2717:
inr	a
ani	3Fh
sta	8D9Fh
lda	8D84h
ora	a
jnz	loc_2744

loc_2724:
call	sub_24C0
lda	8D77h
cpi	11h
jnc	loc_26C7
di
lda	8D7Ch
ora	a
jz	loc_26C6
lda	8D92h
ora	a
mvi	a, 11h
cz	sub_4B5
ei
jmp	loc_26C7

loc_2744:
mov	a, b
sta	8D85h
jmp	loc_26C7

loc_274B:
mvi	b, 1
call	sub_257C
di
xra	a
sta	8D79h
jmp	loc_270A

loc_2758:
lda	8D84h
ora	a
jnz	loc_26C7
lda	8D85h
mov	b, a
xra	a
sta	8D85h
jmp	loc_2724

loc_276A:
lda	8D86h
ora	a
jz	loc_27A8
lda	8DBBh
rlc
jc	loc_279E
lda	8DBAh
ani	20h
cnz	sub_27B5
lxi	h, 8D86h
shld	8DA7h
lxi	h, 8CFDh
shld	8D48h
mvi	a, 0FFh
sta	8D89h
lda	8DA9h
ori	1
sta	8DA9h
out	1
jmp	loc_26F4

loc_279E:
call	sub_27B5
xra	a
sta	8D86h
jmp	loc_26F4

loc_27A8:
lda	8D87h
dcr	a
jm	loc_26F4
call	sub_121E
jmp	loc_26F4



sub_27B5:
lda	8CFDh
mov	b, a
call	sub_27D6
lda	8D86h
cpi	1
rz
lda	8CFEh
mov	b, a
call	sub_24C0
lda	8D86h
cpi	2
rz
lda	8CFFh
mov	b, a
jmp	sub_24C0
; End of function sub_27B5




sub_27D6:
cpi	7Fh ; ''
rz
call	sub_24C0
ret
; End of function sub_27D6

nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7

loc_2A38:
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7

loc_2E0E:
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7

loc_3030:
rst	7
rst	7
rst	7
rst	7

loc_3034:
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7

loc_3323:
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
rst	7
ana	l
ana	l
ana	l
ana	l
add	b
add	b
add	b
add	b
add	c
add	c
add	c
add	c
add	d
add	d
add	d
add	d
add	e
add	e
add	e
add	e
add	h
add	h
add	h
add	h
add	l
add	l
add	l
add	l
add	m
add	m
add	m
add	m
add	a
add	a
add	a
add	a
dcx	d
dcx	d
dcx	d
dcx	d
lxi	h, 2131h
lxi	sp, 3240h
mov	b, b
sta	loc_3323
inx	h
inx	sp
inr	h
inr	m
inr	h
inr	m
dcr	h
dcr	m
dcr	h
dcr	m
ana	d
ana	d
ana	d
ana	d
dad	h
sim
dad	h
sim
mov	e, a
dcr	l
mov	e, a
dcr	l
dcx	h
dcr	a
dcx	h
dcr	a
mov	a, m
mov	h, b
mvi	e, 1Eh
dsub
dsub
dsub
dsub
sub	a
sub	a
sub	a
sub	a
sbb	b
sbb	b
sbb	b
sbb	b
sbb	c
sbb	c
sbb	c
sbb	c
sbb	d
sbb	d
sbb	d
sbb	d
dad	b
dad	b
dad	b
dad	b
mov	d, c
rnz
ana	h
ana	h
ldhi	39h ; '9'
ldhi	39h ; '9'
lhld	loc_2A38
ldsi	26h ; '&'
stc
mvi	h, 37h ; '7'
mov	e, m
mvi	m, 5Eh ; '^'
mvi	m, 52h ; 'R'
pop	b
stax	d
stax	d
mov	c, a
cmp	m
rrc
rrc
mov	d, b
cmp	a
arhl
arhl
mov	a, e
mov	e, e
dcx	d
dcx	d
mov	a, l
mov	e, l
dcr	e
dcr	e
mov	a, a
mov	a, a
mov	a, a
mov	a, a
sub	h
sub	h
sub	h
sub	h
sub	l
sub	l
sub	l
sub	l
sub	m
sub	m
sub	m
sub	m
sbb	e
sbb	e
sbb	e
sbb	e
mov	b, l
ora	h
dcr	b
dcr	b
mov	d, a
adi	17h
ral
mov	c, c
cmp	b
dad	b
dad	b
mov	d, l
cnz	loc_1515
mov	e, c
rz
dad	d
dad	d
mov	d, h
jmp	locret_1414
mov	b, h
ora	e
inr	b
inr	b
mov	c, e
cmp	d
dcx	b
dcx	b
mov	c, h
cmp	e
inr	c
inr	c
cmc
cma
rar
rar
rst	7
rst	7
rst	7
rst	7
ldax	b
ldax	b
ldax	b
ldax	b
sub	c
sub	c
sub	c
sub	c
sub	d
sub	d
sub	d
sub	d
sub	e
sub	e
sub	e
sub	e
sbb	l
sbb	l
sbb	l
sbb	l
rim
rim
nop
nop
mov	b, c
ora	b
lxi	b, 4A01h
cmp	c
ldax	b
ldax	b
mov	c, b
ora	a
dsub
dsub
mov	b, a
ora	m
rlc
rlc
mov	b, m
ora	l
mvi	b, 6
mov	e, b
rst	0
rdel
rdel
mov	c, l
cmp	h
dcr	c
dcr	c
inr	a
inr	l
inr	a
inr	l
lda	byte_3A3B
dcx	sp
shld	loc_2226+1
daa
dcr	c
dcr	c
dcr	c
dcr	c
sub	b
sub	b
sub	b
sub	b
sbb	h
sbb	h
sbb	h
sbb	h
mov	a, h
mov	e, h
inr	e
inr	e
ana	c
ana	b
ana	m
ana	m
mvi	a, 2Eh ; '.'
mvi	a, 2Eh ; '.'
mov	e, d
ret
.db  1Ah
.db 1Ah, 4Eh, 0BDh, 0Eh, 0Eh, 42h, 0B1h
.db 2, 2, 56h, 0C5h, 16h, 16h, 43h, 0B2h
.db 3, 3, 53h, 0C2h, 0A3h, 0A3h, 0FFh, 0FFh
.db 0FFh, 0FFh,	0FFh, 0FFh, 0FFh, 0FFh,	0D0h
.db 0D1h, 0FFh,	0FFh, 0FFh, 0FFh, 0FFh,	0FFh
.db 41h, 42h, 44h, 43h,	50h, 51h, 52h, 53h
.db 70h, 71h, 72h, 73h,	74h, 75h, 76h, 77h
.db 78h, 79h, 6Dh, 6Ch,	6Eh, 4Dh, 2Eh, 13h
.db 29h, 13h, 0F0h, 12h, 1Ch, 13h, 25h,	13h
.db 0B2h, 9, 52h, 13h, 56h, 11h, 56h, 11h
.db 56h, 11h, 56h, 11h
aAbcdefghijklmn:.text "abcdefghijklmnopqrstuvwxyz"
.db 0
.db 0, 0, 0, 0,	0, 0E1h, 21h, 8Ah, 21h,	27h
.db 18h, 27h, 18h, 27h,	18h, 0C2h, 11h,	0C2h
.db 11h, 0Eh, 12h, 0F7h, 11h, 0F7h, 11h
.db 0C2h, 11h, 6Dh, 12h, 0ACh, 12h, 27h
.db 18h, 27h, 18h, 27h,	18h, 0E0h, 12h,	81h
.db 8Ah, 90h, 9Ah, 0C5h, 0D3h, 0D2h, 0Eh
.db 0AFh, 0Ch, 17h, 0Ch, 0BDh, 0Ch, 0A8h
.db 0Ch, 0Bh, 18h, 6Bh,	18h, 27h, 0Fh, 87h
.db 0Fh, 0D0h, 0Ch, 83h, 0Ch, 5Ch, 0Ch,	0
.db 0, 71h, 16h, 5Ch, 0Ch, 0CEh, 0Eh, 0E3h
.db 0Ch, 0Bh, 0Dh, 0ADh, 0Dh, 75h, 14h,	4
.db 5, 53h, 6, 7, 8, 9,	16h, 17h, 18h, 19h
.db 26h, 27h, 28h, 29h,	36h, 37h, 38h, 39h
.db 46h, 47h, 10h, 49h,	25h, 0,	9, 0, 6
.db 17h, 4, 59h, 3, 0, 3, 40h, 2, 80h, 1
.db 0C0h, 0, 60h, 0, 40h, 0, 3Ah, 0, 30h
.db 0, 20h, 0, 18h, 0, 0Ch, 0, 6, 0, 20h
.db 20h, 20h, 35h, 30h,	20h, 20h, 20h, 37h
.db 35h, 20h, 20h, 31h,	31h, 30h, 31h, 33h
.db 34h, 2Eh, 35h, 20h,	20h, 31h
byte_3A3B:.db 35h
sim
rim
rim
sta	loc_3030
rim
rim
inx	sp
sim
sim
rim
rim
mvi	m, 30h ; '0'
sim
rim
lxi	sp, 3032h
sim
rim
lxi	sp, 3038h
sim
rim
sta	loc_3030
sim
rim
sta	loc_3034
sim
rim
inx	sp
mvi	m, 30h ; '0'
sim
rim
inr	m
ldsi	30h ; '0'
sim
rim
dad	sp
mvi	m, 30h ; '0'
sim
lxi	sp, 3239h
sim
sim
push	d
arhl
dcx	b
rlc
ldax	d
mvi	c, 5Ch ; '\'
inr	c
mov	e, h
inr	c
inx	h
mvi	c, 0BEh	; 'æ'
mvi	c, 5Ch ; '\'
inr	c
jmp	loc_2E0E
mvi	c, 2Eh ; '.'
mvi	c, 62h ; 'b'
mvi	c, 6Bh ; 'k'
mvi	c, 5Ch ; '\'
inr	c
mov	e, h
inr	c
dcx	b
rlc
mov	e, h
inr	c
hlt
mvi	c, 76h ; 'v'
mvi	c, 9Fh ; 'ü'
mvi	c, 5Ch ; '\'
inr	c
mov	e, h
inr	c
xra	b
mvi	c, 0B3h	; '≥'
mvi	c, 1
stax	b
inr	b
dsub
arhl
rim
mov	b, b
add	b
mov	d, e
mov	b, l
mov	d, h
rim
mov	d, l
mov	d, b
rim
mov	b, c
rim
dcr	l
rim
mov	d, h
mov	c, a
rim
mov	b, l
mov	e, b
mov	c, c
mov	d, h
rim
mov	d, b
mov	d, d
mov	b, l
mov	d, e
mov	d, e
rim
daa
mov	d, e
mov	b, l
mov	d, h
dcr	l
mov	d, l
mov	d, b
daa
rim
rim
rim
rim
rim
rim
rim
rim
rim
rim
rim
rim
rim
rim
rim
rim
rim
rim
rim
rim
rim
rim
rim
rim
rim
rim
rim
rim
rim
rim
rim
rim
rim
daa
rdel
daa
rdel
daa
rdel
daa
rdel
daa
rdel
inr	h
inx	h
daa
rdel
dcx	sp
inr	e
dcx	b
rdel
mov	m, c
mvi	d, 6Dh ; 'm'
ral
mov	l, l
ral
mov	l, l
ral
mvi	e, 18h
aci	1Ch
cmp	m
inr	e
daa
rdel
jp	loc_2717
rdel
pchl
.db  17h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db 0E2h ; ‚
.db  17h
.db  27h ; '
.db  18h
.db 0E2h ; ‚
.db  17h
.db 0D9h ; Ÿ
.db  17h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db 0F6h ; ˆ
.db  1Ch
.db  1Eh
.db  1Dh
.db  15h
.db  1Dh
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  36h ; 6
.db  18h
.db  50h ; P
.db  18h
.db  6Bh ; k
.db  18h
.db  0Bh
.db  18h
.db  27h ; '
.db  18h
.db    1
.db  1Dh
.db    7
.db  1Dh
.db 0BDh ; Ω
.db  19h
.db  2Dh ; -
.db  1Ah
.db  18h
.db  1Fh
.db  0Dh
.db  1Fh
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db 0E1h ; ·
.db  21h ; !
.db  49h ; I
.db  21h ; !
.db  27h ; '
.db  18h
.db  49h ; I
.db  19h
.db  29h ; )
.db  23h ; #
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  8Ah ; ä
.db  21h ; !
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  42h ; B
.db  1Ch
.db  68h ; h
.db  1Ch
.db  8Eh ; é
.db  1Ch
.db  27h ; '
.db  1Bh
.db  31h ; 1
.db  1Bh
.db  3Bh ; ;
.db  1Bh
.db  4Ch ; L
.db  1Bh
.db  56h ; V
.db  1Bh
.db  88h ; à
.db  1Bh
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  1Eh
.db  1Dh
.db  15h
.db  1Dh
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  98h ; ò
.db  1Ch
.db 0A2h ; ¢
.db  1Ch
.db  27h ; '
.db  18h
.db  65h ; e
.db  17h
.db    0
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  38h ; 8
.db  17h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  2Dh ; -
.db  1Ah
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  29h ; )
.db  23h ; #
.db 0F6h ; ˆ
.db  17h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db    0
.db    0
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  27h ; '
.db  18h
.db  88h ; à
.db  18h
.db 0BDh ; Ω
.db  18h
.db    4
.db  1Ah
.db 0DDh ; ›
.db  19h
.db 27h, 18h, 27h, 18h,	27h, 18h, 0F1h,	18h
.db 27h, 18h, 18h, 1Fh,	0Dh, 1Fh, 27h, 18h
.db 27h, 18h, 27h, 18h,	27h, 18h, 27h, 18h
.db 27h, 18h, 27h, 18h,	27h, 18h, 27h, 18h
.db 27h, 18h, 27h, 18h,	27h, 18h, 27h, 18h
.db 27h, 18h, 27h, 18h,	27h, 18h, 27h, 18h
.db 27h, 18h, 27h, 18h,	27h, 18h, 27h, 18h
.db 27h, 18h, 27h, 18h,	33h, 23h, 27h, 18h
.db 27h, 18h, 0F1h, 18h, 57h, 1Ah, 51h,	1Dh
.db 5Fh, 20h, 27h, 18h,	27h, 18h, 42h, 1Eh
.db 0C5h, 1Ah, 55h, 23h, 27h, 18h, 27h,	18h
.db 26h, 1Dh, 78h, 1Ah,	27h, 18h, 27h, 18h
.db 27h, 18h, 27h, 18h,	27h, 18h, 3Eh, 23h
.db 9, 0, 27h, 18h, 27h, 18h, 27h, 18h,	27h
.db 18h, 27h, 18h, 27h,	18h, 16h, 0, 1,	2
.db 3, 4, 5, 6,	7, 8, 9, 0Ah, 0Bh, 10h,	11h
.db 12h, 13h, 18h, 19h,	1Ah, 1Bh, 1Ch, 17h
.db 1Dh, 1Eh, 1Fh, 0Ch,	0Dh, 0Eh, 0Fh, 14h
.db 15h, 21h, 1Fh, 44h,	1Fh, 62h, 1Fh, 73h
.db 1Fh, 93h, 1Fh, 0C6h, 1Fh
word_3D1A:.dw 1E62h
.db  76h ; v
.db 1Eh, 62h, 1Eh, 76h,	1Eh, 76h, 1Eh, 76h
.db 1Eh, 77h, 1Eh, 27h,	18h, 8Ah, 1Eh, 0AEh
.db 1Eh, 93h, 1Eh, 0B9h, 1Eh, 0C9h, 1Eh
.db 0DCh, 1Eh, 0EAh, 1Eh, 0F2h,	1Eh, 0FAh
.db 1Eh
word_3D3C:.dw 1D71h
.db  85h ; Ö
.db 1Dh, 71h, 1Dh, 85h,	1Dh, 85h, 1Dh, 85h
.db 1Dh, 86h, 1Dh, 27h,	18h, 99h, 1Dh, 85h
.db 1Dh, 0A2h, 1Dh, 0F0h, 1Dh, 0F9h, 1Dh
.db 0Ch, 1Eh, 17h, 1Eh,	20h, 1Eh, 2Fh, 1Eh
.db 8Ah, 21h, 27h, 18h,	27h, 18h, 27h, 18h
.db 27h, 18h, 49h, 21h,	27h, 18h, 27h, 18h
.db 48h, 17h, 27h, 18h,	27h, 18h, 54h, 17h
.db 1Bh, 23h, 75h, 23h,	87h, 23h, 0B6h,	23h
.db 0BEh, 23h, 17h, 24h, 0CDh, 1Ah, 0D8h
.db 1Ah, 27h, 18h, 27h,	18h, 0E0h, 1Ah,	0E5h
.db 1Ah, 27h, 18h, 0EAh, 1Ah, 2Eh, 1Dh,	38h
.db 1Dh, 3Dh, 1Dh, 42h,	1Dh, 47h, 1Dh, 60h
.db 61h, 62h, 63h, 64h,	65h, 66h, 67h, 68h
.db 69h, 6Ah, 6Bh, 79h,	7Ah, 7Bh, 7Ch, 6Ch
.db 6Dh, 6Eh, 6Fh, 7Dh,	7Eh, 5Fh, 75h, 70h
.db 71h, 72h, 73h, 74h,	76h, 77h, 78h, 1Bh
.db 5Bh, 3Fh, 31h, 3Bh,	32h, 63h, 1Bh, 2Fh
.db 5Ah, 1Bh, 5Bh, 30h,	6Eh, 1Bh, 5Bh, 33h
.db 6Eh
word_3DCE:.dw 26C6h
nop
nop
nop
dsub
nop
arhl
nop
rdel
nop
rim
rst	7
rst	7
rst	7
rst	7
nop
ldsi	8
mov	a, c
dcr	h
mov	a, c
inx	h
mov	h, d
pop	b
rnz
ora	e
adc	h
nop
nop
nop
nop
mov	h, b
mov	m, a
ldhi	0FFh
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
; end of 'ROM'


.end
