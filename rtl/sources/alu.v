module alu (
    input wire [2:0] op,
    input wire [31:0] num1,
    input wire [31:0] num2,
    output wire [31:0] ans, //这里的ans必须是reg类型，否则会报错
    //如果使用后面的always块，那么ans必须是reg类型，才能够对ans进行赋值
    output wire zero
);
    assign ans = ({32{op == 3'b010}} & (num1 + num2))
                |({32{op == 3'b110}} & (num1 - num2))
                |({32{op == 3'b000}} & (num1 & num2))
                |({32{op == 3'b001}} & (num1 | num2))
                |({32{op == 3'b111}} & ((num1<num2)?32'h0000_0001:32'h0000_0000));   
    assign zero = (op == 3'b110&num1==num2)?1:0;           
endmodule

