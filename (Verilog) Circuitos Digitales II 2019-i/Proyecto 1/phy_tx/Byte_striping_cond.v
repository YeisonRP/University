module Byte_striping_cond(
    input clk_2f,
    input valid_in,
    input [7:0]  data_in,
    input reset,
    output reg [7:0] lane_0_c,
    output reg [7:0] lane_1_c,
    output reg valid_0_c,         
    output reg valid_1_c     
);
    
    reg selector;
    reg[7:0] y_0, y_1;
    reg valid_atrasado;
 
/////////////////////////////////////////////////////////////////////////////////////

    //Flip Flops

    always @ (posedge clk_2f)
        begin
            if (reset == 0)
                begin
                    y_0 <= 'b0000; 
                    y_1 <= 'b0000; 
                    valid_atrasado <= 0; 
                end
            else    //reset = 1
                begin
                    valid_atrasado <= valid_in;
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
            lane_0_c = 'h0;
            lane_1_c = 'h0;
            valid_0_c = 0;
            valid_1_c = 0;
            if (reset == 1)            
            begin
                valid_1_c = valid_atrasado;
                lane_0_c = y_0;
                lane_1_c = y_1;
                if (valid_in == 0) begin
                    if(selector == 1) begin
                        valid_0_c = 1;
                        valid_1_c = 0;                         
                    end
                end 
                if(valid_in == 1)
                    begin
                        valid_0_c = 1;  
                        if(selector == 0)
                            lane_0_c = data_in;
                        if(selector == 1)
                            lane_1_c = data_in;  
                    end
            end    
        end  
    /////////////////////////   SELECTOR    ////////////////////////
    always @ (posedge clk_2f)
        begin
            selector <= 0;
            if (valid_in == 1)
                selector <= ~selector;
        end


endmodule