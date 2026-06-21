
module prescaler (
    input wire [15:0] pre_i,
    input  wire       sys_clk,    
    input  wire       rst_in,   
    output  reg       en_o    
);

reg signed [15:0] cnt;

always @(posedge sys_clk or !rst_in) begin
    if(!rst_in) begin
        cnt = 16'h0000;
        en_o <= 1'b0;
    end else begin
        if(cnt >= pre_i) begin
            cnt = 16'h0000;
            en_o <= 1'b1;
        end else begin
            cnt <= cnt + 16'h0001;
            en_o <= 1'b0;
        end
    end
end

endmodule