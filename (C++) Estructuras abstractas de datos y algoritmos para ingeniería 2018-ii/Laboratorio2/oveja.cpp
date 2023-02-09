#include "animales.h"

Oveja::Oveja(){
    this->energiaMaxima = 75;
    this->maximoMovimientoDelAnimal = 2;
};

Oveja::~Oveja(){

};



void Oveja::comer(Celda** Ecosistema){
     int i, j; //poner ya comi en true
    this->yaComiHoy = false;
    
    int x = Ecosistema[0][0].dimensiones[0];
    int y = Ecosistema[0][0].dimensiones[1];
    i = this->ubicacion[0];
    j = this->ubicacion[1];
    //Enunciado no queda claro si las ovejas pueden comer uvas o zanahorias -> suponiendo que si:
    if(!yaComiHoy){
        Ecosistema[i][j]^Ecosistema[i][j];
    }
    yaComiHoy = true;
    if (this->energia>this->energiaMaxima){
        this->energia = this->energiaMaxima;
    }
    
};



void Oveja::reporte_animal_o_planta() {
    cout << "Animal:" << this->especie<< "  ";
    cout << "Energia:" << this->energia<< "  ";
    cout << "ID: " << static_cast<void*>(this->identificador)<<" |"<< endl; 
    cout << "Sexo:" << this->sexo <<"                                   |" << endl;
};