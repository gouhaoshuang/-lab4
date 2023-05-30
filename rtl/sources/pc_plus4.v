module pc_plus4(
    input wire [31:0] pc_new,
    output wire [31:0] pc_plus4F
);
assign  pc_plus4F = pc_new + 4;
endmodule


