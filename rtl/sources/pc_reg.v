module pc_reg (
    input wire clk,rst,
    input wire [31:0] pc ,
    output reg [31:0] pc_new = 0
);

always @(negedge clk ) begin
    if (rst) begin
        pc_new = 0;
    end
    else begin
        pc_new = pc;
    end
end


    
endmodule