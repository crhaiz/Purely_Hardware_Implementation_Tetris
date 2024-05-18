//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Zuofu Cheng   08-19-2023                               --
//                                                                       --
//    Fall 2023 Distribution                                             --
//                                                                       --
//    For use with ECE 385 USB + HDMI                                    --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input  logic [9:0] BallX, BallY, DrawX, DrawY, Ball_size,
                       input logic grid,
                       input logic [15:0] blockgrid,
                       input logic [1:0] arraygrid[25:0][11:0],
                       input logic blockexist,
                       input logic die,
                       input logic startGame,
                       //input logic [9:0] blockgrid,
                       output logic [3:0]  Red, Green, Blue );
    
    logic ball_on;
	 
 /* Old Ball: Generated square box by checking if the current pixel is within a square of length
    2*BallS, centered at (BallX, BallY).  Note that this requires unsigned comparisons.
	 
    if ((DrawX >= BallX - Ball_size) &&
       (DrawX <= BallX + Ball_size) &&
       (DrawY >= BallY - Ball_size) &&
       (DrawY <= BallY + Ball_size))
       )

     New Ball: Generates (pixelated) circle by using the standard circle formula.  Note that while 
     this single line is quite powerful descriptively, it causes the synthesis tool to use up three
     of the 120 available multipliers on the chip!  Since the multiplicants are required to be signed,
	  we have to first cast them from logic to int (signed by default) before they are multiplied). */
	  
    int DistX, DistY, Size;
    assign DistX = DrawX - BallX;
    assign DistY = DrawY - BallY;
    assign Size = Ball_size;
  
//    always_comb
//    begin:Ball_on_proc
//        if ((DrawX >= BallX - Ball_size) &&
//       (DrawX <= BallX + Ball_size) &&
//       (DrawY >= BallY - Ball_size) &&
//       (DrawY <= BallY + Ball_size))
       
//            ball_on = 1'b1;
//        else 
//            ball_on = 1'b0;
//     end 
     //unsure of the if statements to 
//  always_comb
//    begin:Ball_on_proc
//       while (i < 9) begin
//           if ((DrawX >= BallX - Ball_size) &&
//           (DrawX <= BallX + Ball_size) &&
//           (DrawY >= BallY - Ball_size) &&
//           (DrawY <= BallY + Ball_size) && 
//           (blockgrid[i] == 1'b1))
       
//                ball_on = 1'b1;
//            else 
//                ball_on = 1'b0;
            
//            if (DrawX > BallX_size && Draw DrawX % 16 == 1'b0 && DrawY % 16 == 1'b0) begin
//                    i = i + 1;
//            end
        
//        end
//     end

logic [9:0] x1,x2,x3,x4,x5;
logic [9:0] y1,y2,y3,y4,y5;

logic bruh;

   always_comb begin
        x1 = BallX - 32;
        x2 = BallX - 16;
        x3 = BallX;
        x4 = BallX + 16;
        x5 = BallX + 32;
        
        y1 = BallY - 32;
        y2 = BallY - 16;
        y3 = BallY;
        y4 = BallY + 16;
        y5 = BallY + 32;
        //row one of the 4x4 
        if ((DrawX >= x1 && DrawX <= x2 && DrawY >= y1 && DrawY <= y2 && blockgrid[0] == 1'b1)|| // row 1 
            (DrawX >= x2 && DrawX <= x3 && DrawY >= y1 && DrawY <= y2 && blockgrid[1] == 1'b1)||
            (DrawX >= x3 && DrawX <= x4 && DrawY >= y1 && DrawY <= y2 && blockgrid[2] == 1'b1)||
            (DrawX >= x4 && DrawX <= x5 && DrawY >= y1 && DrawY <= y2 && blockgrid[3] == 1'b1)||
            (DrawX >= x1 && DrawX <= x2 && DrawY >= y2 && DrawY <= y3 && blockgrid[4] == 1'b1)||    //row 2
            (DrawX >= x2 && DrawX <= x3 && DrawY >= y2 && DrawY <= y3 && blockgrid[5] == 1'b1)||
            (DrawX >= x3 && DrawX <= x4 && DrawY >= y2 && DrawY <= y3 && blockgrid[6] == 1'b1)||
            (DrawX >= x4 && DrawX <= x5 && DrawY >= y2 && DrawY <= y3 && blockgrid[7] == 1'b1)||
            (DrawX >= x1 && DrawX <= x2 && DrawY >= y3 && DrawY <= y4 && blockgrid[8] == 1'b1)||    //row 3
            (DrawX >= x2 && DrawX <= x3 && DrawY >= y3 && DrawY <= y4 && blockgrid[9] == 1'b1)||
            (DrawX >= x3 && DrawX <= x4 && DrawY >= y3 && DrawY <= y4 && blockgrid[10] == 1'b1)||
            (DrawX >= x4 && DrawX <= x5 && DrawY >= y3 && DrawY <= y4 && blockgrid[11] == 1'b1)||
            (DrawX >= x1 && DrawX <= x2 && DrawY >= y4 && DrawY <= y5 && blockgrid[12] == 1'b1)||   //row 4
            (DrawX >= x2 && DrawX <= x3 && DrawY >= y4 && DrawY <= y5 && blockgrid[13] == 1'b1)||
            (DrawX >= x3 && DrawX <= x4 && DrawY >= y4 && DrawY <= y5 && blockgrid[14] == 1'b1)||
            (DrawX >= x4 && DrawX <= x5 && DrawY >= y4 && DrawY <= y5 && blockgrid[15] == 1'b1))begin
                
                ball_on = 1'b1;
        end 
        
          else begin
          
                ball_on = 1'b0;
                
          end
          
        

   end
    
    
    
    always_comb
    begin:RGB_Display
        if (die || startGame) begin 
            Red = 4'h0;
            Green = 4'h0;
            Blue = 4'hF;
        end
        else begin
            if (grid == 1'b1) begin
                Red = 4'hF;
                Green = 4'hF;
                Blue = 4'hF;
            end
            
            else if ((ball_on == 1'b1)) begin 
                Red = 4'hf;
                Green = 4'h7;
                Blue = 4'h0;
            end       
            
            else if ((blockexist == 1'b1)) begin 
                Red = 4'hf;
                Green = 4'h0;
                Blue = 4'h0;
            end
            
            else begin 
                Red = 4'h0 ; 
                Green = 4'h0 ;
                Blue = 4'h0 ;
            end
        end      
        
    end 
    
endmodule
