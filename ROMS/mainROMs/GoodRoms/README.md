These are my best attempts at reading some known working ROM chips from a DT80 that was sent to me. I haven't fully tested them in my own DT80 however the dissassembly looks good so far.

I've read them multiple ways to verify a good read. The other read attempts have been included but are now mostly redundant as they are the same copy. I've only kept them for the sake of documenting my process.

I've found where the checksums are stored. They are stored in the 8th rom chip at address 0x05E0 little endian.

I have verified the checksums and they all match with the read that I had gotten. So this should be a good copy.