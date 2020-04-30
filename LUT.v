`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/10/2018 06:16:45 PM
// Design Name: 
// Module Name: LUT
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


module LUT(input [5:0] rom_address, output [7:0] rom_data);

reg [7:0] ROM [59:0]; 

assign rom_data = ROM[rom_address]; //reading rom content at the address

initial $readmemb ("ROM_data.txt",ROM,0,59); 
endmodule

