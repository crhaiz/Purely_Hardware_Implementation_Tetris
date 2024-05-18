

`timescale 1ns / 1ps



module movementchecker(  input Clk,
                         input logic [15:0] blockgrid,
                         input logic [9:0] BallX, BallY,
                         input logic [7:0] keycode,
                         input logic [1:0] arraygrid[25:0][11:0],
                         
                         output logic canmoveleft, canmoveright, canmovedown, canrotate,                       
                         
                         output logic [9:0] gridrow, gridcol
                        
                        );

logic [15:0]blockgridtemp;// for checking 
logic [9:0] gridrownextleft, gridcolnextleft,gridrownextright, gridcolnextright,gridrownextdown, gridcolnextdown;



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
        for(int j = 0; j < 4; j++) begin
            if(arraygrid[gridrownextdown + i][gridcolnextdown + j] == 1 && blockgrid[i*4 + j] == 1) begin
                canmovedown = 1'b0;
                
            end
        end
    end



//////////////////////////////// logic to get rotated blockgrid
            
            if( (keycode == 8'h08) )  begin
            case (blockgrid)
                    16'h2320://t piece
                        blockgridtemp = 16'h0720;
                    16'h0720:
                        blockgridtemp = 16'h2620;
                    16'h2620:
                        blockgridtemp = 16'h0270;
                    16'h0270:
                        blockgridtemp = 16'h2320;
                        
                        
                    16'h6220: // L piece
                        blockgridtemp = 16'h1700;
                    16'h1700:
                        blockgridtemp = 16'h4460;
                    16'h4460:
                        blockgridtemp = 16'h7400;
                    16'h7400:
                        blockgridtemp = 16'h6220;
                    
                    16'h6440: // inverted L piece
                        blockgridtemp = 16'hE200;
                    16'hE200:
                        blockgridtemp = 16'h2260;
                    16'h2260:
                        blockgridtemp = 16'h4700;
                    16'h4700:
                        blockgridtemp = 16'h6440;
                    
                    16'h2222: // line piece
                        blockgridtemp = 16'h0F00;
                    16'h0F00:
                        blockgridtemp = 16'h2222;
                        
                    16'h3300: // square piece
                        blockgridtemp = 16'h3300;
                    
                    16'h6300: // z piece
                        blockgridtemp = 16'h2640;
                    16'h2640:
                        blockgridtemp = 16'h6300;
                                        
                    16'h3600: // inverted z piece
                        blockgridtemp = 16'h4620;
                    16'h4620:
                        blockgridtemp = 16'h3600;
                    default:
                        blockgridtemp= 16'h0000;
                endcase                
            end
            
            
            else if (keycode == 8'h14) begin
                case (blockgrid)
  
                    16'h6220: // L piece
                        blockgridtemp = 16'h7400;
                    16'h7400:
                        blockgridtemp = 16'h4460;
                    16'h4460:
                        blockgridtemp = 16'h1700;
                    16'h1700:
                        blockgridtemp = 16'h6220;
                    
                    16'h6440: // inverted L piece
                        blockgridtemp = 16'hE200;
                    16'hE200:
                        blockgridtemp = 16'h4700;
                    16'h4700:
                        blockgridtemp = 16'h2260;
                    16'h2260:
                        blockgridtemp = 16'h6440;
                    
                    16'h3300: // square piece
                        blockgridtemp = 16'h3300;
                    
                    16'h2320: // t piece
                        blockgridtemp= 16'h2700;
                    16'h2700:
                        blockgridtemp = 16'h2620;
                    16'h2620:
                        blockgridtemp = 16'h0720;
                    16'h0720:
                        blockgridtemp = 16'h2320;
                    
                    16'h6300: // Z piece
                        blockgridtemp = 16'h2640;
                    16'h2640:
                        blockgridtemp = 16'h6300;
                    
                    16'h3600: // inverted z piece
                        blockgridtemp = 16'h4620;
                    16'h4620:
                        blockgridtemp = 16'h3600;
                    
                    16'h2222: // line piece
                        blockgridtemp = 16'h0F00;
                    16'h0F00:
                        blockgridtemp = 16'h2222;
                    default:
                        blockgridtemp = 16'h0000;
                endcase
            end
            
                else
                blockgridtemp = blockgrid;
            
            
            
    
//    if (keycode == 8'h08) begin // CLOCKWISE
//        if(blockgrid == 16'b0000111100000000) blockgridtemp = 16'b0010001000100010; // straight piece horizontal to vertical
//        else if(blockgrid == 16'b0010001000100010) blockgridtemp = 16'b0000111100000000; // straight piece vertical to horizontal
//        else if(blockgrid == 16'b0100011000100000) blockgridtemp = 16'b0011011000000000; //inverted z vertical to horizontal
//        else if(blockgrid == 16'b0011011000000000) blockgridtemp = 16'b0100011000100000; // inverted z horizontal to vertical
//        else if(blockgrid == 16'b0010011001000000) blockgridtemp = 16'b0110001100000000; // normal z vert to horizontal
//        else if(blockgrid == 16'b0110001100000000) blockgridtemp = 16'b0010011001000000; // normal z horz to vert\
//        else if(blockgrid == 16'b0100011100000000) blockgridtemp = 16'b0110010001000000; 
//        else if(blockgrid == 16'b0010001001100000) blockgridtemp = 16'b0100011100000000;
//        else if(blockgrid == 16'b1110001000000000) blockgridtemp = 16'b0010001001100000;
//        else if(blockgrid == 16'b0110010001000000) blockgridtemp = 16'b1110001000000000;
//        else if(blockgrid == 16'b0100010001100000) blockgridtemp = 16'b0111010000000000;
//        else if(blockgrid == 16'b0001011100000000) blockgridtemp = 16'b0100010001100000;
//        else if(blockgrid == 16'b0111010000000000) blockgridtemp = 16'b0110001000100000;
//        else if(blockgrid == 16'b0110001000100000) blockgridtemp = 16'b0001011100000000;
//        else if(blockgrid == 16'b0000011100100000) blockgridtemp = 16'b0010011000100000;
//        else if(blockgrid == 16'b0010011000100000) blockgridtemp = 16'b0010011100000000;
//        else if(blockgrid == 16'b0010001100100000) blockgridtemp = 16'b0000011100100000;
        
//        else blockgridtemp = 16'b0000000000000000;
//    end
    
    
//    else if (keycode == 8'h14) begin // COUNTERCLOCKWISE
    
//        if(blockgrid == 16'b0000111100000000) blockgridtemp = 16'b0010001000100010; // straight piece horizontal to vertical
//        else if(blockgrid == 16'b0010001000100010) blockgridtemp = 16'b0000111100000000; // straight piece vertical to horizontal
//        else if(blockgrid == 16'b0100011000100000) blockgridtemp = 16'b0011011000000000; //inverted z vertical to horizontal
//        else if(blockgrid == 16'b0011011000000000) blockgridtemp = 16'b0100011000100000; // inverted z horizontal to vertical
//        else if(blockgrid == 16'b0010011001000000) blockgridtemp = 16'b0110001100000000; // normal z vert to horizontal
//        else if(blockgrid == 16'b0110001100000000) blockgridtemp = 16'b0010011001000000; // normal z horz to vert\
//        else if(blockgrid == 16'b0100011100000000) blockgridtemp = 16'b0010001001100000; 
//        else if(blockgrid == 16'b0010001001100000) blockgridtemp = 16'b1110001000000000;
//        else if(blockgrid == 16'b1110001000000000) blockgridtemp = 16'b0110010001000000;
//        else if(blockgrid == 16'b0110010001000000) blockgridtemp = 16'b0100011100000000;
//        else if(blockgrid == 16'b0100010001100000) blockgridtemp = 16'b0001011100000000;
//        else if(blockgrid == 16'b0001011100000000) blockgridtemp = 16'b0110001000100000;
//        else if(blockgrid == 16'b0111010000000000) blockgridtemp = 16'b0100010001100000;
//        else if(blockgrid == 16'b0110001000100000) blockgridtemp = 16'b0111010000000000;
//        else if(blockgrid == 16'b0000011100100000) blockgridtemp = 16'b0010001100100000;
//        else if(blockgrid == 16'b0010011000100000) blockgridtemp = 16'b0000011100100000;
//        else if(blockgrid == 16'b0010001100100000) blockgridtemp = 16'b0010011100000000;
        
//        else blockgridtemp = 16'b0000000000000000;
    
    
//    end
     
//else
//    blockgridtemp = 16'b0000000000000000;

/////////////////////////////////////// Rotation Check /////////////////////////////////
canrotate = 1'b1; // signal for rotate

    
for(int i = 0; i < 4; i++) begin
    for(int j = 0; j<4; j++) begin
        if((arraygrid[gridrow + i][gridcol + j] == 1) && (blockgridtemp[(i*4 + j)] == 1)) begin  // works
            canrotate = 1'b0; 
        end
    end
end

end

//////////////////////////////////////////////////////////////////////////////

//always_ff @ (posedge Clk) begin
//    if (canrotate && (keycode == 16'h14 || keycode == 16'h08)) begin
//        blockgridrotate <= blockgridtemp;
//    end
//    else
//        blockgridrotate <= blockgrid;
//end




endmodule
