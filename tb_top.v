`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2023 01:58:38 PM
// Design Name: 
// Module Name: tb_top
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


module tb_top();
  reg clk;
  reg reset;
  reg [3:0] switches1;
  reg [3:0] switches2;
  reg [3:0] switches3;
  reg [3:0] switches4;
  reg [15:0] guess;
  wire [15:0] secret_number;
  wire [3:0] wrong_place_count;
  wire [3:0] correct_place_count;

  top top_inst (
    .clk(clk),
    .reset(reset),
    .switches1(switches1),
    .switches2(switches2),
    .switches3(switches3),
    .switches4(switches4),
    .guess(guess),
    .secret_number(secret_number),
    .wrong_place_count(wrong_place_count),
    .correct_place_count(correct_place_count)
  );

  always begin
    #1 clk = ~clk;
  end

  initial begin
    clk = 0;
    reset = 0;
    switches1 = 4'b1010; // A
    switches2 = 4'b0010; // 2
    switches3 = 4'b1100; // C
    switches4 = 4'b0001; // 1

    // Test 1: Secret number: A2C1, Guess: B948
    guess = 16'hB948;
    #10;

    // Test 2: Secret number: A2C1, Guess: B9A4
    guess = 16'hB9A4;
    #10;

    // Test 3: Secret number: A2C1, Guess: BA4C
    guess = 16'hBA4C;
    #10;

    // Test 4: Reset and check the output
    reset = 1;
    #10;
    reset = 0;

    // Test 5: Change the secret number and guess
    switches1 = 4'b0011; // 3
    switches2 = 4'b1101; // D
    switches3 = 4'b1110; // E
    switches4 = 4'b0111; // 7

    // Secret number: 3DE7, Guess: 37ED
    guess = 16'h37ED;
    #10;

    // End the simulation
    $finish;
  end

endmodule

