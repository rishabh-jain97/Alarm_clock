`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2018 12:54:21 PM
// Design Name: 
// Module Name: month_enabler
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


module month_enabler(input enable,input thresh1, input thresh2, input thresh3, input thresh4, 
input manual_increment, input override, output month_enable
    );
    
    assign month_enable = (enable && thresh1 && thresh2 && thresh3 && thresh4) || override || manual_increment;
    
    
    
endmodule
