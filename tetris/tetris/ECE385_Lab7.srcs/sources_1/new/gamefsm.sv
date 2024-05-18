`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2023 01:40:36 PM
// Design Name: 
// Module Name: gamefsm
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


module gamefsm( input logic Clk,
                input logic Reset,
                input logic [7:0] keycode,
                input logic canmovedown,
                
                
                output logic startGame,
                output logic newblock,
                output logic blockcheck,
                output logic rowcheck,
                output logic updategrid


              );
enum logic [10:0] {      Halted, 
						Start,//press space to start
						Newblock,
						Blockcheck,
						Rowcheck,
						Rowcheck1,
						Rowcheck2,
						Rowcheck3,
						Rowcheck4,
						die,
						Shift,
						Blockmove,
						Updategrid
						
						}   State, Next_state;   // Internal state logic
                            
    always_ff @ (posedge Clk)
        begin
            if (Reset) 
                State <= Start;
            else 
                State <= Next_state;
        end
        
    always_comb begin
        
        Next_state = State;
        unique case (State)
                    Start : 
                        if (keycode == 16'h2C) 
                            Next_state = Newblock;
                        else 
                            Next_state = Start;
                    Newblock : 
                        Next_state = Blockcheck;  
                    
                    Blockcheck :                  
                        if (canmovedown == 1'b1)
                            Next_state = Blockmove;
                        else
                            Next_state = Updategrid;
                        
                    Blockmove :
                        Next_state = Blockcheck;
                    
                    Rowcheck :
                        Next_state = Rowcheck1;
                        
                    Rowcheck1 :
                        Next_state = Rowcheck2;
                    
                    Rowcheck2 :
                        Next_state = Rowcheck3;
                    
                    Rowcheck3 :
                        Next_state = Rowcheck4;
                    Rowcheck4 :

                        Next_state = Newblock;
                          
                    
                    Updategrid: 
                           Next_state = Rowcheck;
                    default:;
        endcase
        
    newblock = 1'b0;
    blockcheck = 1'b0;
    startGame = 1'b0;
    rowcheck = 1'b0;
    updategrid = 1'b0;
    
    case (State)  
        Start : begin 
            startGame = 1'b1;   //i am in the start screen basically
            
        end
        
        Newblock : begin 
            newblock = 1'b1;
            
        end
        
        Blockcheck : begin
            blockcheck = 1'b1;
            
        end
        
        Blockmove : ;
        
        Rowcheck : begin
            rowcheck = 1'b1;
        end
        Rowcheck1 : begin
            rowcheck = 1'b1;
        end
        Rowcheck2 : begin
            rowcheck = 1'b1;
        end
        Rowcheck3 : begin
            rowcheck = 1'b1;
        end
        Rowcheck4 : begin
            rowcheck = 1'b1;
        end
        
        Updategrid: begin
            updategrid = 1'b1;
        end 
        default: begin
            startGame = 1'b0;
            newblock = 1'b0;
            blockcheck = 1'b0;
            rowcheck = 1'b0;
            updategrid = 1'b0;
        end
    endcase
    
    end
    
    

endmodule
