
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2018 07:51:11 PM
// Design Name: 
// Module Name: debouncer
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

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2018 12:50:30 PM
// Design Name: 
// Module Name: Debouncer
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


module Debouncer
    (input hours, input minutes,input enable_A, input clk, 
    output hours_out, output minutes_out,output enable_A_out,output clk_5M
    );

    // inputs hours and minutes are the actual signals from the hour and minute buttons that the user will be pressing.
    // outputs hours_out and minutes_out are the clean debounced signals from the hour and minutes button.
    // the input clk should be the 100MHz clk, this circuit divides it down to 5MHz then down to 20 Hz, which drives the circuit.

    wire hour_Q1;
    wire minute_Q1;
    wire hour_Q2;
    wire minute_Q2;
    wire hour_Q2_bar;
    wire minute_Q2_bar;
    wire clk_10;
    wire enable_AQ;
    wire enable_AQ2;
    wire enable_AQ2_bar;
    wire audio_clock;
    //wire clk_5M;
    
    //ckl_wizard divider to generate 5M clock
    //audio clock is not used in final design 
    //note this is a xilinx IP tool 
    clk_wiz_0 divider(.clk_in1(clk), .clk_out1(clk_5M),.audio_clock(audio_clock));
    
    //generate 10hz clock 
    Debounce_Clock_Div debounce_clock(clk_5M, clk_10);
    
    //setup flip-flop for debouncer circuits 
    Flip_Flop Hour_Cap_One (clk_10, hours, hour_Q1);
    Flip_Flop Minute_Cap_One (clk_10, minutes, minute_Q1);
    Flip_Flop Hour_Cap_Two (clk_10, hour_Q1, hour_Q2);
    Flip_Flop Minute_Cap_Two (clk_10, minute_Q1, minute_Q2);
    Flip_Flop Enable_Cap_One (clk_10,enable_A,enable_AQ);
    Flip_Flop Enable_Cap_Two (clk_10, enable_AQ, enable_AQ2);
    
    
    //output debounced signals 
    assign enable_AQ2_bar = ~enable_AQ2;
    assign enable_A_out = enable_AQ & enable_AQ2_bar;
    
    assign hour_Q2_bar = ~hour_Q2;
    assign minute_Q2_bar = ~minute_Q2;
    
    assign hours_out = hour_Q1 & hour_Q2_bar;
    assign minutes_out = minute_Q1 & minute_Q2_bar; 
    
    endmodule


module Flip_Flop(input FF_Clk, input D, output reg Q);

    always @(posedge FF_Clk) 
        begin           
            Q <= D;  
    end
endmodule

//divide the 5Mhz signal to 10Hz
//could have used the clk_wizard divider again 
module Debounce_Clock_Div (input clk_5M, output reg clk_10);

    reg [31:0] counter = 0;
    always @(posedge clk_5M)
        begin
       
            counter <= (counter == 249999)?20'b0:counter+1;
            clk_10 <= (counter < 124999)?1'b0:1'b1;          
    end

endmodule 

