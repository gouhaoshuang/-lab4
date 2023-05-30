`include "my_mips.svh"
module hazard (
    input  wire rst,

    input decode_data_t decode_data,
    input execute_data_t execute_data,
    input memory_data_t memory_data,
    input wb_data_t wb_data,
    input control_sign_t decode_sign,execute_sign,memory_sign,wb_sign,
    output hazard_sign_t hazard_sign

);
    
    //E阶段转发  未考虑lw sw 中的暂停
    //只要有一个R型或者lw指令这种会向寄存器写回的指令,在M阶段或者W阶段，就直接转发到E阶段
    assign hazard_sign.forwardAE = (memory_sign.regwrite & (execute_data.rs_addr == memory_data.writereg) & (execute_data.rs_addr !=0)) ? 2'b10:        
                        (wb_sign.regwrite& (execute_data.rs_addr == wb_data.writereg) & (execute_data.rs_addr !=0))? 2'b01:2'b00;  

    assign hazard_sign.forwardBE = (memory_sign.regwrite & (execute_data.rt_addr == memory_data.writereg) & (execute_data.rt_addr !=0)) ? 2'b10:
                        (wb_sign.regwrite & (execute_data.rt_addr == wb_data.writereg) & (execute_data.rt_addr !=0))? 2'b01:2'b00;  

    //D阶段转发
    //只要有一个R型或者lw指令这种会向寄存器写回的指令,在E阶段的时候,就直接转发到D阶段。  
    //注意：是将aluoutE转发到D阶段，而不是aluoutM转发到D阶段               
    assign hazard_sign.forwardAD = (execute_sign.regwrite & (decode_data.rs_addr == execute_data.writereg) & (decode_data.rs_addr != 0)) ; 
    assign hazard_sign.forwardBD = (execute_sign.regwrite & (decode_data.rt_addr == execute_data.writereg) & (decode_data.rt_addr != 0)) ; 

    wire lwstall , branch_stall;
    //当检测到lw指令处于E阶段时，且后面的一条指令要读取lw在W阶段写回的寄存器的值，就暂停
    assign lwstall = (execute_sign.memtoreg & ((execute_data.rt_addr == decode_data.rt_addr)| (execute_data.rt_addr == decode_data.rs_addr))); 
    //当检测到D阶段时beq指令，且这条beq指令要读取的寄存器和前面的指令要写入的寄存器相同，就暂停
    assign branch_stall = (decode_sign.branch & execute_sign.regwrite & (execute_data.writereg == decode_data.rs_addr)|(execute_data.writereg == decode_data.rt_addr))|//暂停：add beq ; lw beq
                        (decode_sign.branch & memory_sign.memtoreg & (memory_data.writereg == decode_data.rs_addr)|(memory_data.writereg == decode_data.rt_addr));  //暂停：lw nop beq


    assign hazard_sign.stallF = rst ? 1'b0 : (lwstall | branch_stall);
    assign hazard_sign.stallD = rst ? 1'b0 : (lwstall | branch_stall);
    assign hazard_sign.flushE = rst ? 1'b0 : (lwstall | branch_stall);

endmodule