# ulx3s_sdram
SDRAM experiments on the ULX3S

# Synthesis

``bash synth.sh``

# Programming
Use openFPGALoader with the host computer connected
directly to the USB1 on the ULX3S

``openFPGALoader -b ulx3s -m ulx3s_top.bit``

or use openocd with a JTAG capable cable connected
directly to the ULX3S JTAG header(which you have to
solder on)

Using openocd in this manner can be as fast as 3 seconds.

``openocd -f ftdi-232.cfg -f ecp5.cfg``
