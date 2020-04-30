`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2018 01:01:14 PM
// Design Name: 
// Module Name: month_fixer
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


module month_fixer(input [5:0] month, input [5:0] day, input clk,
input reset, output reg month_increment, output reg day_reset
    );
    reg tracker =0;
    
    always @(posedge clk) begin 
    
        if (month == 0 && day == 31 && !tracker) begin 
            month_increment <=1; day_reset <=1; tracker <=1;
        end
        
        else if (month == 1 && day == 28 && !tracker) begin 
            month_increment <=1; day_reset <=1; tracker <=1;
        end
        
        else if (month == 2 && day == 31 && !tracker) begin 
            month_increment <=1; day_reset <=1; tracker <=1;
        end
                
        else if (month == 3 && day == 30 && !tracker) begin 
            month_increment <=1; day_reset <=1; tracker <=1;
        end
                 
        else if (month == 4 && day == 31 && !tracker) begin 
            month_increment <=1; day_reset <=1; tracker <=1;
        end  //may     
                            
        else if (month == 5 && day == 30 && !tracker) begin 
            month_increment <=1; day_reset <=1; tracker <=1;
        end //june
                                                   
        else if (month == 6 && day == 31 && !tracker) begin 
            month_increment <=1; day_reset <=1; tracker <=1;
        end       //july                                                    
                              
        else if (month == 7 && day == 31 && !tracker) begin 
            month_increment <=1; day_reset <=1; tracker <=1;
        end //aug
                                           
        else if (month == 8 && day == 30 && !tracker) begin 
            month_increment <=1; day_reset <=1; tracker <=1;
        end                               
                                           
        else if (month == 9 && day == 31 && !tracker) begin 
            month_increment <=1; day_reset <=1; tracker <=1;
        end                                              
                 
        else if (month == 10 && day == 30 && !tracker) begin 
            month_increment <=1; day_reset <=1; tracker <=1;
        end  
        
        else if (month == 11 && day == 31 && !tracker) begin 
            month_increment <=1; day_reset <=1; tracker <=1;
        end  
        
        
        else if(tracker) begin 
        month_increment <=0; day_reset <=0; tracker <=0;
        end
    
    end
       
endmodule
