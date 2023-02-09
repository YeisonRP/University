#include "animales.h"


Conejo::Conejo(){
    this->energiaMaxima = 25;
    this->maximoMovimientoDelAnimal = 1;
};

Conejo::~Conejo(){


};



void Conejo::comer(Celda** Ecosistema){
    int i, j; //poner ya comi en true
    this->yaComiHoy = false;
    
    int x = Ecosistema[0][0].dimensiones[0];
    int y = Ecosistema[0][0].dimensiones[1];
    i = this->ubicacion[0];
    j = this->ubicacion[1];
    if (!yaComiHoy){
        Ecosistema[i][j]^Ecosistema[i][j]; //Sobrecarga
    }
    yaComiHoy=true;
    if (this->energia>this->energiaMaxima){
        this->energia = this->energiaMaxima;
    }
};




void Conejo::reporte_animal_o_planta() {
    cout << "Animal:" << this->especie<< "  ";
    cout << "Energia:" << this->energia<< "  ";
    cout << "ID: " << static_cast<void*>(this->identificador)<<" |"<< endl; 
    cout << "Sexo:" << this->sexo <<"                                   |" << endl;
};