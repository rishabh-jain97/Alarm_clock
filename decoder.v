`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2018 03:30:35 PM
// Design Name: 
// Module Name: decoder
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


module decoder(input [5:0] hour, output reg [5:0] n_hour,output reg  PM,
input two_four_format    );
    
    always @(*) begin 
    
    if(!two_four_format) begin 
    case (hour) 
    
    6'b000000: begin n_hour = 6'b001100; PM =0; end
    6'b000001: begin n_hour = 6'b000001; PM =0; end
    6'b000010: begin n_hour = 6'b000010; PM =0; end
    
    6'b000011: begin n_hour = 6'b000011; PM =0; end
    
    6'b000100: begin n_hour = 6'b000100; PM =0; end
    
    6'b000101: begin n_hour = 6'b000101; PM =0; end
    6'b000110: begin n_hour = 6'b000110; PM =0; end
    6'b000111: begin n_hour = 6'b000111; PM =0; end
    
    6'b001000: begin n_hour = 6'b0001000; PM =0; end
    6'b001001: begin n_hour = 6'b0001001; PM =0; end
    6'b001010: begin n_hour = 6'b0001010; PM =0; end
    6'b001011: begin n_hour = 6'b0001011; PM =0; end
    
    6'b001100: begin n_hour = 6'b001100; PM =1; end
    
    
    
    6'b001101: begin n_hour = 6'b000001; PM =1; end
    
    6'b001110: begin n_hour = 6'b000010; PM =1; end
    
    6'b001111: begin n_hour = 6'b000011; PM =1; end
    
    6'b010000: begin n_hour = 6'b000100; PM =1; end
    
    6'b010001: begin n_hour = 6'b000101; PM =1; end
    6'b010010: begin n_hour = 6'b000110; PM =1; end
    6'b010011: begin n_hour = 6'b000111; PM =1; end
    
    6'b010100: begin n_hour = 6'b0001000; PM =1; end
    6'b010101: begin n_hour = 6'b0001001; PM =1; end
    6'b010110: begin n_hour = 6'b0001010; PM =1; end
    6'b010111: begin n_hour = 6'b0001011; PM =1; end
    
    6'b011000: begin n_hour = 6'b0001100; PM =0; end
    
    6'b011001: begin n_hour = 1; PM = 0; end
    6'b011010: begin n_hour =2; PM=0; end
    6'b011011: begin n_hour =3; PM=0; end
    6'b011100: begin n_hour =4; PM=0; end
    6'b011101: begin n_hour =5; PM=0; end
    6'b011110: begin n_hour =6; PM=0; end
    6'b011111: begin n_hour =7; PM=0; end
    6'b100000: begin n_hour =8; PM=0; end
    6'b100001: begin n_hour =9; PM=0; end
    6'b100010: begin n_hour =10; PM=0; end
    6'b100011: begin n_hour =11; PM=0; end
    6'b100100: begin n_hour =12; PM=1; end
    6'b100101: begin n_hour =1; PM=1; end
        
    
    endcase
    end 
    else begin 
    case (hour)
        6'b000000: begin n_hour = 6'b000000; PM =0; end
        
        6'b000001: begin n_hour = 6'b000001; PM =0; end
        
        6'b000010: begin n_hour = 6'b000010; PM =0; end
        
        6'b000011: begin n_hour = 6'b000011; PM =0; end
        
        6'b000100: begin n_hour = 6'b000100; PM =0; end
        
        6'b000101: begin n_hour = 6'b000101; PM =0; end
        6'b000110: begin n_hour = 6'b000110; PM =0; end
        6'b000111: begin n_hour = 6'b000111; PM =0; end
        
        6'b001000: begin n_hour = 6'b0001000; PM =0; end
         6'b001001: begin n_hour = 6'b0001001; PM =0; end
          6'b001010: begin n_hour = 6'b0001010; PM =0; end
           6'b001011: begin n_hour = 6'b0001011; PM =0; end
           
            6'b001100: begin n_hour = 6'b001100; PM =0; end
            
            
            
             6'b001101: begin n_hour = 6'b001101; PM =0; end
               
               6'b001110: begin n_hour = 6'b001110; PM =0; end
               
               6'b001111: begin n_hour = 6'b001111; PM =0; end
               
               6'b010000: begin n_hour = 6'b010000; PM =0; end
               
               6'b010001: begin n_hour = 6'b010001; PM =0; end
               6'b010010: begin n_hour = 6'b010010; PM =0; end
               6'b010011: begin n_hour = 6'b010011; PM =0; end
               
               6'b010100: begin n_hour = 6'b010100; PM =0; end
               6'b010101: begin n_hour = 6'b010101; PM =0; end
               6'b010110: begin n_hour = 6'b010110; PM =0; end
               6'b010111: begin n_hour = 6'b010111; PM =0; end
               6'b011000: begin n_hour = 6'b000000; PM =0; end
                
                
                //above 24 hours going to try decimal and see if it works   
                   6'b011001: begin n_hour = 1; PM = 0; end  
                   6'b011010: begin n_hour =2; PM=0; end 
                   6'b011011: begin n_hour =3; PM=0; end 
                   6'b011100: begin n_hour =4; PM=0; end
                   6'b011101: begin n_hour =5; PM=0; end
                   6'b011110: begin n_hour =6; PM=0; end
                   6'b011111: begin n_hour =7; PM=0; end
                   6'b100000: begin n_hour =8; PM=0; end
                   6'b100001: begin n_hour =9; PM=0; end
                6'b100010: begin n_hour =10; PM=0; end
                6'b100011: begin n_hour =11; PM=0; end
                6'b100100: begin n_hour =12; PM=0; end
                6'b100101: begin n_hour =13; PM=0; end
                
    endcase
    end
    end
endmodule
