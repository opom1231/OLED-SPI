`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2026 04:29:21 PM
// Design Name: 
// Module Name: ssd1331_init
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


module ssd1331_init(
    input clk,
    input rst,
    
    // OLED Pins
    output reg oled_dc,
    output reg oled_res,
    output reg oled_vccen,
    output reg oled_pmoden,
    
    // SPI Pins
    output oled_sclk,
    output oled_sdin,
    output oled_cs
    
    );
    
    reg [7:0] init_rom [0:44];
    
    // Internal control signals
    reg [5:0] rom_index; // Track 0 - 44 instruction bytes
    reg [2:0] state; // Current FSM state
    
    // spi_master interface
    reg spi_start;
    wire [7:0] spi_data_in;
    wire spi_status;
    
     spi_master master_inst (
        .clk(clk),
        .rst(rst),
        .start(spi_start),
        .data_in(spi_data_in),
        .oled_cs(oled_cs),
        .status(spi_status),
        .oled_sclk(oled_sclk),
        .oled_sdin(oled_sdin)
    );
    
    // States 
    
    localparam STATE_POWER_UP = 3'd0;
    
    initial begin
        // Step 7: Unlock
        init_rom[0] = 8'hFD; init_rom[1] = 8'h12;
        // Step 8: Display Off
        init_rom[2] = 8'hAE;
        // Step 9: Remap & Color Depth
        init_rom[3] = 8'hA0; init_rom[4] = 8'h72;
        // Step 10: Start Line
        init_rom[5] = 8'hA1; init_rom[6] = 8'h00;
        // Step 11: Offset
        init_rom[7] = 8'hA2; init_rom[8] = 8'h00;
        // Step 12: Normal Display
        init_rom[9] = 8'hA4;
        // Step 13: Multiplex Ratio
        init_rom[10]= 8'hA8; init_rom[11]= 8'h3F;
        // Step 14: Master Config
        init_rom[12]= 8'hAD; init_rom[13]= 8'h8E;
        // Step 15: Power Saving
        init_rom[14]= 8'hB0; init_rom[15]= 8'h0B;
        // Step 16: Phase Length
        init_rom[16]= 8'hB1; init_rom[17]= 8'h31;
        // Step 17: Clock / Osc Freq
        init_rom[18]= 8'hB3; init_rom[19]= 8'hF0;
        // Steps 18-20: Pre-charge Speeds (A, B, C)
        init_rom[20]= 8'h8A; init_rom[21]= 8'h64;
        init_rom[22]= 8'h8B; init_rom[23]= 8'h78;
        init_rom[24]= 8'h8C; init_rom[25]= 8'h64;
        // Step 21: Pre-charge Voltage
        init_rom[26]= 8'hBB; init_rom[27]= 8'h3A;
        // Step 22: VCOMH Deselect
        init_rom[28]= 8'hBE; init_rom[29]= 8'h3E;
        // Step 23: Master Current
        init_rom[30]= 8'h87; init_rom[31]= 8'h06;
        // Step 24-26: Contrast (A, B, C)
        init_rom[32]= 8'h81; init_rom[33]= 8'h91;
        init_rom[34]= 8'h82; init_rom[35]= 8'h50;
        init_rom[36]= 8'h83; init_rom[37]= 8'h7D;
        // Step 27: Disable Scroll
        init_rom[38]= 8'h2E;
        // Step 28: Clear Screen (5 byte command)
        init_rom[39]= 8'h25; init_rom[40]= 8'h00; init_rom[41]= 8'h00; 
        init_rom[42]= 8'h5F; init_rom[43]= 8'h3F;
        // Step 30: Display ON
        init_rom[44]= 8'hAF;
        
    end

    
     
endmodule
