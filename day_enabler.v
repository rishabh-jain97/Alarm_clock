`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2018 12:24:24 PM
// Design Name: 
// Module Name: day_enabler
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


module day_enabler
    (input enable, input thresh1, input thresh2, input thresh3,input push_increment,
    output day_enable   
    );
 
    assign day_enable =(enable && thresh1 && thresh2 && thresh3) || push_increment;
    
    
endmodule
