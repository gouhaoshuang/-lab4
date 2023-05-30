module alu_decode (
    input wire [1:0] aluop,
    input wire [5:0] funct,
    output wire [2:0] alucontrol
);
    assign alucontrol =
    (aluop == 2'b10 && funct == 6'b100000)?(3'b010)://add指令
    (aluop == 2'b10 && funct == 6'b100010)?(3'b110)://sub指令
    (aluop == 2'b10 && funct == 6'b100100)?(3'b000)://and指令
    (aluop == 2'b10 && funct == 6'b100101)?(3'b001)://or指令
    (aluop == 2'b10 && funct == 6'b101010)?(3'b111)://slt指令
    (aluop == 2'b00 )?(3'b010):                     //lw和sw指令
    (aluop == 2'b01 )?(3'b110):                     //beq指令
    (3'b000);            
endmodule