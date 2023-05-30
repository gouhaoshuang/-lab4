module slt2 #(
    parameter width = 16
) (
    input  wire [width-1:0] se_num,
    output wire [width-1:0] se_sl_num
);
    assign se_sl_num = se_num<<2;
    
endmodule