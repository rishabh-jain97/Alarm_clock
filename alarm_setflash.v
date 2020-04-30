`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2018 08:32:42 PM
// Design Name: 
// Module Name: alarm_setflash
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


module alarm_setflash(input clk,reset, enable, output reg led1, output reg led2,output reg led3
    );
       reg [32:0] count;
       
       always@(posedge clk or posedge reset) begin 
        
           if(reset) begin count<=0; led1 <=0; led2 <=0; led3 <=0;  
           end
            
           else if (enable) begin
               if( count == 1) begin 
                led1 <= ~led1; led2 <= ~led2; led3<= ~led3; count<=0; 
               end
               
               else count <= count +1;
               end 
            
           else if (!enable) begin 
            led1 <=0; led2 <=0; led3<=0; 
           end
       end
    
endmodule
