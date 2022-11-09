This is an experimental clone of the DT80's original firmware. I'm writing this to learn about the DT80's hardware

and because I still haven't gotten the original firmware working. So this is also being used to debug the system

as I'm writing it and attempting to implement features. It's already revealed a few more problems with the hardware.

I will try to stay true to the original features as close as possible. I might even add a few new or modern features.

Current working version can only receive data at 9600 8N1. I don't have a keyboard yet.

I wouldn't say that this is even complete enough to properly display text. The cursor still has 

problems, and I don't know enough about the hardware to properly implement all ANSI standards as of yet. I have 

my own ESC sequences implement, but it's not ANSI and it's only for reverse engineering purposes.


Some addition info about the hardware as I'm discovering it.

OUT REG: 0x3F bits;

B1 = Works with B3 of individual char attributes. Hides or Unhides characters. Using this to blink text.

B2 = Swaps Invert and Underline character attributes.

B3 = Interlace Enable/Disable

B4 = Blanks entire display.

B5 = Enables/Disables individual char attributes.

B6 = 50hz/60hz mode.

B7 = 80col/132col

B8 = Inverts entire display.