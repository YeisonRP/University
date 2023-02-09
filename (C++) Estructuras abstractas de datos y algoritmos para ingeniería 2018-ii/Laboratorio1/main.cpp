/**
 * @brief Este es el main del simulador de ecosistema
 * @file main.cpp
 * @author Yeison Rodriguez Pacheco B56074
 * @author Fabian Guerra Esquivel B53207
 * @author Christopher Rodríguez Zúñiga, B66150
 * @date 2018-09-07
 */

#include "funciones.h"

int main(int argc, char** args)
{
    int a;
    int b;
    string archivoTexto = args[1];
    string diasDeSimulacion = args[2];
    int diasSimulacion = atoi(diasDeSimulacion.c_str());
    

    Celda** Ecosistema = llenarCeldas(archivoTexto, &a, &b);
    cout << endl;
    cout << "Y ahora se presenta el mapa del ecosistema:";
    reporte(Ecosistema,a,b);
    
    pasarDias(Ecosistema,a,b,diasSimulacion);
    borrarMemoriaDinamicaDeEcosistema(Ecosistema,a,b);
    
    return 0;
}
