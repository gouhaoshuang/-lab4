module mux3_1 (
    input wire [31:0] a_00,b_01,c_10,
    input wire [1:0] sel,
    output wire [31:0] out
);
    assign out = ({32{sel == 2'b00}} & (a_00))
                |({32{sel == 2'b01}} & (b_01))
                |({32{sel == 2'b10}} & (c_10));
endmodule