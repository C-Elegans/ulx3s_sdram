`timescale 1ns/1ps
module driver_tb;
   `include "sdr_parameters.vh"
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [12:0]		DRAM_ADDR;		// From uut of top.v
   wire [1:0]		DRAM_BA;		// From uut of top.v
   wire			DRAM_CAS_N;		// From uut of top.v
   wire			DRAM_CKE;		// From uut of top.v
   wire			DRAM_CLK;		// From uut of top.v
   wire			DRAM_CS_N;		// From uut of top.v
   wire [15:0]		DRAM_DQ;		// To/From uut of top.v
   wire [1:0]		DRAM_DQM;		// From uut of top.v
   wire			DRAM_RAS_N;		// From uut of top.v
   wire			DRAM_WE_N;		// From uut of top.v
   wire [7:0]		led;			// From uut of top.v
   // End of automatics
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg			CLOCK_100;		// To uut of top.v
   reg			CLOCK_100_del_3ns;	// To uut of top.v
   reg			CLOCK_50;		// To uut of top.v
   reg			rst;			// To uut of top.v
   reg                  button;
   // End of automatics

   top uut(/*AUTOINST*/
	   // Outputs
	   .DRAM_ADDR			(DRAM_ADDR[12:0]),
	   .DRAM_BA			(DRAM_BA[1:0]),
	   .DRAM_CAS_N			(DRAM_CAS_N),
	   .DRAM_CKE			(DRAM_CKE),
	   .DRAM_CLK			(DRAM_CLK),
	   .DRAM_CS_N			(DRAM_CS_N),
	   .DRAM_DQM			(DRAM_DQM[1:0]),
	   .DRAM_RAS_N			(DRAM_RAS_N),
	   .DRAM_WE_N			(DRAM_WE_N),
	   .led				(led[7:0]),
	   // Inouts
	   .DRAM_DQ			(DRAM_DQ[15:0]),
	   // Inputs
	   .CLOCK_50			(CLOCK_50),
	   .CLOCK_100			(CLOCK_100),
	   .CLOCK_100_del_3ns		(CLOCK_100_del_3ns),
	   .rst				(rst),
	   .button			(button));

   sdr ram(
	   // Inouts
	   .Dq				(DRAM_DQ),
	   // Inputs
	   .Clk				(DRAM_CLK),
	   .Cke				(DRAM_CKE),
	   .Cs_n			(DRAM_CS_N),
	   .Ras_n			(DRAM_RAS_N),
	   .Cas_n			(DRAM_CAS_N),
	   .We_n			(DRAM_WE_N),
	   .Addr			(DRAM_ADDR),
	   .Ba				(DRAM_BA),
	   .Dqm				(DRAM_DQM));
   
   initial begin
      CLOCK_50 = 1;
      CLOCK_100 = 1;
      CLOCK_100_del_3ns = 1;
      rst = 1;
      button = 0;
      

      $dumpfile("dump.vcd");
      $dumpvars;

      #20000 $finish;
   end

   initial begin
      # 50 rst = 0;
      # 3000 button = 1;
      # 100 button = 0;
      # 500 button = 1;
      # 100 button = 0;
      # 500 button = 1;
      # 100 button = 0;
      # 500 button = 1;
      # 100 button = 0;
		      
   end


   
      always #10 CLOCK_50 <= ~CLOCK_50;
   always #5 begin
      CLOCK_100 <= ~CLOCK_100;
   end
   always @(CLOCK_100) begin
      #3
        CLOCK_100_del_3ns <= CLOCK_100;
   end

endmodule
