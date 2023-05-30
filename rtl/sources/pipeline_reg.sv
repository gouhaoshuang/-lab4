`include "my_interface.svh"
`include "my_mips.svh"

module f_d_reg (
    input wire clk,
    input wire rst,
    input wire stallD,
    input wire clear,
    input fetch_data_t data_in,
    output fetch_data_t data_out
    
);
    
always_ff @( posedge clk ) begin 
    if(rst) begin
        data_out<=0;
    end 
    else if(clear) begin
        data_out<=0;
    end 
    else if(~stallD) begin
        data_out<=data_in;
    end
end
endmodule

module d_e_reg (
    input wire clk,
    input wire rst,
    input wire en,
    input wire clear,
    input decode_data_t data_in,
    input control_sign_t sign_in,
    input control_sign_t sign_out,
    output decode_data_t data_out
    
);
    
always_ff @( posedge clk ) begin 
    if(rst) begin
        data_out<=0;
        sign_out<=0;
    end 
    else if(clear) begin
        data_out<=0;
        sign_out<=0;
    end 
    else if(en) begin
        data_out<=data_in;
        sign_out<=sign_in;
    end
end
endmodule

module e_m_reg (
    input wire clk,
    input wire rst,
    input wire en,
    input wire clear,
    input execute_data_t data_in,
    input control_sign_t sign_in,
    input control_sign_t sign_out,
    output execute_data_t data_out
    
);
    
always_ff @( posedge clk ) begin 
    if(rst) begin
        data_out<=0;
        sign_out<=0;
    end 
    else if(clear) begin
        data_out<=0;
        sign_out<=0;
    end 
    else if(en) begin
        data_out<=data_in;
        sign_out<=sign_in;
    end
end
endmodule

module m_w_reg (
    input wire clk,
    input wire rst,
    input wire en,
    input wire clear,
    input control_sign_t sign_in,
    input control_sign_t sign_out,
    input memory_data_t data_in,
    output memory_data_t data_out
    
);
    
always_ff @( posedge clk ) begin 
    if(rst) begin
        data_out<=0;
        sign_out<=0;
    end 
    else if(clear) begin
        data_out<=0;
        sign_out<=0;
    end 
    else if(en) begin
        data_out<=data_in;
        sign_out<=sign_in;
    end
end
endmodule
