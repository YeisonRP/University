/**
 * @brief Este es el codigo correspondiente de las funciones del programa
 * @file funciones.cpp
 * @author Yeison Rodriguez Pacheco B56074
 * @author Fabian Guerra Esquivel B53207
 * @date 2018-09-07
 */


#include "funciones.h"

//Terminado
Celda** llenarCeldas(string archivo, int *a, int *b){
    char animal;
    char sexo;
    int x;
    int y;
    int energiaAnimal;
    int energiaPlanta;
    char planta;
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
    dimensiones[0] = atoi(tamano[0].c_str()); //dimesion del arreglo en x
    inputFile >> tamano[1];
    dimensiones[1] = atoi(tamano[1].c_str()); //dimension del arreglo en y

    *a = dimensiones[0];
    *b = dimensiones[1];
  
    int i = 0;

     Celda** Ecosistema; //matriz de objetos celda guardados en Puntero doble Ecosistema
    Ecosistema = new Celda*[dimensiones[0]];
    for(i = 0; i < dimensiones[0]; i++ ){
        Ecosistema[i] = new Celda[dimensiones[1]];
    }
    


    while (inputFile >> lectura) {

        if (controlador == 0){
          x = atoi(lectura.c_str()); //leyendo el primer elemento, coordenada x
          inputFile >> lectura;
        } 


        y = atoi(lectura.c_str()); //leyendo el segundo elemento, coordenada y
        inputFile >> lectura; 

        energiaPlanta = atoi(lectura.c_str()); //leyendo el tercer elemento, energia planta
        inputFile >> lectura;

        planta = lectura[0]; //leyendo el tipo de planta que es
        inputFile >> lectura;

        energiaAnimal = atoi(lectura.c_str()); //leyendo el quinto elemento, energia animal
        inputFile >> lectura;


        animal = 0;
        sexo = 0;
        if ((lectura[0] == 'O') || (lectura[0] == 'L') || (lectura[0] == 'Z') || (lectura[0] == 'C')  ){
            animal = lectura[0];
            sexo = lectura[1];
            controlador = 0;
 
            Ecosistema[x][y].setAnimal(x,y,animal,sexo,energiaAnimal);
        } 
        else{
          controlador = 1;
        }
        
        //llenando celda con coordenadas x,y
        Ecosistema[x][y].coordenadas[0] = x;
        Ecosistema[x][y].coordenadas[1] = y;        //hacer set animal y set planta
        Ecosistema[x][y].dimensiones[0] = *a; //dimension en x
        Ecosistema[x][y].dimensiones[1] = *b; //dimension en y

        //Inicializando el tipo de planta que es 
        Ecosistema[x][y].setPlanta(x, y, planta, energiaPlanta);

    if(controlador == 1){x = atoi(lectura.c_str()); }
    }

    inputFile.close();

    return Ecosistema; 
}

//Terminado
void borrarMemoriaDinamicaDeEcosistema(Celda** Ecosistema){

    int y = Ecosistema[0][0].dimensiones[1];
    int i = 0;
    
    for(i = 0; i < y; i++){
      delete[]  Ecosistema[i];
    }
    
    delete[] Ecosistema;

}

//TErminado
void reporte(Celda ** Ecosistema){
    cout << endl;
    int i;
    int j;
    int x = Ecosistema[0][0].dimensiones[0];
    int y = Ecosistema[0][0].dimensiones[1];

    for (i=0;i<x;i++){

        for(j = 0; j<y; j++){
            //cout << "coordenada:";
            cout << "_________________________________________"<< endl; 
            cout << "(" << Ecosistema[i][j].coordenadas[0] << "," << Ecosistema[i][j].coordenadas[1] <<  ")" << "                                    |"<<endl;
            if(Ecosistema[i][j].hayAnimal){
                Ecosistema[i][j].animal->reporte_animal_o_planta();
 
            }
            else{cout << "Animal: Vacio" << "                            |"<< endl;}
            Ecosistema[i][j].vegetal->reporte_animal_o_planta();
        }
        
    }
}

//Terminado
void matarAnimales(Celda ** Ecosistema){
    int i, j;
    int a = Ecosistema[0][0].dimensiones[0];
    int b = Ecosistema[0][0].dimensiones[1];

    for(i = 0; i < a; i++){
        for(j = 0; j < b; j++){

            if(Ecosistema[i][j].hayAnimal){ // si hay un animal
                Ecosistema[i][j].animal->morir(Ecosistema);
            }

        }
    }
    
}

//Terminado
void sexoSalvaje(Celda ** Ecosistema){
    int i, j;
    int a = Ecosistema[0][0].dimensiones[0];
    int b = Ecosistema[0][0].dimensiones[1];

    for(i = 0; i < a; i++){
        for(j = 0; j < b; j++){  

            if(Ecosistema[i][j].hayAnimal){ // si hay un animal
                Ecosistema[i][j].animal->reproducirse(Ecosistema); //// HACIENDO QUE SE REPRODUZCAN CON UNA SOBRECARGA
            }
        }
    }
}

//Terminado
void ponerLosAnimalesAMoverse(Celda ** Ecosistema){
    
   int a = Ecosistema[0][0].dimensiones[0];
   int b = Ecosistema[0][0].dimensiones[1];
   int i;
   int j;

    for(i = 0; i < a; i++){
        for(j = 0; j < b; j++){

            if(Ecosistema[i][j].hayAnimal){    
                Ecosistema[i][j].animal->mover(Ecosistema);        
            }
        }
    }// cuando termine el dia poner en false los yaMeMoviHoy

}

void ponerLosAnimalesAComer(Celda ** Ecosistema){
    int a = Ecosistema[0][0].dimensiones[0];
    int b = Ecosistema[0][0].dimensiones[1];
    int i;
    int j;

    for(i = 0; i < a; i++){
        for(j = 0; j < b; j++){

            if(Ecosistema[i][j].hayAnimal){    
                Ecosistema[i][j].animal->comer(Ecosistema);        
            }
        }
    }// cuando termine el dia poner en false los yaMeComiHoy
}

//CREO QUE YA ESTA, PERO LA HICE EN LA U ENTONCES REVISAR
void pasarDias(Celda ** Ecosistema, int d){
    int k;
    int a = Ecosistema[0][0].dimensiones[0];
    int b = Ecosistema[0][0].dimensiones[1];
    //cout << d << endl;
    for(k = 0; k < d; k++){

        // cout << "****************************************************************************************************" << endl;
        // cout << "****************************************************************************************************" << endl;
        // cout << "****************************************************************************************************" << endl;
        // cout << "*******************************************DIA NUMERO " << k + 1 << "*********************************************" << endl;
        // cout << "****************************************************************************************************" << endl;
        // cout << "****************************************************************************************************" << endl;
        // cout << "****************************************************************************************************" << endl;
        /*****************/
        //cout << endl;
        //cout << "Posicion inicial: ";
        //reporte(Ecosistema);
        //cout << endl;
        //cout << "A continuacion se presenta el reporte de cada animal que se movio: " << endl;
        ponerLosAnimalesAMoverse(Ecosistema);
        //cout << endl;
        //cout << "Y ahora se presenta el mapa del ecosistema resultante despues del movimiento:";
        //reporte(Ecosistema);
        /*****************/

        /*****************/
        //cout << endl;
        ponerLosAnimalesAComer(Ecosistema);
        //cout << endl;
        //cout << "Y ahora se presenta el mapa del ecosistema resultante despues de comer:";
        //reporte(Ecosistema);
        /*****************/
        
        /*****************/

        
        //cout << endl;
        //cout << "despues de reproducirse: " << endl;
        sexoSalvaje(Ecosistema);
        //cout << endl;
        //cout << "Y ahora se presenta el mapa del ecosistema resultante despues de la reproduccion:";
        //reporte(Ecosistema);
        /*****************/

        
        /*****************/
        
        //cout << endl;
        //cout << "despues de morir: " << endl;
        matarAnimales(Ecosistema);

        //cout << endl;
        //cout << "Y ahora se presenta el mapa del ecosistema resultante despues de llamar la funcion morir:";
        //reporte(Ecosistema);
        /*****************/

        
        int i, j;
        for(i = 0; i < a; i++){
            for(j = 0; j < b; j++){
                Ecosistema[i][j].vegetal->contadorDeDias +=1;
                Ecosistema[i][j].vegetal->fotosintesis();

                if(Ecosistema[i][j].hayAnimal){ // si hay un animal
                    
                    Ecosistema[i][j].animal->energia = (int)((Ecosistema[i][j].animal->energia)*0.95); // perdiendo el 5 de la energia los animales
                    Ecosistema[i][j].animal->resetStats(); // Reseteando stats
         
                }
                
            }
        } 
    }
}