`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2022 12:36:55 AM
// Design Name: 
// Module Name: led_registers
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


module led_registers(
    input wire clk,
    input wire operation,
    input wire [15:0] led_write,
    output reg [15:0] LED,
    output reg [31:0] led_state
    );
    
    always@(posedge clk) begin
        if(operation == 0) begin
            led_state <= LED;
        end
        else begin
            LED <= led_write;
            led_state <= led_write;
        end 
    end
endmodule
