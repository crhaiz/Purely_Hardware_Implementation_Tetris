`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2023 04:24:42 PM
// Design Name: 
// Module Name: test_for_movementchecker
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


module test_for_movementchecker();


timeunit 10ns; // Half clock cycle at 50 MHz
   // This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the processor will be 
// instantiated as a submodule in testbench.
logic Clk = 0;

int rowindex;
logic reset;
logic [15:0] blockgrid;
//logic [7:0]keycode;
logic [1:0] rotation, rowcheck;
logic [7:0] keycode;
//logic [11:0] arraygrid [0:25][11:0];
logic [31:0] arraygrid[25:0][11:0];
logic [9:0] BallX, BallY;
logic canmoveleft, canmoveright, canmovedown, canmove, canrotate;
logic[31:0] c1,c2,c3,c4,a1;
logic [9:0] gridrow, gridcol, gridrownextleft, gridcolnextleft, gridrownextright, gridcolnextright, gridrownextdown, gridcolnextdown;
enum logic [4:0] {  Halted, 
      PauseIR1, 
      PauseIR2, 
      S_18, 
      S_33_1, S_33_2, S_33_3,
      S_35, 
      S_22
      }   State, Next_state;   // Internal state logic

logic startGame;
logic updategrid;
logic newblock;
// A counter to count the instances where simulation results
// do no match with expected results
integer ErrorCnt = 0;
  
// Instantiating the DUT
// Make sure the module and signal names match with those in your design
movementchecker yo(.*); 
updatearraygrid wassup(.*);
ball bruhhhh (.Reset(reset),.*);

// Toggle the clock
// #1 means wait for a delay of 1 timeunit
always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end
//always begin
////#1 if (state == PauseIR1) Continue = 1'b1;
////else Continue = 1'b0;
////#1 Continue = (state == PauseIR1);
//end

initial begin : CLOCK_INITIALIZATION
    Clk = 0;
end 

// Testing begins here
// The initial block is not synthesizable
// Everything happens sequentially inside an initial block
// as in a software program
initial begin: TEST_VECTORS
//#2 reset = 1'b1;
//#2 reset = 1'b0;
#2 newblock = 1'b1;
#2 newblock = 1'b0;

#2 updategrid = 1'b0;
#2 startGame = 1'b1;
#2 startGame = 1'b0;
//#2 keycode = 16'h00;
//#2 keycode = 16'h14;
//#2 rowcheck = 1'b1;
#2 blockgrid = 16'b0010011000100000;
#2 BallX = 10'd320;
#2 BallY = 10'd64;


#2 BallY = BallY + 16;
#2 BallY = BallY + 16;
//#2 BallX = BallY + 16;
//#2 BallX = BallX - 16;
//#2 BallX = BallX - 16;
//#2 BallX = BallX - 16;
#2 BallY = BallY + 16;
#2 BallY = BallY + 16;
#2 BallY = BallY + 16;
#2 BallY = BallY + 16;
#2 BallY = BallY + 16;
end
endmodule
