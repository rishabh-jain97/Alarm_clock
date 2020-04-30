`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2018 12:33:00 PM
// Design Name: 
// Module Name: cal_incrementer
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


//module used to increment the month and days for the calendar
module cal_incrementer(input enable,input enable_A, input cal_switch, 
input reset, input month, input day, input clock, 
output reg month_out, output reg day_out
    );
    

reg tracker_month =0;
reg tracker_day =0;


always @(posedge clock) begin
    if (reset) begin month_out <= 0; day_out <=0; tracker_month <=0; tracker_day<=0; end 
    
    
    else if (cal_switch && !enable && !enable_A) begin 
    
        if (month && (!day)) begin 
        
            if(tracker_month ==0) begin 
            month_out <=1;
            tracker_month <=1;
            end
            else if (tracker_month ==1) month_out <=0;
              
        end
        
       
        else if (day && (!month)) begin
            if (tracker_day ==0) begin 
            day_out <=1;
            tracker_day <=1; end
           
            else if (tracker_day ==1) day_out <=0;                
        end  
        
        else if(tracker_month ==1 && (!month)) begin
                     tracker_month <=0;   end    
                     
        else if(tracker_day ==1 && (!day)) begin
                     tracker_day <=0;   end   
                      
    end
    
end  
   
 
   
endmodule
