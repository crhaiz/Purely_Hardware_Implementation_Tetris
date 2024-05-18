
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2023 10:44:56 PM
// Design Name: 
// Module Name: gridmapper
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


module gridmapper(  input logic [9:0] DrawX, DrawY,
                    output logic grid
    );
  
    
always_comb begin 
    if (DrawX < 10'd240 || DrawX > 10'd400) 
	    grid = 1'b0;
    
    else if (DrawY < 10'd32 || DrawY > 416)
	   grid = 1'b0;
	   
    else if(DrawX % 16 == 0 || DrawY % 16 == 0)
	   grid = 1'b1;
	   
    else 
	   grid = 1'b0;
end
endmodule
