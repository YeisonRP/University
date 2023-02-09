DOXY = 

all: build run 

build:
	@echo "Compilando..."
	@g++ -std=c++11 main.cpp -o listaEnlazada.exe

clean:
	@echo "Removiendo archivos ejecutables y documentacion doxygen"
	@cd ../informe ; rm -rf html latex
	@rm listaEnlazada.exe

run:
	@echo "Ejecutando el programa"
	@./listaEnlazada.exe 4

doc:	
	@echo "Generando la documentacion, su PDF se abrira en breve" 
	@doxygen Doxyfile.txt; cd ../informe/latex/; make; xdg-open refman.pdf

pdf:
	@echo "Abriendo el reporte del laboratorio 5" 
	@cd ../informe ; xdg-open lab5_g4.pdf
	

	
	
