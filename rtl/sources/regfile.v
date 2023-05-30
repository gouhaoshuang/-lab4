
module regfile(
	input wire clk,
	input wire we3,
	input wire[4:0] ra1,ra2,wa3,//ra1:rs  ,  ra2:rt
	input wire[31:0] wd3,
	output wire[31:0] rd1,rd2//rd1:rs , rd2:rt;
    );

	reg [31:0] rf[31:0];

	always @(negedge clk) begin
		if(we3) begin
			 rf[wa3] <= wd3;
		end
	end

	assign rd1 = (ra1 != 0) ? rf[ra1] : 0;//如果ra1等于0的话，那么就是读出0号寄存器的值。
	assign rd2 = (ra2 != 0) ? rf[ra2] : 0;
endmodule
