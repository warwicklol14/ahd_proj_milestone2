`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2022 10:32:06 PM
// Design Name: 
// Module Name: data_memory
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


module data_memory(
    input wire clk,
    input wire [31:0] address,
    input wire operation,
    input wire [31:0] write_data,
    output reg [31:0] data
    );
    
    reg [31:0] data_mem [0:2047];
    
    wire [31:0] addr = (address[27:0] >> 2);
     
    always@(posedge clk)
    begin
        if(operation == 0) begin
            data <= data_mem[addr];
        end
        else begin
            data_mem[addr] <= write_data;
            data <= write_data;
        end
    end
endmodule
