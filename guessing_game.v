`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2023 02:22:05 AM
// Design Name: 
// Module Name: guessing_game
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

module guessing_game(
  input [3:0]switch_seg_0, 
  input [3:0]switch_seg_1,
  input [3:0]switch_seg_2,
  input [3:0]switch_seg_3, 
  input clk,
  input rst,
  input btn,
  output[6:0]segment,
  output[6:0]AN_Out
);

reg [7:0] counter;
reg [2:0] state;
reg [7:0] AN_In = 8'b00000011; 

parameter IDLE = 3'b000;
parameter P1_GUESS = 3'b001;
parameter P2_GUESS = 3'b010;
parameter P1_WINS = 3'b011;
parameter P2_WINS = 3'b100;

//debouncing button
wire debounced_btn;

debouncer debouncer_inst (
  .clk(clk),
  .button(btn),
  .clean(debounced_btn)
);

//collecting inputs
wire[15:0] p1_answer;
wire[15:0] p2_answer;

read_input p1_secret_num(switch_seg_0, switch_seg_1, switch_seg_2, switch_seg_3, p1_answer);
read_input p2_secret_num(switch_seg_0, switch_seg_1, switch_seg_2, switch_seg_3, p2_answer);

//collecting guesses
wire[15:0] p1_guess;
wire[15:0] p2_guess;

read_input guess_p1(switch_seg_0, switch_seg_1, switch_seg_2, switch_seg_3, p1_guess);
read_input guess_p2(switch_seg_0, switch_seg_1, switch_seg_2, switch_seg_3, p2_guess);

//checking guesses
wire[7:0] p1_guess_check;
wire[7:0] p2_guess_check;

check_guess guess_checking_p1(.clk(clk), .reset(rst),
    .answer(p2_answer),
    .guess(p1_guess),
    .result(p1_guess_check)
  );
  
  check_guess guess_checking_p2(.clk(clk), .reset(rst),
    .answer(p1_answer),
    .guess(p2_guess),
    .result(p2_guess_check)
  );
  
//display { num correct in wrong place, num correct in right place}
    //p1
    wire[6:0] p1_wrong_seg_disp;
    wire[6:0] p1_correct_seg_disp;
    bin_to_sevenseg num_wrong_p1_disp(clk, rst, p1_guess_check[7:4], p1_wrong_seg_disp);
    bin_to_sevenseg num_correct_p1_disp(clk, rst, p1_guess_check[3:0], p1_correct_seg_disp);
    
    //p2
    wire[6:0] p2_wrong_seg_disp;
    wire[6:0] p2_correct_seg_disp;
    bin_to_sevenseg num_wrong_p2_disp(clk, rst, p2_guess_check[7:4], p2_wrong_seg_disp);
    bin_to_sevenseg num_correct_p2_disp(clk, rst, p2_guess_check[3:0], p2_correct_seg_disp);
    
//instantiate dsisplay
    reg[55:0] C_In;
    SevenSegmentLED ssLED(.clk(clk),.rst(rst),.AN_In(AN_In),.C_In(C_In),.AN_Out(AN_Out),.C_Out(segment));

    
always @(posedge clk) begin
    if (rst) begin
      counter <= 0;
      state <= IDLE;
      C_In <= {7'd0,7'd0, 7'd0, 7'd0, 7'd0, 7'd0,7'b0111111, 7'b0111111};
    end
    
  case(state)
    IDLE: begin
    C_In <= {7'd0,7'd0, 7'd0, 7'd0, 7'd0, 7'd0,7'b0111111, 7'b0111111};
      counter <= 0;
      if(debounced_btn) begin
        state <= P1_GUESS;
      end
    end

    P1_GUESS: begin
      if(debounced_btn) begin
        C_In <= {7'd0,7'd0, 7'd0, 7'd0, 7'd0, 7'd0,p1_wrong_seg_disp, p1_correct_seg_disp};
        if(p1_guess_check == 8'b00000100) begin
          state <= P1_WINS;
        end
      end
        else begin
          state <= P2_GUESS;
        end
      end
    

    P2_GUESS: begin
      counter <= 0;
      if(debounced_btn) begin
      C_In <= {7'd0, 7'd0, 7'd0, 7'd0, 7'd0, 7'd0,p2_wrong_seg_disp, p2_correct_seg_disp};
        if(p2_guess_check == 8'b00000100) begin
          state <= P2_WINS;
        end
        else begin
          state <= P1_GUESS;
        end
      end
    end

    P1_WINS: begin
    C_In <= {7'd0, 7'd0, 7'd0, 7'd0, 7'd0, 7'd0,7'b1110011, 7'b0000110};
      if(counter == 8'hFF) begin
        state <= IDLE;
      end
      else begin
        counter <= counter + 1;
      end
    end
    
    P2_WINS: begin
    C_In <= {7'd0, 7'd0, 7'd0, 7'd0, 7'd0, 7'd0,7'b1110011, 7'b1011011};
      if(counter == 8'hFF) begin
        state <= IDLE;
      end
      else begin
        counter <= counter + 1;
      end
    end
  endcase
end


endmodule

