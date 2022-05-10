
;<Program title>
org 0x0800
	hlt         ;Init marker
	jmp init
	hlt         ;External TX routine marker
	jmp TX
	hlt         ;External RX routine marker
	jmp RX
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
init:  mvi a,0x07  ;Turn down brightness of CRT
	out 0x3A
	mvi a,0xC8      ;Initialize video processor clock and config.
	out 0x3F
	mvi a,0x50      ;Initialize 'last line of text' pointer.
	out 0x3B        ;make this start of command text.
	mvi a,0x00      ;Initialize 'last line of text' pointer.
	out 0x3C
;initialize serial port
    ;Configure Bitrate Timer
    mvi a,0x24  ;Select T0 MSB, RX
    out 0x13
    mvi a,0x00
    out 0x10
    mvi a,0x14  ;Select T0 LSB, RX
    out 0x13
    mvi a,0x0C  ;Load D12 for 9600BAUD
    out 0x10
    mvi a,0x64  ;Select T1 MSB, TX
    out 0x13
    mvi a,0x00
    out 0x11
    mvi a,0x54  ;Select T1 LSB, TX
    out 0x13
    mvi a,0x0C  ;Load D12 for 9600BAUD
    out 0x11
    ;Configure USART
    mvi a,0x4E  ;Configure serial port for 8N1 Internal Sync
    out 0x01
    mvi a,0x00
    out 0x01
    mvi a,0x05  ;Enable transmit and receive.
    out 0x01
    ;Configure additional port attributes
    mvi a,0x00  ;Use external timer for BAUD
    out 0x3E
;0x1000 through 0x17FF is the third ROM. We are going to copy text/data from that to ram.
    lxi h,0x1000    ;Start of 3rd ROM
    lxi d,0x8050    ;Start of memory to copy to.
cpy: mov a,m
    xchg
    mov m,a
    xchg
    inx h
    inx d
    mov a,h
    cpi 0x17
    jnz cpy
    mov a,l
    cpi 0xFF
    jnz cpy
	jmp 0x018F      ;Jump back to main program and continue.

;Hardware serial port routines.
;Transmit
TX: mov a,b
    out 0x00    ;Load serial port with data byte. This should auto start transmitting.
;Loop until done transmitting.
TL: in  0x01    ;Get status
    ani 0x01    ;And it with 0x01
    jz  TL      ;if not zero then it's done.
    pop h
    pop psw
    pop d
    pop b
    ret

;Receive
RX: in  0x01    ;Get status
    ani 0x02    ;And it with 0x02
    jz  RX      ;if not zero then there's a data byte.
;Loop until data is ready.
;Once data is ready, just read it and it should be in REG A where it needs to be anyways.
    in  0x00    ;Read serial port 1 RX data.
    pop h
    pop d
    pop b
    ret
