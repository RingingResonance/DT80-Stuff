This init ROM uses the 8085 debugger as it's bootloader, but could be modified to work on it's own.

It looks for anything but 0xFF from the 3rd rom to the 8th rom and copys it to the screen until it 
finds a NULL char where it waits for a few seconds before copying the next block of text.

The DT80 only shows 22 lines at a time in it's current state.