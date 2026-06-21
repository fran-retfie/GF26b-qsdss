/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_franretfie_top (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // Input resynchronization
  reg [2:0] ui_d, ui_dd;
  always @(posedge clk) begin
    ui_d <= ui_in[2:0];
    ui_dd <= ui_d;
  end

  wire [15:0] pre;

  spi spi_0 (
    .sys_clk (clk),    
    .rst_in (rst_n),
    .sck_i (ui_dd[0]), // SCK -> ui_in[0]
    .mosi_i (ui_dd[2]), // MOSI -> ui_in[21]  
    .cs_i (ui_dd[1]), // CS -> ui_in[1] 
    .data_o (pre)
  );

  wire en_o;

  prescaler pre_0 (
    .pre_i (pre),
    .sys_clk (clk),   
    .rst_in (rst_n),
    .en_o (en_o) 
  );

  wire [15:0] sin_o;
  wire [15:0] cos_o;

  signal_generator sg_0 (
      .en_i (en_o),    
      .sys_clk (clk),    
      .rst_in (rst_n),   
      .sin_o (sin_o),
      .cos_o (cos_o)
  );

  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out  = 0; 
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
