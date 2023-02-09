module clkgen (  
    output reg              clk_f,       //Cuatro señales de reloj, la fundamental es 8f Hz
    output reg              clk_2f,      //clk4f tiene una frecuencia de 4f Hz,
    output               clk_8f,
    input                   clk_8f_in,
    input                   resetCLK);      

    reg clk_4f;

assign clk_8f = clk_8f_in;
always @(posedge clk_8f_in) begin
    if (resetCLK == 0) begin
        clk_4f <= 0;
        clk_2f <= 0;
        clk_f <= 0;  
    
    end
    else begin
    {clk_f, clk_2f, clk_4f} <= {clk_f, clk_2f, clk_4f} - 1;
    end
end
/*
always @(posedge clk_8f_in) begin
    if (resetCLK == 0) begin
        clk_8f <= 1;
    end
    else begin
        clk_8f <= ~clk_8f;
    end  
end

always @(negedge clk_8f_in ) begin
    if (resetCLK == 0) begin
        clk_8f <= 1;
    end
    else begin
        clk_8f <= ~clk_8f;
    end    
end
*/
endmodule
