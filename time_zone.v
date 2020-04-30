`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2018 12:21:30 PM
// Design Name: 
// Module Name: time_zone
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


module time_zone(input clk, input tz1, input tz2, input tz3, input tz4, input[5:0] hour_in,
output reg [5:0] hour_zone
    );
    
    
    always @(posedge clk) begin 
    
    if (tz1) begin hour_zone <= hour_in + 1;  end //halifax
    else if(!tz1 && tz2) begin hour_zone <= hour_in +3; end //sao paulo 
    else if (!tz1 && !tz2 && tz3) begin hour_zone <= hour_in +6; end // milan 
    else if (!tz1 && !tz2 && !tz3 && tz4) begin hour_zone <= hour_in +9; end //dubai 
    else begin hour_zone <= hour_in; end
    end
    
endmodule
