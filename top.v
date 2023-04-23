`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2023 01:57:46 PM
// Design Name: 
// Module Name: top
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


module top (
  input wire clk,
  input wire reset,
  input wire [3:0] switches1,
  input wire [3:0] switches2,
  input wire [3:0] switches3,
  input wire [3:0] switches4,
  input wire [15:0] guess,
  output wire [15:0] secret_number,
  output wire [3:0] wrong_place_count,
  output wire [3:0] correct_place_count
);

  wire [3:0] digit1;
  wire [3:0] digit2;
  wire [3:0] digit3;
  wire [3:0] digit4;

  hex_digit_selector digit_selector1 (
    .clk(clk),
    .switches(switches1),
    .hex_digit(digit1)
  );

  hex_digit_selector digit_selector2 (
    .clk(clk),
    .switches(switches2),
    .hex_digit(digit2)
  );

  hex_digit_selector digit_selector3 (
    .clk(clk),
    .switches(switches3),
    .hex_digit(digit3)
  );

  hex_digit_selector digit_selector4 (
    .clk(clk),
    .switches(switches4),
    .hex_digit(digit4)
  );

  assign secret_number = {digit1, digit2, digit3, digit4};

  guess_checker guess_checker_inst (
    .clk(clk),
    .reset(reset),
    .secret_number(secret_number),
    .guess(guess),
    .wrong_place_count(wrong_place_count),
    .correct_place_count(correct_place_count)
  );

endmodule


