`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2022 12:36:55 AM
// Design Name: 
// Module Name: identity_registers
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


module identity_registers(
    input wire clk,
    input wire [31:0] addr,
    output reg [31:0] number
    );
    
    reg [31:0] rom ['h0010000c:'h00100000]; 
    
    initial begin
        rom['h00100008] = 'hfee9ab00; // 11266558 == 0x00abe9fe => Little_Endian(0x00abe9fe) == 0xfee9ab00
        rom['h00100004] = 'h4567c900; // 13199173 == 0x00c96745 => Little_Endian(0x00c96745) == 0x4567c900
        rom['h00100000] = 'h944db200; // 11685268 == 0x00b24d94 => Little_Endian(0x00b24d94) == 0x944db200
    end
    
    always@(posedge clk) begin
        number <= rom[addr[31:0]];
    end
    
endmodule
