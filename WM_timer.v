`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2018 05:07:51 PM
// Design Name: 
// Module Name: WM_timer
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


module WM_timer
    (
    input clk, 
    input reset, 
    input enable,
    input [1:0] rn, 
    input B1, input B2, input B3, input B4,
    output reg right,
    output reg done
    );
    
    reg [31:0] count;
    reg tracker;
  
    always @(posedge clk) begin 
  
     if (reset) begin 
        tracker <=0; right <=0; count <=0; 
     end
  
     else if (enable && !tracker) begin 
        
        //if the timer runs out, the done signal is asserted
        //while the right signal is off, thereby indicating a failure 
        if (count == 500) begin tracker <=1; right <=0; done <=1; count <=0; end
         
  
        //match the random number to the button which was pressed to determine a hit
        else if(rn ==1 && B2 && !B1 && !B3 && !B4) begin tracker <=1; right <=1; done <=1; end 
        
        else if(rn ==2 && !B2 && !B1 && B3 && !B4) begin tracker <=1; right <=1; done <=1; end 
        
        else if(rn ==3 && !B2 && !B1 && !B3 && B4) begin tracker <=1; right <=1; done <=1; end
        
        else begin  count <= count +1; tracker <=0; done <=0; end
        
        
    end //end else if enable
    
  end
endmodule
