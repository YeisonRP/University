

ARCHIVO=TRANSLAYER


#-------------------------------------------------------------------------
Tarea6: auto run clean


yosys:
	yosys yosys_comandos.ys

	sed -i 's/error_out_c/error_out_e/g' $(ARCHIVO)_e.v
	sed -i 's/active_out_c/active_out_e/g' $(ARCHIVO)_e.v
	sed -i 's/idle_out_c/idle_out_e/g' $(ARCHIVO)_e.v
	sed -i 's/data_out_0_c/data_out_0_e/g' $(ARCHIVO)_e.v
	sed -i 's/data_out_1_c/data_out_1_e/g' $(ARCHIVO)_e.v
	sed -i 's/valid_out_0_c/valid_out_0_e/g' $(ARCHIVO)_e.v
	sed -i 's/valid_out_1_c/valid_out_1_e/g' $(ARCHIVO)_e.v
	sed -i 's/error_out_e(/error_out_c(/g' $(ARCHIVO)_e.v
	sed -i 's/active_out_e(/active_out_c(/g' $(ARCHIVO)_e.v
	sed -i 's/idle_out_e(/idle_out_c(/g' $(ARCHIVO)_e.v


	sed -i 's/module $(ARCHIVO)_c/module $(ARCHIVO)_e/g' $(ARCHIVO)_e.v
	sed -i 's/\RAM_c/\RAM_e/g' $(ARCHIVO)_e.v
	sed -i 's/\fifo_c/\fifo_e/g' $(ARCHIVO)_e.v
	sed -i 's/module FSM_c/module FSM_e/g' $(ARCHIVO)_e.v

	sed -i '1i `include "cmos.v"' $(ARCHIVO)_e.v

auto:
	emacs --batch banco_pruebas.v -f verilog-auto -f save-buffer

run:
	iverilog -Tmin banco_pruebas.v
	vvp a.out
	gtkwave $(ARCHIVO).vcd

clean:
	rm $(ARCHIVO).vcd
	rm a.out