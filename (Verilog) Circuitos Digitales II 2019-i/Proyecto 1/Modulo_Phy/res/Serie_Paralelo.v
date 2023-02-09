
module Serie_Paralelo(input  clk_8f,
                      input  clk_f,
                      input  data_in,
                      input  reset,
                      output reg valid_out_c,
                      output reg [7:0] parallel_out_c);
    

    // SEÑALES INTERNAS Y CABLES:
    reg [7:0] Data_P, parallel_out_auxiliar;
    reg [2:0] bit_counter, BC_counter;
    wire clk_8f, clk_f, data_in, reset;
    reg active, valid_out_c_retrasado;


    // INICIALIZACION DE VARIABLES Y ACTIVACIÓN DEL ACTIVE
    always @(*) begin
         if(BC_counter > 3) begin
            active = 1; 
        end
        else begin
            active = 0;
        end

        
    end 

    // PARALELIZADO:

       always @(posedge clk_f) begin
            if(!active || Data_P == 'hBC) begin
                valid_out_c_retrasado <= 0;
                parallel_out_auxiliar <=0;
                
            end
            else begin
                valid_out_c_retrasado <= 1;
                parallel_out_auxiliar <= Data_P;
            end
          
    end
    
    always @(posedge clk_8f) begin
        if(!reset) begin
            bit_counter = 3'b111;
            Data_P = 8'b0;
            BC_counter = 3'b0;
        end
        else begin
            Data_P[bit_counter] <= data_in;
            bit_counter <= bit_counter - 1;

            if (Data_P == 'hBC && bit_counter == 0) begin
                BC_counter <= BC_counter +1;
            end
           
        end
    end

    integer i;
    always @(*) begin
        parallel_out_c = 0;
        valid_out_c = 0;
        if(reset) begin
            for (i = 7; i > 0 ; i = i - 1) begin
                parallel_out_c[i] = parallel_out_auxiliar[i];
            end
            parallel_out_c[0] = Data_P[0];
            valid_out_c = 0;
            if (active) begin
                valid_out_c = valid_out_c_retrasado;
                if (parallel_out_c == 'hBC) begin
                    valid_out_c = 0;
                end
            end
        end
    end
 

endmodule