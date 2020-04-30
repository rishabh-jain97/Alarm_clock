`timescale 1ns / 1ps

//DESCRIPTION OF INPUTS 
//twenty_four_format: switch that displays time in 24 hour format or 12 hour format
//cal_swtich: switch to display the calendar (month and day) 
//tz# switches that change the timezone display of different cities
//down is a switch that allows to decrement the hours and minute 
//clk is a 100Mhz input 
//alarm_enable is a switch that sets the alarm on 
//enable button displays the time to set (and allows one to change it) 
//enable_A button displays and allows one to change the alarm time 
//hour and minute are used to increment hour and minute (down switch will use this as decrements)
//load1 button takes the set time and loads it to the current time 


//DESCRIPTION OF OUTPUTS 
//an and seg outputs are for the 7 segnment display 
//PMF is the light that indicates a time is in PM for 12 hour format 
//alarm set indicates that you are changing the alarm time 
//alarm_on light works with alarm_enable to know the alarm is enabled 
// flash# flashes the lights when the alarm goes off 
//random data is the LED corresponding to "moles" for the wackamole game 


module alarm_top
    (input twenty_four_format,input cal_switch, input tz1, input tz2, input tz3, input tz4,
    input down,input clk,input alarm_enable,input enable,input enable_A, input reset,input hour, input minute,
    input load1, output [7:0] an, output  [6:0] seg , output PMF,output alarm_set,output alarm_on, output flash1, output flash2, output flash3,
    output [1:0] random_data
    );
    
    //output numbers from loader module and alarm
    wire [5:0] hour_out_loaded,min_out_loaded,hour_outa,min_outa;
    
    //debounced signals of minute and hour increment push buttons
    wire hour_out, min_out; 
    
    //actual second and minute and hour values that are loaded into current time
    //or into the alarm time  
    wire [5:0] sec_out_realtime,sec_a, min_out_realtime,min_a,hour_out_realtime;
    
    //segments from current time, loading time, alarm time
    wire [6:0] seg1,seg2,seg3,seg4,seg1L,seg2L,seg3L,seg4L,seg1f,seg2f,seg3f,seg4f,seg5f,seg6f,seg7f,seg8f;
    //anode code from current tume, loading time and alarm time
    wire [7:0] an1,an2,an3,an4,an1L,an2L,an3L,an4L,an1f,an2f,an3f,an4f,an5f,an6f,an7f,an8f;
    wire [7:0] an1A,an2A,an3A,an4A;
    //from calendar month/day
    wire [7:0] anc1,anc2,anc3,anc4;
    //segments from alarm
    wire [6:0] seg1A,seg2A,seg3A,seg4A,segc1,segc2,segc3,segc4;
    //clock for mux display and audio
    wire PML,PM,PMA;
    wire clk_5M;
    wire ringing;
    //wires for WM game
    wire done,right,WM_thresh; 
    wire [6:0] WM_seg;
    wire [7:0] WM_an;
    wire WM, RNG, timer_enable, timer_reset,count, count_reset, count_stop;
    //wire [1:0] random_data;
    wire [3:0] WM_score;
    wire month_out, day_out;
    wire stop;
    wire [2:0] state;
    wire enable_out, enable_A_out;
    wire clk_1khz;
   
   
    //debounce the push-button signals and generate a 5M clock
    Debouncer deb
        (.hours(hour),.minutes(minute),.enable_A(enable_A),.clk(clk)
        ,.hours_out(hour_out),.minutes_out(min_out),.enable_A_out(enable_A_out),.clk_5M(clk_5M)
        );
       
    //provide a 1khz clock for all 
    //with seperate divider 
    divide clkdivide1k
        (16'd5000,clk_5M,clk_1khz);
    
    //drive the PM light (indicates when a time is PM rather than AM)
    pm_driver pm 
        (.enable(enable),.enable_a(enable_A),.pm1(PML),.pm2(PM),.pmA(PMA),.pmf(PMF)
        );
       
    //when the cal switch is on, the calendar will increment with the push buttons
    //recall that the month and days are incremented with the hour and minute buttons
    cal_incrementer cal_buttons
        (.enable(enable),.enable_A(enable_A),.cal_switch(cal_switch), 
        .reset(reset), .month(hour_out), .day(min_out), .clock(clk_1khz),  
        .month_out(month_out), .day_out(day_out)
        );
           
    //loader for setting the current real time (loaded), also displays the time as it is being changed 
    loader_f loader
        (.down(down),.clk(clk_1khz),.enable(enable),.reset(reset), .hour(hour_out),
        .minute(min_out),.twenty_four_format(twenty_four_format),.hour_count(hour_out_loaded), .min_count(min_out_loaded),  
        .an1(an1L),.an2(an2L),.an3(an3L),.an4(an4L), 
        .seg1(seg1L), .seg2(seg2L), .seg3(seg3L), .seg4(seg4L), .PM(PML)
        );
     
    //loader for setting alarm, also displays the time as it is being set 
    loader_f alarm 
        (.down(down),.clk(clk_1khz),.enable(enable),.reset(reset), .hour(hour_out),
        .minute(min_out),.twenty_four_format(twenty_four_format),.hour_count(hour_outa), .min_count(min_outa),  
        .an1(an1A),.an2(an2A),.an3(an3A),.an4(an4A), 
        .seg1(seg1A), .seg2(seg2A), .seg3(seg3A), .seg4(seg4A), .PM(PMA)
        );
           
    //module that holds and increments the current real time 
    //handles time zone change displays 
    top timer
        (.push_increment_month(month_out),.push_increment_day(day_out)
        ,.tz1(tz1),.tz2(tz2),.tz3(tz3),.tz4(tz4),.clk(clk_1khz), .enable(1'b1)
        ,.reset(reset),.load1(load1), .hour_in(hour_out_loaded), .minute_in(min_out_loaded),
        .twenty_four_format(twenty_four_format), .seconds(sec_out_realtime),.minutes(min_out_realtime),
        //outputs
        .hours(hour_out_realtime),.an1(an1), .an2(an2), .an3(an3),  .an4(an4), 
        .anC1(anc1), .anC2(anc2),.anC3(anc3),.anC4(anc4),
        .seg1(seg1), .seg2(seg2), .seg3(seg3), .seg4(seg4), 
        .segC1(segc1),.segC2(segc2),.segC3(segc3),.segC4(segc4), .PM(PM)
        );
                               
    //compare alarm time and real time           
    comparator comp
        (.clk(clk_1khz),.reset(reset),.alarm_enable(alarm_enable), 
        .hour_in(hour_out_realtime),.min_in(min_out_realtime),.sec_in(sec_out_realtime),
        .hour_ina(hour_outa), .minute_ina(min_outa),.alarm(ringing), .set(alarm_set)
        );       
                 
     //alarm module to flash lights when changing time   
    alarm_setflash blinky
        (clk_1khz,reset,enable_A,flash1,flash2,flash3
        );
      
      //flash the alarm light when alarm goes off 
      //also starts the wackamole game                  
    alarm ringer
        (clk_1khz, ringing,WM,  alarm_on
        );   

     //count stop assures that the score only goes up once when a mole is hit
     //wack a mole module for dictating the states, idle state and in game states
     //controls and manages all the signals 
    WM_SM state_machine
        (clk_1khz,ringing,alarm_enable,done,right,WM_thresh,
        WM, RNG, timer_enable, timer_reset,count, count_reset, state, stop, count_stop
        );

    //random number generator to pick which "mole" and light to turn on 
    LSFR Random
        (clk_1khz,reset,RNG,stop,random_data
        );

    //uses the 4 buttons (enables, hour and min. Compares these buttons against the 
    //random number which was generated to determine if a mole was hit 
    WM_timer game
        (clk_1khz, timer_reset, timer_enable,random_data, 
        enable_A_out, enable, hour_out, min_out,right,
        done
        );
 
    //counter to keep track of score and determine when the game has been beat 
    //(WM_thresh from this module dictates when it is complete)
    WM_counter1 WM_count
        (clk_1khz, count, count_reset, count_stop, WM_score, WM_thresh 
        );

    //used to convert the current score to a displayable 7 segment display 
    number WM_number_converter
        (WM_score, WM_seg, WM_an
        );
    
    //mux for display    
    mux_driver driver
        ( clk_1khz,WM,WM_seg, //wack a mole game signals
        tz1,tz2,tz3,tz4,
        cal_switch,enable,enable_A, //timezones and enables for display
        an1L, an2L, an3L, an4L, //loader anodes
        an1, an2, an3, an4, //regular anodes
        an1A,an2A,an3A,an4A, //alarm anodes
        anc1,anc2,anc3,anc4, //calendar anodes
        
        seg1L,  seg2L, seg3L, seg4L, //loader segments
        seg1,seg2,seg3, seg4, //regular segments
        seg1A,seg2A,seg3A,seg4A, //alarm segments
        segc1,segc2,segc3,segc4, //calendar segments
        an1f, an2f, an3f, an4f,an5f,an6f,an7f,an8f, //outputs of anodes to big_mux
        seg1f,seg2f,seg3f,seg4f,seg5f,seg6f,seg7f, seg8f
        
        ); //outputs of segments to big mux
        
     
    //only one of the 8 anodes can be displayed at once, 
    //therefore each anode is flashed at a fast rate which is 
    //untraceable by the human eye (1kHz)
    big_mux mux_flasher
        (clk_1khz, 
        an1f, an2f, an3f, an4f,an5f,an6f,an7f,an8f,
        seg1f,seg2f, seg3f, seg4f,seg5f,seg6f,seg7f,seg8f, 
        an,seg 
        );  
                
endmodule
