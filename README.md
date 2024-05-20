# Purely_Hardware_Tetris_Implementation

This project was a assignment of the class of ECE 385 Digital Systems Design. My partner and I designed a purely hardware version of tetris.

----

To run this, one needs to have a Microblaze processor, accompanied by GPIO for the keyboard. Furthermore AXI GPIOs have to be set up.

---- 

Key Aspects of the project include:

* Game-logic: A 6 state Moore State Machine was used to determine start, end, checking and falling states. This was done to prevent syncronization errors between screen updates. 

* Memory: We instantiated the game as a 25 by 12 grid. The top and bottom rows and columns were used as a boundary, which would later simplify game logic. Furthermore the top four rows are used simply for rendering a new block.

* Block Checking: We used a 16 bit binary to encode every block allowing us the flexibility to decide on the drawing of each block. Furthermore, grid array representation allowed us to do a simple XOR to determine if a particular block was there or not. This being true regardless of whether the block was dropped or was a boundary.

* Random Number Generator: We used a linear feedback shift register to get the encoding of random bit strings for every new block. We use a 16 bit shift register seeded on reset. Every clock cycle the 13th and 15th bit off the a shift register is XNORed together and left shifted in the register, allowing for a pseudo random state. This would then be seeded in the a new block state.

* Graphics: We used a VGA to HDMI converter IP using RGB values and a cathode ray coordinate system to allow for text mode and pixel mode graphics.
