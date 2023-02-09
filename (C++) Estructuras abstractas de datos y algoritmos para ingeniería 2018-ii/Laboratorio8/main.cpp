/**
 * @file main.cpp
 * @author Yeison Rodriguez. Fabian Guerra
 * @brief En este archivo se ejecuta un main de pruebas para el programa que cuenta la frecuencia de las palabras usando la STL
 * @version 0.1
 * @date 2018-11-24
 * 
 * @copyright Copyright (c) 2018
 * 
 */
#include "FrecuenciaPalabras.h"



int main(){
    FrecuenciaPalabras *a = new FrecuenciaPalabras;
    a->ArchivostopWords = "stopWords.txt";
    a->ArchivosParrafo = "archivoTexto.txt";
    a->llenarStopWords(); 
    cout << '\t' << "Explicacion: En este programa se lee un archivo con texto y se cuenta la frecuencia de las palabras." << endl << endl;
    cout << '\t' << "Palabras leidas del texto y su frecuencia:" << endl<< endl;
    a->contarLasPalabras(); 
    return 0;
}

