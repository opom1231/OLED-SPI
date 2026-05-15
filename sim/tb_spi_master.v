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
    
    // Generate 100MHz clock
    always #5 clk = ~clk;
    
    initial begin
        // Initialize spi_master module
        clk = 0;
        rst = 1; // Not letting it start right away
        start = 0;
        data_in = 8'hA5; // Binary = 10100101
        
        // Release the reset
        #20 rst = 0;
        
        // Send a start signal to the module
        #20 start = 1; 
        // oled_cs should switch to 0 on the next clock edge
        // oled_sclk, oled_sdin should be 0
        #10 start = 0; // spi_master should be busy now
        
        wait(status == 0);
        #100;
        
        // Sending a second byte
        data_in = 8'h3C;
        #20 start = 1;
        #10 start = 0;
        wait(status == 0);
        
        #500; // Check if it returns to idle
        
        
        $finish;
       
           
    
    
    end
endmodule
