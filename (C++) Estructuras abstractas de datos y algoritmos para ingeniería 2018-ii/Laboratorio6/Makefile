all: build run clean

build:
	@g++ -std=c++11 main.cpp -o arbolBinario.exe

clean:
	@ echo "\nFin del programa...\n"
	@ echo "------------------------------------------------------------------\n"
	@rm arbolBinario.exe

run:
	@ echo "\n------------------------------------------------------------------\n"
	@ echo "Ejecutando el programa...  \n"
	@./arbolBinario.exe

doc: 
	@doxygen doxyfile.txt; cd ../informe/latex/; make; xdg-open refman.pdf

pdf:
	@cd ../informe ; xdg-open lab6_g4.pdf
