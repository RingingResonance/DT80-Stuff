;# 8085 based system debugging tool.
;# Jarrett Cigainero 2022

;########################
;########################
;########################
;########################
;# Command and Text Locations
textstart	EQU	0x0044
htext		EQU	textstart + 0x0000
help		EQU	textstart + 0x0043
hexread		EQU	textstart + 0x0049
hexwrite	EQU	textstart + 0x0052
jump		EQU	textstart + 0x005C
ioread		EQU	textstart + 0x0062
iowrite		EQU	textstart + 0x006A
BadSyn      EQU textstart + 0x0074
ImIn		EQU	textstart + 0x0083
ucmd		EQU	textstart + 0x00B1
newln		EQU	textstart + 0x00C1
prmt		EQU	textstart + 0x00C4
bkspce		EQU	textstart + 0x00C9
hex         EQU textstart + 0x00CD

;########################
;########################
;# Memory
romSt		EQU	0x0000	;ROM start address
romEnd		EQU	0x07FF	;ROM end address. 2K ROM chip; no need to test before that.
;# Dynamic Memory map. These get added to the 'found block' start address
autobd		EQU	0x0000  ;autobaud setting
mendL		EQU	0x0001	;Memory block end address lower byte
mendH		EQU	0x0002	;Memory block end address upper byte
rdL         EQU 0x0003  ;read lower byte
rdH         EQU 0x0004  ;read upper byte
dio         EQU 0x0005  ;data IO
dioadr      EQU 0x0006  ;data IO address
dioret      EQU 0x0007  ;data IO return address
wrhx1       EQU 0x0008
wrhx2       EQU 0x0009
cmdstrt		EQU	0x000A	;Command Storage start address.
quiet       EQU 0x0012

curs    equ 0x8FFF      ;Cursor position.
ccfg    equ 0x8FFE      ;Cursor config.
lnmb    equ 0x8FFD      ;Current working line.
flU     equ 0x8FFC      ;First Line address pointer Upper.
flL     equ 0x8FFB      ;First Line address pointer Lower.
ccnt    equ 0x8FFA      ;Column count setting.
wlU     equ 0x8FF9      ;Current displaying line number address Upper.
wlL     equ 0x8FF8      ;Current displaying line number address Lower.
lcnt    equ 0x8FF7      ;Line count setting.
pgln    equ 0x8FF6      ;Page total number of lines
stack   equ 0x8FF5      ;Stack pointer
bgnadr  equ 0x8000      ;Beginning address of ram
;Constants
flMU    equ 0xA0        ;Starting point of text. Upper
flML    equ 0x50        ;Starting point of text. Lower


;#########################################################################################################
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
	nop		;Mark it with a few 0x00's for easier editing in the hex editor.
	nop
	nop
	nop

org 0x0115
init:    ;Configure USART
    mvi a,0x64  ;Select T1 MSB, TX
    out 0x13
    mvi a,0x00
    out 0x11
    mvi a,0x54  ;Select T1 LSB, TX
    out 0x13
    mvi a,0x0C  ;Load D12 for 9600BAUD
    out 0x11
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
;Copy text to video memory until we hit a null char.
        lxi h,0x069B
        call print
;Reconfigure memory space
        lxi d,stack     ;Set DE to stack address as well.
        lxi sp,stack
        lxi b,bgnadr    ;Set the beginning address to our choosing.
;##################################################
;# Move our end address to a spot in ram.
    lxi  h,mendL	;Load address index to HL
	dad  b		;Add BC to HL
	mov  m,e	;Do the data transfer.
	lxi  h,mendH	;Load address index to HL
	dad  b		;Add BC to HL
	mov  m,d	;Do the data transfer.
	mov  d,b	;Move BC to DE. This is our new memory start address.
	mov  e,c	;As long as we keep the contents of one of these two safe, we will always know where to start and where our memory end address is as it's stored in the memory locations just before this.
;######################################################
;# Print welcome text.
wlcm: lxi  h,ImIn	;Point to 1337 HAX0R T3XT
	call print	;Print some 1337 HAX0R T3XT
;#### Print memory space ####
;Print the range of the block of ram we found.
	mov  a,b
	call printh	;Print the contents of B
	mov  a,c
	call printh	;Print the contents of C
	mvi  a,0x2D	;Move char '-' into A to be used by TX
	call tx
;Now for the end address we have to get that info back out of our memory location mentioned earlier.
	lxi  h,mendH	;Load address index to HL
	dad  b		;Add BC to HL
	mov  a,m	;Do the data transfer.
	call printh	;Print the Upper 8 bits
	lxi  h,mendL	;Load address index to HL
	dad  b		;Add BC to HL
	mov  a,m	;Do the data transfer.
	call printh	;Print the Lower 8 bits

;Load a RET instruction to this spot in ram for use later.
    lxi  h,dioret  ;Use address indexed by 'dioret'
    dad  d
    mvi  m,0xC9 ;Move 'RET' operand to space in memory.

;###################################################
;###################################################
;###################################################
;############## Command Interpreter ################
prompt:	lxi  h,prmt	;print command promt stuff "NL + RET + '#:' "
	call print
	lxi  h,cmdstrt
	dad  d          ;DE should still be our base address.
	mov  b,h        ;From now on, BC is used to compare to HL to see how much was typed if anything was typed.
    mov  c,l

;###################################################################
;This is our command/Text input subroutine.
;No protection from keeping someone from typing until
;the program overwrites the stack!
mn:	call rx		;Loops in this sub waiting for a key press
 	mov  m,a	;Move keypress to memory
 	cpi  0x08	;Check what keypress is in A
 	jz   bkspc	;Check for Backspace.
	cpi  0x0D
 	jz   enter	;Check for Enter.
	mov  a,m    ;Echo not what has been typed, but what has been stored in memory.
 	call tx		;Now send it.
 	inx  h		;Key entered, move to next memory location.
 	jmp  mn		;Loop again.

enter:	mov  a,l	;check to see if anything was typed. If not then go back to prompt.
 	cmp  c          ;This is crude as if the correct amount of data is entered it won't catch this.
	jz   prompt
	push h
	lxi  h,newln	;Print newline when enter/return is pressed.
	call print
	pop  h
	jmp  cmdint     ;Jump to command interpreter.

bkspc:	mov  a,l	;Get address (stored in HL) of command array
 	cmp  c		;If it matches with BC then we have backspaced all the way
	jnz  backs	;Backspaced all the way.
	mov  a,h	;Get address (stored in HL) of command array
 	cmp  b		;If it matches with BC then we have backspaced all the way
	jz   mn		;Backspaced all the way, don't backspace anymore.
backs: 	dcx  h		;Backspace. Clear text on screen and decrease command array pointer (HL)
	push h
	lxi  h,bkspce
	call print
	pop  h
 	jmp  mn


;#####################################
;######## Command Comparison #########
;## help text command
cmdint:	mov  h,b	;Put the HL reg back to start of prompt array.
	mov  l,c
	push b		;Push BC onto the stack.
	push d		;Push DE onto the stack.
	lxi d,help	;############## Location of text to compare to. ################
	call cmdcmp
	mov a,b
	pop d		;Pop DE off the stack.
	pop b		;Pop BC off the stack.
 	cpi 0x02	;If cmdcmp returned a 2 then it wasn't a match. Move on to the next command to test.
 	jnz phelp	;Print Help Text.

;## hexread command
	mov  h,b	;Put the HL reg back to start of prompt array.
	mov  l,c
	push b		;Push BC onto the stack.
	push d		;Push DE onto the stack.
	lxi d,hexread	;############## Location of text to compare to. ################
	call cmdcmp
	mov a,b
	pop d		;Pop DE off the stack.
	pop b		;Pop BC off the stack.
 	cpi 0x02	;If cmdcmp returned a 2 then it wasn't a match. Move on to the next command to test.
 	jnz hread	;Print memory specified by user.

;## hexrite command
	mov  h,b	;Put the HL reg back to start of prompt array.
	mov  l,c
	push b		;Push BC onto the stack.
	push d		;Push DE onto the stack.
	lxi d,hexwrite	;############## Location of text to compare to. ################
	call cmdcmp
	mov a,b
	pop d		;Pop DE off the stack.
	pop b		;Pop BC off the stack.
 	cpi 0x02	;If cmdcmp returned a 2 then it wasn't a match. Move on to the next command to test.
 	jnz hwrite	;Allow user to input data manually into memory.

;## ioread command
	mov  h,b	;Put the HL reg back to start of prompt array.
	mov  l,c
	push b		;Push BC onto the stack.
	push d		;Push DE onto the stack.
	lxi d,ioread	;############## Location of text to compare to. ################
	call cmdcmp
	mov a,b
	pop d		;Pop DE off the stack.
	pop b		;Pop BC off the stack.
 	cpi 0x02	;If cmdcmp returned a 2 then it wasn't a match. Move on to the next command to test.
 	jnz rdIO	;Print IO specified by user.

;## iowrite command
	mov  h,b	;Put the HL reg back to start of prompt array.
	mov  l,c
	push b		;Push BC onto the stack.
	push d		;Push DE onto the stack.
	lxi d,iowrite	;############## Location of text to compare to. ################
	call cmdcmp
	mov a,b
	pop d		;Pop DE off the stack.
	pop b		;Pop BC off the stack.
 	cpi 0x02	;If cmdcmp returned a 2 then it wasn't a match. Move on to the next command to test.
 	jnz wrIO	;Print IO specified by user.

;## jump command
	mov  h,b	;Put the HL reg back to start of prompt array.
	mov  l,c
	push b		;Push BC onto the stack.
	push d		;Push DE onto the stack.
	lxi d,jump	;############## Location of text to compare to. ################
	call cmdcmp
	mov a,b
	pop d		;Pop DE off the stack.
	pop b		;Pop BC off the stack.
 	cpi 0x02	;If cmdcmp returned a 2 then it wasn't a match. Move on to the next command to test.
 	jnz usrjmp	;Jump execution to user specified address.

;Unknown Command
	lxi  h,ucmd	;Print "Unknown Command"
	call print
	jmp  prompt	;If no command is found then jump back to prompt.

;#########################
;#### Text Comparator ####
cmdcmp:	push h
	mov h,d		;move DE to HL
	mov l,e
	mov b,m		;move char from ROM to b
	pop h		;get HL back
;check to see if the char we read from rom is 0x0A (new line) If so then all other chars have matched so far and we return 0x04.
	mov a,b		;move b to a
	cpi 0x0A	;check for 0x0A
	jz  done	;if found, then we are done.
;otherwise keep checking until we get a different char
	mov a,m		;move char from RAM to a
	cmp b		;compare a and b
	jnz diff	;if they are different than go back.
	inx d		;increment HL and DE
	inx h
	jmp cmdcmp	;do the next char
diff: 	mvi b,0x02	;RETURN 2	no match
	ret
done:	mvi b,0x04	;RETURN 4	match found
	ret

;######################################################################
;What our commands do go here.

;####
;jump
usrjmp: mov  h,b ;First index HL to beginning of command array after the command.
    mov  l,c
    lxi  b,0x0005   ;How many chars is the command?
    dad  b
    call glong  ;Get address data from args, returns them in HL
    mov  h,b    ;Move BC to HL
    mov  l,c
    pchl        ;Move HL to program counter. AKA: Indirect Jump
    nop         ;NOP buffer.
    nop

;#### "ioread"
;Read IO address specified by user
rdIO: push b
    push d
    lxi  h,dio  ;Use address indexed by 'dio'
    dad  d
    mvi  m,0xDB ;Move 'IN' operand to space in memory.
    mov  h,b    ;Index to end of command where args will be
    mov  l,c
    lxi  b,0x0007   ;End of command, beginning of args.
    dad  b
    call hget   ;Get the first two args. This will be the IO address to read.
    lxi  h,dioadr  ;Use address indexed by 'dioadr'
    dad  d
    mov  m,a ;Move 'A' to memory address.
;Now do some call trickery.
    lxi  h,dio  ;Use address indexed by 'dio'
    dad  d      ;Add HL to DE
    call iojmp  ;This should call an address that immediately exchanges the HL reg with the Program counter.
    call printh ;Now print what we just read.
    pop d
    pop b
    jmp  prompt

;####
;Write to IO address specified by user
wrIO: push b
    push d
    lxi  h,dio  ;Use address indexed by 'dio'
    dad  d
    mvi  m,0xD3 ;Move 'OUT' operand to space in memory.
    mov  h,b    ;Index to end of command where args will be
    mov  l,c
    lxi  b,0x0008   ;End of command, beginning of args.
    dad  b
    call hget   ;Get the first two args. This will be the IO address to write to.
    push h
    lxi  h,dioadr  ;Use address indexed by 'dioadr'
    dad  d
    mov  m,a ;Move 'A' to memory address.
    pop  h
;Load 'A' with next arg
    inx  h
    call hget   ;Get the second two args. This will be the data to write.
;Now do some call trickery.
    lxi  h,dio  ;Use address indexed by 'dio'
    dad  d      ;Add HL to DE
    call iojmp  ;This should call an address that immediately exchanges the HL reg with the Program counter.
    pop d
    pop b
    jmp  prompt

iojmp: pchl     ;Jump to what ever is pointed to by HL

;####
;Print Help Text
phelp:	lxi  h,htext
	call print
	jmp  prompt

;####
;Write to specified memory space.
hwrite: 	push b
	push h
	push d
;First index HL to beginning of command array after the command.
    mov  h,b
    mov  l,c
    lxi  b,0x0009
    dad  b
    call adget  ;Get address data from args, returns them in HL and variable rdL + rdH
    call ptHL   ;Print first address
	lxi  b,0x0101

wrnxt: push h
    lxi  h,wrhx1
    dad  d
    call rx     ;Wait for user input
    call tx     ;Read it back
    cpi  0x71   ;Check for the letter 'q' in case user wants to quit
    jz   usrqt
    mov  m,a
    inx  h
    call rx     ;Wait for user input
    call tx     ;Read it back
    cpi  0x71   ;Check for the letter 'q' in case user wants to quit
    jz   usrqt
    mov  m,a
    dcx  h
    call hget   ;Convert the two HEX chars to a number
    pop  h
	mov  m,a	;store A in memory.
	mvi  a,0x20	;Space between hex numbers
	call tx
;# Check for if we need an extra space
	mov  a,b
	cpi  0x10
	cz   nxtcol
	inr  b
;# Check for if we need a new line
	mov  a,c
	cpi  0x04
	cz   nxtln
;# Check for end of memory
    push h
	mov  a,h
	lxi  h,rdH
	dad  d
	cmp  m
	jnz  wnxtmem
    pop  h
    push h
	mov  a,l
	lxi  h,rdL
	dad  d
	cmp  m
	jnz  wnxtmem
 ;clear 'Q' with space
usrqt:	lxi  h,cmdstrt
    lxi  d,0x8000
    dad  d
    lxi  b,quiet
    dad  b
    mvi  m,0x20
    pop  h
	pop  d
	pop  h
	pop  b
	jmp  prompt

wnxtmem: pop h
	inx  h
	jmp  wrnxt

;####
;Read specified memory space.
hread:	push b
	push h
	push d
;First index HL to beginning of command array after the command.
    mov  h,b
    mov  l,c
    lxi  b,0x0008
    dad  b
    call adget  ;Get address data from args, returns them in HL and variable rdL + rdH
    call ptHL   ;Print first address
	lxi  b,0x0101

rdnxt:	mov  a,m	;move memory to A so printh can use it
	call printh
	mvi  a,0x20	;Space between hex numbers
	call tx
;# Check for if we need an extra space
	mov  a,b
	cpi  0x10
	cz   nxtcol
	inr  b
;# Check for if we need a new line
	mov  a,c
	cpi  0x04
	cz   nxtln
;# Check for end of memory
    push h
	mov  a,h
	lxi  h,rdH
	dad  d
	cmp  m
	jnz  nxtmem
    pop  h
    push h
	mov  a,l
	lxi  h,rdL
	dad  d
	cmp  m
	jnz  nxtmem
	;clear 'Q' with space
	lxi  h,cmdstrt
	lxi  d,0x8000
    dad  d
    lxi  b,quiet
    dad  b
    mvi  m,0x20
    pop  h
	pop  d
	pop  h
	pop  b
	jmp  prompt

nxtmem: pop h
	inx  h
	jmp  rdnxt

;Formatting system. B is number of bytes per column. C is number of columns.
;HL is address to be read from or written to.
nxtcol:	mvi  b,0x00
	inr  c
	mvi  a,0x20	;Double space between columns.
	call tx
	ret

nxtln:	lxi  b,0x0101
	push  h
	lxi  h,newln
	call print
	pop  h
	inx  h
	call ptHL   ;Print start address of new line.
	dcx  h
	ret

;######################################################################
;Hex data stuff.

;Print HL in hex (xxxxh: )
;First check for a 'Q'
ptHL: push h
    push b
    push psw
    push d
    lxi  h,cmdstrt
    lxi  d,0x8000
    dad  d
    lxi  b,quiet
    dad  b
    mov  a,m
    cpi  0x51
    jnz  notQ
    pop d
    pop psw
    pop b
    pop h
    ret
;not quite
notQ: pop d
    pop psw
    pop b
    pop h
    mov  a,h
    call printh
    mov  a,l
    call printh
    push h
    lxi  h,hex
	call print
	pop  h
	ret

;# Gets address range data from args and returns them in HL and rdL + rdH.
adget: call glong
	inx  h      ;Space between the two addresses
	call hget
	push h
	lxi  h,rdH
	dad  d      ;add HL to the offset stored in DE
	mov  m,a
	pop  h
	call hget
	lxi  h,rdL
	dad  d
	mov  m,a
	mov  h,b
	mov  l,c
	ret

glong: call hget   ;Get long data from command arg. returns it in BC
	mov  b,a
	call hget
	mov  c,a
	ret
;Gets what ever two chars are pointed to by HL, converts them to data, and
;returns it in A
hget:   push b
        mvi  a,0x00
        call geth
        rlc
        rlc
        rlc
        rlc
        mov  b,a
        inx  h
        call geth
        ora  b
        inx  h
        pop  b
        ret

geth:   mov  a,m
        cpi  0x30   ;Check if smaller than 0x30
        jc   derr
        mov  a,m
        cpi  0x3A   ;Check if smaller than or equal to 0x39
        jc   ndcd
        mov  a,m
        cpi  0x41   ;Check if smaller than 0x41
        jc   derr
        mov  a,m
        cpi  0x47   ;Check if smaller than or equal to 0x46
        jc   udcd
        mov  a,m
        cpi  0x61   ;Check if smaller than 0x61
        jc   derr
        mov  a,m
        cpi  0x67   ;Check if smaller than or equal to 0x66
        jc   ldcd
        jmp  derr
ndcd:   sui  0x30
        ret
udcd:   sui  0x37
        ret
ldcd:   sui  0x57
        ret

derr:   lxi  h,BadSyn
        call print
        mvi  a,0x00     ;Return with 0x00 in A
        ret

;prints what ever is in the A reg in HEX out the serial port
printh:	push b
	mov  b,a	;Make a copy of A into the D reg.
	ani  0xF0	;AND A and 0xF0
	rlc		;Move the 4 remaining bits to the right.
	rlc
	rlc
	rlc
	call parsv	;Convert it to text
	call tx		;send the text
	mov  a,b	;Move D to A
	ani  0x0F
	call parsv	;Pars the result and put in in C
	call tx
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

;######################################################################
;# prints a string pointed to by HL that is terminated by a null char.
print:	mov a,m
	cpi 0x00
	rz
	mov a,m
	call tx
	inx h
 	jmp print

;#### Everything below this line is our BIOS ####
;# RX and TX is our input and output.
;Hardware serial port routines.
;Transmit
tx: push b
    push d
    push h
    mov b,a
    call ftext  ;send the text to the display
    mov a,b
    out 0x00    ;Load serial port with data byte. This should auto start transmitting.
;Loop until done transmitting.
TL: in  0x01    ;Get status
    ani 0x01    ;And it with 0x01
    jz  TL      ;if not zero then it's done.
    pop h
    pop d
    pop b
    ret

;Receive
rx: push b
    push d
    push h
rrx: in  0x01    ;Get status
    ani 0x02    ;And it with 0x02
    jz  rrx      ;if not zero then there's a data byte.
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
        cpi  0x09       ;Check for new tab char.
        jz   tab        ;If new line, increase cursor position by 5 spaces!
        mov  b,a        ;get data stored in A and move it to B
        cpi  0x0A       ;Check for new line char.
        jz   newlne     ;If new line, make a new line!
        cpi  0x0D       ;Check for return char.
        jz   rtrn       ;If return char, reset cursor to 0x01!
        cpi  0x08       ;Check for backspace.
        jz   bakspc      ;If backspace, reduce cursor by 1 unless it's already at 1
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
bakspc:  lxi  h,curs     ;get cursor
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
ddone:   lxi h,wlU   ;Save working line number.
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
        jmp  ddone

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
