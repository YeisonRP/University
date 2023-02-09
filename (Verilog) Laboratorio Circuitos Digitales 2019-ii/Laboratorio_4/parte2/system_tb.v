`timescale 1 ns / 1 ps

module system_tb; //No necesita entradas o salidas porque es un testbench
	reg clk = 1;
	always #5 clk = ~clk;

	reg resetn = 0;
	initial begin
		if ($test$plusargs("vcd")) begin
			$dumpfile("system.vcd");
			$dumpvars(0, system_tb);
		end
		repeat (10) @(posedge clk);
		resetn <= 1;
		
	//	repeat (10) begin
	//        @(posedge clk);
	//	  resetn <= ~resetn;		
	//	end
		
	//	$finish;
	end

	wire trap;
	wire [7:0] out_byte;
	wire out_byte_en;
	wire [7:0] out_enable_digit;

	system uut (   //Unit under test
		.clk        (clk        ),
		.resetn     (resetn     ),
		.trap       (trap       ),
		.out_byte   (out_byte   ),
		.out_byte_en(out_byte_en)
	);

	always @(posedge clk) begin
		if (resetn && out_byte_en) begin
			$write("%c", out_byte);
			$fflush;
		end
		if (resetn && trap) begin
			//$finish;
		end
	end
endmodule
