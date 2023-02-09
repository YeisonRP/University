#!/bin/bash

for ((i=1;i<2000;i++))
     {

        if ((i%10 == 0))
        then
            g++ -o proyecto1.exe main.cpp;
            ./proyecto1.exe $i;
        fi
        
     }
exit 0;
