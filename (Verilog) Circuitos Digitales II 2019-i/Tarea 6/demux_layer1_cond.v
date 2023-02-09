module demux_layer1_cond(
    input clk,
    input reset_L,
    output reg[3:0] data_out0,
    output reg[3:0] data_out1,
    input [3:0] data_in,
    input valid_in,
    output reg valid_out
);

    reg selector;
    reg[3:0] y_0;
    reg[3:0] y_1;
 
/////////////////////////////////////////////////////////////////////////////////////

    //Flip Flops
    

    always @ (posedge clk)
        begin
            if (reset_L == 0)
                begin
                    y_0 <= 'b0000; 
                    y_1 <= 'b0000; 
                end
            else    //reset = 1
                begin
                    if(valid_in == 0)
                        begin
                                y_0 <= y_0;
                                y_1 <= y_1;                                           
                        end
                    else    //valid in == 1
                        begin
                            if(selector == 0)
                            begin
                                y_0 <= data_in;
                                y_1 <= y_1;                                 
                            end
                            if(selector == 1)
                            begin
                                y_0 <= y_0;
                                y_1 <= data_in;                                      
                            end                              
                        end
                        
                end
        end

    always @ (*)
        begin           
            data_out0 = 'h0;
            data_out1 = 'h0;
            valid_out = 0;
            if (reset_L == 1)            
            begin
                data_out0 = y_0;
                data_out1 = y_1;
                valid_out = 0;  
                if(valid_in == 1)
                    begin
                        valid_out = 1;  
                        if(selector == 0)
                            data_out0 = data_in;
                        if(selector == 1)
                            data_out1 = data_in;  
                    end
            end    
        end  
    /////////////////////////   SELECTOR    ////////////////////////
    always @ (posedge clk)
        begin
            selector <= 0;
            if (reset_L == 1)
                selector <= ~selector;
        end

endmodule

