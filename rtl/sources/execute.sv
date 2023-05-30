`include "my_mips.svh"
module execute (
    input logic[1:0] forwardAE,forwardBE,
    input control_sign_t execute_sign,
    input decode_data_t execute_data_in,
    input memory_data_t memory_data,
    input wb_data_t wb_data,
    output execute_data_t execute_data
);
assign execute_data.instr=execute_data_in.instr;

always_comb begin 
  execute_data.rs_addr =execute_data_in.rs_addr;
  execute_data.rt_addr =execute_data_in.rt_addr;
  execute_data.rd_addr =execute_data_in.rd_addr;

end
mux3_1 mux3_1_srcAE (
  .a_00 (execute_data_in.RD1_data ),
  .b_01 (wb_data.result),
  .c_10 (memory_data.aluout ),
  .sel (forwardAE ),
  .out  ( execute_data.srcAE)
);
mux3_1 mux3_1_writedataE (
  .a_00 (execute_data_in.RD2_data ),
  .b_01 (wb_data.result ),
  .c_10 (memory_data.aluout ),
  .sel (forwardBE ),
  .out  (execute_data.writedata)
);

//E阶段判断输出：srcBE
mux mux_srcBE (
    .a_1 (execute_data_in.signimm ),
    .b_0 (execute_data.writedata ),
    .sel (execute_sign.alusrc ),
    .out  ( execute_data.srcBE )
);

//E阶段：regdst信号，输出writeregE regdst=1,输出：rd
mux mux_regdst (
    .a_1 ({{27{0}}, execute_data_in.rd_addr}), 
    .b_0 ({{27{0}}, execute_data_in.rt_addr}),
    .sel (execute_sign.regdst ),
    .out  ( execute_data.writereg)
);

//E阶段 alu运算?
alu alu_dut (
    .op (execute_sign.alucontrol ),
    .num1 (execute_data.srcAE ),
    .num2 (execute_data.srcBE ),
    .ans  ( execute_data.aluout),
    .zero (zero)
);


endmodule