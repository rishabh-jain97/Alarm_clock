`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2018 06:13:21 PM
// Design Name: 
// Module Name: WM_SM
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


module WM_SM
    (clk,alarm_signal,alarm_switch,done,right,threshold,
    alarm, RNG, timer_enable, timer_reset,count, count_reset,state,stop, count_stop
    );
    
    input clk,alarm_signal,alarm_switch,done,right,threshold; 
    output reg alarm, RNG, timer_enable, timer_reset,count,count_reset,stop,count_stop;
    
    output  reg [2:0] state;
    reg [2:0] ns; 
    
    //4 states to cycle through 
    //the state machine gets initiated when the signal state goes off 
    //the only way to go back to idle state (turn it off) is to 
    //assert the treshold signal within the WM_counter
    parameter Idle =0, Signal = 1, RN = 5, Wait = 3, Got_Right =4;
    
    //comb block for next state 
    always @(*) begin 
    
        case (state) 
            Idle: if(alarm_signal && alarm_switch) ns = Signal; 
                    else ns = Idle; 
                  
            Signal: if(!alarm_switch) ns = RN;
                    else ns = Signal; 
                    
            RN: ns = Wait; 
            
            Wait: if (done && right) ns = Got_Right; 
                  else if (done && ! right) ns= RN; 
                  else ns= Wait;
                  
            Got_Right: if(threshold) ns = Idle; 
                       else ns = RN;   
                               
            default: ns = Idle;
        
       endcase 
   end
       
       
    always @(posedge clk) begin 
        state <= ns; 
    end
       
    // combinational logic for outputs
    always @(state) begin 
       
       case (state) 
       
       Idle: begin  alarm = 0; RNG = 0;  timer_enable =0; 
                    timer_reset=0; count = 0; count_reset =1;stop =1; count_stop =1;
             end
             
       Signal: begin  alarm = 1; RNG = 0;  timer_enable =0; 
                      timer_reset=0; count = 0; count_reset=1; stop=0; count_stop =1;
               end   
               
        RN:  begin  alarm = 1; RNG = 1; timer_enable =0; 
                    timer_reset=1; count = 0; count_reset = 0; stop=0; count_stop =1;
             end                   
        
        Wait: begin  alarm = 1; RNG = 0;  timer_enable =1; 
                     timer_reset=0; count = 0; count_reset =0; stop=0; count_stop =0;
              end   
              
       Got_Right: begin alarm = 1; RNG = 0;  timer_enable =0; 
                        timer_reset=1; count = 1; count_reset =0;stop =0; count_stop =0;
       
                  end
       default: begin alarm = 0; RNG = 0;  timer_enable =0; 
                      timer_reset=0; count = 0; count_reset =1; stop =0; count_stop =0;
                end
       
       endcase
   end
endmodule
