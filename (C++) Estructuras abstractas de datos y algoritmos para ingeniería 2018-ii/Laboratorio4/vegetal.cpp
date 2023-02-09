#include "clases.h"

Vegetal::Vegetal(){
    this->contadorDeDias = 0;
};

Vegetal::~Vegetal(){
    
};

void Vegetal::fotosintesis(){
    if (this->contadorDeDias == this->diasParaRecuperar){
        this->energia += 5;
        this->contadorDeDias = 0;
        if (this->energia > this->energiaMax){
            this->energia = this->energiaMax;
        }
    }
    
}


