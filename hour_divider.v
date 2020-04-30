`timescale 1ns / 1ps



module hour_divider(input enable,input thresh,input thresh2, input load1, output minute_enable

    );
    
   assign minute_enable = ((thresh && enable &&thresh2) || load1); 
endmodule




/*
module hour_divider(input reset, input clk,input enable,output reg enable2) ;
reg[32:0] counter =0; 

always @(posedge clk or posedge reset)begin 
if (reset) begin 
counter <=0;
enable2<=0;
end//end reset
else if (enable) begin 
    if (counter == 300000000) begin
    //if (counter == 100) begin
    //if (counter == 2) begin
    counter <=0;
    enable2 <=1;
                       end
    else begin
    enable2<=0;
    counter <= counter +1; end
end //end else if enable
else if (!enable) begin 
enable2 <=0;
counter <=0;
end
end//endposedge clock
endmodule*/