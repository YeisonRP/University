/**
 * @file FrecuenciaPalabras.h
 * @author Yeison Rodriguez. Fabian Guerra
 * @brief Esta es la clase FrecuenciaPalabras, que se encarga de contar la frecuencia de las palabras en un texto que el usuario desee ingresar
 * @version 0.1
 * @date 2018-11-24
 * 
 * @copyright Copyright (c) 2018
 * 
 */
#include <iostream>
#include <fstream>
#include <string>
#include <cstdlib>
#include <vector>
#include <map> 
using namespace std;

class FrecuenciaPalabras {
    public:
        FrecuenciaPalabras();
        ~FrecuenciaPalabras();

        vector<string> stopWords;                   //guarda los stopWords
        map<string, int> palabrasFrecuentes;        // Guarda cada palabra unica como un Key y en el dato guarda la cantidad de veces que se le ha encontrado
        string ArchivostopWords;                    // Nombre del archivo de texto de stopwords
        string ArchivosParrafo;                     // Nombre del archivo de texto del parrafo a analizar
        int wordsMF[25];                            //palabras mas frecuentes int
        string SwordsMF[25];                        //palabras mas frecuentes int

        /**
         * @brief Este metodo se encarga de verificar la frecuencia de las palabras encontradas en el texto
         * verificando que no se cuente ninguna palabra que sea un stopWord
         */
        void contarLasPalabras();
        
        /**
         * @brief SE encarga de llenar el vector stopWords con las palabras stop
         * 
         */
        void llenarStopWords();
};