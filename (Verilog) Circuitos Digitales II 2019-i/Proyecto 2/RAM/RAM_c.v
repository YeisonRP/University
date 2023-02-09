`ifndef RAM_C   //-- Para no tener problemas con los include, si el
 `define RAM_C  //   modulo RAM_c ya estaba definido ignora el codigo


module RAM_c #(
    parameter AW = 3,   //-- Cantidad de bits de direcciones (Adress width)
    parameter DW = 4)   //-- Cantidad de bits de datos (Data width) 
    (   
    input clk,                          //-- Reloj
    input reset,                        //-- Reset
    input [AW-1: 0] addrr,               //-- Direccion1 de la RAM
    input [AW-1: 0] addrw,               //-- Direccion2 de la RAM
    input [1:0] rw,                     //-- 00 idle, 01 write, 10 read, 11 read and write
    input [DW-1: 0] data_in,            //-- Dato entrada de la RAM 
    output reg [DW-1: 0] data_out_c     //-- Dato salida de RAM
    );         

    localparam cantidad_datos = 2 ** AW;

    reg [DW-1:0] ram_memory [0: cantidad_datos-1];  //-- Numero de datos (cantidad_datos) de DW bits
                                                    //-- ejm: si AW = 4 y DW = 5 se tiene que hay 
                                                    //-- 2^4 datos de 5 bits cada uno.
  
    integer i;
    always @(posedge clk) begin
        if (reset == 0) begin           //-- Inicializando en 0 la RAM
            data_out_c <= 'b0;  
            for (i = 0;i < cantidad_datos;i = i + 1) begin
                ram_memory[i] <= 'b0;   
            end
        end
        else begin

            if(rw == 'b11 )begin
                ram_memory[addrw]<=data_in;
                data_out_c <= ram_memory[addrr];
            end

            if(rw == 'b01 )begin
                ram_memory[addrw]<=data_in;
            end
            if(rw == 'b10 )begin
                data_out_c <= ram_memory[addrr];
            end
            if(rw == 'b00 )begin
                data_out_c <= 'b00;
            end
            
        end 

    end     

endmodule

`endif