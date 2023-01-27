A collection of info for the Datamedia DT80 terminal.

I found it in an area about 10 yards from a creek that sees frequent flooding from the creek when it rains. It was in bad shape.

Restoration pictures can be found here:

https://imgur.com/a/k5q9cSh

https://imgur.com/a/ZNHksjy

https://imgur.com/a/dp7g6D7

https://imgur.com/a/CYnG6me

https://imgur.com/a/BXIMCau

and restoration playlist can be found here:

https://www.youtube.com/watch?v=23zrD_eBGzU&list=PLwSyG2RzSC1Ws-bqocjMjpOM1eAAWK26V

Roms are toast, but I've included them anyways. I fixed the char rom, but the firmware roms are still toast. Until I can find a copy of the originals, I will have to
reverse engineer the terminal and write my own. UPDATE!! I managed to get ahold of some original rom chips! They have been included.

Found someone with a terminal and they loaned me the ROMs to read. I've included what I was able to get from them.

If you have a DT80 terminal you are trying to debug, the directory "1ROMDEBUGGER" might interest you.

It is a debugger I wrote for the DT80 terminal that only uses one 2K rom chip and has the bare minimum code to get a terminal and text

onto the terminal's display. It does not use the DT80's keyboard. Instead it uses serial port 1 at 9600 8n1.

UPDATE: With an original copy of the firmware ROMs, I still am unable to get the terminal to work. I presume it's because I still don't have a keyboard so I've

began writing my own firmware from scratch called 'CDT80' which stands for "Cloned DT80". As of today, Jan 26, 2023, I have some basic funcationality implemented

such as a power on memory test and ROM checksum generator. It's designed so that this part of the firmware will work with just ONE ROM chip. The second ROM chip is

for extended functionality later on and is currently only being used for basic character attributes code.