all: build run 

build:
	@echo "\nCompilando... \n"
	@g++ -o proyecto1.exe main.cpp des.cpp
clean:
	@echo "\nEliminando archivos ejecutables... \n"
	@rm proyecto1.exe	
run:
	@echo "\nEjecutando el programa... \n"
	@./proyecto1.exe 

doc: 
	@doxygen doxyfile.txt; cd ../informe/latex/; make; xdg-open refman.pdf

pdf:
	@cd ../informe ; xdg-open P1_g4.pdf


