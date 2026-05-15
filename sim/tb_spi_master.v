`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2026 02:56:06 PM
// Design Name: 
// Module Name: tb_spi_master
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_spi_master();
    // Inputs to drive
    reg clk, rst, start;
    reg [7:0] data_in;
    
    // Outputs to observe
    wire oled_cs, status;
    wire oled_sclk, oled_sdin;
    
    spi_master uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .data_in(data_in),
        .oled_cs(oled_cs),
        .status(status),
        .oled_sclk(oled_sclk),
        .oled_sdin(oled_sdin)
    );
endmodule
