
module probador2(
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

    parameter BUS_SIZE = 20;                     //-- tamano salida de datos
    parameter WORD_SIZE = 5;                    //-- 
    parameter WORD_NUM = BUS_SIZE/WORD_SIZE;    //-- tamano salida de control


initial begin
	$dumpfile("banco_pruebas.vcd");
	$dumpvars();
    reset <= 0;
	data_in <= 0;
    clk <= 0;

	@(posedge clk);
    data_in <= 20'h FFACD ;
    reset <= 0;
    
	@(posedge clk);
    @(posedge clk);
    reset <= 1;
    data_in <= 20'h FFA20 ;
	@(posedge clk);
    data_in <= 20'h FF341 ;
	@(posedge clk);
    data_in <= 20'h FF282 ;
    @(posedge clk);
    data_in <= 20'h FF623 ;
    @(posedge clk);
    data_in <= 20'h FF344 ;
    @(posedge clk);
    data_in <= 20'h FFA85 ;
    @(posedge clk);
    data_in <= 20'h FF026 ;
    @(posedge clk);
    data_in <= 20'h FF647 ;
    @(posedge clk);
    data_in <= 20'h FF288 ;
    @(posedge clk);
    data_in <= 20'h F0229 ;
    @(posedge clk);
    data_in <= 20'h FF240 ;
    @(posedge clk);
    data_in <= 20'h FF281 ;
    @(posedge clk);
    data_in <= 20'h FF282 ;
    @(posedge clk);
    data_in <= 20'h FF044 ;
    @(posedge clk); 
    data_in <= 20'h FF220 ;
    @(posedge clk);
    data_in <= 20'h FF221 ;
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