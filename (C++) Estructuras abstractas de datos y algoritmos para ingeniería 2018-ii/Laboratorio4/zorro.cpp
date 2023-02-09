#include "animales.h"

Zorro::Zorro(){
    this->energiaMaxima = 50;
    this->maximoMovimientoDelAnimal = 2;
};

Zorro::~Zorro(){


};



void Zorro::comer(Celda** Ecosistema){
    int i, j; //poner ya comi en true
    this->yaComiHoy = false;
    int p, q;
    int x = Ecosistema[0][0].dimensiones[0];
    int y = Ecosistema[0][0].dimensiones[1];
    i = this->ubicacion[0];
    j = this->ubicacion[1];

    if (!yaComiHoy){
        
        if (Ecosistema[i][j].vegetal->tipoPlanta != 'U'){
            for(p = this->ubicacion[0] - 1; p<= this->ubicacion[0] + 1; p++){
                for(q = this->ubicacion[1] - 1; q<= this->ubicacion[1] + 1; q++){
                    if(!(p<0 || q<0 || q>(y-1) || p>(x-1)) ){
                        if(Ecosistema[p][q].hayAnimal && Ecosistema[p][q].animal->especie == 'C'){
                            Ecosistema[i][j]<Ecosistema[p][q];
                            Ecosistema[p][q].hayAnimal = false;
                            delete Ecosistema[p][q].animal;
                        }
                    }
                }
            }
            
        }
        if(Ecosistema[i][j].vegetal->tipoPlanta == 'U'){ 
            Ecosistema[i][j]^Ecosistema[i][j]; 
        }
    }
    if (this->energia>this->energiaMaxima){
        this->energia = this->energiaMaxima;
    }
};






void Zorro::reporte_animal_o_planta() {
    cout << "Animal:" << this->especie<< "  ";
    cout << "Energia:" << this->energia<< "  ";
    cout << "ID: " << static_cast<void*>(this->identificador)<<" |"<< endl; 
    cout << "Sexo:" << this->sexo <<"                                   |" << endl;
};