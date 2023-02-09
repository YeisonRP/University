all: build run

build:
	@iverilog -o biblioteca_componentes.o -Ttyp banco_pruebas_conductual.v

run:
	@ echo "\n--------------------------------------------------------------------------------------------------------\n"
	@ echo "Ejecutando el programa...  \n"
	@vvp biblioteca_componentes.o

gtk: 
	@gtkwave biblioteca_componentes.vcd;

clean:
	@rm biblioteca_componentes.vcd biblioteca_componentes.o 

prueba0: build run

pdf:
	cd ../informe; xdg-open Tarea_3y4_B56074.pdf

#emacs --batch alarma_desc_conductual.v -f verilog-auto -f save-buffer


