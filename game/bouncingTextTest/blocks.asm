
;<Cloned DT80 Firmware>
;Memory organization.
;Text writer and clear screen
curs    equ 0x8FFF      ;Cursor position.
ccfg    equ 0x8FFE      ;Cursor config.
lnmb    equ 0x8FFD      ;Current working line.
flU     equ 0x8FFC      ;First Line address pointer Upper.
flL     equ 0x8FFB      ;First Line address pointer Lower.
ccnt    equ 0x8FFA      ;Column count setting.
wlU     equ 0x8FF9      ;Current displaying line number address Upper.
wlL     equ 0x8FF8      ;Current displaying line number address Lower.
lcnt    equ 0x8FF7      ;Line count setting.
timer1  equ 0x8FF6      ;Timer byte.
timer2  equ 0x8FF5      ;Timer byte.
blnkr   equ 0x8FF4      ;Timing for blinking text and cursor.
blnkbt  equ 0x8FF3      ;Byte to look at for blinking text and cursor, and maybe a clock in the future.
fbnkbt  equ 0x8FF2      ;Fast blinking bits.
pgln    equ 0x8FF1      ;Page total number of lines
;Game renderer
brdU    equ 0x8FF0      ;Game board Upper address start pointer
brdL    equ 0x8FEF      ;Game board Lower address start pointer
tilatrU equ 0x8FEE      ;Tile attribute Upper address start pointer
tilatrL equ 0x8FED      ;Tile attribute Lower address start pointer
tilactU equ 0x8FEC      ;Tile active data Upper address start pointer
tilactL equ 0x8FEB      ;Tile active data Lower address start pointer
X       equ 0x8FEA
Y       equ 0x8FE9
xyDir   equ 0x8FE8
rchar   equ 0x8FE7
;Stack pointer
stack   equ 0x8FE6      ;Stack pointer start
bgnadr  equ 0x8000      ;Beginning address of ram
;Constants
flMU    equ 0xA0        ;Starting point of text. Upper
flML    equ 0x50        ;Starting point of text. Lower

org 0x0000
    jmp init
;# Built in IRQ vectors.
;org	0x0024		;TRAP
;    DI
;	jmp  irqT
;org	0x002C		;RST5.5
;    DI
;	jmp  irq5
;org	0x0034		;RST6.5
;    DI
;	jmp  irq6
org	0x003C		;RST7.5
    DI
	jmp  disp

org 0x0044		;Leave space for text.
	nop		;Mark it with a few 0x00's for easier editing in the hex editor.
	nop
	nop
	nop

org 0x0123

init:   lxi sp,stack    ;Load stack pointer
    mvi a,0x02  ;Turn down brightness of CRT
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
;Initialize display.
        lxi h,lcnt      ;22 lines
        mvi m,0x16
        lxi h,ccnt      ;80 column
        mvi m,0x50      ;Use actual address
        call cls        ;clear and init screen memory
        ;Configure IRQ's
        mvi a,0x0B  ;only enable IRQ 7.5 for now.
        sim
        EI          ;enable IRQ's
;#########################################################################################################################
;Main program stuff.
;Ball test
        lxi h,X
        mvi m,0x05
        lxi h,Y
        mvi m,0x08
ball:   lxi h,rchar
        mov a,m
        inr m
        lxi h,X
        mov c,m
        lxi h,Y
        mov b,m
        call draw
        lxi h,xyDir ;now check directions. 1 is up, 0 is down
        mov a,m
        ani 0x01    ;get X direction
        jz  xDown
        jmp xUp
ytst:   lxi h,xyDir ;now check directions. 1 is up, 0 is down
        mov a,m
        ani 0x02    ;get X direction
        jz  yDown
        jmp yUp

xDown:  lxi h,X     ;get X position
        dcr m       ;decrease X
        mov a,m     ;move it to A for compare
        cpi 0x00
        jnz ytst
        lxi h,xyDir ;if zero then flip the direction bit to a 1
        mov a,m
        ori 0x01
        mov m,a
        jmp ytst

xUp:    lxi h,X     ;get X position
        inr m       ;increase X
        mov a,m     ;move it to A for compare
        cpi 0x4F
        jnz ytst
        lxi h,xyDir ;if zero then flip the direction bit to a 1
        mov a,m
        ani 0xFE
        mov m,a
        jmp ytst

yDown:  lxi h,Y     ;get Y position
        dcr m       ;decrease Y
        mov a,m     ;move it to A for compare
        cpi 0x00
        jnz wait
        lxi h,xyDir ;if zero then flip the direction bit to a 1
        mov a,m
        ori 0x02
        mov m,a
        jmp wait

yUp:    lxi h,Y     ;get Y position
        inr m       ;increase Y
        mov a,m     ;move it to A for compare
        cpi 0x16
        jnz wait
        lxi h,xyDir ;if zero then flip the direction bit to a 1
        mov a,m
        ani 0xFD
        mov m,a
        jmp wait

wait:   jmp ball

;#########################################################################################################################
;Draws what is specified in the CPU reg's on the screen using block attribute data.
;A is the char to draw, BC is the Y and X location to draw it.
draw:   lxi  h,lnmb     ;Move B to line number, it is our Y. Positive is DOWN
        mov  m,b
        mov  d,a
        call gliadr     ;Get the address of that line, returns it in HL
        mvi  b,0x00     ;clear B
        inx  B          ;increase B by one
        dad  b          ;Add BC to HL, this is now the pointer used to write the data to display memory
        mov  m,d        ;write the char to display.
        ret

;Clear screen and buffer.
cls:    lxi h,flU       ;set start of display buffer
        mvi m,flMU
        lxi h,flL
        mvi m,flML
        lxi h,pgln     ;get total number of lines on this page.
        mvi m,0x00     ;clear it
        call gmem      ;get memory needed for a full page, returns it in HL
        mov  b,h       ;copy HL to BC
        mov  c,l       ;BC contains the total amount of memory needed.
        mvi  a,flMU
        ani 0x0F       ;remove the upper 4 config bits
        ori 0x80       ;and then OR the 8th bit
        mov  d,a
        mvi  e,flML
        mov  h,d       ;HL and DE now contains the starting address.
        mov  l,e
        dad  b         ;add BC to HL to get ending address of page. HL now contains ending address
        xchg           ;Exchange DE and HL, HL is now starting address again, and DE is ending address.
sfill:  mvi  m,0x20    ;start filling page with spaces.
        mov  a,d
        cmp  h
        jnz  kflin
        mov  a,e
        cmp  l
        jnz  kflin
        ;Done filling, now set some default attributes and line addresses.
        lxi  h,curs ;reset cursor position to 1
        mvi  m,0x01
        lxi  h,lnmb ;set working line number to 0
        mvi  m,0x00
        ;Setup all lines to show a blank page.
finit:  call slnt
        lxi  h,lcnt ;get max line count
        mov  a,m    ;move it to A for comparison
        lxi  h,lnmb ;get working line number
        cmp  m      ;compare it
        jz   fidne  ;if not the same then keep filling
        inr  m      ;increase line number
        jmp  finit  ;keep filling
fidne:  lxi  h,lnmb ;get working line number
        mvi  m,0x00 ;clear it.
        ret
;Keep filling the buffer.
kflin:  inx  h
        jmp  sfill

;#########################################################################################################################
;#########################################################################################################################
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

;Setup next line of text.
slnt:   call gliadr  ;Get working line start address, returns it in HL
        mvi  m,0x00 ;Set attributes for this line, and for next line of text to be the last line.
        xchg        ;Now put start address in DE
        ;Get column count and add it to HL
        lxi  h,ccnt
        mov  c,m
        mvi  b,0x00 ;clear B
        xchg        ;get HL back from DE, as it contains the start address of the working line.
        dad  b      ;add BC to HL, now it contains the line end address
        inx  h      ;Increase HL by 1 to get past end of line. HL is now pointing to the Upper next line Address
        ;Now check if our working line is the last line. If it is then we need to point the next line to the first memory address.
        xchg        ;save HL for later without using stack
        lxi  h,lcnt     ;get total line count
        mov  a,m        ;move it to A for a compare
        dcr  a          ;Decrease A by 1
        lxi  h,lnmb     ;get working line number
        cmp  m          ;compare it
        jz   wrplne     ;jump to wrap line routine.
        xchg
        mov  d,h    ;Make a copy of HL for later use.
        mov  e,l
        inx  h      ;Make HL contain the address of the next line.
        inx  h
        mvi  m,0x00 ;Set default for this line to be the last line.
        xchg        ;Get the working line next address's address back.
        mov  a,d    ;Now move DE to the next line address spot in memory, but use the default line settings.
        ani 0x0F    ;remove the first 4 bits
        ori 0xA0    ;and then OR 0xA0
        mov  m,a
        inx  h
        mov  m,e
        ret
        ;Make last line point to first memory address containing text info.
wrplne: xchg        ;Get HL back.
        mvi  m,flMU
        inx  h
        mvi  m,flML
        ret

;Get line start address of current working line. Returns it in HL
gliadr: push b
        push d
        lxi  h,ccnt ;get column count and put it in A
        mov  a,m
        adi  0x03   ;add three bytes to account for the attribute and address bytes.
        mov  c,a    ;move it to C
        mvi  b,0x00 ;clear B, BC now contains line data count.
        lxi  h,lnmb ;Put working line number in D
        mov  d,m
        call mult   ;Multiply the two, returns the result in HL.
        xchg        ;Move HL to DE
        mvi  a,flMU
        ani 0x0F    ;remove the first 4 bits
        ori 0x80    ;and then OR the 7th bit
        mov  b,a
        mvi  c,flML
        xchg        ;Get data back from DE and put it in HL
        dad  b      ;add BC to HL
        pop  d
        pop  b
        ret

;Get memory required for column and line count. Returns it in HL
gmem:   lxi  h,lcnt     ;Get line count
        mov  c,m        ;move it to BC
        mvi  b,0x00     ;clear B
        lxi  h,ccnt     ;Get column count
        mov  a,m        ;move it to A
        adi  0x03       ;Add 3 bytes to column count
        mov  d,a        ;move it to D
        call mult
        ret

;8bit to 16 bit unsigned int multiply BC * D = HL
mult:   lxi  h,0x00     ;Clear H
        mov  a,d        ;check to see if D is 0
        ana  a          ;check if zero
        rz
multl:  dad  b          ;add BC to HL
        dcr  d          ;decrease d
        jnz  multl      ;loop until d is 0
        ret

;#########################################################################################################################
;#########################################################################################################################
;#########################################################################################################################
;#########################################################################################################################
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
;        mov h,d     ;Check for last line.
;        mov l,e
;        mov a,m
;        ani 0x40
;        jnz  lline   ;If 1 then it is last line.
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
        out  0x1f
        mov  a,c
        out  0x20
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
        ;Generic timer stuff not directly related to the screen.
        lxi h,timer1    ;Timer 1
        mov a,m
        cpi 0x00
        cnz  t1dec
        lxi h,timer2    ;Timer 2
        mov a,m
        cpi 0x00
        cnz  t2dec
        ;Timing for blinking stuff and maybe a clock in the future.
        lxi h,fbnkbt    ;For fast blinking and strobing at refresh rate.
        inr m
        lxi h,blnkr     ;Slower Blinker
        mov a,m
        cpi 0x00
        jnz  blnktm
        mvi m,0x0F      ;~250ms timing.
        lxi h,blnkbt    ;increase blinking byte. Gives 250ms, 500ms, 1S, 2S, etc. timings.
        inr m           ;increase blnkbt and let it roll over.
        ret
blnktm: dcr m
        ret

t1dec:  dcr m
        ret

t2dec:  dcr m
        ret
