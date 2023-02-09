module probador #(
    parameter AW = 3,   //-- Cantidad de bits de direcciones (Adress width)
    parameter DW = 4)   //-- Cantidad de bits de datos (Data width) 
    (
    output reg clk,                          //-- Reloj
    output reg reset,                        //-- Reset
    output reg [AW-1: 0] addrr,               //-- Direccion de lectura en la RAM
    output reg [AW-1: 0] addrw,               //-- Direccion de escritura en la RAM
    output reg  [1:0] rw,                     //-- 00 idle, 01 write, 10 read, 11 read and write
    output reg [DW-1: 0] data_in,            //-- Dato entrada de la RAM 
    input [DW-1: 0] data_out_c,    //-- Dato salida de RAM conductual
    input [DW-1: 0] data_out_e     //-- Dato salida de RAM estructural
    );

	initial begin
		$dumpfile("banco_pruebas.vcd");
        $dumpvars();
        clk = 0;
        reset = 0;
        addrr = 7;
        addrw = 5;
        rw = 10;
        data_in = 0;
		@(posedge clk);
		@(posedge clk);
        reset = 1;
		@(posedge clk);
    	@(posedge clk);

      repeat(8) begin
	 @(posedge clk);
        rw <= 11; // write
        data_in <= data_in + 1;
        addrr <= addrr + 1;
        addrw <= addrw + 1;
      end

      repeat(8) begin
	 @(posedge clk);
        rw <= 'b00; // read
        addrr <= addrr + 1;
        addrw <= addrw + 1;
      end    
     @(posedge clk);  
     @(posedge clk);   
      repeat(8) begin
	 @(posedge clk);
        rw <= 'b01; // write
        data_in <= data_in + 1;
        addrr <= addrr + 1;
        addrw <= addrw + 1;
      end

      repeat(8) begin
	 @(posedge clk);
        rw <= 'b11; // read
        addrr <= addrr + 1;
        addrr <= 8;
        addrw <= 8;
      end    
     @(posedge clk);  
     addrr <= addrr + 1;
     addrw <= addrw + 1;
     @(posedge clk);  
     @(posedge clk);  
     addrr <= 1;
     addrw <= 5;
     @(posedge clk);  
     @(posedge clk);  
     addrr <= 6;
     addrw <= 2;
     @(posedge clk);  
     addrr <= 5;
     addrw <= addrw + 1;

     @(posedge clk);  
     addrw <= 8;
     @(posedge clk);  
		$finish;
	end

	
    initial clk <= 0;
    always #5 clk <= ~clk;

endmodule