`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2018 04:01:58 PM
// Design Name: 
// Module Name: comparator
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


module comparator
    (input clk, input reset, input alarm_enable, input [5:0] hour_in, input [5:0] min_in,input [5:0] sec_in,
    input [5:0] hour_ina, input [5:0] minute_ina,output reg alarm, output reg set
    );
    
    reg tracker =0;
    
    
    always @(posedge clk or posedge reset) begin
    
        if(reset) begin set<=0; tracker <= 0; end
    
    //if alarm is enables the set output dictates the set light
        else if(alarm_enable) begin
            set <=1; 
            //if time goes off, alrm goes off and set tracker to 1
            if((hour_in == hour_ina)&&(min_in == minute_ina) && (sec_in ==0) && !tracker && alarm_enable) begin
            alarm <=1; tracker <=1; end
        end
        
        //once tracker is set high, the only way to set it off is to disable alarm
        else if (!alarm_enable && tracker) 
            begin  alarm <=0; tracker <=0; set<=0; 
        end
   
        else if(!alarm_enable && !tracker) begin set<=0; alarm <=0; 
        end
   
    end
    
    
endmodule
