
module signal_generator (
    input  wire       en_i,    
    input  wire       sys_clk,    
    input  wire       rst_in,   
    output wire [15:0] sin_o,
    output  wire [15:0] cos_o
);

parameter k_log2 = 13;
parameter a_log2 = 6;

reg signed [15:0] x;
reg signed [15:0] y;

wire signed [15:0] x1;
assign x1 = x - (x >>> k_log2) + y;

always @(posedge sys_clk or !rst_in) begin
    if(!rst_in) begin
        x <= 16'h7123;
        y <= 16'h0000;
    end else begin
        if(en_i) begin
            y <= x1 - (x1 >>> k_log2) - x;
            x <= x1;
        end 
    end
end

assign cos_o = y <<< a_log2;
assign sin_o = x;

endmodule