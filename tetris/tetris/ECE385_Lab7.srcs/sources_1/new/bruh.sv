`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2023 07:31:35 PM
// Design Name: 
// Module Name: bruh
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


module bruh(        input logic Clk,
                    input logic updategrid,
                    input logic rowcheck,
                    input logic startGame,
                    input logic [15:0] blockgrid,
                    
                    input logic [9:0] BallX, BallY,
                    input logic [7:0] keycode,
                    output logic canmoveleft, canmoveright, canmovedown, canrotate
                    
    );
    
        
        logic [1:0] arraygrid [25:0][11:0];
        
       	logic [9:0] newblock, gridrow, gridcol, gridrownextleft, gridcolnextleft, gridrownextright, gridcolnextright, gridrownextdown, gridcolnextdown;
       	//logic [3:0] sum;
       	

always_ff @ (posedge Clk) begin
    if (startGame == 1'b0) begin
        for (int i = 0; i < 26; i++) begin
            for(int j = 0; j < 12; j++) begin
                arraygrid[i][j] <= 1; 
            end
        end

        for(int i= 0; i<26; i++) begin //set sides to 1
            arraygrid[i][0] <= 1;
            arraygrid[i][11] <= 1;
        end
    
        for(int j= 0; j<12; j++) begin // set sides to 1
            arraygrid[0][j] <= 1;
            arraygrid[25][j] <= 1;
        end
    
    end
    
    else if (updategrid == 1'b1) begin       
        for( int i = 0; i<4; i++) begin
            for (int j = 0; j < 4; j++) begin
                arraygrid[gridrow][gridcol] <= blockgrid[i*4+ j];
            end  
        end
  
        
    end
    
//    else if (rowcheck == 1'b1) begin //to do row checking 
        
//        for (int row = 0; row < 26 ; row++) begin   //find rows that i need to delet
//            int rowtobedeleted;
//            sum = 0;
//            for (int col = 0; col < 12; col++) begin
//                sum = sum + arraygrid[row][col];    //if sum is 12 means row is full then tag for deletion 
//            end 
            
//            if (sum == 12) begin
//                rowtobedeleted = row;
                
//                for (int row1 = 0; row1 < rowtobedeleted ; row1++) begin           
//                    for (int col1 = 0; col1 < 12; col1++) begin
//                        arraygrid[row1+1][col1] = arraygrid[row1][col1];
//                    end
//                end
        
//                for (int col1 = 0; col1 < 12 ; col1++) begin
//                    arraygrid[0][col1] = 0;
//                end
                
//            end
    
//        end
        
//    end
    
    else begin
        for (int i = 0; i < 26; i++) begin
            for(int j = 0; j < 12; j++) begin
                arraygrid[i][j] <= arraygrid[i][j];
            end
        end
    end
    
    
    
end



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


logic [15:0]blockgridtemp;// for checking 
always_comb begin

    

    gridrow = ((BallY - 32) / 16) - 1 ; // math for indexing to grid (trust it works dont bother checking)
    gridcol = ((BallX - 240) / 16) - 1 ; 
    /////////////////////// for  moving left
    gridrownextleft = gridrow;
    gridcolnextleft = gridcol - 1;
    
    canmoveleft = 1'b1;
    for(int i = 0; i < 4; i++) begin
        for(int j = 0; j<4; j++) begin
            if(arraygrid[gridrownextleft + i][gridcolnextleft + j] == 1 && blockgrid[i*4+ j] == 1) begin
                    canmoveleft = 1'b0;
            end
        end
    end
    /////////////////////////////////// for moving right
    canmoveright = 1'b1;
    gridrownextright = gridrow;
    gridcolnextright = gridcol + 1;
    
    for(int i = 0; i < 4; i++) begin
        for(int j = 0; j<4; j++) begin
            if(arraygrid[gridrownextright + i][gridcolnextright + j] == 1 && blockgrid[i*4+ j] == 1) begin
                canmoveright = 1'b0;
            end
        end
    end

////////////////////////////////// moving down
    
    gridrownextdown = gridrow + 1;
    gridcolnextdown = gridcol;
    
    canmovedown = 1'b1;
    
    for(int i = 0; i < 4; i++) begin
        for(int j = 0; j<4; j++) begin
            if(arraygrid[gridrownextdown + i][gridcolnextdown + j] == 1 && blockgrid[i*4+ j] == 1) begin
                canmovedown = 1'b0;
                canmoveleft = 1'b0;
                canmoveright = 1'b0;
            end
        end
    end



//////////////////////////////// logic to get rotated blockgrid
    
    if (keycode == 16'h08) begin // CLOCKWISE
        if(blockgrid == 16'b0000111100000000) blockgridtemp = 16'b0010001000100010; // straight piece horizontal to vertical
        else if(blockgrid == 16'b0010001000100010) blockgridtemp = 16'b0000111100000000; // straight piece vertical to horizontal
        else if(blockgrid == 16'b0100011000100000) blockgridtemp = 16'b0011011000000000; //inverted z vertical to horizontal
        else if(blockgrid == 16'b0011011000000000) blockgridtemp = 16'b0100011000100000; // inverted z horizontal to vertical
        else if(blockgrid == 16'b0010011001000000) blockgridtemp = 16'b0110001100000000; // normal z vert to horizontal
        else if(blockgrid == 16'b0110001100000000) blockgridtemp = 16'b0010011001000000; // normal z horz to vert\
        else if(blockgrid == 16'b0100011100000000) blockgridtemp = 16'b0110010001000000; 
        else if(blockgrid == 16'b0010001001100000) blockgridtemp = 16'b0100011100000000;
        else if(blockgrid == 16'b1110001000000000) blockgridtemp = 16'b0010001001100000;
        else if(blockgrid == 16'b0110010001000000) blockgridtemp = 16'b1110001000000000;
        else if(blockgrid == 16'b0100010001100000) blockgridtemp = 16'b0111010000000000;
        else if(blockgrid == 16'b0001011100000000) blockgridtemp = 16'b0100010001100000;
        else if(blockgrid == 16'b0111010000000000) blockgridtemp = 16'b0110001000100000;
        else if(blockgrid == 16'b0110001000100000) blockgridtemp = 16'b0001011100000000;
        else if(blockgrid == 16'b0000011100100000) blockgridtemp = 16'b0010011000100000;
        else if(blockgrid == 16'b0010011000100000) blockgridtemp = 16'b0010011100000000;
        else if(blockgrid == 16'b0010001100100000) blockgridtemp = 16'b0000011100100000;
        
        else blockgridtemp = 16'b0000000000000000;
    end
    
    
    else if (keycode == 16'h14) begin // COUNTERCLOCKWISE
    
        if(blockgrid == 16'b0000111100000000) blockgridtemp = 16'b0010001000100010; // straight piece horizontal to vertical
        else if(blockgrid == 16'b0010001000100010) blockgridtemp = 16'b0000111100000000; // straight piece vertical to horizontal
        else if(blockgrid == 16'b0100011000100000) blockgridtemp = 16'b0011011000000000; //inverted z vertical to horizontal
        else if(blockgrid == 16'b0011011000000000) blockgridtemp = 16'b0100011000100000; // inverted z horizontal to vertical
        else if(blockgrid == 16'b0010011001000000) blockgridtemp = 16'b0110001100000000; // normal z vert to horizontal
        else if(blockgrid == 16'b0110001100000000) blockgridtemp = 16'b0010011001000000; // normal z horz to vert\
        else if(blockgrid == 16'b0100011100000000) blockgridtemp = 16'b0010001001100000; 
        else if(blockgrid == 16'b0010001001100000) blockgridtemp = 16'b1110001000000000;
        else if(blockgrid == 16'b1110001000000000) blockgridtemp = 16'b0110010001000000;
        else if(blockgrid == 16'b0110010001000000) blockgridtemp = 16'b0100011100000000;
        else if(blockgrid == 16'b0100010001100000) blockgridtemp = 16'b0001011100000000;
        else if(blockgrid == 16'b0001011100000000) blockgridtemp = 16'b0110001000100000;
        else if(blockgrid == 16'b0111010000000000) blockgridtemp = 16'b0100010001100000;
        else if(blockgrid == 16'b0110001000100000) blockgridtemp = 16'b0111010000000000;
        else if(blockgrid == 16'b0000011100100000) blockgridtemp = 16'b0010001100100000;
        else if(blockgrid == 16'b0010011000100000) blockgridtemp = 16'b0000011100100000;
        else if(blockgrid == 16'b0010001100100000) blockgridtemp = 16'b0010011100000000;
        
        else blockgridtemp = 16'b0000000000000000;
    
    
    end
     
else
    blockgridtemp = 16'b0000000000000000;

/////////////////////////////////////// Rotation Check /////////////////////////////////
canrotate = 1'b1; // signal for rotate

gridrow = ((BallY - 32) / 16) - 1 ; // dk why tf i had to do again
gridcol = ((BallX - 240) / 16) - 1 ; 
    
for(int i = 0; i < 4; i++) begin
    for(int j = 0; j<4; j++) begin
        if((arraygrid[gridrow + i][gridcol + j] == 1) && (blockgridtemp[(i*4 + j)] == 1)) begin  // works
            canrotate = 1'b0; 
        end
    end
end

end
   
    
    
endmodule
