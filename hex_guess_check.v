`timescale 1ns / 1ps

module hex_guess_check (
  input wire [15:0] secret_number,
  input wire [15:0] guess,
  output reg [3:0] correct_digits,
  output reg [3:0] wrong_place_digits
);

  reg [3:0] secret_digit, guess_digit;
  reg [15:0] secret_mask, guess_mask;
  integer i, j;
  reg digit_found;
  integer iteration_limit, iteration_count;

  always @(*) begin
    correct_digits = 0;
    wrong_place_digits = 0;
    secret_mask = 16'hFFFF;
    guess_mask = 16'hFFFF;

    // Count correct digits
    for (i = 0; i < 4; i++) begin
      secret_digit = secret_number[4*i +: 4];
      guess_digit = guess[4*i +: 4];
      if (secret_digit == guess_digit) begin
        correct_digits = correct_digits + 1;
        secret_mask = secret_mask & ~(4'b1111 << (4*i));
        guess_mask = guess_mask & ~(4'b1111 << (4*i));
      end
    end

    // Count digits in wrong place
    iteration_limit = 2000;
    for (i = 0; i < 4; i++) begin
      secret_digit = secret_number[4*i +: 4] & secret_mask[4*i +: 4];
      digit_found = 1'b0;
      iteration_count = 0;
      for (j = 0; j < 4 && !digit_found && iteration_count < iteration_limit; j++) begin
        guess_digit = guess[4*j +: 4] & guess_mask[4*j +: 4];
        if (secret_digit == guess_digit && secret_digit != 4'b0000) begin
          wrong_place_digits = wrong_place_digits + 1;
          secret_mask = secret_mask & ~(4'b1111 << (4*i));
          guess_mask = guess_mask & ~(4'b1111 << (4*j));
          digit_found = 1'b1;
        end
        iteration_count = iteration_count + 1;
      end
    end
  end

endmodule
