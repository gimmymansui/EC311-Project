`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2023 01:58:04 PM
// Design Name: 
// Module Name: guess_checker
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

module check_guess (
  input clk,
  input reset,
  input [15:0] answer,
  input [15:0] guess,
  output reg [7:0] result
);
  reg [3:0] correct_count;
  reg [3:0] wrong_count;
  
  always @(posedge clk, posedge reset) begin
    if (reset) begin
      result <= 8'b00000000;
    end 
    else begin
      correct_count = ((answer[3:0] == guess[3:0]) ? 1 : 0) +
                      ((answer[7:4] == guess[7:4]) ? 1 : 0) +
                      ((answer[11:8] == guess[11:8]) ? 1 : 0) +
                      ((answer[15:12] == guess[15:12]) ? 1 : 0);

      wrong_count = ((answer[3:0] == guess[7:4] || answer[3:0] == guess[11:8] || answer[3:0] == guess[15:12]) ? 1 : 0) +
                    ((answer[7:4] == guess[3:0] || answer[7:4] == guess[11:8] || answer[7:4] == guess[15:12]) ? 1 : 0) +
                    ((answer[11:8] == guess[3:0] || answer[11:8] == guess[7:4] || answer[11:8] == guess[15:12]) ? 1 : 0) +
                    ((answer[15:12] == guess[3:0] || answer[15:12] == guess[7:4] || answer[15:12] == guess[11:8]) ? 1 : 0);

      result = {wrong_count, correct_count};
    end
  end
endmodule
