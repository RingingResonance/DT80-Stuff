
;<Cloned DT80 Firmware>
;Memory organization.
curs    equ 0x8FFF      ;Cursor position.
ccfg    equ 0x8FFE      ;Cursor config.
lnmb    equ 0x8FFD      ;Current working line.
flU     equ 0x8FFC      ;First Line address Upper.
flL     equ 0x8FFB      ;First Line address Lower.
ccnt    equ 0x8FFA      ;Column count.
wlU     equ 0x8FF9      ;Current working line number Upper.
wlL     equ 0x8FF8      ;Current working line number Lower.
lcnt    equ 0x8FF7      ;Line count
stack   equ 0x8FF6      ;Stack pointer

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
    mvi a,0x05  ;Turn down brightness of CRT
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

;Clear screen.
cls:    call gmem   ;get memory needed for a full page
        mov  b,h    ;move HL to BC
        mov  c,l
        lxi  h,flU  ;get address of first line
        mov  d,m
        lxi  h,flL
        mov  l,m
        mov  h,d    ;HL now contains the starting address.
sfill:  mvi  m,0x20 ;start filling page with spaces.
        mov  a,d
        cmp  h
        jnz  kflin
        mov  a,e
        cmp  l
        jnz  kflin
        mvi  h,flU  ;Done filling, now set some default attributes and line addresses.
        mvi  l,flL
        xchg        ;exchange HL and DE for later use.
        mvi  m,0x40 ;First, and the last line of text.
        lxi  h,curs ;reset cursor position to 0
        mvi  m,0x00
        lxi  h,ccnt ;Get column count and add it to HL
        mov  c,m
        mvi  b,0x00 ;clear B
        xchg        ;get HL back
        dad  b      ;add C to HL
        inx  h      ;Increase HL by 1 to get past end of line. HL is now pointing to the Upper next line Address
        mov  d,h    ;Make a copy of HL for later use.
        mov  e,l
        inx  h
        inx  h      ;HL should now be pointing to next line of text
        mvi  m,0x00
        xchg        ;I have no clue what I'm doing here. It's 3:30AM and I need sleep. This is where I left off.
        ret

;Keep filling the buffer.
kflin:  inx  h
        jmp  sfill

;Get memory required for column and line count specified. Returns it in HL
gmem:   lxi  h,lcnt     ;Get line count
        mov  c,m        ;move it to BC
        lxi  h,ccnt     ;Get column count
        mov  a,m        ;move it to A
        adi  0x03       ;Add 3 bytes
        call mult
        ret

;16 bit int multiply C * D = HL
mult:   mvi  b,0x00     ;Clear B
        lxi  h,0x00     ;Clear H
        dad  b          ;add BC to HL
        dcr  d          ;decrease d
        jnz  mult       ;loop until d is 0
        ret

;Text to display input.
ftext:  mov  b,a

;Display IRQ routine
;reg BC will be address of current working line number.
disp:   push PSW
        push B
        push D
        push H
        lxi h,wlU   ;Get working line number.
        mov b,m
        lxi h,wlL
        mov c,m
        in  0x32    ;Check for blanking signal.
        ani 0x01
        cz  blank   ;If zero then display is blanking.
        mov h,d     ;Check for last line.
        mov l,e
        mov a,m
        ani 0x40
        jnz  lline   ;If 1 then it is last line.
        mov  a,b
        out  0x3C
        mov  a,c
        out  0x3B
        call nxtadr ;get the next line's address.
done:   lxi h,wlU   ;Save working line number.
        mov m,b
        lxi h,wlL
        mov m,c
        pop  H      ;Done with IRQ, pop everything off the stack and return.
        pop  D
        pop  B
        pop  PSW
        EI          ;re-enable IRQ's
        ret

;Put BC into the last line reg's
lline:  mov  a,b
        out  0x3C
        mov  a,c
        out  0x3B
        call nxtadr ;get the next line's address.
        jmp  done

;Get start address of next line.
nxtadr: lxi h,ccnt  ;get column count
        mov l,m     ;put it in HL
        mvi h,0x00  ;clear the upper 8 bits of HL
        mov a,b     ;also copy the upper 8 bits of BC to A for further processing.
        ani 0x0F    ;remove the first 4 bits
        ori 0x80    ;and then OR the 7th bit in
        mov d,a     ;then move it to D
        mov e,c     ;move the lower 8 bits to e
        dad d       ;16 bit add with DE and HL to get the ACTUAL address of next line.
        inx h       ;bump it by 1 to get the correct address
        mov b,m     ;Copy new address and line config to BC
        inx h
        mov c,m     ;move the lower 8 bits to C
        ret

;Display is blanking. Reset some things and load in the first line address.
blank:  lxi h,flU   ;get address of first line.
        mov b,m
        mov a,m     ;also copy the upper 8 bits to A for further processing.
        ani 0x0F    ;remove the first 4 bits
        ori 0x80    ;and then OR the 7th bit in
        mov d,a     ;then move it to D
        lxi h,flL
        mov c,m
        mov e,m     ;move the lower 8 bits to e
        ret
