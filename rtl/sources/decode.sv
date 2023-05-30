`include "my_mips.svh"
module decode (
    input clk,
    input fetch_data_t decode_data_in,
    input logic forwardAD, forwardBD,
    input control_sign_t decode_sign,
    input wb_data_t wb_data,
    input execute_data_t execute_data,
    input control_sign_t wb_sign,
    output decode_data_t decode_data

);


assign decode_data.instr = decode_data_in.instr;
assign decode_data.rs_addr = decode_data_in.instr[25:21];
assign decode_data.rt_addr = decode_data_in.instr[20:16];
assign decode_data.rd_addr = decode_data_in.instr[15:11];

//D阶段：寄存器
regfile regfile_dut (
  .clk (clk ),
  .we3 (wb_sign.regwrite ),
  .ra1 (decode_data.rs_addr ),
  .ra2 (decode_data.rt_addr ),
  .wa3 (wb_data.writereg ),
  .wd3 ( wb_data.result),
  .rd1 (decode_data.RD1_data),
  .rd2 (decode_data.RD2_data)
);

//两个控制冒险多路选择?
word_t RD1D_equal,RD2D_equal;
mux mux2_1_RD1D (.a_1 (execute_data.aluout ),.b_0 (decode_data.RD1_data ),.sel (forwardAD ), .out  ( RD1D_equal ));
mux mux2_1_RD2D (.a_1 (execute_data.aluout),.b_0 (decode_data.RD2_data  ),.sel (forwardBD ), .out  ( RD2D_equal ));
assign decode_data.zero = (RD1D_equal==RD2D_equal);


//有符号数扩展

sign_extention #(16) sign_extention_dut (.num (decode_data_in.instr[15:0]),.se_num  (decode_data.signimm));

//左移两位
assign decode_data.signimm_sl2 = decode_data.signimm<<2;


//立即数和pc_plus4D相加，得到pc_branchD 
//注意这里必须使用pc_plus4D-4   
adder adder_dut (.a (decode_data.signimm_sl2  ),.b (decode_data_in.pc_plus4-4),.y  (decode_data.pc_branch));


endmodule