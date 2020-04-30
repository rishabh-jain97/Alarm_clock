`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2018 09:03:26 PM
// Design Name: 
// Module Name: Clock_Divider
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


module divide(input [15:0] dividetgt, input clkin, output reg clkout);
    reg [15:0] count;
    always @(posedge clkin)// or reset)//pretty sure not pos edge
    begin
        //if (reset) count = 16'h0000;
        if (count == dividetgt/2) begin
            clkout = ~clkout;
            count = 16'h0000;
        end
        else count = count + 1;
    end
endmodule
