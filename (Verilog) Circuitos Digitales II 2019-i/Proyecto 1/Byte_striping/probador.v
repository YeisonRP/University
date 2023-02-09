
module probador(
    output reg clk_2f,
    output reg [7:0] data_in,
    output reg valid_in,
    output reg reset,
    input [7:0] lane_0_c,
    input [7:0] lane_1_c,
    input valid_0_c,         
    input valid_1_c,   
    input [7:0] lane_0_e,
    input [7:0] lane_1_e,
    input valid_0_e,         
    input valid_1_e  
);


initial begin
	$dumpfile("banco_pruebas.vcd");
	$dumpvars();
    clk_2f = 0;
    data_in = 0;
    valid_in = 0;
	reset = 0;

	@(posedge clk_2f);
	@(posedge clk_2f);
    @(posedge clk_2f);
	@(posedge clk_2f);
    reset <= 1;
    data_in <= 8'h A4 ;
    @(posedge clk_2f);
    @(posedge clk_2f);
    valid_in <= 1;
    data_in <= 8'hFF ;
    @(posedge clk_2f);
    data_in <= 8'hEE ;
    @(posedge clk_2f);
    data_in <= 8'hDD ;
    @(posedge clk_2f);
    data_in <= 8'hCC ;
    @(posedge clk_2f);
    valid_in <= 0;
    data_in <= 8'h11 ;
    @(posedge clk_2f);
    data_in <= 8'h22 ;

    @(posedge clk_2f);
    valid_in <= 1;
    data_in <= 8'h03 ;
    @(posedge clk_2f);
    data_in <= 8'h04 ;
    @(posedge clk_2f);
    data_in <= 8'hDD ;
    valid_in <= 0;
    @(posedge clk_2f);
    data_in <= 8'hCC ;
    @(posedge clk_2f);
    @(posedge clk_2f);
    valid_in <= 1;
    data_in <= 8'hAA ;
    @(posedge clk_2f);
    data_in <= 8'h99 ;
    @(posedge clk_2f);
    data_in <= 8'h12 ;
    valid_in <= 0;
    @(posedge clk_2f);
    @(posedge clk_2f);
    @(posedge clk_2f);
    valid_in <= 1;
    data_in <= 8'h07 ;
    @(posedge clk_2f);
    data_in <= 8'h08 ;
    @(posedge clk_2f);
    data_in <= 8'h32 ;
    valid_in <= 0;
    @(posedge clk_2f);
    @(posedge clk_2f);
    @(posedge clk_2f);
    valid_in <= 1;
    data_in <= 8'h02 ;
    @(posedge clk_2f);
    data_in <= 8'h01 ;
    @(posedge clk_2f);
    data_in <= 8'h43 ;
    @(posedge clk_2f);
    data_in <= 8'h12 ;
    valid_in <= 0;
    @(posedge clk_2f);
    reset <= 0;
    @(posedge clk_2f);
	$finish;
end  


initial clk_2f <= 0;
always #1 clk_2f <= ~clk_2f;

        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////// INICIO: MONITOR DE PRUEBAS    /////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////


/*    /////////////////////// checker:
    always @ (posedge clk_2f) 
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

        end */


endmodule