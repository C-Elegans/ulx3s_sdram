module ulx3s_top(/*AUTOARG*/
   // Outputs
   sdram_clk, sdram_cke, sdram_csn, sdram_wen, sdram_rasn, sdram_casn,
   sdram_a, sdram_ba, sdram_dqm, led,
   // Inouts
   sdram_d,
   // Inputs
   btn, clk_25mhz
   );
   output sdram_clk;
   output sdram_cke;
   output sdram_csn;
   output sdram_wen;
   output sdram_rasn;
   output sdram_casn;

   output [12:0] sdram_a;
   output [1:0]  sdram_ba;
   output [1:0]  sdram_dqm;
   inout [15:0]  sdram_d;

   input [2:1] 	 btn;
   input 	 clk_25mhz;
   output [7:0]  led;


   wire 	 CLOCK_100;
   wire 	 CLOCK_100_del_3ns;
   wire 	 CLOCK_50;
   
   reg [2:0] 	 rst_sync = 3'b111;
   always @(posedge CLOCK_50)
     rst_sync <= {rst_sync[1:0], btn[1]};
   
   wire 	 rst = rst_sync[2];
   

   pll pll(/*AUTOINST*/
	   // Outputs
	   .CLOCK_100			(CLOCK_100),
	   .CLOCK_100_del_3ns		(CLOCK_100_del_3ns),
	   .CLOCK_50			(CLOCK_50),
	   .locked			(locked),
	   // Inputs
	   .clkin			(clk_25mhz));

   top top(
	   // Outputs
	   .DRAM_ADDR			(sdram_a),
	   .DRAM_BA			(sdram_ba),
	   .DRAM_CAS_N			(sdram_casn),
	   .DRAM_CKE			(sdram_cke),
	   .DRAM_CLK			(sdram_clk),
	   .DRAM_CS_N			(sdram_csn),
	   .DRAM_DQM			(sdram_dqm),
	   .DRAM_RAS_N			(sdram_rasn),
	   .DRAM_WE_N			(sdram_wen),
	   .led				(led[7:0]),
	   // Inouts
	   .DRAM_DQ			(sdram_d[15:0]),
	   // Inputs
	   .CLOCK_50			(CLOCK_50),
	   .CLOCK_100			(CLOCK_100),
	   .CLOCK_100_del_3ns		(CLOCK_100_del_3ns),
	   .rst				(rst),
	   .button			(btn[2]));
   
   
endmodule
   
   
