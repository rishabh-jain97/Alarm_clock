`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2018 05:03:59 PM
// Design Name: 
// Module Name: LSFR
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

module LSFR(
  input clk,
  input rst_n,
  input enable,
   
  input stop,
  output reg [1:0] data1
    );
    
    reg [4:0] data;
    reg [4:0] data_next;
    
    always @(*) begin
      if (enable) begin
          data_next[4] = data[4]^data[1];
          data_next[3] = data[3]^data[0];
          data_next[2] = data[2]^data_next[4];
          data_next[1] = data[1]^data_next[3];
          data_next[0] = data[0]^data_next[2];
      end
    end
    
    always @(posedge clk or posedge rst_n)
          if(rst_n)
            data <= 5'h1f;
          //when not enabled, stop changin the numbers
          else if (enable) begin
           
            data <= data_next[4:0];
            data1 <= data[3:2];
          end
          //when given stop comman,d stop outputiing numbers in idle state
          else if(stop) begin 
            data1 <= 2'b00;
          end
endmodule
