/**
 * @brief Este es el archivo cabecera de las clases Celda y animal
 * @file funciones.h
 * @author Yeison Rodriguez Pacheco B56074
 * @author Fabian Guerra Esquivel B53207
 */

#include <iostream>
#include <fstream>
#include <string>
#include <cstdlib>

#include "plantas.h"



using namespace std;


class Celda;
class Animal;



/**
 * @brief Clase Celda encargada de Contener un objeto animal y un objeto vegetal
 * 
 */
class Celda{
    public:
        Celda();
        Celda(const Celda& c);
        virtual ~Celda();
        /**
         * @brief PUntero a un animal, contiene un animal
         * 
         */
        Animal* animal;
        /**
         * @brief PUntero a un vegetal, contiene un vegetal
         * 
         */
        Vegetal* vegetal;
        /**
         * @brief COntiene las dimensiones del Arreglo de celdas
         * 
         */
        int dimensiones[2];

        bool hayAnimal;

        int coordenadas[2];

        
        void setAnimal(int x, int y, char cualAnimal, char sexo, int energia);
        void setAnimal(int x, int y, char cualAnimal, char sexo, int energia, Animal* animalito);
        void setPlanta(int x, int y, char cualPlanta, int energiaPlanta);

        

        /**
         * @brief Sobrecarga el operador ~ para que mate un animal
         * 
         */
        void operator~();
        
        /**
         * @brief Sobrecarga el operadpr * para que reproduzca dos animales
         * 
         * @param celdita Celda donde está el animal que se va a reproducir
         * @return Animal*  Retorna el animal producto de la reproducción
         */
        Animal* operator*(const Celda& celdita);

        /**
         * @brief Sobrecarga el operador ^ para comer la planta
         * 
         */
        // void operator-();


        void operator<(const Celda& celdita);
        void operator^(const Celda&celdita);
};

/**
 * @brief Clase que representa un animal en el Ecosistema
 * 
 */
class Animal {
    public:
        Animal();
        Animal(const Animal& m);
        virtual ~Animal();

        // ATRIBUTOS
        int ubicacion[2];
        int energia;
        int velocidad;
        int energiaMaxima;
        char sexo;
        char especie;
        bool yaHizoReproduccionHoy;
        bool yaMeMoviHoy;
        bool yaComiHoy;
        /**
         * @brief Es un parámetro que indica la cantidad de movimientos máximos que puede hacer un animal en un día
         * 
         */
        int maximoMovimientoDelAnimal;

        /**
         * @brief Id del animal
         * 
         */
        Animal* identificador;

        //METODOS
        /**
         * @brief Resetea los stats de control al terminar un día de la simulación
         * 
         */
        void resetStats();

        /**
         * @brief Función virtual pura que pone los animales a comer
         * 
         * @param Ecosistema Puntero doble a objetos celda
         */
        virtual void comer(Celda** Ecosistema)=0;
        /**
         * @brief Pone a los animales a moverse, método concreto
         * 
         * @param Ecosistema  Puntero doble a objetos celda
         */
        void mover(Celda** Ecosistema);
        /**
         * @brief POne a los animales a reproducirse
         * 
         * @param Ecosistema  Puntero doble a objetos celda
         */
        void reproducirse(Celda** Ecosistema); // No deberia ser virtual

        /**
         * @brief Mata a los animales que cumplan las condiciones para morir
         * 
         * @param Ecosistema Puntero doble a objetos celda
         */
        virtual void morir(Celda** Ecosistema); // Se necesita virtual
        
        
        /**
         * @brief Función virtual pura que será declarada más adelante, reporta datos personales del animal
         * 
         */
        virtual void reporte_animal_o_planta()=0;
        
    
       

};

