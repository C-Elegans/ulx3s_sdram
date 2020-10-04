# ulx3s_sdram
SDRAM experiments on the ULX3S

# Synthesis

``bash synth.sh``

# Programming
## [openFPGALoader](https://github.com/trabucayre/openFPGALoader)
Use openFPGALoader with the host computer connected
directly to the USB1 on the ULX3S. This can be as slow
as 30s.

``openFPGALoader -b ulx3s -m ulx3s_top.bit``

## [OpenOCD](http://openocd.org/getting-openocd/)
You may need to install the latest version of openocd
on MacOS with ``brew install -s --HEAD openocd``.

You also need a JTAG capable cable connected
directly to the ULX3S JTAG header(which you have to
solder on).

Using openocd in this manner can be as fast as 3 seconds.

``openocd -f ftdi-232.cfg -f ecp5.cfg``

# Results

You should observe the following values on the LEDs.

 - 0x78
 - 0x56
 - 0x34
 - 0x12 