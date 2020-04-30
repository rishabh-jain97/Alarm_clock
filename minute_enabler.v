`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2018 09:48:21 AM
// Design Name: 
// Module Name: minute_enabler
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


module minute_enabler(input enable,input thresh, input loader, output minute_enable

    ); 
   assign minute_enable = ((thresh && enable) || loader); 
   
endmodule
