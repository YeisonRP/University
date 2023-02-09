module probador #(
    parameter AW = 3,   //-- Cantidad de bits de direcciones (Adress width)
    parameter DW = 8)   //-- Cantidad de bits de datos (Data width) 
    (
    output reg clk,                        //-- clock
    output reg reset,                      //-- Reset
    output reg [DW-1: 0] data_in,          //-- Entrada del FIFO de 6 bits
    output reg pop,                        //-- 1 si se quiere hacer pop, 0 nada
    output reg push,                       //-- 1 si se quiere hacer push, 0 nada
    output reg [3:0] umbral_almost_full,    //-- Umbral de que el FIFO esta casi lleno
    output reg [3:0] umbral_almost_empty,    //-- Umbral de que el FIFO esta casi lleno
    input [DW-1: 0] data_out_c,  //-- Salida del FIFO
    input valid_out_c,           //-- es 1 cuando la salida del FIFO es un dato valido
    input almost_empty_full_c,         
    input fifo_empty_c,          //-- Entrada de la maquina de estados, Es 1 si el FIFO esta vacio, 0 en caso contrario
    input error_c,                //--Entrada de la maquina de estados, Es 1 solo si se pide hacer un push y el fifo estaba lleno o si se pide pop y el FIFO estaba vacio
    input [DW-1: 0] data_out_e,  //-- Salida del FIFO
    input valid_out_e,           //-- es 1 cuando la salida del FIFO es un dato valido
    input almost_empty_full_e,         //-- Parte del flow control, 1 para pedir una pausa, 0 no hace nada
    input fifo_empty_e,          //-- Entrada de la maquina de estados, Es 1 si el FIFO esta vacio, 0 en caso contrario
    input error_e                //--Entrada de la maquina de estados, Es 1 solo si se pide hacer un push y el fifo estaba lleno o si se pide pop y el FIFO estaba vacio    
    );

	initial begin
		$dumpfile("banco_pruebas.vcd");
        $dumpvars();
        clk = 0;
        reset = 0;
        pop = 0;
        push = 0;
        data_in = 'hE0;
        umbral_almost_full = 7;
        umbral_almost_empty = 3;
		@(posedge clk);
		@(posedge clk);

      reset <= 1;
      pop <= 0;
      push <= 0;
      @(posedge clk);
      // 3 WRITE
      repeat(3) begin
        @(posedge clk);
        push <= 1; 
        data_in <= data_in + 1;
      end
      @(posedge clk);
      push <= 0;
      // 1 READ
      repeat(1) begin
        @(posedge clk);
        pop <= 1; 
      end
      @(posedge clk);
      pop <= 0;


		@(posedge clk);
      reset <= 1;
      pop <= 0;
      push <= 0;
      // 4 WRITE
      repeat(4) begin
        @(posedge clk);
        push <= 1; 
        data_in <= data_in + 1;
      end
      @(posedge clk);
      push <= 0;
      // 2 READ
      repeat(2) begin
        @(posedge clk);
        pop <= 1; 
      end
      @(posedge clk);
      pop <= 0;

		@(posedge clk);
      reset <= 1;
      pop <= 0;
      push <= 0;
      // 2 WRITE
      repeat(3) begin
        @(posedge clk);
        push <= 1; 
        data_in <= data_in + 1;
      end
      @(posedge clk);
      push <= 0;
      data_in <= data_in - 1;
      // 6 READ
      repeat(7) begin
        @(posedge clk);
        pop <= 1; 
        data_in <= data_in + 1;
      end
      @(posedge clk);
      pop <= 0;


      @(posedge clk);

      @(posedge clk);
      pop <= 1;
      @(posedge clk);
      pop <= 0;
      @(posedge clk);
 
      @(posedge clk);
      reset <= 0;
      pop <= 0;
      push <= 0;
      @(posedge clk);
      @(posedge clk);
      reset <= 1;  
      repeat(9) begin
        @(posedge clk);
        push <= 1; 
        data_in <= data_in + 1;
      end
      @(posedge clk);
      @(posedge clk);

      @(posedge clk);
      reset <= 0;
      pop <= 0;
      push <= 0;

    @(posedge clk);

    @(posedge clk);
      reset <= 1;
    @(posedge clk);
      push <= 1; 
      data_in <= data_in + 1;
      repeat(4) begin
        @(posedge clk);
        push <= 1;
        pop <= 1; 
        data_in <= data_in + 1;
      end
        @(posedge clk);
        data_in <= data_in + 1;
        pop <= 0; 
        @(posedge clk);
        push <= 0;
        @(posedge clk);
      repeat(4) begin
        @(posedge clk);
        push <= 1;
        pop <= 1; 
        data_in <= data_in + 1;
      end
        @(posedge clk);
		$finish;
	end
	
    initial clk <= 0;
    always #5 clk <= ~clk;

endmodule