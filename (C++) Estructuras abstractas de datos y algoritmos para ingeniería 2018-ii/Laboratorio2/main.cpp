
/**
 * @brief Este es el main del simulador de ecosistema
 * @file main.cpp
 * @author Yeison Rodriguez Pacheco B56074
 * @author Fabian Guerra Esquivel B53207
 * @date 2018-09-07
 */

#include "funciones.h"


int main(int argc, char** args)
{
    
     int a;
     int b;
     string archivoTexto = args[1];
     string diasDeSimulacion = args[2];
     int diasSimulacionNum = atoi(diasDeSimulacion.c_str());
    

    Celda** Ecosistema = llenarCeldas(archivoTexto, &a, &b);

    pasarDias(Ecosistema, diasSimulacionNum); //ESTO LLAMA TODAS LAS

    borrarMemoriaDinamicaDeEcosistema(Ecosistema);
    
    
    return 0;
}

