`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2018 02:18:23 PM
// Design Name: 
// Module Name: month_decoder
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


module month_decoder
(input [5:0] month_in, input [5:0] day_in, input clk,
 output reg [8:0]offset  
 );
 
    always @(posedge clk) begin
    
        if(month_in == 0) offset <= 0 +day_in;
        
        else if(month_in ==1) offset <=31 + day_in;
        
        else if(month_in ==2) offset <=59 +day_in;
        
        else if(month_in ==3) offset <=89 +day_in;
        
        else if(month_in ==4) offset <=119 + day_in;
        
        else if(month_in ==5) offset <=150 +day_in;
        
        else if(month_in ==6) offset <=180 +day_in;
        
        else if(month_in ==7) offset <=211 +day_in;
        
        else if(month_in ==8) offset <=242 +day_in;
        
        else if(month_in ==9) offset <=272 +day_in;
        
        else if(month_in ==10) offset <=303 +day_in;
        
        else if(month_in ==11) offset <=333 +day_in;
    
    end
 
endmodule
