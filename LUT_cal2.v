`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2018 02:42:17 PM
// Design Name: 
// Module Name: LUT_cal2
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


module LUT_cal2(input [11:0] rom_address, output [7:0] rom_data_month, output [7:0] rom_data_day);

reg [7:0] ROM [59:0]; 
wire [5:0] rom_data1, rom_data2;

assign rom_data1 = rom_address[11:6];
assign rom_data2 = rom_address[5:0];

 
assign rom_data_month = ROM[rom_data1]; //reading rom content at the address
assign rom_data_day = ROM[rom_data2]; //reading rom content at the address

initial $readmemb ("ROM_data.txt",ROM,0,59); 
endmodule


