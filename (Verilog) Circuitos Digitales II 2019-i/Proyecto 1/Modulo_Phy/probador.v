module probador(
    output reg [7:0] data_in_0_c,
    output reg [7:0] data_in_1_c,
    output reg valid_in_0_c,
    output reg valid_in_1_c,
    input clk_2f_to_prob,
    output reg reset,
    output reg resetCLK,
    output reg clk_8f_probador,
	input [7:0] data_out_c_0,
	input [7:0] data_out_c_1,
    input valid_out_c_0,
    input valid_out_c_1
 ); 


initial begin
	$dumpfile("banco_pruebas.vcd");
	$dumpvars();
	reset = 0;
    data_in_0_c = 0;
    data_in_1_c = 0;
    valid_in_0_c = 0;
    valid_in_1_c = 0;
    resetCLK = 0;
    clk_8f_probador = 0;

    @(posedge clk_8f_probador);
    @(posedge clk_8f_probador);
    @(posedge clk_8f_probador);
    @(posedge clk_8f_probador);
    resetCLK <= 1;
    
    @(posedge clk_2f_to_prob);
    
    @(posedge clk_2f_to_prob);
    
    reset <= 1;
	@(posedge clk_2f_to_prob);
    
    @(posedge clk_2f_to_prob);
    
    
	@(posedge clk_2f_to_prob);
    
    
    data_in_0_c <= 8'h A4 ;
    data_in_1_c <= 8'h 32 ;
    @(posedge clk_2f_to_prob);
    
    @(posedge clk_2f_to_prob);
    
    @(posedge clk_2f_to_prob);
    
    @(posedge clk_2f_to_prob);
    
    valid_in_0_c <= 1;
    data_in_0_c <= 8'h FF ;
    @(posedge clk_2f_to_prob);
    
    
    valid_in_1_c <= 1;
    data_in_0_c <= 8'h EE ;
    data_in_1_c <= 8'h 00 ;
    @(posedge clk_2f_to_prob);
    
    data_in_0_c <= 8'h DD ;
    data_in_1_c <= 8'h 01 ;    
    @(posedge clk_2f_to_prob);
    
    
    data_in_0_c <= 8'h CC ;
    data_in_1_c <= 8'h 02 ;   
    @(posedge clk_2f_to_prob);
    
    valid_in_0_c <= 0;
    valid_in_1_c <= 0;
    @(posedge clk_2f_to_prob);
    
    
    @(posedge clk_2f_to_prob);

    
    valid_in_1_c <= 0;
    data_in_1_c <= 8'h 03 ; 
    @(posedge clk_2f_to_prob);
    
    @(posedge clk_2f_to_prob);
    
    valid_in_0_c <= 1;
    data_in_1_c <= 8'h 04 ; 
    data_in_0_c <= 8'h BB ;
    @(posedge clk_2f_to_prob);
    
    valid_in_0_c <= 0;
    valid_in_1_c <= 0;
    @(posedge clk_2f_to_prob);
    
    
    @(posedge clk_2f_to_prob);
    
    @(posedge clk_2f_to_prob);
    
    valid_in_0_c <= 1;
    valid_in_1_c <= 1;
    data_in_1_c <= 8'h 05 ; 
    data_in_0_c <= 8'h AA ;   
    @(posedge clk_2f_to_prob);
    
    
    data_in_1_c <= 8'h 06 ; 
    data_in_0_c <= 8'h 99 ;    
    @(posedge clk_2f_to_prob);
     
    valid_in_0_c <= 0;
    valid_in_1_c <= 0;
    @(posedge clk_2f_to_prob); 
    
    
    @(posedge clk_2f_to_prob); 
    
    valid_in_0_c <= 1;
    valid_in_1_c <= 1;  
    data_in_1_c <= 8'h 07 ; 
    data_in_0_c <= 8'h 88 ;  

    @(posedge clk_2f_to_prob);
     
    data_in_1_c <= 8'h 08 ; 
    data_in_0_c <= 8'h 77 ;        

    @(posedge clk_2f_to_prob);
    
    data_in_1_c <= 8'h 16 ; 
    data_in_0_c <= 8'h 32 ;  

    @(posedge clk_2f_to_prob);
       
    valid_in_0_c <= 0;
    valid_in_1_c <= 0;  

    @(posedge clk_2f_to_prob); 
    

    @(posedge clk_2f_to_prob); 
    

     @(posedge clk_2f_to_prob); 
    

    
    @(posedge clk_2f_to_prob); 
    reset <= 0;
    @(posedge clk_2f_to_prob); 

    $finish;
end  

/*
initial clk_f <= 0;
always #8 ;   */

	initial	clk_8f_probador 	<= 1;				// Valor inicial al reloj, sino siempre ser� indeterminado
	always	#2 clk_8f_probador 	<= ~clk_8f_probador;		// Hace "toggle" cada 2*10ns 



 endmodule 

