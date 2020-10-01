`timescale 1ns/1ps
module top(/*AUTOARG*/
   // Outputs
   DRAM_ADDR, DRAM_BA, DRAM_CAS_N, DRAM_CKE, DRAM_CLK, DRAM_CS_N,
   DRAM_DQM, DRAM_RAS_N, DRAM_WE_N, led,
   // Inouts
   DRAM_DQ,
   // Inputs
   CLOCK_50, CLOCK_100, CLOCK_100_del_3ns, rst, button
   );
   input CLOCK_50;
   input CLOCK_100;
   input CLOCK_100_del_3ns;
   input rst;
   input button;
   
   
   output [12:0] DRAM_ADDR;
   output [1:0]  DRAM_BA;
   output        DRAM_CAS_N;
   output 	 DRAM_CKE;
   output 	 DRAM_CLK;
   output        DRAM_CS_N;
   inout [15:0]  DRAM_DQ;
   output [1:0]  DRAM_DQM;
   output        DRAM_RAS_N;
   output        DRAM_WE_N;
   output [7:0]  led;
   
   
   wire [23:0] 	 address;
   wire [31:0] 	 data_out;
   wire [31:0] 	 data_in;
   wire 	 req_read;
   wire 	 req_write;
   wire 	 data_valid;
   wire 	 write_complete;
   
   

   sdram_controller3 controller(/*AUTOINST*/
				// Outputs
				.data_out	(data_out[31:0]),
				.data_valid	(data_valid),
				.write_complete	(write_complete),
				.DRAM_ADDR	(DRAM_ADDR[12:0]),
				.DRAM_BA	(DRAM_BA[1:0]),
				.DRAM_CAS_N	(DRAM_CAS_N),
				.DRAM_CKE	(DRAM_CKE),
				.DRAM_CLK	(DRAM_CLK),
				.DRAM_CS_N	(DRAM_CS_N),
				.DRAM_DQM	(DRAM_DQM[1:0]),
				.DRAM_RAS_N	(DRAM_RAS_N),
				.DRAM_WE_N	(DRAM_WE_N),
				// Inouts
				.DRAM_DQ	(DRAM_DQ[15:0]),
				// Inputs
				.CLOCK_50	(CLOCK_50),
				.CLOCK_100	(CLOCK_100),
				.CLOCK_100_del_3ns(CLOCK_100_del_3ns),
				.rst		(rst),
				.address	(address[23:0]),
				.req_read	(req_read),
				.req_write	(req_write),
				.data_in	(data_in[31:0]));

   driver driver(
		 // Outputs
		 .address		(address[23:0]),
		 .req_read		(req_read),
		 .req_write		(req_write),
		 .data_in		(data_in[31:0]),
		 .led			(led[7:0]),
		 // Inputs
		 .clk			(CLOCK_50),
		 .rst			(rst),
		 .button                (button),
		 .data_out		(data_out[31:0]),
		 .data_valid		(data_valid),
		 .write_complete	(write_complete));
   
   
endmodule
