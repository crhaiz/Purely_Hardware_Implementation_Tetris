`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2023 04:49:55 PM
// Design Name: 
// Module Name: rotation
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


module rotation(input logic Clk,
                input logic Reset,
                input logic [7:0] keycode,
                input logic [15:0] blockgrid,
                input logic canrotate,
                output logic [15:0] blockgridrotate

                );
                
        logic holdflag;               
        logic [7:0] prev;
        always_ff @ (posedge Clk) begin
            prev <= keycode;
        end
assign holdflag = (prev == 8'd0) && (keycode != 8'd0);               

//always_ff @ (posedge Clk) begin
//    if (keycode == 8'h00) 
//        holdflag <= 1'b1;
//    else
//        holdflag <= holdflag;

//end
always_comb begin
        if (Reset == 1'b1) begin
            blockgridrotate = 16'b0000000000000000;
        end
        else begin 
            if (canrotate == 1'b1 && (keycode == 8'h08) && holdflag) begin
                case (blockgrid)
                    16'h2320://t piece
                        blockgridrotate = 16'h0720;                    
                    16'h0720:
                        blockgridrotate = 16'h2620;
                    16'h2620:
                        blockgridrotate = 16'h0270;
                    16'h0270:
                        blockgridrotate = 16'h2320;
                        
                        
                    16'h6220: // L piece
                        blockgridrotate = 16'h1700;
                    16'h1700:
                        blockgridrotate = 16'h4460;
                    16'h4460:
                        blockgridrotate = 16'h7400;
                    16'h7400:
                        blockgridrotate = 16'h6220;
                    
                    16'h6440: // inverted L piece
                        blockgridrotate = 16'hE200;
                    16'hE200:
                        blockgridrotate = 16'h2260;
                    16'h2260:
                        blockgridrotate = 16'h4700;
                    16'h4700:
                        blockgridrotate = 16'h6440;
                    
                    16'h2222: // line piece
                        blockgridrotate = 16'h0F00;
                    16'h0F00:
                        blockgridrotate = 16'h2222;
                        
                    16'h3300: // square piece
                        blockgridrotate = 16'h3300;
                    
                    16'h6300: // z piece
                        blockgridrotate = 16'h2640;
                    16'h2640:
                        blockgridrotate = 16'h6300;
                                        
                    16'h3600: // inverted z piece
                        blockgridrotate = 16'h4620;
                    16'h4620:
                        blockgridrotate = 16'h3600;
                    default:
                        blockgridrotate = 16'h0000;
                endcase
            
                     
            end
            else if (canrotate == 1'b1 && (keycode == 8'h14) && holdflag) begin
                case (blockgrid)
  
                    16'h6220: // L piece
                        blockgridrotate = 16'h7400;
                    16'h7400:
                        blockgridrotate = 16'h4460;
                    16'h4460:
                        blockgridrotate = 16'h1700;
                    16'h1700:
                        blockgridrotate = 16'h6220;
                    
                    16'h6440: // inverted L piece
                        blockgridrotate = 16'hE200;
                    16'hE200:
                        blockgridrotate = 16'h4700;
                    16'h4700:
                        blockgridrotate = 16'h2260;
                    16'h2260:
                        blockgridrotate = 16'h6440;
                    
                    16'h3300: // square piece
                        blockgridrotate = 16'h3300;
                    
                    16'h2320: // t piece
                        blockgridrotate = 16'h2700;
                    16'h2700:
                        blockgridrotate = 16'h2620;
                    16'h2620:
                        blockgridrotate = 16'h0720;
                    16'h0720:
                        blockgridrotate = 16'h2320;
                    
                    16'h6300: // Z piece
                        blockgridrotate = 16'h2640;
                    16'h2640:
                        blockgridrotate = 16'h6300;
                    
                    16'h3600: // inverted z piece
                        blockgridrotate = 16'h4620;
                    16'h4620:
                        blockgridrotate = 16'h3600;
                    
                    16'h2222: // line piece
                        blockgridrotate = 16'h0F00;
                    16'h0F00:
                        blockgridrotate = 16'h2222;
                    default:
                        blockgridrotate = 16'h0000;
                endcase
            end
            else
                blockgridrotate = blockgrid;
            
        end
    
end

endmodule
