#!/bin/bash

for ((i=0;i<250;i++))
     {
        g++ -std=c++11 animal.cpp celda.cpp conejo.cpp funciones.cpp lobo.cpp  oveja.cpp vegetal.cpp zorro.cpp plantas.cpp main.cpp -o ecosistema.exe;
        ./ecosistema.exe animales.txt $i;
     }
exit 0;
