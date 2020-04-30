`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2018 12:04:01 PM
// Design Name: 
// Module Name: mux_driver
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


module mux_driver
    (input clk,input WM,input [6:0] WM_seg,
    input tz1, input tz2, input tz3, input tz4, input switch,
    input enable, input enable_A, 
    input [7:0] an1L,input[7:0] an2L,input [7:0] an3L,input [7:0] an4L, // loader time
    input [7:0] an1,input[7:0] an2,input [7:0] an3,input [7:0] an4, //regular time
    input [7:0] an1A,input[7:0] an2A,input [7:0] an3A,input [7:0] an4A, //alarm time
    input [7:0] an5C, input [7:0] an6C, input [7:0] an7C, input [7:0] an8C,//calendar
    
    input[6:0] seg1, input [6:0] seg2,input [6:0] seg3,input [6:0] seg4,//loader segments
    input[6:0] seg1l, input [6:0] seg2l,input [6:0] seg3l,input [6:0] seg4l,//real time 
    input[6:0] seg1A, input [6:0] seg2A,input [6:0] seg3A,input [6:0] seg4A,//alarm time
    input [6:0] segC, input [6:0] segC2,input [6:0] segC3,input [6:0] segC4,//calendar 
    
    output reg [7:0] an1f,output reg [7:0] an2f,output reg [7:0] an3f, output reg [7:0] an4f, //outputs for time 
    output reg [7:0] an1C, output reg [7:0] an2C, output reg [7:0] an3C, output reg [7:0] an4C, //output for month/day
    output reg [6:0] seg1f, output reg [6:0] seg2f,output reg [6:0] seg3f,output reg [6:0] seg4f, //output for time
    output reg [6:0] seg1C, output reg [6:0] seg2C, output reg [6:0] seg3C, output reg [6:0] seg4C //output for month 
    );
    
    wire [6:0] seg_default = 7'b1111111; 
    wire [7:0] an_default = 8'b11111111;
    wire [7:0] an_letter1 = 8'b11110111;
    wire [7:0] an_letter2 = 8'b11111011; 
    wire [7:0] an_letter3 = 8'b11111101;
    wire [7:0] an_letter4 = 8'b11111110;
    
    
    always @(posedge clk) begin 
    
    //if wackamole game mode, just display the game score 
    if(WM) begin 
        an1f <= 8'b01111111; an2f<= an_default; an3f<= an_default; an4f<= an_default;
        an1C<= an_default; an2C<= an_default; an3C<= an_default; an4C<= an_default;
    
        seg1f <= WM_seg; seg2f <= seg_default; seg3f <= seg_default; seg4f <=seg_default;
        seg1C <= seg_default; seg2C <= seg_default; seg3C<= seg_default; seg4C<= seg_default;
    end
    
    //changing the current time 
    else if(enable && !enable_A && !switch) begin 
        an1f <= an1L; an2f <= an2L; an3f<=an3L; an4f<= an4L;
        seg1f <= seg1; seg2f <= seg2; seg3f <= seg3; seg4f <= seg4;
   
        an1C <=an_letter1; an2C<= an_letter2; an3C <= an_letter3; an4C <= an_letter4;
        seg1C <=7'b0000000; seg2C <= 7'b1000000; seg3C<= 7'b0010010; seg4C<=7'b1111111;
   
    end
    
    //no switches or buttons pushed aka real time 
    else if(!enable && !enable_A && !switch) begin 
    
        an1f <= an1; an2f <= an2; an3f<=an3; an4f<= an4;
        seg1f <= seg1l; seg2f <= seg2l; seg3f <= seg3l; seg4f<= seg4l;
        
         //all time zone cases, display a city based on the tz switch used 
         if (!tz1 && !tz2 && !tz3 && !tz4) begin 
            an1C <=an_letter1; an2C<= an_letter2; an3C <= an_letter3; an4C <= an_letter4;
            seg1C <=7'b0000000; seg2C <= 7'b1000000; seg3C<= 7'b0010010;  seg4C<=7'b1111111;
         end 
                   
         else if(tz1) begin 
            an1C <=an_letter1; an2C<= an_letter2; an3C <= an_letter3; an4C <= an_letter4;
            seg1C <=7'b0001001; seg2C <= 7'b0001000; seg3C<= 7'b1000111; seg4C<=7'b1111111;
         end //halifax
                 
         else if (!tz1 && tz2 ) begin 
            an1C <=an_letter1; an2C<= an_letter2; an3C <= an_letter3; an4C <= an_letter4;
            seg1C <=7'b0010010; seg2C <= 7'b0001000; seg3C<= 7'b1000000; seg4C<=7'b1111111;
         end  //sao paulo
                                                 
         else if (!tz1 && !tz2 && tz3) begin 
            an1C <=an_letter1; an2C<= an_letter2; an3C <= an_letter3; an4C <= an_letter4;
            seg1C <=7'b0001110; seg2C <= 7'b1000111; seg3C<= 7'b1000000; seg4C<=7'b1111111;
         end  //florence
                  
         else if (!tz1 && !tz2 && !tz3 && tz4) begin 
            an1C <=an_letter1; an2C<= an_letter2; an3C <= an_letter3; an4C <= an_letter4;
            seg1C <=7'b1000000; seg2C <= 7'b1000001; seg3C<= 7'b0000000; seg4C<=7'b1111111;
         end //dubai 
                  
         else begin 
            an1C <=an_letter1; an2C<= an_letter2; an3C <= an_letter3; an4C <= an_letter4;
            seg1C <=7'b0000000; seg2C <= 7'b0000001; seg3C<= 7'b0100100;end seg4C<=7'b1111111;
       
    end //end else
   
    //calendar mode to display the day and month as well 
    else if(!enable && !enable_A && switch ) begin 
          an1f <= an1; an2f <= an2; an3f<=an3; an4f<= an4; 
          seg1f <= seg1l; seg2f <= seg2l; seg3f <= seg3l; seg4f<= seg4l;
          
          //display day and month from calendar
          an1C <=an_letter1; an2C<= an_letter2; an3C <= an_letter3; an4C <= an_letter4;
          seg1C <=segC; seg2C <= segC2; seg3C<= segC3;  seg4C<= segC4; 
    end 
  
  
    // last case is if the alarm mode is set, so display the alarm time 
    else begin 
        an1f <= an1A; an2f <= an2A; an3f<=an3A; an4f<= an4A; 
        seg1f <= seg1A; seg2f <= seg2A; seg3f <= seg3A; seg4f <= seg4A;
             
        an1C <=an_letter1; an2C<= an_letter2; an3C <= an_letter3; an4C <= an_letter4;
        seg1C <=7'b0000000; seg2C <= 7'b1000000; seg3C<= 7'b0010010; seg4C<=7'b1111111;
    end
    
    end //always 
    
    
endmodule
