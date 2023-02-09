#include "animales.h"

Lobo::Lobo(){
    this->energiaMaxima = 100;
    this->maximoMovimientoDelAnimal = 3;
};

Lobo::~Lobo(){


};


void Lobo::comer(Celda** Ecosistema){
    int i, j; //poner ya comi en true
    this->yaComiHoy = false;
    int p, q;
    int x = Ecosistema[0][0].dimensiones[0];
    int y = Ecosistema[0][0].dimensiones[1];
    i = this->ubicacion[0];
    j = this->ubicacion[1];

        for(p = this->ubicacion[0] - 1; p<= this->ubicacion[0] + 1; p++){
            for(q = this->ubicacion[1] - 1; q<= this->ubicacion[1] + 1; q++){
                if(!(p<0 || q<0 || q>(y-1) || p>(x-1)) ){
                    if(Ecosistema[p][q].hayAnimal && Ecosistema[p][q].animal->especie != 'L' && !(yaComiHoy)){
                        Ecosistema[i][j]<Ecosistema[p][q];
                        this->yaComiHoy = true;
                        Ecosistema[p][q].hayAnimal = false;
                        delete Ecosistema[p][q].animal;
                    }
                }
            }
        }  
    if (this->energia>this->energiaMaxima){
        this->energia = this->energiaMaxima;
    }
};





//TERMINADO
void Lobo::morir(Celda** Ecosistema){
    int i, j;
    int a = this->ubicacion[0];
    int b = this->ubicacion[1];
    int x = Ecosistema[0][0].dimensiones[0];
    int y = Ecosistema[0][0].dimensiones[1];
    char miSexo = this->sexo;

    if (Ecosistema[a][b].animal->energia == 0){
        // cout <<"Soy un " << this->especie << this->sexo << " en la coordenada ("<< a << "," << b << ")" ;
        // cout << " y voy a morir porque mi energia llego a 0 " << endl;
       ~Ecosistema[a][b]; // HACIENDO DELETE 
    }

    else {



        if(miSexo == 'M'){
            for(i = this->ubicacion[0] - 1; i<= this->ubicacion[0] + 1; i++){
                for(j = this->ubicacion[1] - 1; j<= this->ubicacion[1] + 1; j++){
                    if(!(i<0 || j<0 || j>(y-1) || i>(x-1)) ){ // si la posicion es valida
                    //si hay un animal, si es un lobo, si es macho
                        if(Ecosistema[i][j].hayAnimal and Ecosistema[i][j].animal->especie =='L' and Ecosistema[i][j].animal->sexo == 'M'){
                            if (!(i==a and j==b)){
                                this->energia = 0;
                                // cout <<"Soy un " << this->especie << this->sexo << " en la coordenada ("<< a << "," << b << ")" ;
                                // cout << " y voy a morir porque un " << this->especie << this->sexo << " en la coordenada ";
                                // cout << "(" << i << "," << j << ")" << " me mato" << endl;
                                ~Ecosistema[a][b]; // HACIENDO DELETE
                                j = this->ubicacion[1] + 2;
                                i = this->ubicacion[0] + 2;
                            }
                        }
                    }
                }
            }
        }
    }
    

};

void Lobo::reporte_animal_o_planta() {
    cout << "Animal:" << this->especie<< "  ";
    cout << "Energia:" << this->energia<< "  ";
    cout << "ID: " << static_cast<void*>(this->identificador)<<" |"<< endl; 
    cout << "Sexo:" << this->sexo <<"                                   |" << endl;
};