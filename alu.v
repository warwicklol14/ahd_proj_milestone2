`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2022 01:19:47 PM
// Design Name: 
// Module Name: alu
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


module alu(
        input wire [31:0] input1,
        input wire [31:0] input2,
        input wire [3:0] operation,
        output wire [31:0] calc_output
    );
    
    assign calc_output = (operation == 4'b0000) ? {input1 + input2}:
    (operation == 4'b0001) ? {input1 - input2}:
    (operation == 4'b0010) ? {input1 == input2}:
    (operation == 4'b0011) ? {input1 != input2}:
    (operation == 4'b0100) ? {input1 < input2}:
    (operation == 4'b0101) ? {input1 <= input2}:
    (operation == 4'b0110) ? {input1 > input2}:
    (operation == 4'b0111) ? {input1 >= input2}:
    (operation == 4'b1000) ? {input1 ^ input2}:
    (operation == 4'b1001) ? {input1 | input2}:
    (operation == 4'b1010) ? {input1 & input2}:
    (operation == 4'b1011) ? {input1 << input2}:
    (operation == 4'b1100) ? {input1 >> input2}:
    calc_output;
endmodule
