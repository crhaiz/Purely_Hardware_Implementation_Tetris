//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Zuofu Cheng   08-19-2023                               --
//    Fall 2023 Distribution                                             --
//                                                                       --
//    For use with ECE 385 USB + HDMI Lab                                --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  ball (  input logic Reset, frame_clk,
                input logic [7:0] keycode,
                input logic canmoveleft,
                input logic canmoveright,
                input logic canmovedown,
                input logic canmove,
                input logic canrotate,
                input logic newblock,
                input logic startGame,     
                output logic [9:0]  BallX, BallY, BallS,
               output logic [9:0] Ball_Y_Motion
               
               );
    
    logic [9:0] Ball_X_Motion, Ball_Y_Motion;
    logic [4:0] counter;
    logic slow_clk;
    parameter [9:0] Ball_X_Center=320;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center= 32+32;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min=240+17;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=400-17;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min= 32-17;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max = 416-1;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step=1;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step=1;      // Step size on the Y axis

    assign BallS = 32;  // default ball size

    
//    always_ff @(posedge frame_clk) begin // clk divider to get new clk (which is the slower clk)

//        if (Reset) begin
//             counter <=0; //clock divider starts on reset
//             slow_clk <=0;
//        end
        
//        else begin
//            if (counter >= 6) begin
//                slow_clk <= ~slow_clk;
//                counter <=0;
//            end
//            else begin
//                 counter <= counter + 1;
//            end
//        end
//    end
    
    logic holdflag;               

//always_ff @ (posedge Clk) begin
//    if (keycode == 8'h00) 
//        holdflag <= 1'b1;
//    else
//        holdflag <= holdflag;

        logic [7:0] prev;
        always_ff @ (posedge frame_clk) begin
            prev <= keycode;
        end

assign holdflag = (prev == 8'd0) && (keycode != 8'd0);
    
    
    always_ff @ (posedge frame_clk or posedge Reset) //make sure the frame clock is instantiated correctly
    begin: Move_Ball
           
        if (Reset || newblock == 1'b1 || startGame == 1'b1)  // asynchronous Reset
        begin 
            Ball_Y_Motion <= 10'd0; //Ball_Y_Step;
            Ball_X_Motion <= 10'd0; //Ball_X_Step;
            BallY <= Ball_Y_Center;
            BallX <= Ball_X_Center;
            
        end
           
        else 
        begin 
             
             if (keycode == 8'h1A  ) begin//w
                 Ball_Y_Motion <= -10'd1;
                 Ball_X_Motion <= 10'd0;
             end
                         
                              
             else if (keycode == 8'h04 && canmoveleft && holdflag) begin//
                Ball_X_Motion  <= -10'd16;
                Ball_Y_Motion <= 10'd0; 
             end
             
             else if (keycode == 8'h16) begin//S
                Ball_Y_Motion <= 10'd1;
                Ball_X_Motion <= 10'd0;
             end
             
             else if (keycode == 8'h07 && canmoveright && holdflag) begin//D
                Ball_X_Motion <= 10'd16;
                Ball_Y_Motion <= 10'd0;
             end
                
             else begin
              Ball_X_Motion <= 10'd0;
              Ball_Y_Motion <= 10'd1;
             end
           
    

    
                 BallY <= (BallY + Ball_Y_Motion);  // Update ball position
                 BallX <= (BallX + Ball_X_Motion);
                  
       
  end  
    end
      
endmodule
