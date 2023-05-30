module mux (
    input  wire [31:0] a_1,b_0,
    input wire sel,
    output wire [31:0] out
);
assign out = (sel == 1) ? a_1:b_0;
endmodule