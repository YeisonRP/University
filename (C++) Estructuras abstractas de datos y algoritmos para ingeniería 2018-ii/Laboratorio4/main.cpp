
/**
 * @brief Este es el main del simulador de ecosistema
 * @file main.cpp
 * @author Yeison Rodriguez Pacheco B56074
 * @author Fabian Guerra Esquivel B53207
 * @date 2018-09-07
 */
#include <ctime>
#include <unistd.h>
#include <iostream>
#include <string>
#include <chrono>
#include "funciones.h"
using namespace std;
using namespace std::chrono;




void init(float x)
{
    // hace cosas: MARISOL!!!!!111oneone
    sleep((int)x);
    return;
}

void f(float x)
{
    // hace cosas: MARISOL!!!!!111oneone
    sleep((int)x);
    return;
}


void f_poly3(unsigned long long n){

    for(unsigned long long i = 0; i < n; i++ ) {
        for(unsigned long long j = 0; j < n; j++ ){
            for(unsigned long long k = 0; k < n; k++ )
            {
                i*i;
            }
        }
    }
    return;
}

void f_lineal(unsigned long long x)
{
    for (unsigned long long i=0; i < x; i++) {
        i*x;
    }
    return;
}

int main(int c, char** v)
{

     int a;
     int b;
     
    
     string archivoTexto = v[1];
     string diasDeSimulacion = v[2];
     int diasSimulacionNum = atoi(diasDeSimulacion.c_str());
    

    Celda** Ecosistema = llenarCeldas(archivoTexto, &a, &b);
    //unsigned long long x = stoull(v[1]);
    
    
    
    //time_t t0 = time(0);
    init(0);
    steady_clock::time_point t0 = steady_clock::now();
    //f(0);

    


        //cout << diasDeSimulacion << endl;
        pasarDias(Ecosistema, diasSimulacionNum); //ESTO LLAMA TODAS LAS

        borrarMemoriaDinamicaDeEcosistema(Ecosistema);



        /////////////////////       TIEMPOS

        

        steady_clock::time_point t1 = steady_clock::now();
        //time_t t1 = time(0);

        unsigned long long tiempito = duration_cast<nanoseconds>(t1-t0).count();
        //time_t tiempito = t1-t0;

        
        cout << tiempito << endl;
    
    
    return 0;
}

