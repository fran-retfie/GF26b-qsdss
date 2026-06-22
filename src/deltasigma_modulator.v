
module deltasigma_modulator (
    input  wire                clk,
    input  wire                rst_i,
    input  wire signed [15:0]  sig_i,
    output wire                 ds_o
);
    reg signed [16:0] integ;
    wire signed [16:0] dac;
    
    assign dac = ds_o ? 17'h08000 : -17'h08000;
    assign ds_o = (integ >= 0);
    always @(posedge clk) begin
        if(!rst_i) begin
            integ <= 17'h00000;
        end else begin
            integ <= integ + ((sig_i - dac) >>> 1);
        end
    end

endmodule