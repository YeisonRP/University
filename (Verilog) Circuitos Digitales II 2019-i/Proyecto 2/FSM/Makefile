
all:
	@make synth
	@make sed
	@make emacs
	@make compile
	@make sim
	@make view
	@make borrar
	

NAME_BANCO_PRUEBAS = Banco_Pruebas_FSM

compile: 
	iverilog  $(NAME_BANCO_PRUEBAS).v -o $(NAME_BANCO_PRUEBAS).out
sim:
	vvp $(NAME_BANCO_PRUEBAS).out

view: 
	gtkwave $(NAME_BANCO_PRUEBAS).vcd

sed:

	@sed -i "s/_c/_e/g" ./FSM_e.v
	
emacs:
	@emacs --batch $(NAME_BANCO_PRUEBAS).v -f verilog-auto -f save-buffer
	
synth: 
	yosys yosys_comandos.ys

borrar:
	rm $(NAME_BANCO_PRUEBAS).vcd $(NAME_BANCO_PRUEBAS).out
	
