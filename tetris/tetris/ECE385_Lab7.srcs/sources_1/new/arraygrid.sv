`timescale 1ns / 1ps
/////////////////////////////////////
//this module is only to update the array grid when state is in the updategrid state
//this is also where we do row checking
module arraygrid(   input logic updategrid,
                    input logic rowcheck,
                    input logic startGame,
                    input logic [10:0] gridrow,
                    input logic [10:0] gridcol,
                    input logic [15:0] blockgrid,
                    output int arraygrid [25:0][11:0]                    
                );


always_comb begin
    if (startGame == 1'b0) begin
        for (int i = 0; i < 26; i++) begin
            for(int j = 0; j < 12; j++) begin
                arraygrid[i][j] = 0; 
            end
        end

        for(int i= 0; i<26; i++) begin //set sides to 1
            arraygrid[i][0] = 1;
            arraygrid[i][11] = 1;
        end
    
        for(int j= 0; j<26; j++) begin // set sides to 1
            arraygrid[0][j] = 1;
            arraygrid[25][j] = 1;
        end
    
    end
    
    else if (updategrid == 1'b1) begin       
        for( int i = 0; i<4; i++) begin
            for (int j = 0; j < 4; j++) begin
                arraygrid[gridrow][gridcol] = blockgrid[i*4+ j];
            end  
        end
        
    
    
    
    
        
    end
    
    else if (rowcheck == 1'b1) begin //to do row checking 
        
        for (int row = 0; row < 26 ; row++) begin   //find rows that i need to delet
            int rowtobedeleted;
            int sum = 0;
            for (int col = 0; col < 12; col++) begin
                sum = sum + arraygrid[row][col];    //if sum is 12 means row is full then tag for deletion 
            end 
            
            if (sum == 12) begin
                rowtobedeleted = row;
                
                for (int row1 = 0; row1 < rowtobedeleted ; row1++) begin           
                    for (int col1 = 0; col1 < 12; col1++) begin
                        arraygrid[row1+1][col1] = arraygrid[row1][col1];
                    end
                end
        
                for (int col1 = 0; col1 < 12 ; col1++) begin
                    arraygrid[0][col1] = 0;
                end
                
            end
    
        end
        
    end
    
    
    
end

endmodule
