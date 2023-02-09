/**
 * @brief Archivo que contiene las cabeceras de las clases de los cuatro animales
 * 
 * @file animales.h
 * @Yeison Rodríguez
 * @Fabián Guerra
 * @date 2018-09-21
 */

#include <iostream>
#include <fstream>
#include <string>
#include <cstdlib>

#include "clases.h"

using namespace std;

/**
 * @brief Clase que representa un lobo en el ecosistema
 * 
 */
class Lobo : public Animal{
    public:
        Lobo();
       virtual ~Lobo();
        
        /**
         * @brief Clase virtual que pone el Lobo a comer
         * 
         * @param Ecosistema puntero doble que apunta a una matriz de objetos Celda
         */
        virtual void comer(Celda** Ecosistema);

        /**
         * @brief Función que pone a morir al lobo cuando su energía llega a cero o cuando otro lobo macho lo mata
         * 
         * @param Ecosistema puntero doble que apunta a una matriz de objetos Celda
         */
        void morir(Celda** Ecosistema);

        /**
         * @brief Función declarada virtual pura en clase animal, sirve para reportar la posición y energía del animal
         * 
         */
        void reporte_animal_o_planta();
};

class Oveja : public Animal{
    public:
        Oveja();
        virtual ~Oveja();
        
       /**
        * @brief Pone a comer al animal Oveja
        * 
        * @param Ecosistema puntero doble que apunta a una matriz de objetos Celda
        */
        virtual void comer(Celda** Ecosistema);
        /**
         * @brief Función declarada virtual pura en clase animal, sirve para reportar la posición y energía del animal
         * 
         */
        void reporte_animal_o_planta();

};

class Zorro : public Animal{
    public:
        Zorro();
        virtual ~Zorro();
        
        /**
        * @brief Pone a comer al animal Zorro
        * 
        * @param Ecosistema puntero doble que apunta a una matriz de objetos Celda
        */
        virtual void comer(Celda** Ecosistema);
        /**
         * @brief Función declarada virtual pura en clase animal, sirve para reportar la posición y energía del animal
         * 
         */
        void reporte_animal_o_planta();

};

class Conejo : public Animal{
    public:
        Conejo();
        virtual ~Conejo();
        
        /**
        * @brief Pone a comer al animal Conejo
        * 
        * @param Ecosistema puntero doble que apunta a una matriz de objetos Celda
        */  
        void comer(Celda** Ecosistema);
        /**
         * @brief Función declarada virtual pura en clase animal, sirve para reportar la posición y energía del animal
         * 
         */
        void reporte_animal_o_planta();

};