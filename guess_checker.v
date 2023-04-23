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

module guess_checker (
  input wire clk,
  input wire reset,
  input wire [15:0] secret_number,
  input wire [15:0] guess,
  output reg [3:0] wrong_place_count,
  output reg [3:0] correct_place_count
);
      reg [3:0] local_correct_place_count;
      reg [3:0] local_wrong_place_count;
      reg [3:0] i, j;
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      wrong_place_count <= 4'b0000;
      correct_place_count <= 4'b0000;
    end else begin

      local_correct_place_count = 4'b0000;
      local_wrong_place_count = 4'b0000;

      for (i = 0; i < 4; i = i + 1) begin
        if (secret_number[i*4 +: 4] == guess[i*4 +: 4]) begin
          local_correct_place_count = local_correct_place_count + 1;
        end
      end

      for (i = 0; i < 4; i = i + 1) begin
        for (j = 0; j < 4; j = j + 1) begin
          if (i != j && secret_number[i*4 +: 4] == guess[j*4 +: 4]) begin
            local_wrong_place_count = local_wrong_place_count + 1;
          end
        end
      end

      wrong_place_count <= local_wrong_place_count;
      correct_place_count <= local_correct_place_count;
    end
  end

endmodule


