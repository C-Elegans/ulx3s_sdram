`timescale 1ns/1ps
module testbench;
   `include "sdr_parameters.vh"


   wire [DQ_BITS-1:0]	Dq;			// To/From ram of sdr.v
   wire [ADDR_BITS-1:0] Addr;
   wire [BA_BITS-1:0] 	Ba;
   wire [DM_BITS-1:0] 	Dqm;
   wire 		Clk;
   wire 		Cke;
   wire 		Cs_n;
   wire 		Ras_n;
   wire 		Cas_n;
   wire 		We_n;
   

   reg 			clk_50;
   reg 			clk_100;
   reg 			clk_100_3ns;

   wire [31:0] 		data_out;
   wire 		data_valid;
   wire 		write_complete;
   
   
   reg 			rst;
   reg [23:0] 		address;
   reg 			req_read;
   reg 			req_write;
   reg [31:0] 		data_in;
   
   

   sdr ram(/*AUTOINST*/
	   // Inouts
	   .Dq				(Dq[DQ_BITS-1:0]),
	   // Inputs
	   .Clk				(Clk),
	   .Cke				(Cke),
	   .Cs_n			(Cs_n),
	   .Ras_n			(Ras_n),
	   .Cas_n			(Cas_n),
	   .We_n			(We_n),
	   .Addr			(Addr[ADDR_BITS-1:0]),
	   .Ba				(Ba[BA_BITS-1:0]),
	   .Dqm				(Dqm[DM_BITS-1:0]));

   sdram_controller3 controller(
				// Outputs
				.data_out	(data_out[31:0]),
				.data_valid	(data_valid),
				.write_complete	(write_complete),
				.DRAM_ADDR	(Addr),
				.DRAM_BA	(Ba),
				.DRAM_CAS_N	(Cas_n),
				.DRAM_CKE	(Cke),
				.DRAM_CLK	(Clk),
				.DRAM_CS_N	(Cs_n),
				.DRAM_DQM	(Dqm),
				.DRAM_RAS_N	(Ras_n),
				.DRAM_WE_N	(We_n),
				// Inouts
				.DRAM_DQ	(Dq),
				// Inputs
				.CLOCK_50	(clk_50),
				.CLOCK_100	(clk_100),
				.CLOCK_100_del_3ns(clk_100_3ns),
				.rst		(rst),
				.address	(address[23:0]),
				.req_read	(req_read),
				.req_write	(req_write),
				.data_in	(data_in[31:0]));
   
   always #10 clk_50 <= ~clk_50;
   always #5 begin
      clk_100 <= ~clk_100;
   end
   always @(clk_100) begin
      #3
        clk_100_3ns <= clk_100;
   end
   
   initial begin
      rst = 1;
      clk_50 = 0;
      clk_100 = 0;
      clk_100_3ns = 0;
      address = 0;
      req_read = 0;
      req_write = 0;
      data_in = 0;

      
      $dumpfile("dump.vcd");
      $dumpvars;

      #200000 $finish;
   end

   integer i;
   initial begin
      #20 rst = 0;


      @(posedge clk_50);
      address = 'h1000;

      data_in = 32'hdeadbeef;
      req_write = 1;
      # 20 req_write = 0;
      @(posedge write_complete);

      @(posedge clk_50);
      address = 'h1000;
      
      req_read = 1;
      # 20 req_read = 0;
      @(posedge data_valid);

      @(posedge clk_50);
      address = 'h1001;
      
      req_read = 1;
      # 20 req_read = 0;
      @(posedge data_valid);
      @(posedge clk_50);
      address = 'h1002;
      
      req_read = 1;
      # 20 req_read = 0;
      @(posedge data_valid);
   end
   
   

endmodule // testbench
