`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2023 02:37:21 PM
// Design Name: 
// Module Name: test_for_fsm
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


module test_for_fsm();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the processor will be 
// instantiated as a submodule in testbench.
logic Clk = 0;



logic [15:0] blockgrid;

                 logic Reset;
                 logic [15:0] keycode;
                 logic movevalid;
                 logic rowfull;

                logic startGame;
                logic newblock;
                logic blockcheck;

enum logic [4:0] {      Halted, 
						Start,//press space to start
						Newblock,
						Blockcheck,
						Rowcheck,
						Shift,
						Blockmove,
						Updategrid
						
						}   State, Next_state;   // Internal state logic


				
// A counter to count the instances where simulation results
// do no match with expected results
integer ErrorCnt = 0;
		
// Instantiating the DUT
// Make sure the module and signal names match with those in your design
gamefsm fsm(.*);	

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
#2 Reset = 1'b1;
#2 Reset = 1'b0;

#2 keycode = 16'h2C;
#2 movevalid = 1'b1;
//#2 movevalid = 1'b0; 
 


end


endmodule
