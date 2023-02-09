/**
 * @brief Este es el archivo cabecera de las funciones
 * @file funciones.h
 * @author Yeison Rodriguez Pacheco B56074
 * @author Fabian Guerra Esquivel B53207
 */


#include <iostream>
#include <fstream>
#include <string>
#include <cstdlib>

#include "clases.h"

using namespace std;

/**
 * @brief Esta funcion llena una matriz de objetos celda leyendo un archivo de texto
 * y guarda en los punteros de entrada las dimensiones de la matriz
 * @param archivo archivo para leer
 * @param a filas
 * @param b columnas
 * @return Celda** retorna el puntero doble a la matriz de objetos celda
 */
Celda** llenarCeldas(string archivo, int *a, int *b);



/**
 * @brief Esta funcion libera la memoria dinamica reservada en la funcion llenarCeldas
 * @param Ecosistema puntero doble que apunta al primer elementro de la matriz de objetos celda
 */
void borrarMemoriaDinamicaDeEcosistema(Celda** Ecosistema);


/**
 * @brief Funcion que genera un reporte del ecosistema en el cual se menciona 
 * la posicion de cada animal junto con su especie y sexo
 * @param Ecosistema puntero doble que apunta al primer elementro de la matriz de objetos celda
 */
void reporte(Celda ** Ecosistema);


/**
 * @brief Esta funcion se encarga de matar animales cuando su energia llega a 0, o si dos
 * lobos machos se encuentran juntos
 * @param Ecosistema Puntero doble a Matriz de celdas
 */
void matarAnimales(Celda ** Ecosistema);


/**
 * @brief Esta funcion se encarga de poner los animales a reproducirse siemore y cuando
 * cumplan las condiciones, que es tener mas del 66% de energia, ser de distinto sexo y
 * tener espacio para el hijo que tendran
 * @param Ecosistema Puntero doble a Matriz de celdas
 */
void sexoSalvaje(Celda ** Ecosistema);


/**
 * @brief Funcion que pone los animales de la matriz Ecosistema a moverse
 * @param Ecosistema puntero doble que apunta al primer elementro de la matriz de objetos celda
 */
void ponerLosAnimalesAMoverse(Celda ** Ecosistema);


/**
 * @brief Funcion que pone los animales de la matriz Ecosistema a comer
 * @param Ecosistema puntero doble que apunta al primer elementro de la matriz de objetos celda
 */
void ponerLosAnimalesAComer(Celda ** Ecosistema);

/**
 * @brief Esta funcion se encarga de pasar un dia completo en la simulacion
 * Haciendo que los animales coman, se reproduzcan y mueran
 * @param Ecosistema 
 * @param d Cantidad de dias de la simulacion
 */
void pasarDias(Celda ** Ecosistema, int d);