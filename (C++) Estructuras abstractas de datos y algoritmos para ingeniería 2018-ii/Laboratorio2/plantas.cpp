#include "plantas.h"
using namespace std;
Pasto::Pasto(){
this->diasParaRecuperar=3;
};

Pasto::~Pasto(){

};

void Pasto::reporte_animal_o_planta(){
    cout << "Planta:" << this->tipoPlanta << "  Energia:" << this->energia;
    cout << "  ID: " << static_cast<void*>(this->identificador)<<" |"<< endl;
    cout << "_________________________________________|"<< endl;
};


////////////////////////////////////////

Uva::Uva(){
this->diasParaRecuperar=6;
};

Uva::~Uva(){

};

void Uva::reporte_animal_o_planta(){
    cout << "Planta:" << this->tipoPlanta << "  Energia:" << this->energia;
    cout << "  ID: " << static_cast<void*>(this->identificador)<<" |"<< endl;
    cout << "_________________________________________|"<< endl;
};


////////////////////////////////////////


Zanahoria::Zanahoria(){
this->diasParaRecuperar=6;
};

Zanahoria::~Zanahoria(){

};

void Zanahoria::reporte_animal_o_planta(){
    cout << "Planta:" << this->tipoPlanta << "  Energia:" << this->energia;
    cout << "  ID: " << static_cast<void*>(this->identificador)<<" |"<< endl;
    cout << "_________________________________________|"<< endl;
};

////////////////////////////////////////

Roble::Roble(){
this->diasParaRecuperar=6;
};

Roble::~Roble(){

};

void Roble::reporte_animal_o_planta(){
    cout << "Planta:" << this->tipoPlanta << "  Energia:" << this->energia;
    cout << "  ID: " << static_cast<void*>(this->identificador)<<" |"<< endl;
    cout << "_________________________________________|"<< endl;
};

