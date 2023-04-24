`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2023 05:13:59 PM
// Design Name: 
// Module Name: read_input
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


module read_input(
//4 bit binary inputs, from switches
    input clk, rst,
    input [3:0]switch_seg_0, //LSB
    input [3:0]switch_seg_1,
    input [3:0]switch_seg_2,
    input [3:0]switch_seg_3, //MSB
    output [15:0]usr_input //16 bit hex output conversion
    );
    
    bin_to_hex input_seg_0(clk, rst,switch_seg_0, usr_input[3:0]); //LSB
    bin_to_hex input_seg_1(clk, rst,switch_seg_1, usr_input[7:4]);
    bin_to_hex input_seg_2(clk, rst,switch_seg_2, usr_input[11:8]);
    bin_to_hex input_seg_3(clk, rst,switch_seg_3, usr_input[15:12]); //MSB
    
 
 
 
endmodule
