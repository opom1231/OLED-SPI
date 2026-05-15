`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/14/2026 06:27:57 PM
// Design Name: 
// Module Name: spi_master
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


module spi_master(
    input clk,
    input rst,
    input start,
    input [7:0] data_in,
    output reg oled_sclk,
    output reg oled_cs,
    output reg oled_sdin,
    output reg status
    );
    
    reg [5:0] counter; 
    reg [3:0] bit_count; // to count 8 bit input data
    
    always @(posedge clk) begin
        if (rst) begin // initialize idle values
            counter <= 0;
            oled_sclk <= 0;
            oled_cs <= 1; // Active low, 1 = idle
            oled_sdin <= 0;
            bit_count <= 0;
            status <= 0;
        end  
        
        // initializing the spi master when a request is recieved 
        else if (start == 1 && oled_cs == 1) begin // oled driver sends a request while master is idle
            status <= 1; // about to be busy
            oled_cs <= 0; // activate the peripheral
            bit_count <= 0; // ready the bit counter
            counter <= 0; 
            oled_sclk <= 0;
            oled_sdin <= data_in[7]; // latch the first bit
        end
        
        // busy phase, cs = 0
        else if (oled_cs == 0) begin 
            if (counter == 50) begin 
                counter <= 0; // reset the timer
                oled_sclk <= ~oled_sclk; // toggle the SPI clock
                
                if (oled_sclk == 1) begin // this was the HIGH state, about to go LOW
                    if (bit_count == 7) begin
                        oled_cs <= 1; // we just finished the 8th bit
                        status <= 0; // no longer busy
                    end else begin
                        oled_sdin <= data_in[7 - (bit_count + 1)];
                        bit_count <= bit_count + 1;
                    end
                end
            end 
            else begin
                counter <= counter + 1; // increment ONLY when counter is not 50
            end
        end                      
    end
endmodule
