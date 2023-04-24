`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2023 06:35:13 PM
// Design Name: 
// Module Name: debouncer
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


module debouncer(
    input clk, button,
    output reg clean
    );
    reg [3:0] deb_count;
    reg output_exist;
    
    reg [3:0] MAX = 4'b1000;
    
    always @ (posedge clk)
    begin
        if (button) begin         
            if (!output_exist) begin             
                if (deb_count == MAX) begin
                    clean <= 1'b1;
                    deb_count = 4'b0;
                    output_exist = 1'b1;
                end else begin
                    deb_count = deb_count + 1;
                end    
            end else begin
                clean <= 1'b0;
            end           
        end else begin
            clean <= 1'b0;
            deb_count <= 4'b0;
            output_exist <= 1'b0;
        end
    end
endmodule
