DOXY = 

all: build run 

build:
	g++ -std=c++11 animal.cpp celda.cpp conejo.cpp funciones.cpp lobo.cpp  oveja.cpp vegetal.cpp zorro.cpp plantas.cpp main.cpp -o ecosistema.exe

clean:
	rm ecosistema.exe

run:
	./ecosistema.exe animales.txt 2

doc: 
	doxygen Doxyfile.txt; cd ../Documentacion/Doxygen/html/; xdg-open index.html

pdf:
	cd ../Documentacion ; xdg-open lab2_g4.pdf
	

	
	
