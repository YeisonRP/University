all: build run

build:
	@iverilog -o banco_pruebas.o -Ttyp banco_pruebas.v

run:
	@ echo "\n--------------------------------------------------------------------------------------------------------\n"
	@ echo "Ejecutando el programa...  \n"
	@vvp banco_pruebas.o

gtk: 
	@gtkwave banco_pruebas.vcd;

clean:
	@rm banco_pruebas.vcd banco_pruebas.o 

prueba0: build run

prueba1:
	@sed -i 's/probador/probador1/g' banco_pruebas.v;make; sed -i 's/probador1/probador/g' banco_pruebas.v

prueba2:
	@sed -i 's/probador/probador2/g' banco_pruebas.v;make; sed -i 's/probador2/probador/g' banco_pruebas.v

pdf:
	cd ../informe; xdg-open Tarea_3y4_B56074.pdf

#emacs --batch banco_pruebas.v -f verilog-auto -f save-buffer


