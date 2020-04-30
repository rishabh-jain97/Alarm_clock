`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2018 12:39:26 PM
// Design Name: 
// Module Name: pm_driver
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

//PM1 is for setting the time 
//PM2 is the current loaded time 
//PMA is the alarm time 

module pm_driver(
input enable,enable_a,input pm1, input pm2,input pmA, output reg pmf
    );
    
    always @(*)  begin 
        if (enable && !enable_a) pmf = pm1;
        else if (!enable && !enable_a) pmf = pm2; 
        else pmf=pmA;
    end
    
    
endmodule