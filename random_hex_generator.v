module random_hex_generator (
  input wire clk,
  input wire reset,
  output reg [15:0] random_hex_number
);

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      random_hex_number <= 16'h0000;
    end else begin
      random_hex_number <= $random & 16'hFFFF; // Mask the random value to keep only 16 bits
    end
  end

endmodule
