module sum_pipe_c(
    input [3:0] dataA,
    input [3:0] dataB,
    input clk,
    input reset_L,
    output reg [3:0] sum30_dd_c
);

    reg acarreo, acarreo_d;
    reg [1:0] dataA_d, dataB_d, sum10, sum10_d;
    reg [3:0] sum30_d;

    // SECCION 1
    always @(*) begin
        sum10 = 'b0;
        acarreo = 0;
        if (reset_L) begin
            sum10 = dataA[1:0] + dataB[1:0];                           
            if ( (sum10 < dataA[1:0]) | (sum10 < dataB[1:0]) ) begin                
                acarreo = 1;   
            end             
        end
    end

always @(posedge clk ) begin
    if (reset_L == 0) begin
        sum30_dd_c <= 0;
        sum30_d <= 0;
        acarreo_d <= 0;
        sum10_d <= 'b0;
        dataA_d <= 'b0;
        dataB_d <= 'b0;

    end
    
    else begin
        // SECCION 2
        dataA_d <= dataA[3:2];
        dataB_d <= dataB[3:2];
        sum10_d <= sum10;
        acarreo_d <= acarreo;
        sum30_d[3:2] = dataA_d + dataB_d + acarreo_d;
        sum30_d[1:0] = sum10_d;
        // SECCION 3
        sum30_dd_c <= sum30_d;
    end
end


endmodule // sum_pipe_c