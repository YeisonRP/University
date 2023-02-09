#include "clases.h"


Animal::Animal(){

};

Animal::Animal(const Animal& orig){

};

Animal::~Animal(){ //verigicar si hay que ponerlo virtual aqui o qu[e]


};


void Animal::morir(Celda** Ecosistema){
    int i = this->ubicacion[0];
    int j = this->ubicacion[1];

    if (Ecosistema[i][j].animal->energia == 0){
        // cout <<"Soy un " << this->especie << this->sexo << " en la coordenada ("<< i << "," << j << ")" ;
        // cout << " y voy a morir porque mi energia llego a 0 " << endl;
        ~Ecosistema[i][j] ;
    }
};

//FALTA VERIFICAR CON UN IF SI EL ROBLE ESTA EN SU MAXIMO
void Animal::reproducirse(Celda** Ecosistema){
    
    int i, j;
    int a, b;
    int energiaMax=this->energiaMaxima;
    int x = Ecosistema[0][0].dimensiones[0];
    int y = Ecosistema[0][0].dimensiones[1];
    bool hayEspacio = false;
    char miSexo = this->sexo;
    char animal = this->especie;
    char sexoOpuesto;
    char sexo;
    //int rand();
    
    if(rand()%2 == 0){
        sexo = 'M';
    } else {sexo = 'H';};
    
    
    if(miSexo == 'M'){
        sexoOpuesto = 'H';
    }
    if(miSexo == 'H'){
        sexoOpuesto = 'M';
    }
   
    for(i = this->ubicacion[0] - 1; i<= this->ubicacion[0] + 1; i++){
        for(j = this->ubicacion[1] - 1; j<= this->ubicacion[1] + 1; j++){
            if(!(i<0 || j<0 || j>(y-1) || i>(x-1) ) and !(hayEspacio) ){ // faltaba un parentesis
                if(!(Ecosistema[i][j].hayAnimal)){
                    // si no hay un roble con toda la energia:
                    if(!(Ecosistema[0][0].vegetal->tipoPlanta == 'R' and (Ecosistema[0][0].vegetal->energia == Ecosistema[0][0].vegetal->energiaMax))){
                        hayEspacio = true;
                        a = i; 
                        b = j;
                    }

                    
                    
                }  // En este for se recorren todos los espacios adyacentes para verificar si hay espacio para reproducirse
                    // Se guarda en a,b el espacio donde se va a reproducir
                    
            }  
        }
    } // si

    
        for(i = this->ubicacion[0] - 1; i<= this->ubicacion[0] + 1; i++){
            for(j = this->ubicacion[1] - 1; j<= this->ubicacion[1] + 1; j++){
                if(!(i<0 || j<0 || j>(y-1) || i>(x-1)) ){
                  
                    if(!(this->yaHizoReproduccionHoy)){  // verifica que no se haya reproducido hoy
                           
                        if(Ecosistema[i][j].hayAnimal & hayEspacio){ //si hay espacio y si hay un animal
                            if(Ecosistema[i][j].animal->especie == this->especie){ // verifica que haya otro animal de la misma especie
                                if (Ecosistema[i][j].animal->sexo == sexoOpuesto){ //del sexo opuesto


                                    if (this->energia >= (int)((this->energiaMaxima)*0.66) and Ecosistema[i][j].animal->energia>=(int)((this->energiaMaxima)*0.66) and !(Ecosistema[i][j].animal->yaHizoReproduccionHoy)){ //que ambos tengan energia suficiente

                                                    // cout << "Soy un/una (" << this->especie << ") y estoy en (" << this->ubicacion[0] << "," <<  this->ubicacion[1] << ") y me voy a reproducir con un/una (" << this->especie << ") que esta en la coordenada (" << i << "," << j << ")"<< endl;
                                                    // cout << "Nacio un nuevo animal tipo (" << this->especie << ") y esta en la coordenada (" << a << "," <<  b << ")" << endl;
                                                    //ANIMAL NUEVO CON SOBRECARGA DE *
                                                 
                                                    Animal* animalito = Ecosistema[i][j] * Ecosistema[this->ubicacion[0]][this->ubicacion[1]]; //Sobrecarga


                                                    Ecosistema[a][b].setAnimal(a,b,animal,sexo,energiaMax,animalito); // animal nuevo
                                                    Ecosistema[a][b].animal->yaHizoReproduccionHoy = true; // animal nuevo ya se reprodujo
                                                  // this->yaHizoReproduccionHoy = true; // uno de los animales ya se reprodujo
                                                 //   Ecosistema[i][j].animal->yaHizoReproduccionHoy = true;  // el otro de los animales //cambie Ecosistema[a][b] por Ecosistema[i][j]
                                                    
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    

}

void Animal::mover(Celda** Ecosistema){
    int i, j;
    int x = Ecosistema[0][0].dimensiones[0];
    int y = Ecosistema[0][0].dimensiones[1];
    int movMax = this->maximoMovimientoDelAnimal;

    for(i = this->ubicacion[0] - movMax; i<= this->ubicacion[0] + movMax; i++){
        for(j = this->ubicacion[1] - movMax; j<= this->ubicacion[1] + movMax; j++){
            if(!(i<0 || j<0 || j>(y-1) || i>(x-1)) ){
                if(!(Ecosistema[0][0].vegetal->tipoPlanta == 'R' and (Ecosistema[0][0].vegetal->energia == Ecosistema[0][0].vegetal->energiaMax))){ 

                    if(!(Ecosistema[i][j].hayAnimal) & (this->yaMeMoviHoy == false)){ // si no hay un animal y si no me he movido hoy
                
                
                
                        Ecosistema[i][j].animal = Ecosistema[this->ubicacion[0]][this->ubicacion[1]].animal; //copiando puntero
                        Ecosistema[i][j].hayAnimal = true;

                        Ecosistema[this->ubicacion[0]][this->ubicacion[1]].hayAnimal = false;
                        //reporte en consola
                        //cout << "Soy un (" << Ecosistema[i][j].animal->especie << ") y me movi de (" << this->ubicacion[0] << "," << this->ubicacion[1]  << ") a (" << i << "," << j << ")" << endl;
                        
                        //poniendo las direcciones del animal de nuevo donde van
                        Ecosistema[i][j].animal->ubicacion[0] =  i;
                        Ecosistema[i][j].animal->ubicacion[1] =  j;

                        this->yaMeMoviHoy = true;
                        
                        i = this->ubicacion[0] + movMax + 1; //para que termine
                        j = this->ubicacion[1] + movMax + 1; //para que termine
                    }
                }
            }
        }
    }
    
 
};

void Animal::resetStats(){
    this->yaHizoReproduccionHoy = false;
    this->yaMeMoviHoy = false ;
    this->yaComiHoy = false;
};



