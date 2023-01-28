
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
cladrU  equ 0x8FF0      ;Current Line Address Upper
cladr   equ 0x8FEF      ;Current Line Address Lower
svrtmr  equ 0x8FEE      ;Screen Saver Timer.
svrtmr2 equ 0x8FED      ;Screen Blanker Timer.
svrbtr  equ 0x8FEC      ;Screen Saver Brightness
bcrsU   equ 0x8FEB
bcrs    equ 0x8FEA
RXBPT   equ 0x8FE9      ;RX buffer IN index. Used by the RX routine.
RXBFF   equ 0x8FE8      ;RX buffer OUT index. Used by the ftext routine.
escprs  equ 0x8FE7      ;ESC pressed flags.
dspstt  equ 0x8FE6      ;Display settings
sattb   equ 0x8FE5
orgatr  equ 0x8FE4
chkadrU equ 0x8FE3
chkadr  equ 0x8FE2      ;ROM checksum address temp storage.
chksumU equ 0x8FE1
chksum  equ 0x8FE0      ;ROM checksum storage.
stack   equ 0x8FDF      ;Stack pointer start.
bgnadr  equ 0x8000      ;Beginning address of ram
;Constants
RXstrt  equ 0x8C00      ;RX buffer start address
RXblng  equ 0xFF        ;RX buffer Max Length
savsec  equ 0x4B        ;Screen saver timer in 4 second intervals. (0x4B = 300S = 5min)
scrnbk  equ 0xE1        ;Screen blank timer in 4 second intervals. (0xE1 = 900S = 15min)
flMU    equ 0xA0        ;Starting point of text and it's attributes. Upper
flML    equ 0x00        ;Starting point of text. Lower
flM     equ 0xA000      ;Starting point of text.
dsdflt  equ 0x79        ;Display Defaults (IO address 0x3F)
;String pointers.
soffset     equ 0x0044        ;String offset.
SelfTest    equ 0x0000 + soffset
Pounds      equ 0x000A + soffset
MemTest     equ 0x0016 + soffset
AttrTst     equ 0x0027 + soffset
ROMCHK      equ 0x0037 + soffset
Fail        equ 0x0045 + soffset
Pass        equ 0x0022 + soffset
AM1         equ 0x004A + soffset
RM1         equ 0x005C + soffset
RM2         equ 0x006E + soffset
;Start of program.
org 0x0000
Azero:  DI      ;Disable system IRQs
    ;CPU init and power delay done. Continue with display init and memory check.
	mvi a,0x69  ;Initialize video processor clock and config.
	out 0x3F
	;Do memory check.
	jmp memcheck    ;Jumps back to sysrdy if the memory test passes.
;Done with memory check, continue as normal.
sysrdy: lxi sp,stack    ;Set the stack.
        call p1init     ;initialize port 1
        mvi a,dsdflt    ;Initialize video processor clock and config.
        out 0x3F
        sta dspstt      ;And set defaults
        mvi a,0xFF      ;Initialize ESC code counter.
        sta escprs
        mvi a,0x00      ;Set default character attributes.
        sta sattb
        jmp IRQskp

;# Built-in 8085 CPU IRQ vectors.
org	0x0024		;TRAP
    EI          ;Re-enable IRQ's before returning.
	ret
org	0x002C		;RST5.5 TX stuff.
    EI          ;Re-enable IRQ's before returning.
    ret
org	0x0034		;RST6.5 RX stuff.
    ;DI
    jmp  RXCHK
org	0x003C		;RST7.5
    ;DI
	jmp  disp
;Text data.
org 0x0044
    nop
    nop
    nop
    nop
org 0x00C4
;Running normal system.
        ;Initialize display system for 80col, 22lines.
IRQskp: lxi h,lcnt      ;22 lines
        mvi m,0x16
        lxi h,ccnt      ;80 column
        mvi m,0x50
        call cls        ;clear and initialize screen buffer memory
        call tbrhi      ;Turn brightness up and restart the screen saver timer.
        call stbkg      ;Draw self test placard.
        ;Initialize Input Buffer Pointers.
        mvi a,0x01
        sta RXBFF
        mvi a,0x01
        sta RXBPT
        ;Configure IRQ's
        mvi a,0x09      ;Un-mask IRQ's 6.5, and 7.5
        sim
        EI              ;enable global IRQ's

;###############################################################################################################################
;Main loop.
main:   call scrnsvr    ;Screen saver routine.
        call blnkcrs    ;Blink the cursor.
        call prtbff     ;Print what's in the buffer onto the screen.
        call blnker     ;Text blink routine.
        hlt             ;shhhh, goto sleep...
        jmp  main       ;Loop
;***************************************************************************************
;Screen Saver Timer.
scrnsvr: lda timer1      ;This variable gets decremented by the display routine 60 times per second.
        ora a
        rnz
        ;Timer1 reset
        lxi h,timer1 ;This address gets decremented by the display routine 60 times per second.
        mvi m,0xF0   ;4 second intervals.
        ;Seconds counter for screen blanking
        lda svrtmr2
        ora a
        jz  tbroff
        dcr a
        sta svrtmr2
        ;Seconds counter for screen dimming
        lda svrtmr
        dcr a
        sta svrtmr
        rnz
;Screen Saver Brightness Adjustments.
tbrlow: mvi a,0x07  ;Turn down brightness of CRT.
        out 0x3A
        ret
tbroff: mvi a,0xFF  ;Turn brightness of CRT all the way off..
        out 0x3A
        ret
tbrhi:  mvi a,0x00  ;Turn up brightness of CRT all the way.
        out 0x3A
        ;Reset the screen saver timers.
        mvi a,savsec    ;Dim timer.
        sta svrtmr
        mvi a,scrnbk    ;Blank timer.
        sta svrtmr2
        ret

;Blink Cursor
blnkcrs: lhld bcrs      ;HL now has cursor address
        lxi  d,0x1000
        dad  d
        lda  blnkbt     ;get blinking bits
        ani  0x01       ;Get 250ms bit.
        jz   crsoff
        mvi  m,0x02     ;Cursor Visible/Inverted.
        ret

crsoff: mvi  m,0x00     ;Cursor is Blank/Normal
        ret

;Blinker Routine. Makes the text blink.
blnker: lda  blnkbt     ;get blinking bits
        ani  0x02       ;Get 500ms bit.
        jnz   bitff
        lda  dspstt
        out  0x3F
        ret

bitff:  lda  dspstt
        ani  0xFE     ;Blank
        out  0x3F
        ret

;#########################################################################################################################
;Text to display input.
ftext:  push b
        push d
        push h
        mov  b,a        ;get data stored in A and move it to B
        ;Check for ESC key press.
        cpi  0x1B
        jz   ESC
        ;Check for if previous char was an ESC press.
        lda  escprs
        ori  0x00
        jz   nESC       ;If it was then record this keypress into escprs as the ESC command.
        ;If previous key's were the start of an ESC sequence then check ESC commands.
        jmp  chESC
        ;No ESC sequence found, continue with normal text to display input.
noESC:  mov  a,b
        cpi  0x01       ;Check for start of heading
        jz   clear      ;If start of heading then clear screen
        cpi  0x09       ;Check for tab char.
        jz   tab        ;If tab, increase cursor position by 5 spaces!
        cpi  0x0A       ;Check for new line char.
        jz   newlne     ;If new line, make a new line!
        cpi  0x0D       ;Check for return char.
        jz   rtrn       ;If return char, reset cursor to 0x01!
        cpi  0x08       ;Check for backspace.
        jz   bkspc      ;If backspace, reduce cursor by 1 unless it's already at 1
        lhld bcrs       ;Get cursor address pointer.
        mov  m,b        ;store char it in memory where the cursor is pointing to
        ;Update attribute for this char.
        lxi  d,0x1000
        dad  d          ;Add 4K of memory space to get to character attributes memory
        lda  sattb
        mov  m,a        ;Result is in A, move it back to attributes memory.
        lxi  h,curs     ;get cursor position address
        inr  m          ;increase cursor position by one.
        ;Now check if we need to move to the next line.
        lda  curs       ;get cursor position
        mov  b,a        ;move it to B for compare
        lda  ccnt       ;get column setting
        inr  a          ;increase A by one
        cmp  b          ;compare the two
        cz   nxtlne     ;If the same, call nxtlne
        call csadr      ;update cursor address.
fmtdon: pop h
        pop d
        pop b
        ret

;ESC sequence stuff.
        ;ESC has been pressed, load 0x00 into escprs
ESC:    mvi a,0x00
        sta escprs
        jmp fmtdon
        ;Get next char after ESC and put it in escprs
nESC:   mov a,b
        sta escprs
        jmp fmtdon
;Do ESC command.
chESC:  lda escprs
        ;check for 'd' command.
        cpi 0x64        ;check for the letter 'd'
        jz  sdsp        ;Set display command.
        ;check for 'l' command.
        cpi 0x6C        ;check for the letter 'l'
        jz  slinea      ;Set line attribute command.
        ;check for 'a' command.
        cpi 0x61        ;check for the letter 'a'
        jz  sattrb      ;Set line attribute command.
        ;check for 'c' command.
        cpi 0x63        ;check for the letter 'c'
        jz  schar       ;Set char attribute command.
        ;If no valid ESC commands were found then reset escprs to 0xFF
        mvi a,0xFF
        sta escprs
        jmp noESC       ;No ESC command found.

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
rtrn:   call clrattb    ;Clear previous Cursor attribute.
        lxi  h,curs     ;get cursor
        mvi  m,0x01     ;reset it to one
        call csadr      ;update cursor address.
        jmp  fmtdon
;Backspace.
bkspc:  call clrattb    ;Clear previous Cursor attribute.
        lxi  h,curs     ;get cursor
        mov  a,m        ;move it to A for comparison
        cpi  0x01
        jz   fmtdon     ;if it's already at 1, then don't do anything
        dcr  m          ;otherwise decrease it by 1
        call csadr      ;update cursor address.
        jmp  fmtdon
;Tab
tab:    call clrattb    ;Clear previous Cursor attribute.
        lxi  h,ccnt     ;get col count
        mov  a,m        ;move it to A for comparison
        sbi  0x06       ;add 5
        lxi  h,curs     ;get cursor
        cmp  m          ;Compare it.
        jc   fmtdon     ;if it goes beyond the end of the line do not continue to add.
        lda  curs       ;get cursor
        adi  0x05       ;add 5
        mov  m,a        ;If not beyond column count, add to cursor.
        call csadr      ;update cursor address.
        jmp  fmtdon

;Clear  char attribute.
clrattb: lhld bcrs      ;HL now has cursor address
        lxi  d,0x1000
        dad  d
        mvi  m,0x00     ;Cursor Off
        ret

;Clear Screen
clear:  call cls        ;clear screen.
        jmp  fmtdon
;New line check. Check if we need to scroll when making a new line.
lnechk: call clrattb    ;Clear previous Cursor attribute.
        lda  lcnt       ;get max total line count
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
        mov  a,h
        ani  0x0F       ;Clear upper nibble
        ori  0xA0       ;Set default line attribute.
        mov  h,a
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
        ;Clear the attributes.
        push b
        lxi  b,0x1000
        dad  b
        mvi  m,0x00     ;Clear it.
        pop  b
        inx  d
        lxi  h,ccnt     ;get total column count setting
        mov  a,m
        cmp  c          ;compare C and A
        rz              ;return if they are the same
        inr  c
        jmp  clrfil

;Clear screen and buffer.
cls:    lxi h,flM       ;set start of display buffer
        shld flL
        lxi h,pgln      ;get total number of lines on this page.
        mvi m,0x00      ;Clear it.
        call gmem       ;get memory needed for a full page, returns it in HL
        mov  b,h        ;copy HL to BC
        mov  c,l        ;BC contains the total amount of memory needed.
        mvi  a,flMU     ;Get first line Upper address.
        ani 0x0F        ;remove the upper 4 config bits
        ori 0x80        ;and then OR the 8th bit
        mov  d,a        ;Now we have the upper address byte.
        mvi  e,flML     ;DE now points to first line start address.
        mov  h,d        ;HL and DE now contains the starting address.
        mov  l,e
        dad  b          ;add BC to HL to get ending address of page. HL now contains ending address
        xchg            ;Exchange DE and HL, HL is now starting address again, and DE is ending address.
        ;Space fill.
sfill:  mvi  m,0x20     ;fill page with spaces.
        mov  a,d
        cmp  h
        jnz  kflin
        mov  a,e
        cmp  l
        jnz  kflin
        ;Done filling, now set some default attributes and line addresses.
        lxi  h,lnmb     ;set working line number to 0
        mvi  m,0x00
;Setup the whole screen.
clrfll: lxi  h,lcnt     ;Get line count.
        lda  lnmb       ;Get working line number.
        cmp  m          ;Compare the two.
        jz   stpdn      ;If the same then we are done.
        call slnt       ;call line setup
        lxi  h,lnmb     ;Get working line number pointer
        inr  m          ;Increase working line number
        jmp  clrfll     ;loop until done.
;Keep filling the buffer.
kflin:  inx  h
        jmp  sfill
;setup done, now reset some things.
stpdn:  lxi  h,curs     ;reset cursor position to 1
        mvi  m,0x01
        lxi  h,lnmb     ;set working line number to 0
        mvi  m,0x00
        call gliadr
        call csadr
;reset all character attributes.
        lxi h,9000
drlp:   mvi m,0x00      ;Default character attributes.
        inx h
        mov a,h
        cpi 0xA0        ;Looking for 0xA000, which is one greater than 0x9FFF.
        jnz drlp
        mvi a,0xFF
        sta escprs      ;reset escprs
        ret

;Setup next line of text routine.
slnt:   call gliadr     ;Get working line start address, returns it in HL
        mvi  m,0x00     ;Set attributes for this line.
        xchg            ;Now put start address in DE
        ;Get column count and add it to HL
        lxi  h,ccnt
        mov  c,m
        mvi  b,0x00     ;clear B
        xchg            ;get HL back from DE, as it contains the start address of the working line.
        dad  b          ;add BC to HL, now it contains the line end address
        inx  h          ;Increase HL by 1 to get past end of line. HL is now pointing to the Upper next line Address
        ;Now check if our working line is the last line. If it is then we need to point the next line to the first memory address.
        xchg            ;save HL for later without using stack
        lda  lcnt       ;get total line count
        dcr  a          ;Decrease A by 1
        lxi  h,lnmb     ;get working line number
        cmp  m          ;compare it
        jz   wrplne     ;if the same, jump to wrap line routine. Make last line point to first memory address containing text info.
        xchg            ;Get HL back, we don't need DE anymore. It should still be pointing to H of the next line pointer.
        mov  d,h        ;Make a copy of HL for later use.
        mov  e,l
        inx  h          ;Make HL contain the start address of the next line.
        inx  h
        mvi  m,0x00     ;Set default for this line to be the last line.
        xchg            ;Get the working line next address's address back from DE and put it in HL
        ;DE is now the next line's start address and HL is the address of the next line pointer.
        mov  a,d        ;Now move DE to the next line address spot in memory, but use the default line settings.
        ani 0x0F        ;remove the first 4 bits
        ori flMU        ;and then OR it with default line attributes.
        mov  m,a
        inx  h
        mov  m,e
        call csadr      ;update cursor address.
        ret
;Make last line point to first memory address containing text info.
wrplne: xchg            ;Get HL back.
        mvi  m,flMU
        inx  h
        mvi  m,flML
        call csadr      ;update cursor address.
        ret

;Get cursor address, returns it in HL and bcrs
csadr:  lhld cladr      ;Get line start address and put it in HL
        lda  curs       ;get cursor
        mov  e,a        ;move it to C
        mvi  d,0x00     ;clear D
        dad  d          ;add line address to the cursor position to get cursor address.
        shld bcrs
        ret

;Get start address of current working line. Returns it in HL and 'cladr'
gliadr: lda  ccnt       ;get column count and put it in A
        adi  0x03       ;add three bytes to account for the attribute and address bytes.
        mov  c,a        ;move it to C
        mvi  b,0x00     ;clear B, BC now contains line data count.
        lda  lnmb       ;Put working line number in A
        call mult       ;Multiply BC and A, returns the result in HL.
        mvi  a,flMU     ;Get First line Upper address.
        ani 0x0F        ;remove the upper 4 bits
        ori 0x80        ;and then OR the 7th bit to make it always '1'
        mov  b,a
        mvi  c,flML     ;Get First line Lower address.
        dad  b          ;add BC to HL
        shld cladr
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
; Display bytes are organized as such:  ACCC~80char~CCCHL
; -where 'A' is the first attributes byte, 'C' is a character, and 'HL' is the High and Low byte address of the next line.
; 'H' contains addition attributes data in it's upper four bits.
disp:   push PSW
        push B
        push D
        push H
        lhld wlL    ;Get current working line number address+attributes data.
        xchg        ;Put it in DE
        in  0x32    ;Check for blanking signal.
        ani 0x01
        cz  blank   ;If zero then display is blanking, reset working line number.
        ;Put working line number into the Video Processor's line pointer.
        mov  a,d
        out  0x3C
        mov  a,e
        out  0x3B
done:   call nxtadr
        shld wlL    ;Store it.
        pop  H      ;Done with IRQ, pop everything off the stack and return.
        pop  D
        pop  B
        pop  PSW
        EI          ;re-enable IRQ's
        ret

        ;Get start address of next line.
nxtadr: lda ccnt    ;get column count. eg: 80
        mov l,a     ;put it in L
        mvi h,0x00  ;clear the upper 8 bits of HL
        mov a,d     ;copy the upper 8 bits of DE to A.
        ani 0x0F    ;remove the upper 4 bits of attribute data. We don't need it.
        ori 0x80    ;then OR the 7th bit in because we need it to always be '1'
        mov d,a     ;then move it back to D
        inx d       ;add 1 so that we get past the line's attribute data.
        ;DE now contains the address the current working line with both of it's attributes stripped.
        dad d       ;16 bit add with DE and HL to get the ACTUAL address of the next line pointer.
        mov d,m     ;Copy new address and line config to DE
        inx h
        mov e,m     ;move the lower 8 bits to E
        xchg        ;Move the working line number address to HL
        ret

;Display is blanking. Reset some things and load in the first line address.
;We also use this routine for a few timers.
blank:  lhld flL   ;get address of first line.
        xchg        ;Move it to DE
        ;#######################################################
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
        mvi m,0x07      ;~125ms timing.
        lxi h,blnkbt    ;increase blinking byte. Gives 250ms, 500ms, 1S, 2S, etc. timings.
        inr m           ;increase blnkbt and let it roll over.
        ret
blnktm: dcr m
        ret
t1dec:  dcr m
        ret
t2dec:  dcr m
        ret

;******************************************************************************
;Self test results page stuff.
stbkg:  mvi  b,0x1A     ;Move cursor 26 lines to the right.
        mvi  c,0x01     ;Start on second line of text.
        call mvcurs     ;Update cursor address.
        mvi  b,0x1A     ;Draw 26 diamonds.
        call dmonds     ;Draw them.
        ;Second line of test results.
        mvi  b,0x1A     ;Move cursor 26 lines to the right.
        mvi  c,0x02     ;Third line of text.
        call mvcurs     ;Update cursor address.
        mvi  b,0x06     ;Draw 6 diamonds.
        call dmonds     ;Draw them.
        mvi  b,0x2E     ;Move cursor 46 lines to the right.
        mvi  c,0x02     ;Third line of text.
        call mvcurs     ;Update cursor address.
        mvi  b,0x06     ;Draw 6 diamonds.
        call dmonds     ;Draw them.
        ;3rd - 19th lines
        mvi  c,0x03     ;Third line of text.
drpt:   mvi  b,0x1A     ;Move cursor 26 lines to the right.
        call mvcurs     ;Update cursor address.
        mvi  a,0x00
        call ftext      ;Draw single diamond.
        mvi  b,0x33     ;Move cursor 51 lines to the right.
        call mvcurs     ;Update cursor address.
        mvi  a,0x00
        call ftext      ;Draw single diamond.
        inr  c          ;Move to next line of text.
        mov  a,c
        cpi  0x14       ;check if 19th line.
        jnz  drpt
        ;draw 20th line.
        mvi  b,0x1A     ;Move cursor 26 lines to the right.
        mvi  c,0x14     ;Start on 20th line of text.
        call mvcurs     ;Update cursor address.
        mvi  b,0x1A     ;Draw 26 diamonds.
        call dmonds     ;Draw them.
;Print background texts.
        ; "Self Test"
        mvi  b,0x22     ;Move cursor 34 lines to the right.
        mvi  c,0x02     ;Third line of text.
        call mvcurs     ;Update cursor address.
        lxi  h,SelfTest ;Print "Self Test "
        call fstring
        ;Print #'s
        mvi  b,0x1C     ;Move cursor 28 lines to the right.
        mvi  c,0x04     ;Third line of text.
        call mvcurs     ;Update cursor address.
        lxi  h,Pounds   ;Get #'s
        call fstring    ;Print them.
        ;Print "Memory Test Pass"
        mvi  b,0x1E
        mvi  c,0x04     ;Third line of text.
        call mvcurs     ;Update cursor address.
        lxi  h,MemTest  ;Print "Memory Test Pass"
        call fstring
        ;Print "Attributes Test"
        mvi  b,0x1E
        mvi  c,0x06     ;Third line of text.
        call mvcurs     ;Update cursor address.
        lxi  h,AttrTst  ;Print "Attributes Test"
        call fstring
        ;Print "ROM Checksums"
        mvi  b,0x1E
        mvi  c,0x0A     ;Third line of text.
        call mvcurs     ;Update cursor address.
        lxi  h,ROMCHK   ;Print "ROM Checksums "
        call fstring
;Print chip numbers
        ;Print Attributes Memory Chip Numbers
        mvi  b,0x1F
        mvi  c,0x07     ;Third line of text.
        call mvcurs     ;Update cursor address.
        lxi  h,AM1      ;Print "ROM Checksums "
        call fstring
        ;Print ROM Memory Chip Numbers
        mvi  b,0x1F
        mvi  c,0x0B     ;Third line of text.
        call mvcurs     ;Update cursor address.
        lxi  h,RM1      ;Print "ROM Checksums "
        call fstring
        ;Print Second set of ROM Memory Chip Numbers
        mvi  b,0x1F
        mvi  c,0x0F     ;Third line of text.
        call mvcurs     ;Update cursor address.
        lxi  h,RM2      ;Print "ROM Checksums "
        call fstring
;Do attributes memory check.
        mvi  b,0x1E     ;30th row.
        mvi  c,0x08     ;8th line of text.
        call  prtAP
        mvi  b,0x23     ;35th row
        mvi  c,0x08     ;8th line of text.
        call  prtAP
        mvi  b,0x28     ;40th row
        mvi  c,0x08     ;8th line of text.
        call  prtAP
        mvi  b,0x2D     ;45th row
        mvi  c,0x08     ;8th line of text.
        call  prtAP
        ;Fill with data and then check.
        mvi  b,0x0F
        call atrchk
        mvi  b,0x00
        call atrchk
;Calculate and Print the ROM checksums.
        ;ROM 1
        mvi  b,0x2D     ;45th row of text.
        mvi  c,0x0D     ;13 line of text.
        lxi  h,0x0000
        call prtcsm
        ;ROM 2
        mvi  b,0x28     ;40th row of text.
        mvi  c,0x0D     ;13 line of text.
        lxi  h,0x0800
        call prtcsm
        ;ROM 3
        mvi  b,0x23     ;35th row of text.
        mvi  c,0x0D     ;13 line of text.
        lxi  h,0x1000
        call prtcsm
        ;ROM 4
        mvi  b,0x1E     ;30th row of text.
        mvi  c,0x0D     ;13 line of text.
        lxi  h,0x1800
        call prtcsm
        ;ROM 7
        mvi  b,0x2D     ;45th row of text.
        mvi  c,0x11     ;17 line of text.
        lxi  h,0x3000
        call prtcsm
        ;ROM 6
        mvi  b,0x28     ;40th row of text.
        mvi  c,0x11     ;17 line of text.
        lxi  h,0x2800
        call prtcsm
        ;ROM 5
        mvi  b,0x23     ;35th row of text.
        mvi  c,0x11     ;17 line of text.
        lxi  h,0x2000
        call prtcsm
        ;ROM 8
        mvi  b,0x1E     ;30th row of text.
        mvi  c,0x11     ;17 line of text.
        lxi  h,0x3800
        call prtcsm


;Put Cursor onto last line.
        lda  lcnt       ;Get total line count
        dcr  a          ;Decrease it by one
        sta  pgln       ;Store it in line count.
        mvi  b,0x01
        mvi  c,0x15     ;Third line of text.
        call mvcurs     ;Update cursor address.
        ret
        ;Done with printing test placard.

;#############################################
;Attributes memory checker.
atrchk: lxi h,9000
afll:   mov m,b
        inx h
        mov a,h
        cpi 0xA0        ;Looking for 0xA000, which is one greater than 0x9FFF.
        jnz afll
        ;Now check
        lxi h,9000
atst:   mov a,m
        ani 0x0F        ;Only test lower nibble
        xra b
        cnz attrFl      ;If not zero then there was a failure.
        inx h
        mov a,h
        cpi 0xA0        ;Looking for 0xA000, which is one greater than 0x9FFF.
        jnz atst
        ret

;Figure out which chip had the failure.
attrFl: push b
        push h
        lda  dspstt     ;If there is an attributes memory fault then disable global attributes.
        ani  0xEF
        out  0x3F
        sta  dspstt
        mvi  a,0x9B
        cmp  h      ;if H>A then C=1. else C=0
        jc   atr4f
        mvi  a,0x97
        cmp  h      ;if H>A then C=1. else C=0
        jc   atr3f
        mvi  a,0x93
        cmp  h      ;if H>A then C=1. else C=0
        jc   atr2f
        jmp  atr1f

atr1f:  mvi  b,0x1E
        mvi  c,0x08     ;8th line of text.
        jmp  prtAF
atr2f:  mvi  b,0x23
        mvi  c,0x08     ;8th line of text.
        jmp  prtAF
atr3f:  mvi  b,0x28
        mvi  c,0x08     ;8th line of text.
        jmp  prtAF
atr4f:  mvi  b,0x2D
        mvi  c,0x08     ;8th line of text.
        jmp  prtAF
;Print the 'Failures'
prtAF:  call mvcurs     ;Update cursor address.
        lxi  h,Fail     ;Print "Fail "
        call fstring
        pop  h
        pop  b
        ret
;Print the 'Passes'
prtAP:  call mvcurs     ;Update cursor address.
        lxi  h,Pass     ;Print "Pass "
        call fstring
        ret

;Calculate and then Print rom checksum using HL as the ROM pointer.
prtcsm: shld chkadr     ;store the address.
        call mvcurs     ;Update cursor address.
        lxi b,0x0800    ;set BC to rom size, will be used for rom size.
        lxi d,0x0000    ;clear DE, will be used for checksum adding.
        lxi h,0x0000    ;Clear the checksum.
        shld chksum     ;And then store it.
csmlp:  mov a,b
        ora c           ;Check for end of ROM
        jz  chkprt
        dcx b           ;Decrease ROM size counter.
        lhld chkadr     ;Get address to add
        mov e,m         ;get that data and move it to DE
        inx h           ;increase HL address
        shld chkadr     ;and re-store the address
        lhld chksum     ;Get current checksum
        dad d           ;add them together
        shld chksum     ;then store it back in memory.
        jmp csmlp
;Print the checksum now.
chkprt: lhld chksum     ;Load the checksum
        mov a,h
        call printh     ;Print upper byte
        mov a,l
        call printh     ;Print lower byte
        ret

;prints whatever is in the A reg in HEX onto the screen
printh:	push b
	mov  b,a	;Make a copy of A into the B reg.
	ani  0xF0	;AND A and 0xF0
	rlc		;Move the 4 remaining bits to the right.
	rlc
	rlc
	rlc
	call parsv	;Convert it to text
	call ftext
	mov  a,b	;Move B to A
	ani  0x0F
	call parsv	;Pars the result and put in in C
	call ftext
	pop  b
	ret

parsv:	adi  0x30	; Add 0x30
	mov  c,a	; Make a copy of A
	sui  0x3A	; Check to see if it is larger than 0-9
	jc  pnum	; If it's not then return
	mov  a,c	; But if it is then add 0x07 to get HEX letter A-F
	adi  0x07
	ret
pnum:	mov  a,c
	ret

;Draw a line of diamond symbols as long as what is specified in reg B
dmonds: mvi  c,0x00
dmnds:  mvi  a,0x00
        call ftext
        inr  c
        mov  a,b
        xra  c
        jnz  dmnds
        ret
;Move cursor to new location specified by b and c.
mvcurs: push h
        lxi  h,curs
        mov  m,b
        lxi  h,lnmb
        mov  m,c
        push b
        call gliadr
        call csadr
        pop  b
        pop  h
        ret
;Print string pointed to by HL.
fstring: mov a,m
        ori  0x00
        rz
        call ftext
        inx  h
        jmp  fstring
;******************************************************************************
;******************************************************************************
;Main Memory Test routine.
memcheck: mvi  a,0xA0      ;Load video registers with initializers so that it's not using DMA and slowing down the memory check.
        out  0x3C
        mvi  a,0x00
        out  0x3B
        mvi c,0x80    ;Use BC for walking bits right
        lxi d,0x0008    ;A '1' in D indicates a chip failure. E is pass count. Do 8 passes to test all 8 bits of each byte of ram.
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
        jnz  notdnr     ;not done reading.
        mov  a,l
        cpi  0xFF
        jnz  notdnr     ;not done reading.
        jmp  pssdne
notdnr: inx  h
        jmp  memrd

;Done with a single pass. Rotate C and decrease E
pssdne: dcr e
        jz  memdone     ;If E is 0 then we are done with memory check.
        mov a,c         ;Rotate C to the right.
        rrc
        mov c,a
        jmp chagn       ;Load in the next set and do the test again.

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

;Set the pertaining bit in reg D for each memory failure detected in a chip.
bnk4f:  mov  a,b
        xra  m          ;Do the test again.
        ani  0xF0       ;test the upper four bytes.
        jz   b4lwr      ;if it's clear than it's the lower four bytes that tested bad.
        mov a,d
        ori 0x01
        mov d,a
        mov  a,b
        xra  m          ;Do the test again.
        ani  0x0F       ;test the lower four bytes. If clear then it was only the upper four bytes that tested bad.
        jz cntck        ;continue checking.
b4lwr:  mov a,d
        ori 0x02
        mov d,a
        jmp cntck   ;continue checking.

bnk3f:  mov  a,b
        xra  m          ;Do the test again.
        ani  0xF0       ;test the upper four bytes.
        jz   b3lwr      ;if it's clear than it's the lower four bytes that tested bad.
        mov a,d
        ori 0x04
        mov d,a
        mov  a,b
        xra  m          ;Do the test again.
        ani  0x0F       ;test the lower four bytes. If clear then it was only the upper four bytes that tested bad.
        jz cntck        ;continue checking.
b3lwr:  mov a,d
        ori 0x08
        mov d,a
        jmp cntck   ;continue checking.

bnk2f:  mov  a,b
        xra  m          ;Do the test again.
        ani  0xF0       ;test the upper four bytes.
        jz   b2lwr      ;if it's clear than it's the lower four bytes that tested bad.
        mov a,d
        ori 0x10
        mov d,a
        mov  a,b
        xra  m          ;Do the test again.
        ani  0x0F       ;test the lower four bytes. If clear then it was only the upper four bytes that tested bad.
        jz cntck        ;continue checking.
b2lwr:  mov a,d
        ori 0x20
        mov d,a
        jmp cntck   ;continue checking.

bnk1f:  mov  a,b
        xra  m          ;Do the test again.
        ani  0xF0       ;test the upper four bytes.
        jz   b1lwr      ;if it's clear than it's the lower four bytes that tested bad.
        mov a,d
        ori 0x40
        mov d,a
        mov  a,b
        xra  m          ;Do the test again.
        ani  0x0F       ;test the lower four bytes. If clear then it was only the upper four bytes that tested bad.
        jz cntck        ;continue checking.
b1lwr:  mov a,d
        ori 0x80
        mov d,a
        jmp cntck   ;continue checking.

;If there was a failure, try to find some good memory to put basic text data to show which ram chips were detected failures.
memdone: mov  a,d
         ori  0x00
         jz  sysrdy      ;If no 1's in D then memory test passed and continue to system ready.
         mvi  a,0x00
         out  0x3B
         mov a,d
         ani 0x03
         jz  stk1
         mov a,d
         ani 0x0C
         jz  stk2
         mov a,d
         ani 0x30
         jz  stk3
         jmp  stk4
;Try to put stack somewhere else other than where a detected memory failure is at, this way we can use our TX routine.
;Also try to start video processor at beginning of good memory bank where we will later put basic text data.
stk1:   lxi sp,0x8FFF
        lxi h,0x8C01
        mvi a,0x8C
        out  0x3C
        jmp dinit
stk2:   lxi sp,0x8BFF
        lxi h,0x8801
        mvi a,0x88
        out  0x3C
        jmp dinit
stk3:   lxi sp,0x87FF
        lxi h,0x8401
        mvi a,0x84
        out  0x3C
        jmp dinit
stk4:   lxi sp,0x83FF
        lxi h,0x8001
        mvi a,0x80
        out  0x3C
        ;Attempt to display memory error if there was one.
        ;Load each bit into carry and test. Do this 8 times.
dinit:  mvi a,0x08  ;Turn brightness of CRT up to a level that is just visible.
        out 0x3A
        call p1init ;Initialize the serial port.
        mvi  e,0x08
prterr: mov a,d
        ral
        mov d,a
        jc   fbnk       ;Failure detected in this bank. Print 'F'
        mvi  a,0x50     ;No failure in this bank, load the ASCII letter 'P' into A
        mov  m,a        ;Print successes to screen
        call TX         ;Try to send it out the serial port as well.
nxbnk:  dcr  e
        inx  h
        jz   errlp      ;When done, goto error loop where the CPU is halted.
        jmp  prterr
;Print Failures.
fbnk:   mvi  a,0x46     ;Load the ASCII letter 'F' into A
        mov  m,a        ;Print failures to screen
        call TX         ;Try to send it out the serial port as well.
        jmp  nxbnk

;error loop.
errlp:  hlt
        jmp errlp

p1init: mvi a,0x24  ;Select T0 MSB, RX
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
    ;Setting the timer resets USART.
    ;Configure USART
    mvi a,0x4E  ;Configure serial port for 8N1, 16 clocks per bit.
    out 0x01
    mvi a,0x05  ;Enable transmit and receive.
    out 0x01
    ;Configure additional port attributes
    mvi a,0x00  ;Use external timer for BAUD
    out 0x3E
    ret

;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;Hardware serial port routines.
;Transmit
TX: out 0x00    ;Load serial port with data byte. This should auto start transmitting.
;Loop until done transmitting.
TL: in  0x01    ;Get status
    ani 0x01    ;And it with 0x01
    jz  TL      ;if not zero then it's done.
    ret

;Receive IRQ
RXCHK:  push b
        push d
        push h
        push psw
        in  0x01    ;Get status
        ani 0x02    ;And it with 0x02
        jz  RXdne   ;if 1 then there's a data byte ready.
        call tbrhi  ;Turn brightness up and restart the screen saver timer.
;If there is data then read it into the RX buffer.
        lda RXBPT   ;Get input buffer index
        mov c,a     ;Move it to C
        mvi b,0x00  ;Clear B
        lxi h,RXstrt    ;Get buffer start address
        dad b       ;Add them together.
        in  0x00    ;Read serial port 1 RX data.
        mov m,a     ;Move it into the buffer.
        lda RXBPT   ;Get input buffer index
        mov c,a
        cpi RXblng  ;compare it with max length
        jz  rbrst   ;reset index if it's at it's max.
        mov a,c   ;Get input buffer index
        inr a       ;Otherwise increase it by one.
        sta RXBPT   ;Store input buffer index
RXdne:  pop psw
        pop h
        pop d
        pop b
        EI          ;re-enable IRQ's
        ret

rbrst:  mvi a,0x01
        sta RXBPT
        jmp RXdne

;Print what's in the buffer. FIFO
prtbff: lda RXBFF   ;Get print buffer index
        mov c,a     ; Put it in C
        lda RXBPT   ;Get input buffer index put it in A
        cmp c       ;Compare A and C
        rz          ;If they are the same then return.
        ;If they are different then continue and loop.
        mvi b,0x00
        lxi h,RXstrt    ;Get buffer start address
        dad b       ;Add them together.
        mov a,m     ;Get Buffer data and put it in A
        call ftext  ;Put that data on display.
        lda RXBFF   ;Get print buffer index
        mov c,a     ;Put it in C
        cpi RXblng  ;compare it with max length
        jz  pbrst   ;reset index if it's at it's max.
        mov a,c   ;Get print buffer index
        inr a       ;Otherwise increase it by one.
        sta RXBFF   ;Store input buffer index
        jmp prtbff  ;Loop

pbrst:  mvi a,0x01
        sta RXBFF
        jmp prtbff  ;Loop

;Second ROM
;################################################################################################################################
;################################################################################################################################
;################################################################################################################################
;################################################################################################################################
;################################################################################################################################
;################################################################################################################################
;################################################################################################################################
;################################################################################################################################
;Second ROM
org 0x0800

;ESC sequence stuff.
;Display Setting ESC code
sdsp:   mov a,b
        call nTOb       ;Convert numpad entry into binary bits.
        mov c,a
        lda dspstt      ;get display settings.
        xra c           ;Xor it with C
        sta dspstt      ;store display settings.
        out 0x3F        ;update the display settings.
        mvi a,0xFF
        sta escprs      ;reset escprs
        jmp  fmtdon

;Line attribute setting ESC code. Modifies the next line after current working line.
slinea: lhld cladr      ;Get line start address and put it in HL
        lda  ccnt       ;Get col count
        mov  e,a
        mvi  d,0x00
        dad  d          ;Get to end of line attributes.
        inx  h          ;Bump it one more.
        mov  a,b        ;Get setting data back.
        call nTOb       ;Convert numpad entry into binary bits.
        ani  0xF0       ;Only modify the upper four bits.
        mov  c,m        ;Put memory into C
        xra  c          ;toggle via Xor'ing it with C
        mov  m,a        ;Result is in A, move it back to memory.
        mvi a,0xFF
        sta escprs      ;reset escprs
        jmp  fmtdon

;Attribute setting ESC code. Modifies current line.
sattrb: lhld cladr      ;Get line start address and put it in HL
        mov  a,b        ;Get setting data back.
        call nTOb       ;Convert numpad entry into binary bits.
        mov  c,m        ;Put memory into C
        xra  c          ;toggle via Xor'ing it with C
        mov  m,a        ;Result is in A, move it back to memory.
        mvi a,0xFF
        sta escprs      ;reset escprs
        jmp  fmtdon

;Character Attribute setting ESC code. Modifies current char.
schar:  mov  a,b        ;Get setting data back.
        call nTOb       ;Convert numpad entry into binary bits.
        mov  c,a        ;Put bits into C
        lda  sattb      ;get attributes setting.
        xra  c          ;toggle via Xor'ing it with C
        sta  sattb      ;get attributes setting.
        mvi a,0xFF
        sta escprs      ;reset escprs
        jmp  fmtdon

;numpad to binary bit.
nTOb:   cpi  0x31
        jz   num1
        cpi  0x32
        jz   num2
        cpi  0x33
        jz   num3
        cpi  0x34
        jz   num4
        cpi  0x35
        jz   num5
        cpi  0x36
        jz   num6
        cpi  0x37
        jz   num7
        cpi  0x38
        jz   num8
        mvi  a,0x00
        ret
num1:    mvi  a,0x01
        ret
num2:    mvi  a,0x02
        ret
num3:    mvi  a,0x04
        ret
num4:    mvi  a,0x08
        ret
num5:    mvi  a,0x10
        ret
num6:    mvi  a,0x20
        ret
num7:    mvi  a,0x40
        ret
num8:    mvi  a,0x80
        ret

