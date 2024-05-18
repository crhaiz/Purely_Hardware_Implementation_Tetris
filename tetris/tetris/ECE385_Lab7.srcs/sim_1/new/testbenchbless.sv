module testbenchbless();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the processor will be 
// instantiated as a submodule in testbench.
logic Clk = 0;


logic reset;
logic [15:0] blockgrid;
enum logic [4:0] {  Halted, 
						PauseIR1, 
						PauseIR2, 
						S_18, 
						S_33_1, S_33_2, S_33_3,
						S_35, 
						S_22
						}   State, Next_state;   // Internal state logic
logic move;


				
// A counter to count the instances where simulation results
// do no match with expected results
integer ErrorCnt = 0;
		
// Instantiating the DUT
// Make sure the module and signal names match with those in your design
randnumgen randnumgen(.*);	

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
#2 reset = 1'b1;
#2 reset = 1'b0;


end

endmodule