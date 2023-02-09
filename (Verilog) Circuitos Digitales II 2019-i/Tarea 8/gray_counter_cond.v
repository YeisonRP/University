module gray_counter_cond(
    input clk,
    input enable,
    input reset_L,
    output [4:0] salida_gray_c
);

reg [4:0] count;

always @(posedge clk) begin
    if (reset_L == 0) begin
        count <= 'b00000;
    end
    else begin
        if (enable == 0) count <= count;
        if (enable == 1) count <= count + 1;
    end
end



assign salida_gray_c = count ^ (count >> 1);

endmodule