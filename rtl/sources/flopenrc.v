module flopenrc #(parameter width = 8) (
    input wire clk,rst,en,clear,
    input  wire [width-1:0] d,
    output reg [width-1:0] q
);

always @(posedge clk) begin
    if(rst) begin
        q<=0;
    end 
    else if(clear) begin
        q<=0;
    end 
    else if(en) begin
        q<=d;
    end

end


endmodule