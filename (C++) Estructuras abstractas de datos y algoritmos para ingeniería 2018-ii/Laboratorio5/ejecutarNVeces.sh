#!/bin/bash

for ((i=0;i<200;i++))
     {
        g++ -std=c++11 main.cpp;
        ./listaEnlazada.exe $i;
     }
exit 0;
