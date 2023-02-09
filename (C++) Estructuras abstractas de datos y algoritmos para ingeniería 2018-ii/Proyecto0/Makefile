
all: build run 

build:
	@echo "\nCompilando... \n"
	@g++ `Magick++-config --cxxflags --cppflags` `libpng-config --cflags` -o proyecto0.exe main.cpp funciones.cpp `Magick++-config --ldflags --libs` `libpng-config --ldflags` 
clean:
	@echo "\nEliminando archivos ejecutables... \n"
	@rm proyecto0.exe	
run:
	@echo "\nEjecutando el programa... \n"
	@./proyecto0.exe binario.bin imagen1.png imagen2.JPG imagen3.GIF imagen4.bmp imagen5.JPEG imagen6.PDF
	
doc: 
	@echo "\nGenerando documentacion en DOXYGEN \n"
	@doxygen doxyfile.txt; cd ../informe/latex/; make; xdg-open refman.pdf
pdf:
	@echo "\nAbriendo PDF del informe \n"
	@cd ../informe ; xdg-open P0_g4.pdf
	

	
	
