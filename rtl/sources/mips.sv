`timescale 1ns / 1ps
`include "my_mips.svh"	
module mips(
input wire clk,rst,
output word_t pc,
input word_t instrF,
input word_t readdataM, 
output logic memwriteM,
output word_t aluout,writedata

);

control_sign_t decode_sign;
decode_data_t decode_data;
fetch_data_t fetch_data;
memory_data_t memory_data;
control_sign_t memory_sign;

controller controller_dut (
  .instrD (decode_data.instr ),
  .zero (decode_data.zero ),
  .decode_sign  ( decode_sign)
);

always_comb begin 
	memwriteM = memory_sign.memwrite;
	aluout = memory_data.aluout;
	writedata = memory_data.writedata;

end





datapath datapath_dut (
  .clk (clk ),
  .rst (rst ),
  .pc (pc ),
  .instrF(instrF),
  .readdataM(readdataM),
  .memory_data (memory_data ),
  .decode_data (decode_data ),
  .decode_sign  ( decode_sign),
  .memory_sign(memory_sign)
  
);

endmodule
