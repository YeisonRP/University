#include <iostream>
#include <string>
#include <stdio.h>
#include <math.h>
using namespace std;

class des{ 
  public:
	des();
	~des();
   // long long int encriptar(long long int llave, long long int texto)
 // private:

    /**
     * @brief Get the Byte object
     * 
     * @param longitud 
     * @param posicion 
     * @param bytes 
     * @return long long int 
     */

    /**
     * @brief Obtiene un bit en la posicion especificada
     * @param longitud longitud de la llave de bits
     * @param posicion posicion del bit a obtener
     * @param bytes llave donde se saca el bit
     * @return long long int retorna el bit
     */
    long long int getByte(int longitud, int posicion, long long int bytes);	

    /**
     * @brief Coloca un bit en la posicion que se indique
     * 
     * @param longitud longitud de la llave donde se quiere colocar el bit
     * @param posicion posicion en la que va el bit (izq a derecha)
     * @param bytes Arreglo donde se ingresa el bit
     * @param bit bit a colocar
     */
    void setByte(int longitud, int posicion, long long int &bytes, long long int bit);

    /**
     * @brief FUncion que permuta una llave a partir de un arreglo que se pasa como parametro,
     * 
     * @param arregloPermutar Arreglo con el cual se desea realizar la permutacion
     * @param longitudArreglo Longitud de arreglo con el cual se desea realizar la permutacion
     * @param llaveAPermutar Llave a permutar
     * @param longitudLLaveApermutar Longitud de la llave a permutar
     * @param longitudLlavePermutada Longitud de la llave permutada que se retornara
     * @return long long int retorna la llaver permutada
     */
    long long int permutar(int *arregloPermutar, int longitudArreglo, long long int llaveAPermutar, int longitudLLaveApermutar,int longitudLlavePermutada );

    /**
     * @brief Genera 16 llaves ya permutadas a partir de un C_0 y D_0
     * 
     * @param arregloLlaves donde se guardaran las llaves permutadas y procesadas
     * @param C_0 mitad de una llave izq
     * @param D_0 mitad de una llave der
     */
    void generando16Llaves(long long int *arregloLlaves, long long int C_0, long long int D_0 );

    // 
    /**
     * @brief Funcion que calcula el numero S de una respectiva caja. Utilizado para encriptar
     * Funcion basada en : https://github.com/micromin/Data-Encryption-Standard/blob/master/DES.cpp
     * @param num numero de 1 a 8 de las cajas S
     * @param fila Filas
     * @param columna Columnas
     * @return long long int retorna el numero de la caja S
     */
    long long int S_function(long long int num,long long int fila,long long int columna);

    /**
     * @brief Funcion que calcula f(R_n-1,K_n), parte de encriptacion del mensaje
     * 
     * @param R_n_1 Parametro calculado a partir del mensaje
     * @param K_n Parametro calculado a partir de la llave
     * @return long long int retorna la funcion f(R_n-1,K_n)
     */
    long long int f_function(const long long int R_n_1,const long long int K_n);

    /**
     * @brief Funcion que se encarga de encriptar un mensaje
     * 
     * @param llaves 16 llaves generadas a partir de la llave original
     * @param R_0 mitad derecha de la permutacion del mensaje
     * @param L_0 mitad izquierda de la permutacion del mensaje
     * @return long long int 
     */
    long long int encriptarConLLaves(long long int *llaves, long long int R_0, long long int L_0);


    long long int encriptar(string TextoAEncriptar,string llaveParaEncriptar);
};
