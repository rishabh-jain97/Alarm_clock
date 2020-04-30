`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/10/2018 06:32:05 PM
// Design Name: 
// Module Name: top
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




module top
    (input push_increment_month,input push_increment_day,
    input tz1, input tz2, input tz3, input tz4,input clk, input enable, input reset,
    input load1, input [5:0] hour_in, input [5:0] minute_in, input twenty_four_format,
        
        
    output [5:0] seconds, output [5:0] minutes, output [5:0] hours,
    output [7:0] an1,output [7:0] an2, output [7:0] an3, output [7:0] an4, 
    output [7:0] anC1,output [7:0] anC2,output [7:0] anC3, output [7:0] anC4,
    output [6:0] seg1, [6:0] seg2, [6:0] seg3,[6:0] seg4, 
    output [6:0] segC1, output [6:0] segC2, output [6:0] segC3, output [6:0] segC4,   
    output PM)
    ;
 
      
    wire CLK_1Hz, minute_clk, clk_5Mhz;
    wire thresh1,thresh2,thresh3,thresh4,thresh5;
    wire [5:0] num4,hour_decoded,num_day,num_month;
    wire [7:0] bcd0,bcd1,bcd2;

    wire enable3;

    wire load3 = 1'b0;
    

    wire day_enable1;
    wire day_reseter_but,month_enable;
    wire override_month,day_reset_but;
    wire [7:0]  rom_data_month, rom_data_day;
    wire [8:0] offset;
    wire [11:0] rom_data;
   
    //generate 1Hz signal
  
    dividerHz clk1(.reset(reset), .clk(clk),.enable(enable), .enable2(CLK_1Hz)); 
   
    //seconds counter
    c_counter_binary_0 sec(.LOAD(load3),.L(minute_in),.CLK(clk),.CE(CLK_1Hz),.SCLR(reset),.THRESH0(thresh1),.Q(seconds));

    //minute counter
    minute_enabler min_enable(CLK_1Hz,thresh1, load1,minute_clk);
    c_counter_binary_0 minute(.LOAD(load1),.L(minute_in),.CLK(clk),.CE(minute_clk),.SCLR(reset),.THRESH0(thresh2),.Q(minutes));
    
    //hour counter
    hour_divider hour_enable(CLK_1Hz, thresh1, thresh2,load1 ,enable3) ;
    c_counter_binary_1 hour(.LOAD(load1),.L(hour_in),.CLK(clk),.CE(enable3),.SCLR(reset),.THRESH0(thresh3),.Q(hours));
 
    //day counter
    day_enabler day_enable(CLK_1Hz,thresh1,thresh2,thresh3, push_increment_day,day_enable1);
    //circuit to determine when to reset the days
    day_reset day_reseter( reset,day_reset_but, day_reseter_but);
    c_counter_binary_2 day_count(.CLK(clk),.SCLR(day_reseter_but),.CE(day_enable1),.THRESH0(thresh4),.Q(num_day));
 
    //month counter
    month_enabler month_e(CLK_1Hz,thresh1,thresh2,  thresh3,thresh4, 
    push_increment_month,  override_month, month_enable ); 
    
    month_counter month(.CLK(clk),.SCLR(reset),.CE(month_enable),.THRESH0(thresh5),.Q(num_month));
 
 
    //update month and day on exception events such as november 31st
    //will reset the month and day counter when the end of the month has
    //been reached (ie october 32), has a look t
    month_fixer fix_date(num_month, num_day, clk,reset, override_month,  day_reset_but);
 
    //convert month to place holder in calendar file
    month_decoder MD(num_month, num_day, clk,offset);
 
    //look up table for calendar
    LUT_cal calendar(offset, rom_data);

    //turn a two digit number into two single digit numbers
    LUT_cal2 the_real_cal( rom_data, rom_data_month, rom_data_day);

    //get the appropriate 7segment and anode for day and month  
    number d1(rom_data_day[7:4],segC1,anC1);
    number d2(rom_data_day[3:0],segC2,anC2);
    number m1(rom_data_month[7:4],segC3,anC3); 
    number m2(rom_data_month[3:0],segC4,anC4);
 
   
    //used for time zone with the hours
    //convert appropriate time based on chosen time zone 
    time_zone tz(clk,tz1,tz2, tz3,tz4,hours, num4);
    decoder decode(num4,hour_decoded,PM,twenty_four_format);
    
    
    //get appropriate 7 segment anode and segments for 
    //minutes and hours 
    LUT minute_lut(minutes,bcd2); 
    LUT hour_lut(hour_decoded,bcd0);
    
    number mi1(bcd2[7:4],seg1,an1); 
    number1 mi2(bcd2[3:0],seg2,an2);
    
    numberh2 h1(bcd0[3:0],seg3,an3);
    numberh1 h2(bcd0[7:4],seg4,an4);
    
endmodule
