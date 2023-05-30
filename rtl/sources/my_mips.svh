`ifndef __my_mips
`define __my_mips

typedef logic[31:0] word_t;
typedef logic[4:0] reg_addr_t;


typedef struct packed {
    logic pcsrcD;
    word_t pc_branchD;
    word_t instrD;
} sign_fetch_t; 

typedef struct packed{
    logic regwrite;
    logic memtoreg; 
    logic memwrite; 
    logic[2:0] alucontrol; 
    logic alusrc; 
    logic regdst; 
    logic branch; 
    logic pcsrc;  
    logic jump;
}control_sign_t;    //控制信号


//代表从fetch阶段传递给decode阶段的instrF和pc_plus4F
typedef struct packed {
    word_t instr;
    word_t pc_plus4;
}fetch_data_t;

typedef struct packed{
    word_t RD1_data,RD2_data;
    word_t signimm;
    reg_addr_t rs_addr,rt_addr,rd_addr;
    word_t pc_branch;
    logic zero;
    word_t instr;
    word_t signimm_sl2;
}decode_data_t;

typedef struct packed {
    word_t aluout;
    word_t srcAE;
    word_t srcBE;
    word_t writedata;
    word_t writereg;
    reg_addr_t rs_addr,rt_addr,rd_addr;
    word_t instr;
} execute_data_t;

typedef struct packed {
    word_t aluout;
    word_t writedata;
    word_t writereg;
    word_t readdata;
    word_t instr;

}memory_data_t;
typedef struct packed {
    reg_addr_t writereg;
    word_t result;
    word_t instr;
}wb_data_t;

typedef struct packed {
    logic forwardAD,forwardBD;
    logic[1:0] forwardAE,forwardBE;
    logic stallF,stallD,flushE;
} hazard_sign_t;

`endif 




