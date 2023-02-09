/**
 * @brief Este es el archivo cabecera de los cuatro tipos de plantas
 * @file funciones.h
 * @author Yeison Rodriguez Pacheco B56074
 * @author Fabian Guerra Esquivel B53207
 */

#include <iostream>
#include <fstream>
#include <string>
#include <cstdlib>

#include "vegetal.h"




/**
 * @brief Clase que representa un pasto en el ecosistema
 */
class Pasto : public Vegetal{
    public:
        Pasto();
        virtual ~Pasto();
        /**
         * @brief función que hace que la planta gane enerǵia del sol
         * 
         */
        void fotosintesis();
        /**
         * @brief Reporta el estado de la planta, donde se encuentra, su energía, etc
         * 
         */
        void reporte_animal_o_planta();
};
/**
 * @brief Clase que representa una Uva en el ecosistema
 */
class Uva : public Vegetal{
    public:
        Uva();
      virtual ~Uva();
        /**
         * @brief Reporta el estado de la planta, donde se encuentra, su energía, etc
         * 
         */
        void reporte_animal_o_planta();
        /**
         * @brief función que hace que la planta gane enerǵia del sol
         * 
         */
        void fotosintesis();   
        
};
/**
 * @brief Clase que representa una Zanahoria en el ecosistema
 */
class Zanahoria : public Vegetal{
    public:
        Zanahoria();
       virtual ~Zanahoria();
       /**
        * @brief función que hace que la planta gane enerǵia del sol
        * 
        */
        void fotosintesis();   
        /**
         * @brief Reporta el estado de la planta, donde se encuentra, su energía, etc
         * 
         */
        void reporte_animal_o_planta();
};
/**
 * @brief Clase que representa un Roble en el ecosistema
 */
class Roble : public Vegetal{
    public:
        Roble();
       virtual ~Roble();
       /**
        * @brief función que hace que la planta gane enerǵia del sol
        * 
        */
        void fotosintesis();

        /**
         * @brief tamaño del roble
         * 
         */
        int tamano;  //tama;o del roble

        /**
         * @brief Reporta el estado de la planta, donde se encuentra, su energía, etc
         * 
         */
        void reporte_animal_o_planta();
};

