module sign_extention #(
    parameter width = 16
) (
    input wire [width-1:0] num,
    output wire [31:0] se_num
);
    assign se_num = {{(32-width){num[width-1]}},num};
endmodule