`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2018 10:57:18 AM
// Design Name: 
// Module Name: WM_lighter
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



module WM_lighter(
input clk,  
input enable,
input [1:0] rn, 
output reg M1, output reg M2, output reg M3,output reg M4
    );

  
    always @(posedge clk) begin 
    
    //if(reset) begin M1 <=0; M2<=0; M3<=0; M4<=0; end
    
   if(enable) begin 
    if (rn == 0) begin  M1 <=1; M2<=0; M3<=0; M4<=0; end
    else if (rn == 1) begin M2 <=1; M1 <=0;  M3<=0; M4<=0; end
    else if (rn == 2) begin M3 <=1; M1 <=0; M2<=0; M4<=0; end 
    else if (rn == 3) begin M1 <=0; M2<=0; M3<=0; M4<=1; end 
    end
    
    else if(!enable) M1 <=0; M2<=0; M3<=0; M4<=0;    
    end
    
    
  endmodule
