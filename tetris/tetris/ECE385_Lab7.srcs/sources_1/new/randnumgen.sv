`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2023 06:53:54 PM
// Design Name: 
// Module Name: randnumgen
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


module randnumgen(input logic Clk, 
                  input logic reset,
                  
                  output logic [15:0] blockgrid
                  );
    
      logic [15:0] data_in, data;
    

      always_ff @(posedge Clk) begin
            if (reset)
              data_in <= 16'hF03E; 
            else
              data_in <= {data_in[14:0], !(data_in[15] ^ data_in[13])};
        
          
          
      end
      
      always_comb begin
          data = (data_in == 16'hFFFF) ? 16'h1013 : data_in;
          case (data[2:0]) 
          3'b000:
                blockgrid = 16'b0010001100100000;
          3'b001:
                blockgrid = 16'b0110001000100000;
          3'b010:
                blockgrid = 16'b0110010001000000;
          3'b011:
                blockgrid = 16'b0110001100000000;
          3'b100:
                blockgrid = 16'b0011011000000000;
          3'b101:
                blockgrid = 16'b0010001000100010; 
          3'b110:
                blockgrid = 16'b0011001100000000;
          3'b111:
                blockgrid = 16'b0110010001000000; 
 
          endcase
           
           
      end
endmodule
