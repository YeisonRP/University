module probador(
    output reg clk,
    output reg enable,
    output reg reset_L,
    input [4:0] salida_gray_c,
    input [4:0] salida_gray_e
);

initial begin
	$dumpfile("banco_pruebas.vcd");
	$dumpvars();
    reset_L = 0;
	enable = 0;
    clk = 0;
	@(posedge clk);
	@(posedge clk);
    @(posedge clk);
    reset_L <= 1;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    enable <= 1;
    @(posedge clk);

    repeat (74) begin		
        @(posedge clk);	
    end
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
            if((salida_gray_c != salida_gray_e))
                begin
                  $display ("La salida conductual es distinta a la estructural.");
                  $finish;
                end
        end 

endmodule