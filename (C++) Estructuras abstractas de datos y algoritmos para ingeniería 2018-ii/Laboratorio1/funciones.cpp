/**
 * @brief Este es el codigo correspondiente de las funciones del programa
 * @file funciones.cpp
 * @author Yeison Rodriguez Pacheco B56074
 * @author Fabian Guerra Esquivel B53207
 * @author Christopher Rodríguez Zúñiga, B66150
 * @date 2018-09-07
 */


#include "funciones.h"


//FUNCION TERMINADA

Celda** llenarCeldas(string archivo, int *a, int *b){

    char animal;
    char sexo;
    int x;
    int y;
    int energy;
    int controlador = 0; 

    //abriendo archivo
    ifstream inputFile;
    inputFile.open (archivo);

    if (!inputFile) {
        cerr << "No se pudo abrir el archivo" << endl;
    }

    string lectura;
    string tamano[2];
    int dimensiones[2];

    inputFile >> tamano[0];
    dimensiones[0] = atoi(tamano[0].c_str());
    inputFile >> tamano[1];
    dimensiones[1] = atoi(tamano[1].c_str());

    *a = dimensiones[0];
    *b = dimensiones[1];
  
    int i = 0;

    Celda** Ecosistema;
    Ecosistema = new Celda*[dimensiones[0]];
    for(i = 0; i < dimensiones[0]; i++ ){
        Ecosistema[i] = new Celda[dimensiones[1]];
    }

    while (inputFile >> lectura) {

        if (controlador == 0){
          x = atoi(lectura.c_str());
          inputFile >> lectura;
        } 


        y = atoi(lectura.c_str());
        inputFile >> lectura;

        energy = atoi(lectura.c_str());
        inputFile >> lectura;

        animal = 0;
        sexo = 0;
        

        if ((lectura[0] == 'O') || (lectura[0] == 'L') || (lectura[0] == 'Z') || (lectura[0] == 'R')  ){
            animal = lectura[0];
            sexo = lectura[1];
            controlador = 0;

            //seteando el animal
            Ecosistema[x][y].setAnimal(x,y,animal,sexo);
        } 
        else{
          controlador = 1;
        }

        //llenando celda con coordenadas x,y
        Ecosistema[x][y].x = x;
        Ecosistema[x][y].y = y;
        


    if(controlador == 1){x = atoi(lectura.c_str()); }
    }

    inputFile.close();

    return Ecosistema;
}
//FUNCION TERMINADA

void borrarMemoriaDinamicaDeEcosistema(Celda** Ecosistema, int x, int y){
    int i = 0;
    int j = 0;

    for(i = 0; i < y; i++){
      delete[]  Ecosistema[i];
    }
    
    delete[] Ecosistema;

}

//FUNCION TERMINADA

void reporte(Celda ** Ecosistema, int x, int y){
    cout << endl;
    int i;
    int j;

    for (i=0;i<x;i++){

        for(j = 0; j<y; j++){
            //cout << "coordenada:";
            cout << "_________________________________________"<< endl; 
            cout << "(" << Ecosistema[i][j].x << "," << Ecosistema[i][j].y <<  ")" << "                                    |"<<endl;
            if(Ecosistema[i][j].hayAnimal){
                cout << "Animal:" << Ecosistema[i][j].cualAnimal<< "  ";
                if (Ecosistema[i][j].cualAnimal == 'L'){
                    cout << "Energia:" << Ecosistema[i][j].lobo->energia<< "  ";
                    cout << "ID: " << static_cast<void*>(Ecosistema[i][j].lobo->identificador)<<"      |"<< endl;
                }
                if (Ecosistema[i][j].cualAnimal == 'Z'){
                    cout << "Energia:" << Ecosistema[i][j].zorro->energia<< "  ";
                    cout << "ID: " << static_cast<void*>(Ecosistema[i][j].zorro->identificador)<<"      |"<< endl;
                }
                if (Ecosistema[i][j].cualAnimal == 'O'){
                    cout << "Energia:" << Ecosistema[i][j].oveja->energia<< "  ";
                    cout << "ID: " << static_cast<void*>(Ecosistema[i][j].oveja->identificador)<<"      |"<< endl;
                }
                if (Ecosistema[i][j].cualAnimal == 'R'){
                    cout << "Energia:" << Ecosistema[i][j].raton->energia<< "  ";
                    cout << "ID: " << static_cast<void*>(Ecosistema[i][j].raton->identificador)<<"      |"<< endl;
                }
                cout << "Sexo:" << Ecosistema[i][j].sexo <<"                                   |" << endl;
            }
            else{cout << "Animal: Vacio" << "                |"<< endl;}
            cout << "energia del pasto: " << Ecosistema[i][j].pasto->energia << "                    |"<<endl;
            cout << "_________________________________________|"<< endl;
        }
        
    }
}

//FUNCION TERMINADA

void ponerLosAnimalesAMoverse(Celda ** Ecosistema, int a, int b){

    int i;
    int j;
    for(i = 0; i < a; i++){
        for(j = 0; j < b; j++){

            if(Ecosistema[i][j].hayAnimal){ 
                    
                    void* animal = Ecosistema[i][j].getAnimal();
                    
                    switch(Ecosistema[i][j].cualAnimal) {
                        case 'O' :  
                        {
                            Oveja* O = (Oveja*)animal;
                            O->mover(Ecosistema,a,b);
                            break;
                        }
                            

                        case 'L' :
                        {    
                            Lobo* L = (Lobo*)animal;
                            L->mover(Ecosistema,a,b);
                            break;
                        }

                        case 'Z' : 
                        {
                            Zorro* Z = (Zorro*)animal;
                            Z->mover(Ecosistema,a,b);
                            break;
                        }

                        case 'R' :  
                        {
                            Raton* R = (Raton*)animal;
                            R->mover(Ecosistema,a,b);
                            break;
                        }
                        /*default: cout << "DERP" << endl;
                        break;*/

                    } 
            }
        }
    }// cuando termine el dia poner en false los yaMeMoviHoy

}


//FUNCION TERMINADA

void ponerLosAnimalesAComer(Celda ** Ecosistema, int a, int b){
   int i, j;
    for(i = 0; i < a; i++){
        for(j = 0; j < b; j++){

            if(Ecosistema[i][j].hayAnimal){ // si hay un animal
                    
                void* animal = Ecosistema[i][j].getAnimal(); //obtengo el puntero void del animal
                switch(Ecosistema[i][j].cualAnimal) {
                        case 'O' :  
                            Ecosistema[i][j].oveja->comer(Ecosistema[i][j].pasto); //listo
                            break;
                        case 'L' :  
                            Ecosistema[i][j].lobo->comer(Ecosistema,a,b); //listocout << "HOLA" << endl;
                            break;
                        case 'Z' :  
                            Ecosistema[i][j].zorro->comer(Ecosistema,a,b); //listo
                            break;
                        case 'R' :  
                            Ecosistema[i][j].raton->comer(Ecosistema[i][j].pasto); //listo
                            break;
                    default:
                        cout << " error " << endl;
                        break;

                    }
                  

            }
        }
    }
}



void sexoSalvaje(Celda ** Ecosistema, int a, int b){
    int i, j;
    for(i = 0; i < a; i++){
        for(j = 0; j < b; j++){
            
            if(Ecosistema[i][j].hayAnimal){ // si hay un animal
                    
                
                switch(Ecosistema[i][j].cualAnimal) {
                        case 'O' :  
                          {  Ecosistema[i][j].oveja->reproducirse(Ecosistema, a, b);
                            break;}
                        case 'L' :  
                           { Ecosistema[i][j].lobo->reproducirse(Ecosistema, a, b);
                            break;}
                        case 'Z' :  
                            {Ecosistema[i][j].zorro->reproducirse(Ecosistema, a, b);
                            break;}
                        case 'R' :  
                        {
                            Ecosistema[i][j].raton->reproducirse(Ecosistema, a, b);
                            break;
                        }
                    default:
                        cout << " error " << endl;
                        break;

                    }

            }
        }
    }
}

void matarAnimales(Celda ** Ecosistema, int a, int b){
    int i, j;
    for(i = 0; i < a; i++){
        for(j = 0; j < b; j++){

            if(Ecosistema[i][j].hayAnimal){ // si hay un animal
                    
                
                switch(Ecosistema[i][j].cualAnimal) {
                        case 'O' :
                            Ecosistema[i][j].oveja->morir(Ecosistema);
                            break;
                        case 'L' :  
                            Ecosistema[i][j].lobo->morir(Ecosistema, a,b);
                            break;
                        case 'Z' :  
                            Ecosistema[i][j].zorro->morir(Ecosistema);
                            break;
                        case 'R' :  
                        {
                            Ecosistema[i][j].raton->morir(Ecosistema);
                            break;
                        }
                    default:
                        cout << " error " << endl;
                        break;

                    }

            }
        }
    }
}


void pasarDias(Celda ** Ecosistema, int a, int b, int d){
    int k;
    for(k = 0; k < d; k++){

        cout << "****************************************************************************************************" << endl;
        cout << "****************************************************************************************************" << endl;
        cout << "****************************************************************************************************" << endl;
        cout << "*******************************************DIA NUMERO " << k + 1 << "*********************************************" << endl;
        cout << "****************************************************************************************************" << endl;
        cout << "****************************************************************************************************" << endl;
        cout << "****************************************************************************************************" << endl;
        /*****************/
        cout << endl;
        cout << "Posicion inicial: ";
        reporte(Ecosistema,a,b);
        cout << endl;
        cout << "A continuacion se presenta el reporte de cada animal que se movio: " << endl;
        ponerLosAnimalesAMoverse(Ecosistema, a, b);
        cout << endl;
        cout << "Y ahora se presenta el mapa del ecosistema resultante despues del movimiento:";
        reporte(Ecosistema,a,b);
        /*****************/

        /*****************/
        cout << endl;
        cout << "despues de comer: " << endl;
        ponerLosAnimalesAComer(Ecosistema,a,b);
        /*****************/
        
        /*****************/

        
        cout << endl;
        cout << "despues de reproducirse: " << endl;
        sexoSalvaje(Ecosistema, a, b);
        cout << endl;
        cout << "Y ahora se presenta el mapa del ecosistema resultante despues de la reproduccion:";
        reporte(Ecosistema,a,b);
        /*****************/

        
        /*****************/
        
        cout << endl;
        cout << "despues de morir: " << endl;
        matarAnimales(Ecosistema,a,b);

        cout << endl;
        cout << "Y ahora se presenta el mapa del ecosistema resultante despues de llamar la funcion morir:";
        reporte(Ecosistema,a,b);
        /*****************/


        int i, j;
        for(i = 0; i < a; i++){
            for(j = 0; j < b; j++){
                Ecosistema[i][j].pasto->contadorDeDias +=1;
                if(Ecosistema[i][j].pasto->contadorDeDias%3 == 0){
                Ecosistema[i][j].pasto->recuperarEnergiaDelSol();
                }
                if(Ecosistema[i][j].hayAnimal){ // si hay un animal
                    
                    switch(Ecosistema[i][j].cualAnimal) {
                            case 'O' : { 
                                Ecosistema[i][j].oveja->energia = (int)(0.95*(Ecosistema[i][j].oveja->energia));
                                Ecosistema[i][j].oveja->resetStats();
                                break;} 
                            case 'L' : {  
                                Ecosistema[i][j].lobo->energia = (int)(0.95*(Ecosistema[i][j].lobo->energia));
                                Ecosistema[i][j].lobo->resetStats();
                                break;}
                            case 'Z' :  { 
                                Ecosistema[i][j].zorro->energia = (int)(0.95*(Ecosistema[i][j].zorro->energia));
                                Ecosistema[i][j].zorro->resetStats();
                                break;}
                            case 'R' :{ 
                                Ecosistema[i][j].raton->energia = (int)(0.95*(Ecosistema[i][j].raton->energia));
                                Ecosistema[i][j].raton->resetStats();
                                break;}
                        default:
                            cout << " error " << endl;
                            break;

                    }
                }
                
            }
        } 
    }
}
