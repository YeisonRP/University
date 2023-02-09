all: build run

build:
	@iverilog -o demux.o banco_pruebas_conductual.v

run:
	@ echo "\n--------------------------------------------------------------------------------------------------------\n"
	@ echo "Ejecutando el programa...  \n"
	@vvp demux.o

gtk: 
	@gtkwave demux.vcd;

clean:
	@rm demux.vcd demux.o 

prueba0: build run

prueba1:
	@sed -i 's/probador/probador1/g' banco_pruebas_conductual.v;make; sed -i 's/probador1/probador/g' banco_pruebas_conductual.v

prueba2:
	@sed -i 's/probador/probador2/g' banco_pruebas_conductual.v;make; sed -i 's/probador2/probador/g' banco_pruebas_conductual.v

pdf:
	cd ../informe; xdg-open Tarea_2_B56074.pdf

