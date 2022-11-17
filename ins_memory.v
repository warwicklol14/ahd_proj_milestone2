`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2022 09:03:17 PM
// Design Name: 
// Module Name: ins_memory
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


module ins_memory(
    input wire clk,
    input wire [31:0] address,
    output reg [31:0] instruction
    );
    
    reg [31:0] instruction_rom [0:1023];
        
    initial begin
        $readmemh("main.mem", instruction_rom);
    end
    
    wire [31:0] addr_word = (address[23:0] >> 2);
    
    always@(posedge clk) begin
        instruction <= instruction_rom[addr_word];
    end
endmodule
