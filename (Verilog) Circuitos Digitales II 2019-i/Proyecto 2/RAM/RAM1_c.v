
`ifndef RAM_C   //-- Para no tener problemas con los include, si el
 `define RAM_C  //   modulo RAM_c ya estaba definido ignora el codigo


module RAM_c #(
    parameter AW = 3,   //-- Cantidad de bits de direcciones (Adress width)
    parameter DW = 4)   //-- Cantidad de bits de datos (Data width) 
    (   
    input clk,                          //-- Reloj
    input reset,                        //-- Reset
    input [AW-1: 0] addr,               //-- Direccion de la RAM
    input rw,                           //-- 0 read, 1 write
    input [DW-1: 0] data_in,            //-- Dato entrada de la RAM 
    output [DW-1: 0] data_out_c     //-- Dato salida de RAM
    );         

    localparam cantidad_datos = 2 ** AW;

    reg [DW-1:0] ram_memory [0: cantidad_datos-1];  //-- Numero de datos (cantidad_datos) de DW bits
                                                    //-- ejm: si AW = 4 y DW = 5 se tiene que hay 
                                                    //-- 2^4 datos de 5 bits cada uno.
  
    integer i;
    always @(posedge clk) begin
        if (reset == 0) begin           //-- Inicializando en 0 la RAM
            for (i = 0;i < cantidad_datos;i = i + 1) begin
                ram_memory[i] <= 'b0;   
            end
        end
        if (reset == 1) begin           
            if (rw == 1) begin          //-- Write ram data
                ram_memory[addr] <= data_in;    //-- La entrada se guarda en la RAM en la posicion addr         
            end
        end
    end

    assign data_out_c = (rw == 0)? ram_memory[addr]: 0; //-- La salida es lo que tenga la RAM guardada en la posicion addr
                                                        //   cuando se solicita una lectura rw == 0
endmodule


`endif 