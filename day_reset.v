`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2018 12:59:19 PM
// Design Name: 
// Module Name: day_reset
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


module day_reset(input reset, input manual_reset, output day_reseter
    );
    
    assign day_reseter = reset || manual_reset;
    
    
    
endmodule
