module demux_conductual(
    input clk,
    input reset_L,
    output reg[3:0] data_out0,
    output reg[3:0] data_out1,
    input [3:0] data_in
);
    reg selector;
    reg[3:0] x_0;
    reg[3:0] x_1;
    reg[3:0] y_0;
    reg[3:0] y_1;

    //Flip Flop
    always @ (posedge clk)
        begin
            if (reset_L == 0)
                begin
                    y_0 <= 'b0000; //x_0
                    y_1 <= 'b0000; //x_1
                end
            else    //reset = 1
                if(selector == 0)
                    begin
                        y_0 <= data_in; // X0
                        y_1 <= y_1;
                    end
                else //selector 1
                    begin
                        y_1 <= data_in; // X0
                        y_0 <= y_0;  // mantenla salida a la entrada del FF
                    end
        end

    //logica combinacional de la salida para elegir si la salida final sera lo que guarda el FlipFlop o la calculada
    // por la logica combinacional anterior
    always @ (*)
        begin           
            x_0 = 'b0000;
            x_1 = 'b0000;
            data_out0 = 'h0;
            data_out1 = 'h0;

            if(selector == 0)
                x_0 = data_in;
            else
                x_1 = data_in;   

            if(reset_L == 1 & selector == 1)
                begin
                    data_out0 = y_0;
                    data_out1 = x_1;
                end
            if(reset_L == 1 & selector == 0)
                begin
                    data_out0 = x_0;
                    data_out1 = y_1;
                end
        end 

    //SELECTOR
    always @ (posedge clk)
        begin
            selector <= 0;//OJO
            if (reset_L == 1)
                selector <= ~selector;
        end
endmodule
