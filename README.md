# ulx3s_sdram
SDRAM experiments on the ULX3S

# Synthesis

``bash synth.sh``

# Programming
## [openFPGALoader](https://github.com/trabucayre/openFPGALoader)

Doing ``bash prog.sh`` programs the ULX3s over USB1
using openFPGALoader.

Due to the slow FT231 chip on the ULX3S, programming with
openFPGALoader via the FTDI chip is quite slow.

Using a JTAG cable is noticeably faster. See the next
section.


## [OpenOCD](http://openocd.org/getting-openocd/)
You may need to install the latest version of openocd
on MacOS with ``brew install -s --HEAD openocd``.

You also need a JTAG capable cable such as this
[one](https://www.mouser.com/ProductDetail/895-C232HM-EDHSL-0)
connected directly to the ULX3S JTAG header(which you have to
solder on).

Using openocd in this manner can be as fast as 3 seconds.

``openocd -f ftdi-232.cfg -f ecp5.cfg``

# Results

You should observe the following values on the LEDs.

 - 0x78
 - 0x56
 - 0x34
 - 0x12 
