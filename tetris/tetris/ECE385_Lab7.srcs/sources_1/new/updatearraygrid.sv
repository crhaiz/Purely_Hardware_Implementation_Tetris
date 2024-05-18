`timescale 1ns / 1ps
/////////////////////////////////////
//this module is only to update the array grid when state is in the updategrid state
//p0this is also where we do row checking
module updatearraygrid(   
                    input logic Clk,
                    input logic updategrid,
                    input logic rowcheck,
                    input logic startGame,
                    input logic [9:0] gridrow,
                    input logic [9:0] gridcol,
                    input logic [15:0] blockgrid,
                    input logic [9:0] DrawX, DrawY,
                    output logic die,
                    output logic [1:0] arraygrid [25:0][11:0],        //ccannot pass a 2D array but can pass array of reg         
                    output logic blockexist,
                    output logic [15:0] score     
                );

logic [25:0] sum,rowtobedeleted;
logic [9:0] Xindex,Yindex;
int arraygridtemp [25:0][11:0];

always_comb begin
    if (DrawX >= 224 && DrawX <= 416 && DrawY >= 16 && DrawY <= 432) begin 
        if (arraygrid[((DrawY-16)/16)][((DrawX-224)/16)] == 1'b1) begin
            blockexist = 1'b1;
        end
        else blockexist = 1'b0;

    end
    else blockexist = 1'b0;
    
//    for(int row = 0; row < 26 ; row++) begin
//            for(int col = 0; col < 12; col++) begin
//                if((arraygrid[row][col]) == 1) begin
//                    Xindex = col * 16 + 224;
//                    Yindex = row * 16 + 16;          
//                    if (DrawX >= Xindex && DrawX <= (Xindex + 16) && DrawY >= Yindex && DrawY <= (Yindex+16)) begin
//                        blockexist = 1'b1;
//                    end
                    
//                    else begin
//                        blockexist = 1'b0;         
//                    end
//                end
          
//            end
//        end

end 


always_ff @ (posedge Clk) begin
    if (startGame == 1'b1) begin
        score <= 16'h0000;
        for (int i = 0; i < 26; i++) begin
            for(int j = 0; j < 12; j++) begin
                arraygrid[i][j] <= 0; 
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
                arraygrid[gridrow + i][gridcol + j] <= (arraygrid[gridrow + i][gridcol + j] || blockgrid[i*4+ j]);
            end  
        end
        
        
        
  
        
    end
    
    else if (rowcheck == 1'b1) begin //to do row checking 
        if (arraygrid[2][1] || arraygrid[2][2] || arraygrid[2][3] || arraygrid[2][4] || arraygrid[2][5] || arraygrid[2][6] || arraygrid[2][7] || arraygrid[2][8] || arraygrid[2][9])
            die <= 1'b1;
        else 
            die <= 1'b0; 
        
        for (int row = 1; row < 25; row++) begin
            sum[row] <= arraygrid[row][1] & arraygrid[row][2] & arraygrid[row][3] & arraygrid[row][4]&
            arraygrid[row][5] & arraygrid[row][6] & arraygrid[row][7] & arraygrid[row][8]&
            arraygrid[row][9] & arraygrid[row][10];
        end

        for (int i = 0; i < 26; i++) begin
            if(sum[i] == 1) begin
                 for (int a = i; a > 1; a--) begin
                        arraygrid[a][1] <= arraygrid[a-1][1];
                        arraygrid[a][2] <= arraygrid[a-1][2];
                        arraygrid[a][3] <= arraygrid[a-1][3];
                        arraygrid[a][4] <= arraygrid[a-1][4];
                        arraygrid[a][5] <= arraygrid[a-1][5];
                        arraygrid[a][6] <= arraygrid[a-1][6];
                        arraygrid[a][7] <= arraygrid[a-1][7];
                        arraygrid[a][8] <= arraygrid[a-1][8];
                        arraygrid[a][9] <= arraygrid[a-1][9];
                        arraygrid[a][10] <= arraygrid[a-1][10];                
                end
                        arraygrid[1][1] <= 0;
                        arraygrid[1][2] <= 0;
                        arraygrid[1][3] <= 0;
                        arraygrid[1][4] <= 0;
                        arraygrid[1][5] <= 0;
                        arraygrid[1][6] <= 0;
                        arraygrid[1][7] <= 0;
                        arraygrid[1][8] <= 0;
                        arraygrid[1][9] <= 0;
                        arraygrid[1][10] <= 0;      
                        sum[i] <= 0;
                        score <= score + 1;
                end 
            end

    end
   
        
    
    ///////////////////////////////////////////////////////
    else begin
        for (int i = 0; i < 26; i++) begin
            for(int j = 0; j < 12; j++) begin
                arraygrid[i][j] <= arraygrid[i][j];
            end
        end
    end
    
    
    
end

endmodule
