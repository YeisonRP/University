/**
 * @file funciones.cpp
 * @author Yeison Rodriguez, Fabian Guerra
 * @brief En este archivo se implementan todas las funciones que son necesarias para crear la imagen a partir del binario
 * @version 0.1
 * @date 2018-11-07
 * 
 * @copyright Copyright (c) 2018
 * 
 */

#include "funciones.h"
#include <math.h>
#include <png++/png.hpp>
//#include <Magick++.h> 
//using namespace Magick;
using namespace png;
//TERMINADO
int sizeOfTheBinary(const char * nombreArchivo){

    ifstream binario;
    binario.open (nombreArchivo, ios::in | ios::ate | ios::binary); //abriendo el binario para lectura binaria con puntero al inicio
    
    if (!(binario.is_open())) {
        cout << "No se pudo abrir el archivo binario correctamente " << endl;
        return -1;    
    }

    streampos size;         //formato raro, pero se trata como un entero
    size = binario.tellg(); //tama;o del archivo binario en  bytes, puede convertirse a int
  
    binario.close();

    return size;
}


//TERMINADO
void llenandoEstructuraDeBytes(const char * nombreArchivo, unsigned char ***matrizCubica ,int X, int Y){
    ifstream binario;
    binario.open (nombreArchivo, ios::in | ios::ate | ios::binary); //abriendo el binario para lectura binaria con puntero al final

    if(!(binario.is_open())) {
        cout << "No se pudo abrir el archivo binario correctamente " << endl;   
    }
    streampos size = binario.tellg();       //tama;o del binario
    char * datos = new char[size];          // puntero auxiliar, se libera al final de la funcion
    binario.seekg (0, ios::beg);            //cambiando puntero al inicio del archivo
    binario.read (datos, size);             // leyendo el binario

    int i, j , k;
    int contador = 0;
    for(i = 0; i<X; i++){
        for(j = 0; j< Y; j++){
            for(k = 0; k < 3; k++){
               matrizCubica[i][j][k] = (unsigned char)datos[contador]; //algo raro esta pasando
               contador += 1;
            }
        }
    }
    binario.close();
    delete[] datos;                         //borrando puntero auxiliar de datos
}


//terminado
unsigned char *** creandoEstructuraDinamica(int X, int Y){
    int i;
    int j;
    unsigned char *** matrizCubica =  new unsigned char**[X];

    for(i = 0; i < X; i++){
        matrizCubica[i] = new unsigned char*[Y];
    }

    for(i = 0; i < X; i++){
        for(j = 0; j < Y; j++){
            matrizCubica[i][j] = new unsigned char[3];
        }
    }

    return matrizCubica;
}



//TERMINADO
void borrandoEstructuraDinamica(unsigned char *** matrizCubica, int X, int Y){
    int i;
    int j; 

    for(i = 0; i < X; i++){
        for(j = 0; j < Y; j++){
           delete[] matrizCubica[i][j];
        }
        
    }

    for(i = 0; i < X; i++){
        delete[] matrizCubica[i];
    }

    delete[] matrizCubica;

}

void imprimirMatrizTriple(unsigned char *** matrizCubica, int X, int Y){
int i, j, k;

    for(i = 0; i<X; i++){
        for(j = 0; j<Y; j++){
            for(k = 0; k < 3; k++){
               cout << (int) matrizCubica[i][j][k] << endl;
            }
        }
    }
}

// CITAR ESTA VARA https://www.nongnu.org/pngpp/doc/0.2.1/
void generarImagenPNG(unsigned char *** matrizCubica, int X, int Y, const char * nombreImagenSAlida){   

    image < rgb_pixel > image(X, Y);

    for (size_t y = 0; y < image.get_height(); ++y)
    {
        for (size_t x = 0; x < image.get_width(); ++x)
        {
            image[y][x] = rgb_pixel((int)matrizCubica[x][y][0], (int)matrizCubica[x][y][1],(int)matrizCubica[x][y][2]);

        }
    }
    image.write(nombreImagenSAlida);
}

int *obtenerDimensiones(int tamano){
    int x, y, x0, y0;
    static int dim[2];
    int newArea;
    int prevArea;

    //caso 4:3


    // Caso cuadrado:
    x = (int) sqrt(tamano);
    y = x;
    newArea = x*y;
    prevArea = newArea;
    

    //Caso relacion 4:3
    x0 = (int) 4*sqrt(tamano/12);
    y0 = (int) 3*sqrt(tamano/12);
    newArea = x0*y0;
    if(newArea>=prevArea){
        x = x0;
        y = y0;
        prevArea = newArea;
    }

    //Caso relacion 3:2
    x0 = (int) 3*sqrt(tamano/6);
    y0 = (int) 2*sqrt(tamano/6);
    newArea = x0*y0;
    if(newArea>=prevArea){
        x = x0;
        y = y0;
        prevArea = newArea;
    }

    //Caso relacion 16:9
    x0 = (int) 16*sqrt(tamano/144);
    y0 = (int) 9*sqrt(tamano/144);
    newArea = x0*y0;
    if(newArea>=prevArea){
        x = x0;
        y = y0;
        prevArea = newArea;
    }
    dim[0] = x;
    dim[1] = y;
    return dim;
    

    // intento fallido
    // static int dim0[2];
    // int coef;
    // int newArea = 0;
    // int prevArea = 0;
    // int ancho0 = (int) 2*sqrt(tamano); //inicio el for con una relacion 1:4 de la imagen
    // int anchoCuadrada = (int) sqrt(tamano); 
    // int altoCuadrada = anchoCuadrada;
    // for (int width = ancho0; width >= anchoCuadrada; width--){
    //     for(int height = (int) ancho0/4; height <= altoCuadrada; height++){
    //         newArea = width*height;
    //         if (newArea > prevArea){
    //             dim0[0] = width;
    //             dim0[1] = height;
    //         }
    //         prevArea = newArea;
    //     }
    // }
    // return dim0;
}


// void generandoImagenPNG(unsigned char *** matrizCubica, int X, int Y){
//     //DATOS PARA HACER EL PNG
//     char encabezadoPNG[16] = {137,80, 78, 71, 13, 10, 26, 10, 0, 0, 0, 13, 73, 72, 68, 82};
//     unsigned  int width  = (unsigned int)X;  // 4 bytes]
//     unsigned  int heigh  = (unsigned int)Y;  // 4 bytes]
    
//     //BLOQUE DE CODIGO QUE SIRVE PARA GIRAR LOS BITS DE WIDTH Y HEIGH YA QUE VIENEN AL REVES
//     char *ancho = new char[4];
//     char *alto = new char[4]; 
//     int j = 0;
//     for(j = 0; j < 4; j++){
//         ancho[3-j] = reinterpret_cast<char *>(&width) [j];
//         alto[3-j] = reinterpret_cast<char *>(&heigh) [j];
//     }
//     //FIN BLOQUE CODIGO
    
//      char bitDepth= 8; //byte
//      char colorType= 2; //byte
//      char CompressionMetod= 0; //byte
//      char FilterMetod= 0; //byte
//      char interlaceMetod= 0; //byte
//     //ENCABEZADO PNG

//   ofstream file ("pruebaFinal2.png", ios::in|ios::binary|ios::ate);
  
//     file.write (encabezadoPNG, 16);
//  //ESCRIBIENDO LOS DATOS
//     file.write (ancho, sizeof(width));
//     file.write (alto, sizeof(heigh));
//     file.write (&bitDepth, sizeof(bitDepth));
//     file.write (&colorType, sizeof(colorType));
//     file.write (&CompressionMetod, sizeof(CompressionMetod));
//     file.write (&FilterMetod, sizeof(FilterMetod));
//     file.write (&interlaceMetod, sizeof(interlaceMetod));
//     int i;
//     for(i = 0; i<X; i++){
//         for(j = 0; j<Y; j++){
//             file.write (reinterpret_cast<char *>(&matrizCubica[i][j]), 3);
//         }
//     }
    
    
// } 
