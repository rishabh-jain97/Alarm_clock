`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2018 10:02:25 AM
// Design Name: 
// Module Name: number1
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


module number1(
    input [3:0]x, 
    //output [7:0]an,
    output [6:0] seg,
    output [7:0]an
    );
   assign seg[0] = (~x[1]&x[0]&~x[3]&~x[2])  + (~x[1]&~x[0]&x[2]& (~x[3]));
   assign seg[1] = (x[2]&~x[1]&x[0]) + (x[2]&x[1]&~x[0]);
   assign seg[2] = ~x[3]&~x[2]&x[1]&~x[0];
   assign seg[3] = (~x[1]&~x[0]&x[2]) + (x[1]&x[0]&x[2]) + (~x[3]&~x[2]&~x[1]&x[0]);
   assign seg[4] = x[0] + (~x[3]&x[2]&~x[1]&~x[0]);
   assign seg[5] = (x[1]&x[0]&~x[3]) + (~x[3]&~x[2]&x[0]) + (~x[3]&~x[2]&x[1]);
   assign seg[6] = (~x[3]&~x[2]&~x[1]) + (~x[3]&x[2]&x[1]&x[0]);
   
   assign an = 8'b11101111;
    
endmodule

