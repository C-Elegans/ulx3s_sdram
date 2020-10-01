`timescale 1ns/1ps
module driver(/*AUTOARG*/
   // Outputs
   address, req_read, req_write, data_in, led,
   // Inputs
   clk, rst, button, data_out, data_valid, write_complete
   );
   input clk;
   input rst;
   input button;
   

   output reg [23:0]      address;
   output reg            req_read;
   output reg            req_write;
   output reg [31:0]      data_in;
   input [31:0]       data_out;
   
   input        data_valid;
   input        write_complete;

   output reg [7:0] led;


   parameter [2:0] //synopsys enum state_info
     S_WRITE = 0,
     S_WRITE_COMPLETE = 1,
     S_READ = 2,
     S_READ_COMPLETE = 3,
     S_DATA_OUT1 = 4,
     S_DATA_OUT2 = 5,
     S_DATA_OUT3 = 6,
     S_DATA_OUT4 = 7;
   
   

   reg [2:0] 	//auto enum state_info
     state;

   reg [31:0] 	data_buffer;
   reg [2:0] 	button_sync;

   always @(posedge clk) begin
      if(rst)
	button_sync <= 0;
      else
	button_sync <= {button_sync[1:0], button};
   end
   
   
   
   
   always @(posedge clk) begin
      if(rst) begin
	 state <= S_WRITE;
	 /*AUTORESET*/
	 // Beginning of autoreset for uninitialized flops
	 address <= 24'h0;
	 data_buffer <= 32'h0;
	 data_in <= 32'h0;
	 req_read <= 1'h0;
	 req_write <= 1'h0;
	 // End of automatics
      end
      else begin
	 req_write <= 0;
	 req_read <= 0;
	 
	 case(state)
	   S_WRITE: begin
	      address <= 32;
	      data_in <= 32'h12345678;
	      req_write <= 1;
	      state <= S_WRITE_COMPLETE;
	   end
	   S_WRITE_COMPLETE:
	     if (write_complete)
	       state <= S_READ;
	   S_READ: begin
	      address <= 32;
	      req_read <= 1;
	      state <= S_READ_COMPLETE;
	   end
	   S_READ_COMPLETE:
	     if(data_valid) begin
		data_buffer <= data_out;
		state <= S_DATA_OUT1;
	     end
	   S_DATA_OUT1: begin
	     led <= data_buffer[7:0];
	     if(button_sync[2:1] == 2'b01)
	       state <= S_DATA_OUT2;
	   end
	   S_DATA_OUT2: begin
	     led <= data_buffer[15:8];
	     if(button_sync[2:1] == 2'b01)
	       state <= S_DATA_OUT3;
	   end
	   S_DATA_OUT3: begin
	     led <= data_buffer[23:16];
	     if(button_sync[2:1] == 2'b01)
	       state <= S_DATA_OUT4;
	   end
	   S_DATA_OUT4: begin
	     led <= data_buffer[31:24];
	     if(button_sync[2:1] == 2'b01)
	       state <= S_WRITE;
	   end
	   
	   
		
	      
	   
	   
	   
	   

	 endcase
      end

   end


   /*AUTOASCIIENUM("state","_state_ascii","s_")*/
   // Beginning of automatic ASCII enum decoding
   reg [111:0]		_state_ascii;		// Decode of state
   always @(state) begin
      case ({state})
	S_WRITE:          _state_ascii = "write         ";
	S_WRITE_COMPLETE: _state_ascii = "write_complete";
	S_READ:           _state_ascii = "read          ";
	S_READ_COMPLETE:  _state_ascii = "read_complete ";
	S_DATA_OUT1:      _state_ascii = "data_out1     ";
	S_DATA_OUT2:      _state_ascii = "data_out2     ";
	S_DATA_OUT3:      _state_ascii = "data_out3     ";
	S_DATA_OUT4:      _state_ascii = "data_out4     ";
	default:          _state_ascii = "%Error        ";
      endcase
   end
   // End of automatics
endmodule

