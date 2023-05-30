module main_decode (
    input wire [5:0] op,
    output wire regdst,regwrite,memtoreg,memwrite,alusrc,branch,jump,
    output wire [1:0] aluop

);
    wire [8:0] s;
    assign s = 
    (op==0)?(9'b1100_0010_0)://R型指令
    (op==6'b100011)?(9'b1010_0100_0)://lw指令
    (op==6'b101011)?(9'b0010_1000_0)://sw指令
    (op==6'b000100)?(9'b0001_0001_0)://beq指令
    (op==6'b001000)?(9'b1010_0000_0)://addi指令
    (op==6'b000010)?(9'b0000_0000_1): //j指令
    (9'b0000_0000_0);                    
    
    assign jump = s[0];
    assign aluop = s[2:1];
    assign memtoreg = s[3];
    assign memwrite = s[4];
    assign branch = s[5];
    assign alusrc = s[6];
    assign regdst = s[7];
    assign regwrite = s[8];
endmodule
