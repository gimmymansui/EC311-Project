`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04/19/2023 06:22:27 PM
// Design Name:
// Module Name: hex_guess_game
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


module hex_guess_game (
  input wire [3:0] switches1,
  input wire [3:0] switches2,
  input wire [3:0] switches3,
  input wire [3:0] switches4,
  input wire [15:0] user_guess,
  output wire [15:0] secret_number,
  output wire [3:0] correct_digits,
  output wire [3:0] wrong_place_digits
);

  // Instantiate hex_mem module to generate secret_number
  hex_mem secret_gen (
    .switches1(switches1),
    .switches2(switches2),
    .switches3(switches3),
    .switches4(switches4),
    .hex_number(secret_number)
  );

  // Instantiate hex_guess_check module to check user's guess
  hex_guess_check guess_checker (
    .secret_number(secret_number),
    .guess(user_guess),
    .correct_digits(correct_digits),
    .wrong_place_digits(wrong_place_digits)
  );

endmodule