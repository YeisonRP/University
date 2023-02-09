/**
 * @brief Este programa es un simulador de un ecosistema, con cuatro tipos de animales y 
 * tipo de planta que es el pasto 
 * @file clases.h
 * @author Yeison Rodriguez Pacheco B56074
 * @author Fabian 
 * @author XXXXXX
 * @date 2018-09-07
 */

#include <iostream>
#include <fstream>
#include <string>
#include <cstdlib>
using namespace std;

class Celda;
class Oveja;
class Lobo;
class Zorro;
class Pasto;



/**
 * @brief Clase que representa el pasto en el ecosistema
 */
class Pasto {
    public:
        Pasto();
        ~Pasto();

        /**
         * @brief Energia del pasto
         */
        int energia;
        /**
         * @brief Contador de dias del pasto para saber cuando pasaron tres dias
         * asi puede recuperar energia
         * 
         */
        int contadorDeDias;

        /**
         * @brief Esta funcion hace que el pasto recupere energia del sol
         */
        void recuperarEnergiaDelSol();

};

/**
 * @brief Clase que representa una Oveja en el ecosistema
 */
class Oveja{
    public:
        Oveja(int x, int y, int energia, char especie,char sexo); 
        
        ~Oveja();

        char sexo;
        char especie;
        int ubicacion[2];
        bool yaHizoReproduccionHoy;
        int energia;
        Oveja* identificador;
        bool yaMeMoviHoy;

        void resetStats();

        void comer(Pasto *pastito);
        void mover(Celda** Ecosistema, int x, int y);
	void morir(Celda** Ecosistema);
        void reproducirse(Celda** Ecosistema, int x, int y);
};

/**
 * @brief Clase que representa un raton en el ecosistema
 * 
 */
class Raton {
    public:
        Raton(int x, int y, int energia, char especie,char sexo); 
        
        ~Raton();

        char sexo;
        char especie;
        int ubicacion[2];
        bool yaHizoReproduccionHoy;
        int energia;
        Raton* identificador;
        bool yaMeMoviHoy;
           void resetStats();
        void comer(Pasto *pastito);
        void mover(Celda** Ecosistema, int x, int y);
	void morir(Celda** Ecosistema);
        
        void reproducirse(Celda** Ecosistema, int x, int y);

};

/**
 * @brief Clase que representa un zorro en el ecosistema
 * 
 */
class Zorro {
    public:
        Zorro(int x, int y, int energia, char especie,char sexo); 
        
        ~Zorro();

        char sexo;
        char especie;
        int ubicacion[2];
        bool yaHizoReproduccionHoy;
        int energia;
        Zorro* identificador;
        bool yaMeMoviHoy;
           void resetStats();

        void comer(Celda** Ecosistema, int x, int y);
        void mover(Celda** Ecosistema, int x, int y);
	void morir(Celda** Ecosistema);

        void reproducirse(Celda** Ecosistema, int x, int y);
};

/**
 * @brief Clase que representa un animal lobo en el ecosistema
 * 
 */
class Lobo {

    public:
        Lobo(int x, int y, int energia, char especie,char sexo); //YA
        
        ~Lobo();//YA

        char sexo;
        char especie;
        int ubicacion[2];
        bool yaHizoReproduccionHoy;
        bool yaMeMoviHoy;
        Lobo* identificador;
        int energia;

        void comer(Celda** Ecosistema, int x, int y);
    void resetStats();

        void reproducirse(Celda** Ecosistema, int x, int y);
    
        void mover(Celda** Ecosistema, int x, int y);
        void morir(Celda** Ecosistema, int x, int y);


};


/**
 * @brief Clase que representa una celda en el ecosistema
 *  Contiene un objeto tipo pasto y puede contener un objeto tipo animal
 */
class Celda {
    public:
        Celda();
        ~Celda();

        Celda(Oveja* o);
        Celda(Lobo* l);
        Celda(Zorro* z);
        Celda(Raton* r);

        bool hayAnimal;
        int x;
        int y;
        Pasto* pasto;
        Oveja* oveja;
        Zorro* zorro;
        Lobo* lobo;
        Raton* raton;
        
        char cualAnimal;
        char sexo;
        /**
         * @brief Esta funcion devuelve un puntero con la informacion del animal que contiene
         * 
         * @return void* puntero a void que representa un animal
         */
        void* getAnimal();
        /**
         * @brief Esta funcion inicializa un animal pidiendo memoria dinamica
         * 
         * @param x 
         * @param y 
         * @param cualAnimal 
         * @param sexo 
         */
        void setAnimal(int x, int y, char cualAnimal, char sexo);

};
