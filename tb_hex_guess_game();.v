`timescale 1ns / 1ps

module tb_hex_guess_game();

  reg [3:0] switches1, switches2, switches3, switches4;
  reg [15:0] user_guess;
  wire [15:0] secret_number;
  wire [3:0] correct_digits, wrong_place_digits;

  hex_guess_game hex_game (
    .switches1(switches1),
    .switches2(switches2),
    .switches3(switches3),
    .switches4(switches4),
    .user_guess(user_guess),
    .secret_number(secret_number),
    .correct_digits(correct_digits),
    .wrong_place_digits(wrong_place_digits)
  );

  initial begin
    // Test case 1: Secret number is 4AC1
    switches1 = 4;
    switches2 = 10;
    switches3 = 12;
    switches4 = 1;

    // Test case 1.1: User guess is B948
    user_guess = 16'hB948;
    #10;

    // Test case 1.2: User guess is B9A4
    user_guess = 16'hB9A4;
    #10;

    // Test case 1.3: User guess is BA4C
    user_guess = 16'hBA4C;
    #10;

    // Test case 1.4: User guess is 4AC1 (correct guess)
    user_guess = 16'h4AC1;
    #10;

    // Test case 2: Secret number is 1234
    switches1 = 1;
    switches2 = 2;
    switches3 = 3;
    switches4 = 4;

    // Test case 2.1: User guess is 4321 (all digits in the wrong place)
    user_guess = 16'h4321;
    #10;

    // Test case 2.2: User guess is 1234 (correct guess)
    user_guess = 16'h1234;
    #10;

    // Test case 3: Secret number is FFFF
    switches1 = 15;
    switches2 = 15;
    switches3 = 15;
    switches4 = 15;

    // Test case 3.1: User guess is 0000 (no correct digits)
    user_guess = 16'h0000;
    #10;

    // Test case 3.2: User guess is FFFF (correct guess)
    user_guess = 16'hFFFF;
    #10;

    $finish;
  end

  initial begin
    $monitor("%h %h | %h %h", secret_number, user_guess, correct_digits, wrong_place_digits);
  end

endmodule
