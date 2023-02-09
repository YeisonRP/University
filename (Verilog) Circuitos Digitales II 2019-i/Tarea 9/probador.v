module probador(
    output reg [3:0] idx,
    output reg [3:0] dataA,
    output reg [3:0] dataB,
    output reg clk,
    output reg reset_L,
    input [3:0] sum30_dd_c,
    input [3:0] idx_dd_c,
    input [3:0] sum30_dd_e,
    input [3:0] idx_dd_e
);

initial begin
	$dumpfile("banco_pruebas.vcd");
	$dumpvars();
    reset_L = 0;
	idx = 0;
    clk = 0;
    dataA = 'h0;
    dataB = 'h1;    
	@(posedge clk);
	@(posedge clk);
    @(posedge clk);
    reset_L <= 1;
    idx <= idx + 1;

    repeat (7) begin		
        @(posedge clk);
        idx <= idx + 1;
        dataA <= dataA + 1;
        dataB <= dataB + 1;
    end

    @(posedge clk);

    @(posedge clk);
    @(posedge clk);

    @(posedge clk);
	$finish;
end  



initial clk <= 0;
always #2 clk <= ~clk;


        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////// INICIO: MONITOR DE PRUEBAS    /////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////


    /////////////////////// checker:
    always @ (posedge clk) 
        begin
            if((sum30_dd_c != sum30_dd_e) || (idx_dd_c != idx_dd_e) )
                begin
                  $display ("La salida conductual es distinta a la estructural.");
                  $finish;
                end
        end  

endmodule