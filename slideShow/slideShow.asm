
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
asciiU  equ 0x8FF0      ;ASCII art pointer Upper
asciiL  equ 0x8FEF      ;ASCII art pointer Lower
stack   equ 0x8FEE      ;Stack pointer
bgnadr  equ 0x8000      ;Beginning address of ram
;Constants
flMU    equ 0xA0        ;Starting point of text. Upper
flML    equ 0x50        ;Starting point of text. Lower

org 0x0800
	hlt         ;Init marker
	jmp init
	nop
	nop
	nop
	nop
	nop
	nop
	nop
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
        call cls    ;clear screen
        ;Configure IRQ's
        mvi a,0x0B  ;only enable IRQ 7.5 for now.
        sim
        EI          ;enable IRQ's
;Copy the third rom's text to video memory until we hit a null char.
;0x1000 through 0x17FF is the third ROM. We are going to copy text/data from that to ram.
        lxi h,0x1000    ;Start of 3rd ROM
cpy:    mov a,h         ;move H to A for comparison
        cpi 0x40
        jnz cntcpy      ;if no match then continue copying.
        mov a,l         ;move H to A for comparison
        cpi 0x00
        jnz cntcpy
        lxi h,0x1000    ;If matched, restart at 3rd ROM
cntcpy: mov a,m
        cpi 0xFF        ;Compare with 0xFF
        cnz ftext       ;Send it to screen if it's not 0xFF (blank space)
        inx h
        mov a,m         ;Check if it's a null char.
        cpi 0x00
        jnz cpy         ;If not a null char then keep copying.
        inx h           ;increase H by 1 to get it past null char.
        push h
;now wait a few seconds before continuing so to give the ascii art time to display.
        mvi b,0x02
wait:   lxi h,timer1
        mvi m,0xF0
wt:     mov a,m
        cpi 0x00
        jnz wt
        mov a,b
        cpi 0x00
        jz  cpy2         ;when timer is up, start copying again until null char.
        dcr b
        jmp wait

cpy2:   pop h
        jmp  cpy

;#########################################################################################################################
;Text to display input.
ftext:  push b
        push d
        push h
        mov  b,a        ;get data stored in A and move it to B
        cpi  0x0A       ;Check for new line char.
        jz   newlne     ;If new line, make a new line!
        cpi  0x0D       ;Check for return char.
        jz   rtrn       ;If return char, reset cursor to 0x01!
        cpi  0x08       ;Check for backspace.
        jz   bkspc      ;If backspace, reduce cursor by 1 unless it's already at 1
        push b          ;Store B on the stack
        lxi  h,curs     ;get cursor position
        mov  b,m        ;move it to B for compare
        lxi  h,ccnt     ;get column setting
        mov  a,m        ;move it to A
        inr  a          ;increase A by one
        cmp  b          ;compare the two
        cz   nxtlne     ;If the same, call nxtlne
        ;Now get the address of the cursor
        call gliadr     ;Get line start address and put it in HL
        xchg
        lxi  h,curs     ;get cursor again
        mov  c,m        ;move it to C
        mvi  b,0x00     ;clear B
        xchg
        dad  b          ;add line address to the cursor position
        pop  b          ;get our data to be stored back off the stack.
        mov  m,b        ;store it in memory where the cursor is pointing to
        lxi  h,curs     ;get cursor position
        inr  m          ;increase cursor position by one.
fmtdon: pop h
        pop d
        pop b
        mov a,b
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
        rz              ;if it's already at 1, then just return
        dcr  m          ;otherwise decrease it by 1
        jmp  fmtdon

;New line check. Check if we need to scroll when making a new line.
lnechk: lxi  h,lcnt     ;get max total line count
        mov  a,m        ;move it to A for a compare
        lxi  h,lnmb     ;get working line number
        inr  m          ;increase line number by one
        cmp  m          ;compare it
        cz   maxlne     ;if we've reached the max number of lines then jump here.
        ;Check to see if page is filled. If it is then scroll upwards.
        lxi  h,lcnt     ;Get max total line count.
        mov  a,m        ;move it to A for a compare
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
        xchg            ;store it in DE for a moment
        lxi  h,flU      ;get first line pointer
        mov  m,d        ;store new first line.
        lxi  h,flL
        mov  m,e
        lxi  h,lnmb
        dcr  m          ;decrease working line number by 1
        ret
        ;end of the line, reset first line pointer
eotl:   dcr  m
        lxi  h,flU      ;get first line pointer
        mvi  m,flMU        ;store new first line.
        lxi  h,flL
        mvi  m,flML
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
cls:    lxi h,flU       ;set start of display buffer
        mvi m,flMU
        lxi h,flL
        mvi m,flML
        lxi h,pgln     ;get total number of lines on this page.
        mvi m,0x00
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
gliadr: lxi  h,ccnt ;get column count and put it in A
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
