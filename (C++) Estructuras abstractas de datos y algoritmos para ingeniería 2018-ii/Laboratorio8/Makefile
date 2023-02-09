all: build run clean

build:
	@g++ -std=c++11 main.cpp FrecuenciaPalabras.cpp -o lab8.exe

clean:
	@ echo "\nFin del programa...\n"
	@ echo "------------------------------------------------------------------\n"
	@rm lab8.exe

run:
	@ echo "\n------------------------------------------------------------------\n"
	@ echo "Ejecutando el programa...  \n"
	@./lab8.exe

doc: 
	@doxygen doxyfile.txt; cd ../informe/latex/; make; xdg-open refman.pdf

pdf:
	@cd ../informe ; xdg-open lab8_g4.pdf
