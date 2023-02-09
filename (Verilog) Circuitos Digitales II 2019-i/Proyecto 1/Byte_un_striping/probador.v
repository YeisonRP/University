
module probador(
    output reg clk_f,
    output reg clk_2f,
    output reg [7:0] lane_0,
    output reg [7:0] lane_1,
    output reg valid_0,
    output reg valid_1,
    output reg reset,
    input [7:0] data_out_c,
    input [7:0] data_out_e,
    input valid_out_c,
    input valid_out_e
);


initial begin
	$dumpfile("banco_pruebas.vcd");
	$dumpvars();
    clk_2f = 0;
    clk_f = 0;
    reset = 0;
	lane_1 = 0;
    lane_0 = 0;
    valid_0 = 0;
    valid_1 = 0;

	@(posedge clk_2f);
	@(posedge clk_2f);
    @(posedge clk_2f);
	@(posedge clk_2f);
    reset <= 1;
    lane_0 <= 8'h A4 ;
    lane_1 <= 8'h E2 ;
    @(posedge clk_2f);
    @(posedge clk_2f);
    valid_0 <= 1;
    lane_0 <= 8'hFF ;

	@(posedge clk_2f);
    valid_1 <= 1;
    lane_1 <= 8'hEE ;

    @(posedge clk_2f);
    lane_0 <= 8'hDD ;

 	@(posedge clk_2f);
    lane_1 <= 8'hCC ;

    @(posedge clk_2f);
    valid_0 <= 0;
    lane_0 <= 8'h7F ;

    @(posedge clk_2f);
    valid_1 <= 0;
    lane_1 <= 8'h7D ;

    @(posedge clk_2f);
    valid_0 <= 1;
    lane_0 <= 8'h03 ; 

    @(posedge clk_2f);
    valid_1 <= 1;
    lane_1 <= 8'h04 ;

    @(posedge clk_2f);
    valid_0 <= 0;
    lane_0 <= 8'h11 ;

    
    @(posedge clk_2f);
    valid_1 <= 0;
    lane_1 <= 8'h22 ;

    @(posedge clk_2f);
    valid_0 <= 1;
    lane_0 <= 8'hAA ; 

    @(posedge clk_2f);
    valid_1 <= 1;
    lane_1 <= 8'h99 ;

    @(posedge clk_2f);
    valid_0 <= 0;
    lane_0 <= 8'h62 ;

    @(posedge clk_2f);
    valid_1 <= 0;
    lane_1 <= 8'h34 ;

    @(posedge clk_2f);
    valid_0 <= 1;
    lane_0 <= 8'h07 ; 

    @(posedge clk_2f);
    valid_1 <= 1;
    lane_1 <= 8'h08 ;

    @(posedge clk_2f);
    valid_0 <= 1;
    lane_0 <= 8'h06 ; 

    @(posedge clk_2f);
    valid_1 <= 0;


    @(posedge clk_2f);
    valid_0 <= 0;
    lane_1 <= 8'h12 ;

    @(posedge clk_2f);
    reset <= 0;
    @(posedge clk_2f);
	$finish;
end  


initial clk_f <= 0;
always #2 clk_f <= ~clk_f;

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