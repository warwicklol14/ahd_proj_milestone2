`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2022 12:36:55 AM
// Design Name: 
// Module Name: switch_registers
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


module switch_registers(
    input wire clk,
    input wire [15:0] sw,
    output reg [31:0] state
    );
    
    always@(posedge clk) begin
        state <= sw;
    end
endmodule
