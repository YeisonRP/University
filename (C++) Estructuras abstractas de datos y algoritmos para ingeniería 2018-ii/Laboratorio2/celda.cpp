
#include "animales.h"



//TERMINADO:
Celda::Celda(){

};

Celda::Celda(const Celda& orig){

};


//TERMINADO:
Celda::~Celda(){
    if(this->hayAnimal){delete this->animal;} // borrando la memoria dinamica del animal, si es que la hay
    delete this->vegetal; // siempre se borra el vegetal
};


//TERMINADO:
void Celda::setAnimal(int x, int y, char cualAnimal, char sexo, int energia){
    Animal *animal;




    if(cualAnimal == 'O'){animal = new Oveja;}
    if(cualAnimal == 'L'){animal = new Lobo;}
    if(cualAnimal == 'Z'){animal = new Zorro;}
    if(cualAnimal == 'C'){animal = new Conejo;}

    //inicializando animal en Celda
    this->hayAnimal = true;

    //inicializando animal que esta contenido en celda
    this->animal = animal;
    this->animal->energia = energia;
    this->animal->especie = cualAnimal;
    this->animal->sexo = sexo;
    this->animal->identificador = this->animal;
    this->animal->ubicacion[0] = x;
    this->animal->ubicacion[1] = y;
    this->animal->yaHizoReproduccionHoy = false;
    this->animal->yaMeMoviHoy = false;
    
};

//TERMINADO:
void Celda::setAnimal(int x, int y, char cualAnimal, char sexo, int energia, Animal* animalito){
   
    
    this->hayAnimal = true;

    //inicializando animal que esta contenido en celda
    this->animal = animalito;
    this->animal->energia = energia;
    this->animal->especie = cualAnimal;
    this->animal->sexo = sexo;
    this->animal->identificador = this->animal;
    this->animal->ubicacion[0] = x;
    this->animal->ubicacion[1] = y;
    this->animal->yaHizoReproduccionHoy = false;
    this->animal->yaMeMoviHoy = false;
    
};


//TERMINADO:
void Celda::setPlanta(int x, int y, char cualPlanta, int energiaPlanta){
    Vegetal* vegetal;

    if(cualPlanta == 'P'){vegetal = new Pasto;}
    if(cualPlanta == 'U'){vegetal = new Uva;}
    if(cualPlanta == 'Z'){vegetal = new Zanahoria;}
    if(cualPlanta == 'R'){vegetal = new Roble;}

    
    this->vegetal = vegetal; // puntero a vegetal

    this->vegetal->energia = energiaPlanta; //NO SE CUANTO ERA, Se puede cambiar
    this->vegetal->contadorDeDias = 0;  //inicializando parametros del vegetal
    this->vegetal->tipoPlanta = cualPlanta;
    this->vegetal->ubicacion[0] = x;
    this->vegetal->ubicacion[1] = y;
    this->vegetal->identificador = this->vegetal;
};

void Celda::operator~(){
    delete this->animal;
    this->hayAnimal = false;
}

Animal* Celda::operator*(const Celda& celdita){ 
    Animal* animal;
    if(this->animal->especie == 'O'){animal = new Oveja;}
    if(this->animal->especie == 'L'){animal = new Lobo;}
    if(this->animal->especie == 'Z'){animal = new Zorro;}
    if(this->animal->especie == 'C'){animal = new Conejo;}

    this->animal->yaHizoReproduccionHoy = true;
    celdita.animal->yaHizoReproduccionHoy = true;

    return animal;
};



void Celda:: operator<(const Celda& celdita){
    int i = this->coordenadas[0];
    int j = this->coordenadas[1];
    int p = celdita.coordenadas[0];
    int q = celdita.coordenadas[1];
    if(!this->animal->yaComiHoy){
        if (celdita.animal->especie == 'C'){
            this->animal->energia+=2;
            this->animal->yaComiHoy = true;
            cout << "Soy un " << this->animal->especie << " en (" << i << "," << j << ") y me voy a comer un ";
            cout << celdita.animal->especie << " que se encuentra en (" << p << "," << q << ")" << endl;
            
        };
        if (this->animal->especie == 'L'){
            if (celdita.animal->especie == 'O'){
                this->animal->energia+=10;
                this->animal->yaComiHoy = true;
            cout << "Soy un " << this->animal->especie << " en (" << i << "," << j << ") y me voy a comer un ";
            cout << celdita.animal->especie << " que se encuentra en (" << p << "," << q << ")" << endl;
            }
            if (celdita.animal->especie == 'Z'){
                this->animal->energia+=5;
                this->animal->yaComiHoy = true;
            cout << "Soy un " << this->animal->especie << " en (" << i << "," << j << ") y me voy a comer un ";
            cout << celdita.animal->especie << " que se encuentra en (" << p << "," << q << ")" << endl;
            }
        }
    }
    
}

void Celda:: operator^(const Celda&celdita){
    int i = this->coordenadas[0];
    int j = this->coordenadas[1];
    switch (this->animal->especie){
        case 'O':
            if (celdita.vegetal->tipoPlanta != 'R'){
                if(celdita.vegetal->energia>10){
                    celdita.vegetal->energia-=10;
                    this->animal->energia += 10;
            cout << "Soy un" << this->animal->especie  << " que esta en ("<< i << "," << j << ") y me voy a comer un poquito de la planta de tipo ";
            cout << celdita.vegetal->tipoPlanta << " que esta sobre mi" << endl;
                }else {
                    this->animal->energia += celdita.vegetal->energia;
                    celdita.vegetal->energia = 0;
            cout << "Soy un" << this->animal->especie  << " que esta en ("<< i << "," << j << ") y me voy a comer un poquito de la planta de tipo ";
            cout << celdita.vegetal->tipoPlanta << " que esta sobre mi" << endl;

                }
            }

            break;

        case 'Z':
            if (celdita.vegetal->tipoPlanta == 'U'){
                if(celdita.vegetal->energia>10){
                    celdita.vegetal->energia-=10;
                    this->animal->energia += 10;
            cout << "Soy un" << this->animal->especie  << " que esta en ("<< i << "," << j << ") y me voy a comer un poquito de la planta de tipo ";
            cout << celdita.vegetal->tipoPlanta << " que esta sobre mi" << endl;

                }else {
                    this->animal->energia += celdita.vegetal->energia;
                    celdita.vegetal->energia = 0;
            cout << "Soy un" << this->animal->especie  << " que esta en ("<< i << "," << j << ") y me voy a comer un poquito de la planta de tipo ";
            cout << celdita.vegetal->tipoPlanta << " que esta sobre mi" << endl;
                }
            }

            break;
        case 'C':
            if (celdita.vegetal->tipoPlanta == 'Z'){
                if(celdita.vegetal->energia>20){
                    celdita.vegetal->energia-=20;
                    this->animal->energia += 20;
                }else {
                    this->animal->energia += celdita.vegetal->energia;
                    celdita.vegetal->energia = 0;
                }
            cout << "Soy un" << this->animal->especie  << " que esta en ("<< i << "," << j << ") y me voy a comer un poquito de la planta de tipo ";
            cout << celdita.vegetal->tipoPlanta << " que esta sobre mi" << endl;
            }
            if (celdita.vegetal->tipoPlanta == 'P' || celdita.vegetal->tipoPlanta == 'U'){
                if(celdita.vegetal->energia>10){
                    celdita.vegetal->energia-=10;
                    this->animal->energia +=10;
                }else {
                    this->animal->energia += celdita.vegetal->energia;
                    celdita.vegetal->energia = 0;
                }
            cout << "Soy un" << this->animal->especie  << " que esta en ("<< i << "," << j << ") y me voy a comer un poquito de la planta de tipo ";
            cout << celdita.vegetal->tipoPlanta << " que esta sobre mi" << endl;
            }
            break;
        default:
            break;
    }
}
