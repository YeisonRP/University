all:
	@make compile
	@make sim
	@make view

compile: 
	iverilog  BancoPrueba.v -o TestP_S.out
sim:
	vvp TestP_S.out

view: 
	gtkwave P_S.vcd 

sed:

	@sed -i "s/module Paralelo_Serie_conductual/module P_S_Yosys/g" ./P_S_Yosys.v
	@sed -i "s/data_out_c/ data_out_e/g" ./P_S_Yosys.v
	@sed -i "s/data2send_c/ data2send_e/g" ./P_S_Yosys.v


synth: 
	yosys yosysfileP_S.ys
