/**
 * @brief Este es el archivo cabecera de la clase vegetal
 * @file funciones.h
 * @author Yeison Rodriguez Pacheco B56074
 * @author Fabian Guerra Esquivel B53207
 */

#include <iostream>
#include <fstream>
#include <string>
#include <cstdlib>



/**
 * @brief Clase que representa los vegetales en el Ecosistema
 * 
 */
class Vegetal{
    public:
        Vegetal();
        virtual ~Vegetal();

        //ATRIBUTOS
        int ubicacion[2];
        int energia;
        int contadorDeDias;
        char tipoPlanta;
        Vegetal* identificador;
        int energiaMax = 75;
        int diasParaRecuperar;

        /**
         * @brief Este método se encarga de que cada planta recupere energía del sol según corresponde
         * 
         */
        void fotosintesis();

        /**
         * @brief Esta función es virtual pura y se declara en las plantas, sirve para que reporten su energía y dónde están
         * 
         * 
         */
       virtual void reporte_animal_o_planta()=0;


};