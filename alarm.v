`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2018 07:45:37 PM
// Design Name: 
// Module Name: alarm
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


module alarm
    ( input clk, input enable, input WM, output reg alarm_on
    );
    reg [32:0] count;
    always @(posedge clk) begin
        if(enable || WM) begin 
            if(count == 1000) begin
            alarm_on <= ~alarm_on; count<=0;
            end
            else count <= count +1;
            end
            
       else begin 
            count <=0; alarm_on <=0; 
       end      
    end     
endmodule
