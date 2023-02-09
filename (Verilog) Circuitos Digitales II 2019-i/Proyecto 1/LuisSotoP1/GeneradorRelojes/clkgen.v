module clkgen (  
    output reg              clkf_c,       //Cuatro señales de reloj, la fundamental es 8f Hz
    output reg              clk2f_c,      //clk4f tiene una frecuencia de 4f Hz,
    output reg              clk4f_c,      //clk2f de 2f Hz y clkf de f Hz
    input                   clk8f,
    input                   reset);      

always @(posedge clk8f) begin
    if (reset == 0) begin
        clk4f_c <= 0;
        clk2f_c <= 0;
        clkf_c <= 0;        
    end
    else begin
    {clkf_c, clk2f_c, clk4f_c} <= {clkf_c, clk2f_c, clk4f_c} - 1;
    end
end

endmodule
