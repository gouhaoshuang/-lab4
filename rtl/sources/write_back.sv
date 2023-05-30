`include "my_mips.svh"
module writeback (
    input memory_data_t wb_data_in,
    input control_sign_t wb_sign,
    output wb_data_t wb_data
);
assign wb_data.instr=wb_data_in.instr;
//W阶段判断写回数据是aluoutW还是mem_data
mux mux_memtoreg (
  .a_1 (wb_data_in.readdata ),
  .b_0 (wb_data_in.aluout ),
  .sel (wb_sign.memtoreg ),
  .out  ( wb_data.result)
);
    
always_comb begin 
    wb_data.writereg = wb_data_in.writereg;
end

endmodule