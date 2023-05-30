`include "my_mips.svh"
module memory (
    input control_sign_t memory_sign,
    input execute_data_t memory_data_in,
    output memory_data_t memory_data,
    input word_t readdataM
);
assign memory_data.instr =memory_data_in.instr;
    always_comb begin 
        memory_data.aluout = memory_data_in.aluout;
        memory_data.writedata = memory_data_in.writedata;
        memory_data.writereg = memory_data_in.writereg;
        memory_data.readdata = readdataM;
    end
endmodule
