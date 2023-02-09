Proy1: auto test rm

yosys:
	yosys synthtmp.ys
	sed -i 's/data_out_0_c/data_out_0_s/g' proy1_synth.v
	sed -i 's/valid_out_0_c/valid_out_0_s/g' proy1_synth.v
	sed -i 's/data_out_1_c/data_out_1_s/g' proy1_synth.v
	sed -i 's/valid_out_1_c/valid_out_1_s/g' proy1_synth.v
	sed -i 's/clk4f_c/clk4f_s/g' proy1_synth.v
	sed -i 's/clk2f_c/clk2f_s/g' proy1_synth.v
	sed -i 's/clkf_c/clkf_s/g' proy1_synth.v
	#Este bloque se borra vvvvvvvvvvvvvvvv
	sed -i 's/data_mid_c/data_mid_s/g' proy1_synth.v
	sed -i 's/valid_mid_c/valid_mid_s/g' proy1_synth.v
	#Este bloque se borra ^^^^^^^^^^^^^^^^
	sed -i 's/module proy1_conductual/module proy1_synth/g' proy1_synth.v
	sed -i 's/module clkgen/module clkgen_s/g' proy1_synth.v
	sed -i 's/module mux/module mux_s/g' proy1_synth.v
	sed -i 's/module demux/module demux_s/g' proy1_synth.v
	sed -i 's/clkgen gen/clkgen_s gen/g' proy1_synth.v
	sed -i 's/mux mux/mux_s mux/g' proy1_synth.v
	sed -i 's/demux de/demux_s de/g' proy1_synth.v

	sed -i '1i `include "cmos_cells.v"' proy1_synth.v

auto:
	emacs --batch BancoPrueba.v -f verilog-auto -f save-buffer

test:
	iverilog -Tmin BancoPrueba.v
	vvp a.out
	gtkwave proy1.vcd

rm:
	rm a.out
	rm proy1.vcd