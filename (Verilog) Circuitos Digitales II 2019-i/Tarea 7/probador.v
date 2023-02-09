
module probador(
    output reg [BUS_SIZE-1:0] data_in,
    output reg reset,
    output reg clk,
    input [BUS_SIZE-1:0] data_out_C,
    input [BUS_SIZE-1:0] data_out_E,
    input [WORD_NUM-1:0] ctrl_out_C,
    input [WORD_NUM-1:0] ctrl_out_E,
    input  nxt_err_C,
    input  err_C,
    input  nxt_err_E,
    input  err_E,
    input  [4:0] estado_C,
    input  [4:0] estado_proximo_C,
    input  [4:0] estado_E,
    input  [4:0] estado_proximo_E      
);

    parameter BUS_SIZE = 16;                     //-- tamano salida de datos
    parameter WORD_SIZE = 4;                    //-- 
    parameter WORD_NUM = BUS_SIZE/WORD_SIZE;    //-- tamano salida de control


initial begin
	$dumpfile("banco_pruebas.vcd");
	$dumpvars();
    reset <= 0;
	data_in <= 0;
    clk <= 0;

	@(posedge clk);
    data_in <= 16'h FACD ;
    reset <= 0;
    
	@(posedge clk);
    @(posedge clk);
    reset <= 1;
    data_in <= 16'h FAC0 ;
	@(posedge clk);
    data_in <= 16'h F3C1 ;
	@(posedge clk);
    data_in <= 16'h F212 ;
    @(posedge clk);
    data_in <= 16'h F653 ;
    @(posedge clk);
    data_in <= 16'h F344 ;
    @(posedge clk);
    data_in <= 16'h FAC5 ;
    @(posedge clk);
    data_in <= 16'h F026 ;
    @(posedge clk);
    data_in <= 16'h F657 ;
    @(posedge clk);
    data_in <= 16'h F208 ;
    @(posedge clk);
    data_in <= 16'h E259 ;
    @(posedge clk);
    data_in <= 16'h F250 ;
    @(posedge clk);
    data_in <= 16'h F251 ;
    @(posedge clk);
    data_in <= 16'h F252 ;
    @(posedge clk);
    data_in <= 16'h F054 ;
    @(posedge clk); 
    data_in <= 16'h F250 ;
    @(posedge clk);
    data_in <= 16'h F251 ;
    @(posedge clk);
    reset <= 0;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
	$finish;
end  


initial clk <= 0;
always #5 clk <= ~clk;


        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////// INICIO: MONITOR DE PRUEBAS    /////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////


    /////////////////////// checker:
    always @ (posedge clk) 
        begin
            if((data_out_C != data_out_E) | (ctrl_out_C != ctrl_out_E) )
                begin
                  $display ("La salida conductual es distinta a la estructural.");
                  $finish;
                end
            if((nxt_err_C != nxt_err_E)| (err_C != err_E))
                begin
                  $display ("La salida conductual es distinta a la estructural.");
                  $finish;
                end

            if((estado_proximo_C != estado_proximo_E)| (estado_C != estado_E) )
                begin
                  $display ("La salida conductual es distinta a la estructural.");
                  $finish;
                end
        end 


endmodule