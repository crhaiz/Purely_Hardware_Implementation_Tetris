`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2023 06:10:20 PM
// Design Name: 
// Module Name: checker
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

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2023 05:21:45 PM
// Design Name: 
// Module Name: arraygrid
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


module checker ( input logic [15:0] blockgrid,
                 input logic [9:0] BallX, BallY,
                 input logic [1:0] rotation,
                 output logic canmoveleft, canmoveright, canmovedown, canmove, canrotate,
                 output int arraygrid[25:0][11:0],
                 output logic[31:0] c1,c2,c3,c4,
                 output logic [9:0] gridrow, gridcol, gridrownextleft, gridcolnextleft, gridrownextright, gridcolnextright, gridrownextdown, gridcolnextdown 
    );
    
logic [15:0]blockgridtemp;// for checking 

always_comb begin

for(int i = 0; i < 26; i++) begin // initialize 26 x 12 grid to all 0s
    for(int j = 0; j < 12; j++) begin
        arraygrid[i][j] = 0; 
        end
    end

for(int i= 0; i<26; i++) begin //set left and right cols to all ones
    arraygrid[i][0] = 1;
    arraygrid[i][11] = 1;
end

for(int j= 0; j<26; j++) begin // set top and bottom rows to all ones
    arraygrid[0][j] = 1;
    arraygrid[25][j] = 1;
end

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





////////////////////////////// logic to get rotated blockgrid

if (rotation == 2'b01) begin // CLOCKWISE
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
end


if (rotation == 2'b10) begin // COUNTERCLOCKWISE

if(blockgrid == 16'b0000111100000000) blockgridtemp = 16'b0010001000100010; // straight piece horizontal to vertical
    if(blockgrid == 16'b0010001000100010) blockgridtemp = 16'b0000111100000000; // straight piece vertical to horizontal
    if(blockgrid == 16'b0100011000100000) blockgridtemp = 16'b0011011000000000; //inverted z vertical to horizontal
    if(blockgrid == 16'b0011011000000000) blockgridtemp = 16'b0100011000100000; // inverted z horizontal to vertical
    if(blockgrid == 16'b0010011001000000) blockgridtemp = 16'b0110001100000000; // normal z vert to horizontal
    if(blockgrid == 16'b0110001100000000) blockgridtemp = 16'b0010011001000000; // normal z horz to vert\
    if(blockgrid == 16'b0100011100000000) blockgridtemp = 16'b0010001001100000; 
    if(blockgrid == 16'b0010001001100000) blockgridtemp = 16'b1110001000000000;
    if(blockgrid == 16'b1110001000000000) blockgridtemp = 16'b0110010001000000;
    if(blockgrid == 16'b0110010001000000) blockgridtemp = 16'b0100011100000000;
    if(blockgrid == 16'b0100010001100000) blockgridtemp = 16'b0001011100000000;
    if(blockgrid == 16'b0001011100000000) blockgridtemp = 16'b0110001000100000;
    if(blockgrid == 16'b0111010000000000) blockgridtemp = 16'b0100010001100000;
    if(blockgrid == 16'b0110001000100000) blockgridtemp = 16'b0111010000000000;
    if(blockgrid == 16'b0000011100100000) blockgridtemp = 16'b0010001100100000;
    if(blockgrid == 16'b0010011000100000) blockgridtemp = 16'b0000011100100000;
    if(blockgrid == 16'b0010001100100000) blockgridtemp = 16'b0010011100000000;

end     

///////////////////////////////////// Rotation Check /////////////////////////////////
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

//////////////////////////////////////////////////////////////////////////////
endmodule