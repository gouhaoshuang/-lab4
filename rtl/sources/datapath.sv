`include "my_mips.svh"
`include "my_interface.svh"

module datapath (
    input wire clk,rst,
    output wire [31:0]pc,
    input word_t readdataM,
    input word_t instrF,
    output memory_data_t memory_data,
    output decode_data_t decode_data,
    input control_sign_t decode_sign,
    output control_sign_t memory_sign
    

);
//控制信号
control_sign_t execute_sign,wb_sign;
hazard_sign_t hazard_sign;
//数据实例�?
fetch_data_t decode_data_in,fetch_data; 
decode_data_t execute_data_in;
execute_data_t execute_data,memory_data_in;
memory_data_t wb_data_in;
wb_data_t wb_data;


//---------------------------------------F阶段--------------------------------
////---------------------------------------F阶段--------------------------------
fetch  fetch (
  . clk(clk),
  . rst(rst),
  . pc(pc),
  . instrF(instrF),
  . fetch_data(fetch_data),
  . decode_data(decode_data),
  . decode_sign(decode_sign)
);
//---------------------------------------D阶段--------------------------------
////---------------------------------------D阶段--------------------------------

//F_D寄存�?
logic stallD;
assign stallD = (hazard_sign.stallD & decode_sign.pcsrc );

f_d_reg f_d_reg_dut (
  .clk (clk ),
  .rst (rst ),
  .stallD (stallD ),
  .clear (1'b0 ),
  .data_in (fetch_data ),
  .data_out  ( decode_data_in)
);

decode decode_dut (
  .clk(clk),
  .decode_data_in (decode_data_in ),
  .forwardAD (hazard_sign.forwardAD ),
  .forwardBD (hazard_sign.forwardBD ),
  .decode_sign (decode_sign ),
  .execute_data (execute_data ),
  .decode_data  ( decode_data ),
  .wb_data(wb_data),
  .wb_sign(wb_sign)
);

//---------------------------------------E阶段--------------------------------
////---------------------------------------E阶段--------------------------------
logic flushE;
assign flushE = hazard_sign.flushE & decode_sign.pcsrc;  //pcsrcD:清空branch指令影响, //flushE:清空lw 对紧跟的指令的影
d_e_reg d_e_reg_dut (
  .clk (clk ),
  .rst (rst ),
  .en (1'b1 ),
  .clear ( flushE),
  .data_in (decode_data ),
  .sign_in (decode_sign ),
  .sign_out (execute_sign ),
  .data_out  ( execute_data_in)
);

execute execute_dut (
  .forwardAE (hazard_sign.forwardAE ),
  .forwardBE (hazard_sign.forwardBE ),
  .execute_sign (execute_sign ),
  .execute_data_in (execute_data_in ),
  .memory_data (memory_data ),
  .wb_data (wb_data ),
  .execute_data  ( execute_data)
);

//-------------------------------------M阶段--------------------------------
//-------------------------------------M阶段--------------------------------
e_m_reg e_m_reg_dut (
  .clk (clk ),
  .rst (rst ),
  .en (1'b1 ),
  .clear (1'b0 ),
  .sign_in (execute_sign ),
  .sign_out (memory_sign ),
  .data_in (execute_data ),
  .data_out  ( memory_data_in)
);
memory memory_dut (
  .readdataM(readdataM),
  .memory_sign(memory_sign),
  .memory_data_in (memory_data_in ),
  .memory_data  ( memory_data)
);

//-------------------------------------W阶段--------------------------------
//-------------------------------------W阶段--------------------------------

m_w_reg m_w_reg_dut (
  .clk (clk ),
  .rst (rst ),
  .en (1 ),
  .clear (0 ),
  .sign_in (memory_sign ),
  .sign_out (wb_sign ),
  .data_in (memory_data ),
  .data_out  ( wb_data_in)
);

writeback writeback_dut (
  .wb_data_in (wb_data_in ),
  .wb_sign (wb_sign ),
  .wb_data  ( wb_data)
);

//-------------------------------------hazard--------------------------------
//-------------------------------------hazard--------------------------------
hazard hazard_dut (
  .rst (rst ),
  .decode_data (decode_data ),
  .execute_data (execute_data ),
  .memory_data (memory_data ),
  .wb_data (wb_data ),
  .decode_sign (decode_sign ),
  .execute_sign (execute_sign ),
  .memory_sign (memory_sign ),
  .wb_sign (wb_sign ),
  .hazard_sign  ( hazard_sign)
);
endmodule
