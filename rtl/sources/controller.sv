`include "my_mips.svh"

module controller (
    input word_t instrD,
    output control_sign_t decode_sign,
    input wire zero
);

  wire [1:0]  aluop;
  logic regwrite,memtoreg,memwrite,alusrc,regdst,branch,jump;
  logic [2:0] alucontrol;
  

  always_comb begin 
    decode_sign.regwrite = regwrite;
    decode_sign.memtoreg = memtoreg;
    decode_sign.memwrite = memwrite;
    decode_sign.alucontrol = alucontrol;
    decode_sign.alusrc = alusrc;
    decode_sign.regdst = regdst;
    decode_sign.branch = branch;
    decode_sign.pcsrc = branch&zero;
    decode_sign.jump = jump;    
  end
    
    main_decode main_decode_gata (
      .op (instrD[31:26] ),
      .regdst (regdst ),
      .regwrite (regwrite ),
      .memtoreg (memtoreg ),
      .memwrite (memwrite ),
      .alusrc (alusrc ),
      .branch (branch ),
      .jump (jump ),
      .aluop ( aluop)
    );
    alu_decode alu_decode_dut (
      .aluop (aluop ),
      .funct (instrD[5:0] ),
      .alucontrol  ( alucontrol)
    );
    
endmodule