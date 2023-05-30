`include "my_mips.svh"

module fetch (
    input wire clk,
    input wire rst,
    input word_t instrF,
    output word_t pc,
    output fetch_data_t fetch_data,
    input decode_data_t decode_data,
    input control_sign_t decode_sign
);

//F阶段信号
word_t pc_plus4F;
word_t pc_new;
word_t PC2F,PC1F;
word_t jump_addr_F;


pc_reg pc_gate (.clk (clk ),.rst (rst ),.pc (PC2F ),.pc_new  ( pc_new));                   //得到 pc_new输出  

pc_plus4 pc_plus4F_gate (.pc_new (pc_new ),.pc_plus4F ( pc_plus4F));                  //得到 pc+4

mux mux_pcsrcD (.a_1 (decode_data.pc_branch ),.b_0 (pc_plus4F ),.sel (decode_sign.pcsrc ),.out  ( PC1F));    //branch指令是否跳转

assign jump_addr_F = {{pc_plus4F[31:28]},{decode_data.instr[25:0]},{2'b00}};                        //得到 jump_addr_F
mux mux_jump (.a_1 (jump_addr_F),.b_0 (PC1F ),.sel (decode_sign.jump ),.out  ( PC2F));               //j指令是否跳转

assign pc = pc_new;


//fetch_data 的数据来�?
always_comb begin 
    fetch_data.pc_plus4 = pc_plus4F;
    fetch_data.instr = instrF;
end
    
endmodule


