
module spi (
    input  wire       sys_clk,    
    input  wire       rst_in,
    input  wire       sck_i,
    input  wire       mosi_i,   
    input  wire       cs_i,   
    output reg [15:0] data_o
);

reg clk_d;
reg cs_d;
reg [15:0] sr; //SPI shift register

always @(posedge sys_clk) begin
    clk_d <= sck_i;
    cs_d <= cs_i;

    if(!rst_in) begin
        //default value for data (1kHz)
        data_o <= 16'h0124; 
        sr <= 16'h0000;
    end else begin
        //rising edge of CS write shift register to output
        if(cs_i & !cs_d) begin
            data_o <= sr;
            sr <= 16'h0000;
        end

        //rising edge of SCK and CS low, shift in data
        if(sck_i & !clk_d & !cs_i) begin
            sr <= {sr[14:0], mosi_i};
        end
    end
end

endmodule