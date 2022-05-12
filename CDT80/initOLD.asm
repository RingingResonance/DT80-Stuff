
;<Cloned DT80 Firmware>
;Memory organization.
lcnt    equ 0x8FFF      ;Current number of lines.
lcfg    equ 0x8FFE      ;Max number of lines.
lnmb    equ 0x8FFD      ;Current working line.
flU     equ 0x8FFC      ;First Line address Upper.
flL     equ 0x8FFB      ;First Line address Lower.
ccnt    equ 0x8FFA      ;Column count.
stack   equ 0x8FF9      ;Stack pointer

org 0x0800
	hlt         ;Init marker
	jmp init
	hlt         ;External TX routine marker
	jmp TX
	hlt         ;External RX routine marker
	jmp RX
org 0x080C
    nop
	EI         ;IRQ TRAP
	RET
org 0x080F
    nop
	EI         ;IRQ 5.5
	RET
org 0x0812
    nop
	EI         ;IRQ 6.5
	RET
org 0x0815
    nop
	jmp  disp  ;IRQ 7.5

init:   lxi h,stack
    SPHL
    mvi a,0x04  ;Turn down brightness of CRT
	out 0x3A
	mvi a,0x48  ;Initialize video processor clock and config.
	out 0x3F
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
    mvi a,0x00  ;Do a reset of the USART
    out 0x01
    mvi a,0x00
    out 0x01
    mvi a,0x00
    out 0x01
    mvi a,0x40  ;Insure that it gets reset.
    out 0x01
    mvi a,0x4E  ;Configure serial port for 8N1 Internal Sync
    out 0x01
    mvi a,0x00
    out 0x01
    mvi a,0x00
    out 0x01
    mvi a,0x05  ;Enable transmit and receive.
    out 0x01
    ;Configure additional port attributes
    mvi a,0x00  ;Use external timer for BAUD
    out 0x3E

;Copy the third rom to video memory, and configure first line of text.
;0x1000 through 0x17FF is the third ROM. We are going to copy text/data from that to ram.
    lxi h,ccnt
    mvi m,0x50
    lxi h,flU
    mvi m,0xA0
    lxi h,flL
    mvi m,0x50
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
;Configure IRQ's
    mvi a,0x0B  ;only enable IRQ 7.5 for now.
    sim
    EI          ;enable IRQ's
    lxi h,stack     ;Reset the stack.
    SPHL
	jmp 0x0194      ;Jump back to main program and continue.

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

;Display IRQ routine
;reg B will be address of current working line number.
disp:   push PSW
        push B
        push D
        push H
        in  0x32    ;Check for blanking signal.
        ani 0x01
        cz  blank   ;If zero then display is blanking.
        mov h,b     ;copy current working line to HL. BC to HL
        mov l,c
        mov a,m     ;check if bit 6 of the line attribute byte is 0 or 1
        ani 0x40
        jz  evn     ;If 0 then load address to (0x3B and 0x3C). If 1 then load address to (0x18 and 0x20)
        call nxtadr ;get the next line's address, and put it in 0x20 and 0x18
        mov  a,b
        out  0x20
        mov  a,c
        out  0x1F
done:   pop  H      ;Done with IRQ, pop everything off the stack and return.
        pop  D
        pop  B
        pop  PSW
        EI          ;enable IRQ's
        ret

evn:    call nxtadr ;get the next line's address, and put it in 0x3B and 0x3C.
        mov  a,b
        out  0x3b
        mov  a,c
        out  0x3c
        jmp  done

;Get address of next line.
nxtadr: lxi h,ccnt  ;get column count
        mov l,m     ;put it in HL
        mvi h,0x00
        dad b       ;16 bit add with BC and HL to get address of next line address
        inx h       ;bump it by 1 to get the address
        mov b,m     ;Copy new address to BC
        inx h
        mov c,m
        ret

;Display is blanking. Reset some things and load in the first line address.
blank:  lxi h,lnmb  ;clear the working line number
        mvi m,0x00
        lxi h,flU   ;get address of first line.
        mov b,m
        mov a,m
        out 0x3C    ;Copy it over to the pointer. Upper address.
        lxi h,flL
        mov c,m
        mov a,m
        out 0x3B    ;Copy it over to the pointer. Lower address.
        ret
