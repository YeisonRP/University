all:	
	@make synth
	@make sed
	@make compile
	@make sim
	@make view
	@make delete

compile: 
	iverilog  BancoPrueba.v -o Test_S_P.out
sim:
	vvp Test_S_P.out

view: 
	gtkwave S_P.vcd 

sed:

	@sed -i "s/module Serie_Paralelo/module S_P_Yosys/g" ./S_P_Yosys.v
	@sed -i "s/parallel_out_c/ parallel_out_e/g" ./S_P_Yosys.v
	@sed -i "s/valid_out_c/ valid_out_e/g" ./S_P_Yosys.v


synth: 
	yosys yosysfile_S_P.ys

delete:
	rm Test_S_P.out
	rm S_P.vcd
