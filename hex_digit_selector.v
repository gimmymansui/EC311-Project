`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2023 01:56:58 PM
// Design Name: 
// Module Name: hex_digit_selector
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

module hex_digit_selector (
  input wire clk,
  input wire [3:0] switches,
  output reg [3:0] hex_digit
);

  always @(posedge clk) begin
    hex_digit <= switches;
  end

endmodule
