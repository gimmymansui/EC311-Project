`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2023 05:57:42 PM
// Design Name: 
// Module Name: bin_to_hex
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


module bin_to_hex(
    input clk, rst,
    input [3:0]binary_val,
    output reg[3:0] hex_val
    );
    
    always @(posedge clk, posedge rst)begin
        if(rst) begin
            hex_val <= 4'h0;
        end
        else begin
        case (binary_val)
            4'b0000: hex_val = 4'h0;
            4'b0001: hex_val = 4'h1;
            4'b0010: hex_val = 4'h2;
            4'b0011: hex_val = 4'h3;
            4'b0100: hex_val = 4'h4;
            4'b0101: hex_val = 4'h5;
            4'b0110: hex_val = 4'h6;
            4'b0111: hex_val = 4'h7;
            4'b1000: hex_val = 4'h8;
            4'b1001: hex_val = 4'h9;
            4'b1010: hex_val = 4'ha;
            4'b1011: hex_val = 4'hb;
            4'b1100: hex_val = 4'hc;
            4'b1101: hex_val = 4'hd;
            4'b1110: hex_val = 4'he;
            4'b1111: hex_val = 4'hf;
            default: hex_val = 4'h0; 
        endcase
        end
    end
endmodule
