
;<Cloned DT80 Firmware>
;Memory organization.
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
cladrL  equ 0x8FF0      ;Current Line Address Upper
cladr   equ 0x8FEF      ;Current Line Address Lower
stack   equ 0x8FEE      ;Stack pointer
bgnadr  equ 0x8000      ;Beginning address of ram
;Constants
flMU    equ 0xA0        ;Starting point of text. Upper
flML    equ 0x50        ;Starting point of text. Lower
flM     equ 0xA050      ;Starting point of text.

org 0x0000
Azero:	mvi  a,0x0F	;Disable IRQs
 	sim
 	lxi sp,stack
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
	jmp init

;# Built in IRQ vectors.
org	0x0024		;TRAP
	ret
org	0x002C		;RST5.5
    ret
org	0x0034		;RST6.5
    ret
org	0x003C		;RST7.5
    DI
	jmp  disp

org 0x0044		;Leave space for text.
	nop		    ;Mark it with a few 0x00's for easier editing in the hex editor.
	nop
	nop
	nop

org 0x0115
;initialize serial port
init: mvi a,0x64  ;Select T1 MSB, TX
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


;Do memory check.
    lxi b,0x0080    ;Use BC for walking bits right
    lxi d,0x0008    ;1 bit in D indicates a chip failure. E is pass count.
chagn:  lxi h,0x8000
        mov  b,c    ;Move C to B
memld:  mov  m,b    ;Move B to memory location.
        ;rotate B to the RIGHT.
        mov  a,b
        rrc
        mov  b,a
        ;Now move to next memory address.
        mov  a,h
        cpi  0x8F
        jnz  notdn
        mov  a,l
        cpi  0xFF
        jnz  notdn
        jmp  memvr
notdn:  inx  h
        jmp  memld

;Now Verify what was written.
memvr:  lxi h,0x8000
        mov b,c         ;move C to B again.
memrd:  ;Check M with B and then rotate B to the RIGHT.
        mov  a,b
        xra  m          ;The result is stored in A so we need to get B again.
        jnz  merror     ;If the result of the XOR isn't zero then we have a problem.
cntck:  mov  a,b        ;Now rotate B to the right.
        rrc
        mov  b,a
        ;Now move to next memory address.
        mov  a,h
        cpi  0x8F
        jnz  notdnr
        mov  a,l
        cpi  0xFF
        jnz  notdnr
        jmp  pssdne
notdnr: inx  h
        jmp  memrd

;Record that there was an error if there was one.
;Figure out which chip has a failure from top to bottom.
merror: mvi  a,0x8B
        cmp  h      ;if H>A then C=1. else C=0
        jc   bnk4f
        mvi  a,0x87
        cmp  h      ;if H>A then C=1. else C=0
        jc   bnk3f
        mvi  a,0x83
        cmp  h      ;if H>A then C=1. else C=0
        jc   bnk2f
        jmp  bnk1f

;Set the pertaining bit in reg D for each memory failure.
bnk4f:  mov a,d
        ori 0x10
        mov d,a
        jmp cntck   ;continue checking.
bnk3f:  mov a,d
        ori 0x20
        mov d,a
        jmp cntck   ;continue checking.
bnk2f:  mov a,d
        ori 0x40
        mov d,a
        jmp cntck   ;continue checking.
bnk1f:  mov a,d
        ori 0x80
        mov d,a
        jmp cntck   ;continue checking.

;Done with a single pass. Rotate C and decrease E
pssdne: dcr e
        jz  memdone     ;If E is 0 then we are done with memory check.
        mov a,c         ;Rotate C to the right.
        rrc
        mov c,a
        jmp chagn

memdone: nop

;Initialize display.
        lxi h,lcnt      ;22 lines
        mvi m,0x16
        lxi h,ccnt      ;80 column
        mvi m,0x50      ;Use actual address
        push d
        call cls    ;clear screen
        pop  d
        ;Configure IRQ's
        mvi a,0x0B  ;only enable IRQ 7.5 for now.
        sim
        EI          ;enable IRQ's
;Attempt to display memory error if there was one.
        mov  a,d
        ori  0x00
        jz  sysrdy      ;If no 1's in D then memory test passed.
        mov a,d
        ral
        mov d,a
        jc   fbnk1      ;Failure detected in this bank.
        mvi  a,0x50     ;Load the ASCII letter 'P' into A
        call ftext
bpnt2:  mov a,d
        ral
        mov d,a
        jc   fbnk2      ;Failure detected in this bank.
        mvi  a,0x50     ;Load the ASCII letter 'P' into A
        call ftext
bpnt3:  mov a,d
        ral
        mov d,a
        jc   fbnk3      ;Failure detected in this bank.
        mvi  a,0x50     ;Load the ASCII letter 'P' into A
        call ftext
bpnt4:  mov a,d
        ral
        mov d,a
        jc   fbnk4      ;Failure detected in this bank.
        mvi  a,0x50     ;Load the ASCII letter 'P' into A
        call ftext
        jmp  errlp

;Print Failures.
fbnk1:  mvi  a,0x46     ;Load the ASCII letter 'F' into A
        call ftext
        jmp  bpnt2

fbnk2:  mvi  a,0x46     ;Load the ASCII letter 'F' into A
        call ftext
        jmp  bpnt3

fbnk3:  mvi  a,0x46     ;Load the ASCII letter 'F' into A
        call ftext
        jmp  bpnt4

fbnk4:  mvi  a,0x46     ;Load the ASCII letter 'F' into A
        call ftext
errlp:  hlt
        jmp  errlp

;Copy the third rom's text to video memory until we hit a null char.
;0x1000 through 0x17FF is the third ROM. We are going to copy text/data from that to ram.
sysrdy: lxi h,0x1000    ;Start of 3rd ROM
cpy:    mov a,h
        cpi 0x3F
        jnz ssaver
        mov a,l
        cpi 0xFF
        jnz ssaver
        lxi h,0x1000    ;Start of 3rd ROM
ssaver: mov a,m
        cpi 0xFF
        jz  skp
        call ftext
skp:    inx h
        mov a,m
        cpi 0x00
        jnz cpy
;now wait a few seconds before continuing so to give the ascii art time to display.
        push h
wait:   lxi h,timer1        ;This address get decremented by the display routine.
        mvi m,0xF0
wt:     mov a,m
        cpi 0x00
        jnz wt
        pop h
        jmp cpy
;Hardware serial port routines.
;Transmit
TX: mov a,b
    call ftext  ;send the text to the display
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

;#########################################################################################################################
;Text to display input.
ftext:  push b
        push d
        push h
        mov  b,a        ;get data stored in A and move it to B
        cpi  0x09       ;Check for tab char.
        jz   tab        ;If tab, increase cursor position by 5 spaces!
        cpi  0x0A       ;Check for new line char.
        jz   newlne     ;If new line, make a new line!
        cpi  0x0D       ;Check for return char.
        jz   rtrn       ;If return char, reset cursor to 0x01!
        cpi  0x08       ;Check for backspace.
        jz   bkspc      ;If backspace, reduce cursor by 1 unless it's already at 1
        push b          ;Store B on the stack
        ;Now check if we need to move to the next line.
        lda  curs       ;get cursor position
        mov  b,a        ;move it to B for compare
        lda  ccnt       ;get column setting
        inr  a          ;increase A by one
        cmp  b          ;compare the two
        cz   nxtlne     ;If the same, call nxtlne
        ;Now get the address of working line and cursor
        lhld cladr      ;Get line start address and put it in HL
        lda  curs       ;get cursor
        mov  c,a        ;move it to C
        mvi  b,0x00     ;clear B
        dad  b          ;add line address to the cursor position to get cursor address.
        pop  b          ;get our data to be stored back off the stack.
        mov  m,b        ;store it in memory where the cursor is pointing to
        lxi  h,curs     ;get cursor position address
        inr  m          ;increase cursor position by one.
fmtdon: pop h
        pop d
        pop b
        ret

;Next line of text to print
nxtlne: call lnechk     ;Check to see if we are on the last line and if we need to scroll.
        lxi  h,curs     ;get cursor
        mvi  m,0x01     ;reset it to one
        call slnt       ;setup next line of text
        ret
;Newline feed
newlne: call lnechk     ;Check to see if we are on the last line.
        call slnt       ;setup next line of text
        jmp  fmtdon
;Return
rtrn:   lxi  h,curs     ;get cursor
        mvi  m,0x01     ;reset it to one
        jmp  fmtdon
;Backspace.
bkspc:  lxi  h,curs     ;get cursor
        mov  a,m        ;move it to A for comparison
        cpi  0x01
        jz   fmtdon     ;if it's already at 1, then don't do anything
        dcr  m          ;otherwise decrease it by 1
        jmp  fmtdon
;Tab
tab:    lxi  h,curs     ;get cursor
        mov  a,m        ;move it to A for comparison
        adi  0x05       ;add 5
        lxi  h,ccnt
        cmp  m
        jz   fmtdon     ;if it goes beyond the end of the line do not continue to add.
        lxi  h,curs     ;get cursor
        mov  m,a        ;If not beyond column count, add to cursor.
        jmp  fmtdon

;New line check. Check if we need to scroll when making a new line.
lnechk: lda  lcnt       ;get max total line count
        lxi  h,lnmb     ;get working line number
        inr  m          ;increase line number by one
        cmp  m          ;compare it
        cz   maxlne     ;if we've reached the max number of lines then jump here.
        ;Check to see if page is filled. If it is then scroll upwards.
        lda  lcnt       ;Get max total line count.
        dcr  a          ;decrease A by one
        lxi  h,pgln     ;get total number of lines on this page.
        cmp  m          ;compare it
        jz   scrll      ;Scroll page if max number of lines has been reached.
        inr  m          ;increase line count for page.
        ret
        ;reset line number.
maxlne: lxi  h,lnmb
        mvi  m,0x00
        ret
        ;scroll page, increase the start address by one line, and set the last line to loop back.
        ;if start address is greater than the last line reset it back to the first.
scrll:  call clrlne     ;clear current working line.
        lxi  h,lcnt     ;get max total line count
        mov  a,m        ;move it to A for a compare
        lxi  h,lnmb     ;get working line number
        inr  m          ;increase working line number by 1
        cmp  m          ;compare it
        jz   eotl       ;jump to end of the line
        ;If not the end of the line, use line count to calculate next first line pointer address.
        call gliadr     ;Get working line number address.
        shld flL
        lxi  h,lnmb
        dcr  m          ;decrease working line number by 1
        ret
        ;end of the line, reset first line pointer
eotl:   dcr  m
        lxi  h,flM      ;get first line pointer
        shld flL        ;store new first line.
        ret
;clear the current line by filling it with spaces
clrlne: call gliadr     ;get working line address. Returns it in HL
        mvi  c,0x01     ;set C to 0x01
        mov  d,h
        mov  e,l
        inx  d          ;DE is now cursor pointer address
clrfil: mov  h,d        ;Get address pointer back from DE
        mov  l,e
        mvi  m,0x20     ;Fill with spaces
        inx  d
        lxi  h,ccnt     ;get total column count setting
        mov  a,m
        cmp  c          ;compare C and A
        rz              ;return if they are the same
        inr  c
        jmp  clrfil

;Clear screen and buffer.
cls:    lxi h,flM   ;set start of display buffer
        shld flL
        lxi h,pgln      ;get total number of lines on this page.
        mvi m,0x00      ;Clear it.
        call gmem   ;get memory needed for a full page, returns it in HL
        mov  b,h    ;copy HL to BC
        mov  c,l    ;BC contains the total amount of memory needed.
        mvi  a,flMU
        ani 0x0F    ;remove the upper 4 config bits
        ori 0x80    ;and then OR the 8th bit
        mov  d,a
        mvi  e,flML
        mov  h,d    ;HL and DE now contains the starting address.
        mov  l,e
        dad  b      ;add BC to HL to get ending address of page. HL now contains ending address
        xchg        ;Exchange DE and HL, HL is now starting address again, and DE is ending address.
sfill:  mvi  m,0x20 ;start filling page with spaces.
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
        call slnt   ;Setup the first two lines of text.
        ret
;Keep filling the buffer.
kflin:  inx  h
        jmp  sfill

;#########################################################################################################################
;#########################################################################################################################
;Setup next line of text.
slnt:   call gliadr  ;Get working line start address, returns it in HL
        shld cladr  ;Store it for later use. This destroys the original contents of HL.
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
        lda  lcnt     ;get total line count
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

;Get start address of current working line. Returns it in HL
gliadr: lda  ccnt   ;get column count and put it in A
        adi  0x03   ;add three bytes to account for the attribute and address bytes.
        mov  c,a    ;move it to C
        mvi  b,0x00 ;clear B, BC now contains line data count.
        lda  lnmb   ;Put working line number in A
        call mult   ;Multiply BC and A, returns the result in HL.
        mvi  a,flMU ;Get First line Upper address.
        ani 0x0F    ;remove the upper 4 bits
        ori 0x80    ;and then OR the 7th bit to make it always '1'
        mov  b,a
        mvi  c,flML ;Get First line Lower address.
        dad  b      ;add BC to HL
        ret

;Get memory required for column and line count. Returns it in HL
gmem:   lxi  h,lcnt     ;Get line count
        mov  c,m        ;move it to BC
        mvi  b,0x00     ;clear B
        lda  ccnt       ;Get column count
        adi  0x03       ;Add 3 bytes to column count
        call mult
        ret

;8bit to 16 bit unsigned int multiply BC * A = HL
mult:   lxi  h,0x00     ;Clear H
        ana  a          ;check if zero
        rz
multl:  dad  b          ;add BC to HL
        dcr  a          ;decrease a
        jnz  multl      ;loop until d is 0
        ret

;#########################################################################################################################
;#########################################################################################################################
;#########################################################################################################################
;#########################################################################################################################
;Display IRQ routine
;reg DE will be address of current working line number.
disp:   push PSW
        push B
        push D
        push H
        lhld wlL    ;Get working line number address.
        xchg        ;Put it in DE
        in  0x32    ;Check for blanking signal.
        ani 0x01
        cz  blank   ;If zero then display is blanking.
        ;Put working line number into the Video Processor's line pointer.
        mov  a,d
        out  0x3C
        mov  a,e
        out  0x3B
        ;Get start address of next line.
        lda ccnt    ;get column count
        mov l,a     ;put it in L
        mvi h,0x00  ;clear the upper 8 bits of HL
        mov a,d     ;also copy the upper 8 bits of DE to A for further processing.
        ani 0x0F    ;remove the first 4 bits
        ori 0x80    ;and then OR the 7th bit in
        mov b,a     ;then move it to B
        mov c,e     ;move the lower 8 bits of DE to C
        dad b       ;16 bit add with BC and HL to get the ACTUAL address of next line.
        inx h       ;bump it up by 1 to get skip past the line attribute byte.
        mov d,m     ;Copy new address and line config to DE
        inx h
        mov e,m     ;move the lower 8 bits to E
        xchg        ;Move the working line number address to HL
        shld wlL    ;Store it.
        pop  H      ;Done with IRQ, pop everything off the stack and return.
        pop  D
        pop  B
        pop  PSW
        EI          ;re-enable IRQ's
        ret

;Display is blanking. Reset some things and load in the first line address.
blank:  lhld flL   ;get address of first line.
        xchg
        mov a,d     ;also copy the upper 8 bits to A for further processing.
        ani 0x0F    ;remove the first 4 bits
        ori 0x80    ;and then OR the 7th bit in
        mov b,a     ;then move it to D
        mov c,e     ;move the lower 8 bits to e
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
        lxi h,fbnkbt    ;For fast blinking, strobing, and animations at refresh rate and it's multiples
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
