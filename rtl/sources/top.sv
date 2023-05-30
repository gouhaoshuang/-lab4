`include "my_mips.svh"
`timescale 1ns / 1ps
module top(
	input wire clk,rst,
	output word_t writedata,dataadr,
	output wire memwrite
    );
	word_t pc,instrF,readdataM;

	mips mips_dut (
	  .clk (clk ),
	  .rst (rst ),
	  .pc (pc ),
	  .instrF (instrF ),
	  .readdataM (readdataM ),
	  .memwriteM (memwrite ),
	  .aluout (dataadr ),
	  .writedata  ( writedata)
	);
  


	
	Instr_mem imem(clk,{26'b0,pc},instrF);

	Data_mem dmem(clk,{{3'b0},memwrite},dataadr,writedata,readdataM);

endmodule
