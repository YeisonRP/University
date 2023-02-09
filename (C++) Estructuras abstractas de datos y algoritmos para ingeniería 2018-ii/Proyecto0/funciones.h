/**
 * @file funciones.h
 * @author Yeison Rodriguez, Fabian Guerra
 * @brief Este es el archivo cabecera para las funciones creadas en este proyecto
 * @version 0.1
 * @date 2018-11-07
 * 
 * @copyright Copyright (c) 2018
 * 
 */

#include <iostream>
#include <fstream>
#include <string>
#include <cstdlib>

using namespace std;

/**
 * @brief Funcion que se encarga de encontrar el tamaño en bytes del binario
 * 
 * @param nombreArchivo Es el nombre del archivo binario del cual se quiere calcular el tamano
 * @return int Valor en bytes del binario
 */
int sizeOfTheBinary(const char * nombreArchivo);


/**
 * @brief Funcion que llena la estructura de bytes a partir del binario ingresado como parametro
 * 
 * @param nombreArchivo Nombre del archivo binario
 * @param bytesTotales Bytes totales del archivo binario
 * @param X Dimension x de la imagen en pyxels (tres bytes)
 * @param Y Dimension y de la imagen en pyxels (tres bytes)
 */
void llenandoEstructuraDeBytes(const char * nombreArchivo, unsigned char ***matrizCubica, int X, int Y);



/**
 * @brief Esta funcion crea una matriz de 3 dimensiones de unsigned chars
 * 
 * @param nombreArchivo 
 * @param X tamano x de la matriz
 * @param Y tamano y de la matriz
 * @return unsigned char*** retorna el puntero triple a la matriz
 */
unsigned char *** creandoEstructuraDinamica(int X, int Y);


/**
 * @brief Borrando la memoria dinamica de la matriz de unsigned char
 * 
 * @param matrizCubica puntero triple a la matriz cubica
 * @param X tamano x de la matriz
 * @param Y tamano y de la matriz
 */
void borrandoEstructuraDinamica(unsigned char *** matrizCubica, int X, int Y);


/**
 * @brief Esta funcion imprime la matriz de chars
 * 
 * @param matrizCubica puntero triple a la matriz cubica
 * @param X tamano x de la matriz
 * @param Y tamano y de la matriz
 */
void imprimirMatrizTriple(unsigned char *** matrizCubica, int X, int Y);

/**
 * @brief  Esta funcion se encarga de generar una imagen en formato png con ayuda de png++
 * 
 * @param matrizCubica puntero triple a la matriz cubica
 * @param X tamano x de la matriz
 * @param Y tamano y de la matriz
 * @param nombreImagenSAlida Nombre de la imagen de salida en formato png
 */
void generarImagenPNG(unsigned char *** matrizCubica, int X, int Y,  const char * nombreImagenSAlida);



/**
 * @brief Encuentra la dimension de la imagen que se generara a partir del tamano del binario
 * 
 * @param tamano tamaño en bytes del binario
 */
int *obtenerDimensiones(int tamano);


