`include "sum_pipe_c.v"

module sumador_c(
    input [3:0] idx,
    input [3:0] dataA,
    input [3:0] dataB,
    input clk,
    input reset_L,
    output [3:0] sum30_dd_c,
    output reg [3:0] idx_dd_c
);

    reg [3:0] idx_d;


always @(posedge clk ) begin
    if (reset_L == 0) begin
        idx_d <= 0;
        idx_dd_c <= 0;
    end
    else begin
        idx_d <= idx;
        idx_dd_c <= idx_d;
    end
end

sum_pipe_c instance_sum_pipe_c_0( /*AUTOINST*/
				 // Outputs
				 .sum30_dd_c		(sum30_dd_c[3:0]),
				 // Inputs
				 .dataA			(dataA[3:0]),
				 .dataB			(dataB[3:0]),
				 .clk			(clk),
				 .reset_L		(reset_L));

endmodule // sumador
