module plltest(/*AUTOARG*/
   // Outputs
   gp,
   // Inputs
   clk_25mhz
   );
   output [1:0] gp;

   input 	clk_25mhz;
   wire 	CLOCK_50;
   wire 	locked;
   
   
   pll pll(
	   // Outputs
	   .CLOCK_100			(gp[0]),
	   .CLOCK_100_del_3ns		(gp[1]),
	   .CLOCK_50			(CLOCK_50),
	   .locked			(locked),
	   // Inputs
	   .clkin			(clk_25mhz));
   
endmodule
