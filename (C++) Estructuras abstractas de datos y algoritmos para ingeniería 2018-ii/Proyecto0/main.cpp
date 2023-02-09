/**
 * @file main.cpp
 * @author Yeison Rodriguez, Fabian Guerra
 * @brief Este es el main del programa donde se hacen todos los llamados a las funciones creadas para generar una imagen a partir de un archivo binario
 * @version 0.1
 * @date 2018-11-07
 * 
 * @copyright Copyright (c) 2018
 * 
 */

#include "funciones.h"
#include <Magick++.h> 
using namespace Magick; 

int main(int arg, char** args){
    

      ///////////////////////////////////////////
      // Tamano del binario ///////////////////
      cout << "Tamano del binario" << endl;
      int size = sizeOfTheBinary(args[1]);
      cout << size << endl;
      ///////////////////////////////////////////


      ///////////////////////////////////////////
      ///////////// para encontrar dimensiones
      int *dimensiones = obtenerDimensiones((int)(size/3));
      int x = dimensiones[0]; //Tamano en pixels x de la imagen
      int y = dimensiones[1]; // tamano en pixels y de la imagen
      cout << "\nDimensiones de la imagen: " << endl;
      cout << x<< " x " << y << endl;
      ///////////////////////////////////////////
   
      ////////////////////////////////////////////////////
      /////////////////Creando estructura de unsigned char
      unsigned char ***matriz = creandoEstructuraDinamica( x, y);
      
      ////////////////////////////////////////////////////
      

      ////////////////////////////////////////////////////
      /////////////////Llenando estructura de bytes del binario
      llenandoEstructuraDeBytes(args[1],matriz,x,y);
      ////////////////////////////////////////////////////
      
      //generando imagen PNG
      generarImagenPNG(matriz, x, y, args[2]);

      InitializeMagick("");

      Image image; 
      image.read(args[2]);
      int i;
      for(i=2;i<arg;i++){
            image.write(args[i]);
      }
      cout << "\nSe generaron " << (arg - 2) << " imagenes"<< endl; 
      //liberando memoria dinamica
      borrandoEstructuraDinamica(matriz, x, y);
      cout << "\nEl programa ha terminado\n" << endl;
      return 0;
}

