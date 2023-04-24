`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2023 07:56:28 PM
// Design Name: 
// Module Name: bin_to_sevenseg
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


module bin_to_sevenseg(
input clk,
input rst,
input [3:0] binaryIn, output reg [6:0] segOut
);

always @ (posedge clk, posedge rst) begin
    if(rst) begin
        segOut <= 4'h0;
    end
    
    else begin 
      case(binaryIn)
        4'b0000: segOut = 7'b0111111; // 0
        4'b0001: segOut = 7'b0000110; // 1
        4'b0010: segOut = 7'b1011011; // 2
        4'b0011: segOut = 7'b1001111; // 3
        4'b0100: segOut = 7'b1100110; // 4
        4'b0101: segOut = 7'b1101101; // 5
        4'b0110: segOut = 7'b1111101; // 6
        4'b0111: segOut = 7'b0000111; // 7
        4'b1000: segOut = 7'b1111111; // 8
        4'b1001: segOut = 7'b1101111; // 9
        4'b1010: segOut = 7'b1110111; // A
        4'b1011: segOut = 7'b1111100; // B
        4'b1100: segOut = 7'b0111001; // C
        4'b1101: segOut = 7'b1011110; // D
        4'b1110: segOut = 7'b1111001; // E
        4'b1111: segOut = 7'b1110001; // F
        default: segOut = 7'b0000000; // Display nothing if input is out of range
      endcase
      end
end

endmodule

