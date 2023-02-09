/**
 * @brief En este archivo se encuentra todo el codigo de los metodos de las clases
 * @file clases.cpp
 * @author Yeison Rodriguez Pacheco B56074
 * @author Fabian 
 * @author XXXXXX
 * @date 2018-09-07
 */

#include "clases.h"


//******************************************************************//
Lobo::Lobo(int x, int y, int energia, char especie,char sexo){
    this->ubicacion[0] = x;
    this->ubicacion[1] = y;
    this->energia = energia;
    this->especie = especie;
    this->sexo = sexo;
    this->yaHizoReproduccionHoy = false;
    this->identificador = this;
};

Lobo::~Lobo(){

};

void Lobo::resetStats(){
    this->yaMeMoviHoy = false;
    this->yaHizoReproduccionHoy = false;

};

/**
 * @brief Funcion que pone los lobos a comer
 * 
 * @param Ecosistema fdas
 * @param x  asdf
 * @param y  asdf
 */
void Lobo::comer(Celda ** Ecosistema, int x, int y){
    int i, j, k; //poner ya comi en true
    int controlador = 0;
    
    for(k = 0; k < 3; k++){
        for(i = this->ubicacion[0] - 1; i<= this->ubicacion[0] + 1; i++){ //filas
            for(j = this->ubicacion[1] - 1; j<= this->ubicacion[1] + 1; j++){ // columnas
                if(!(i<0 || j<0 || j>(y-1) || i>(x-1)) ){ // si se esta dentro del rango de movimientos
                    
                    if((Ecosistema[i][j].hayAnimal)){ // si hay un animal
                        if(Ecosistema[i][j].cualAnimal == 'O' && k == 0 && controlador == 0){ //si encuentro una oveja
                            // reporte en consola
                            cout << "Soy un (" << this->especie << ") que esta en (" << this->ubicacion[0] << "," << this->ubicacion[1] <<  ") y me comi un/una (" <<  Ecosistema[i][j].cualAnimal << ") que estaba en (" << i << "," << j  << ")" << endl;
                            this->energia += 10;                            //ME LA COMO ;)
                            if (this->energia > 100) {this->energia = 100;} //ME LA COMO ;)
                            Ecosistema[i][j].hayAnimal = false; // ya no hay oveja en ecosistema
                            delete Ecosistema[i][j].oveja; 
                            
                            controlador = 1;
                            k = 3;
                            int p;
                        }
                        if(Ecosistema[i][j].cualAnimal == 'Z' && k == 1 && controlador == 0){ //si encuentro una oveja
                            // reporte en consola
                            cout << "Soy un (" << this->especie << ") que esta en (" << this->ubicacion[0] << "," << this->ubicacion[1] <<  ") y me comi un/una (" <<  Ecosistema[i][j].cualAnimal << ") que estaba en (" << i << "," << j  << ")" << endl;
                            this->energia += 5;                            //ME LA COMO ;)
                            if (this->energia > 100) {this->energia = 100;} //ME LA COMO ;)
                            Ecosistema[i][j].hayAnimal = false; // ya no hay oveja en ecosistema
                            delete Ecosistema[i][j].zorro; 
                            controlador = 1;
                            k = 3;
                        }                     
                        if(Ecosistema[i][j].cualAnimal == 'R' && k == 2 && controlador == 0){ //si encuentro una oveja
                            // reporte en consola
                            cout << "Soy un (" << this->especie << ") que esta en (" << this->ubicacion[0] << "," << this->ubicacion[1] <<  ") y me comi un/una (" <<  Ecosistema[i][j].cualAnimal << ") que estaba en (" << i << "," << j  << ")" << endl;
                            cout << i <<j << endl;
                            this->energia += 2;                            //ME LA COMO ;)
                            if (this->energia > 100) {this->energia = 100;} //ME LA COMO ;)
                            Ecosistema[i][j].hayAnimal = false; // ya no hay oveja en ecosistema
                            delete Ecosistema[i][j].raton; 
                            controlador = 1;
                            k = 3;
                        } 
                    }
                }
            }
        } 
    }       
};



void Lobo::mover(Celda** Ecosistema, int x, int y){
    int i, j;

    for(i = this->ubicacion[0] - 3; i<= this->ubicacion[0] + 3; i++){
        for(j = this->ubicacion[1] - 3; j<= this->ubicacion[1] + 3; j++){
            if(!(i<0 || j<0 || j>(y-1) || i>(x-1)) ){

            if(!(Ecosistema[i][j].hayAnimal) & (this->yaMeMoviHoy == false)){
                
                
                
                Ecosistema[i][j].lobo = Ecosistema[this->ubicacion[0]][this->ubicacion[1]].lobo; //ojo
                Ecosistema[i][j].hayAnimal = true;
                Ecosistema[i][j].sexo = this->sexo;
                Ecosistema[i][j].cualAnimal = this->especie;

                Ecosistema[this->ubicacion[0]][this->ubicacion[1]].hayAnimal = false;

                //reporte en consola
                cout << "Soy un (" << Ecosistema[i][j].cualAnimal << ") y me movi de (" << this->ubicacion[0] << "," << this->ubicacion[1]  << ") a (" << i << "," << j << ")" << endl;
                
                //poniendo las direcciones del animal de nuevo donde van
                Ecosistema[i][j].lobo->ubicacion[0] =  Ecosistema[i][j].x;
                Ecosistema[i][j].lobo->ubicacion[1] =  Ecosistema[i][j].y;

                
                this->yaMeMoviHoy = true;
                


                i = this->ubicacion[0] + 2;
                j = this->ubicacion[1] + 2;
                
            }
            }
        }
    }
};

/**
 * @brief retorna el nuevo lobo
 * 
 * @param lobito 
 * @param lobita 
 * @param x 
 * @param y 
 * @return Lobo 
 */
void Lobo::reproducirse(Celda** Ecosistema, int x, int y){
    int i, j;
    int a, b;
    bool hayEspacio = false;
    char miSexo = this->sexo;
    char sexoOpuesto;
    char sexo;
    int rand();
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
            if(!(i<0 || j<0 || j>(y-1) || i>(x-1)) and !(hayEspacio) ){
                if(!(Ecosistema[i][j].hayAnimal)){
                    hayEspacio = true;
                    a = i;
                    b = j;
                    
                }  // En este for se recorren todos los espacios adyacentes para verificar si hay espacio para reproducirse
                    // Se guarda en a,b el espacio donde se va a reproducir
                    
            }  
        }
    }
    
        for(i = this->ubicacion[0] - 1; i<= this->ubicacion[0] + 1; i++){
            for(j = this->ubicacion[1] - 1; j<= this->ubicacion[1] + 1; j++){
                    if(!(i<0 || j<0 || j>(y-1) || i>(x-1)) ){
                        if(!(this->yaHizoReproduccionHoy)){
                            if(Ecosistema[i][j].hayAnimal and hayEspacio){
                                if(Ecosistema[i][j].cualAnimal == 'L'){ // verifica que haya otro raton
                                    if (Ecosistema[i][j].lobo->sexo == sexoOpuesto){ //del sexo opuesto
                                        if (this->energia >= 66 and Ecosistema[i][j].lobo->energia>=66 and !(Ecosistema[i][j].lobo->yaHizoReproduccionHoy)){ //que ambos tengan energia suficiente
                                                        cout << "Soy un/una (" << this->especie << ") y estoy en (" << this->ubicacion[0] << "," <<  this->ubicacion[1] << ") y me voy a reproducir con un/una (" << this->especie << ") que esta en la coordenada (" << i << "," << j << endl;
                                                        cout << "Nacio un nuevo animal tipo (" << this->especie << ") y esta en la coordenada (" << a << "," <<  b << ")" << endl;
                                                        Ecosistema[a][b].setAnimal(a,b,'L',sexo);
                                                        Ecosistema[a][b].lobo->yaHizoReproduccionHoy = true; // para evitar cosas raras
                                                        this->yaHizoReproduccionHoy = true;
                                                        Ecosistema[i][j].lobo->yaHizoReproduccionHoy = true;

                                        }
                                    }
                                }
                            }
                        }
                    }    
            }
        }
    
};

void Lobo::morir(Celda** Ecosistema, int x, int y){
    int i, j;
    int a = this->ubicacion[0];
    int b = this->ubicacion[1];
    char miSexo = this->sexo;
    if(miSexo == 'H'){
        for(i = this->ubicacion[0] - 1; i<= this->ubicacion[0] + 1; i++){
            for(j = this->ubicacion[1] - 1; j<= this->ubicacion[1] + 1; j++){
                if(!(i<0 || j<0 || j>(y-1) || i>(x-1)) ){
                    if(Ecosistema[i][j].hayAnimal and Ecosistema[i][j].cualAnimal=='L' and Ecosistema[i][j].lobo->sexo == 'H'){
                        if (!(i==a and j==b)){
                            this->energia = 0;
                        }
                    }
                }
            }
        }
    }
    
    
    if (Ecosistema[a][b].lobo->energia == 0){
        delete Ecosistema[a][b].lobo;
        Ecosistema[a][b].hayAnimal = false;
    }
}




//******************************************************************//

Oveja::Oveja(int x, int y, int energia, char especie,char sexo){

    this->ubicacion[0] = x;
    this->ubicacion[1] = y;
    this->energia = energia;
    this->especie = especie;
    this->sexo = sexo;
    this->yaHizoReproduccionHoy = false;
    this->identificador = this;
    
};

Oveja::~Oveja(){

};

void Oveja::resetStats(){
    this->yaMeMoviHoy = false;
    this->yaHizoReproduccionHoy = false;

};

void Oveja::comer(Pasto *pastito){
    if(pastito->energia >= 10){
        this->energia += 10;
        pastito->energia -= 10;
        }
    else {
        this->energia += pastito->energia;
        pastito->energia -= pastito->energia;
        }

   
    if (this->energia > 75) {this->energia = 75;}
     //reporte en consola
    cout << "Soy un (" << this->especie << ") que esta en (" << this->ubicacion[0] << "," << this->ubicacion[1] <<  ") y me comi el pasto en donde estoy parado " << endl;
};

void Oveja::mover(Celda** Ecosistema, int x, int y){
    int i, j;

    for(i = this->ubicacion[0] - 2; i<= this->ubicacion[0] + 2; i++){
        for(j = this->ubicacion[1] - 1; j<= this->ubicacion[1] + 1; j++){
            if(!(i<0 || j<0 || j>(y-1) || i>(x-1)) ){

            if(!(Ecosistema[i][j].hayAnimal) & (this->yaMeMoviHoy == false)){
                
                
                
                Ecosistema[i][j].oveja = Ecosistema[this->ubicacion[0]][this->ubicacion[1]].oveja; //ojo
                Ecosistema[i][j].hayAnimal = true;
                Ecosistema[i][j].sexo = this->sexo;
                Ecosistema[i][j].cualAnimal = this->especie;

                Ecosistema[this->ubicacion[0]][this->ubicacion[1]].hayAnimal = false;
                //reporte en consola
                cout << "Soy un (" << Ecosistema[i][j].cualAnimal << ") y me movi de (" << this->ubicacion[0] << "," << this->ubicacion[1]  << ") a (" << i << "," << j << ")" << endl;
                
                //poniendo las direcciones del animal de nuevo donde van
                Ecosistema[i][j].oveja->ubicacion[0] =  Ecosistema[i][j].x;
                Ecosistema[i][j].oveja->ubicacion[1] =  Ecosistema[i][j].y;

                this->yaMeMoviHoy = true;
                
                i = this->ubicacion[0] + 2;
                j = this->ubicacion[1] + 2;
                
            }
            }
        }
    }
    
 
};



 void Oveja::reproducirse(Celda** Ecosistema, int x, int y){
    int i, j;
    int a, b;
    bool hayEspacio = false;
    char miSexo = this->sexo;
    char sexoOpuesto;
    char sexo;
    int rand();
    

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
                    hayEspacio = true;
                    a = i;
                    b = j;

                    
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
                            if(Ecosistema[i][j].cualAnimal == 'O'){ // verifica que haya otro raton
                                if (Ecosistema[i][j].oveja->sexo == sexoOpuesto){ //del sexo opuesto
                                    if (this->energia >= 50 and Ecosistema[i][j].oveja->energia>=50 and !(Ecosistema[i][j].oveja->yaHizoReproduccionHoy)){ //que ambos tengan energia suficiente
                                                    
                                                    cout << "Soy un/una (" << this->especie << ") y estoy en (" << this->ubicacion[0] << "," <<  this->ubicacion[1] << ") y me voy a reproducir con un/una (" << this->especie << ") que esta en la coordenada (" << i << "," << j << ")"<< endl;
                                                    cout << "Nacio un nuevo animal tipo (" << this->especie << ") y esta en la coordenada (" << a << "," <<  b << ")" << endl;
                                                    Ecosistema[a][b].setAnimal(a,b,'O',sexo); // animal nuevo
                                                    Ecosistema[a][b].oveja->yaHizoReproduccionHoy = true; // animal nuevo ya se reprodujo
                                                    this->yaHizoReproduccionHoy = true; // uno de los animales ya se reprodujo
                                                    Ecosistema[i][j].oveja->yaHizoReproduccionHoy = true;  // el otro de los animales //cambie Ecosistema[a][b] por Ecosistema[i][j]
                                                    
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    
};


void Oveja::morir(Celda** Ecosistema){
    int i = this->ubicacion[0];
    int j = this->ubicacion[1];
    if (Ecosistema[i][j].oveja->energia == 0){
        delete Ecosistema[i][j].oveja;
        Ecosistema[i][j].hayAnimal = false;
    }
}

//******************************************************************//
Raton::Raton(int x, int y, int energia, char especie,char sexo){

    this->ubicacion[0] = x;
    this->ubicacion[1] = y;
    this->energia = energia;
    this->especie = especie;
    this->sexo = sexo;
    this->yaHizoReproduccionHoy = false;
    this->yaMeMoviHoy = false;
    this->identificador = this;
};

Raton::~Raton(){

};

void Raton::resetStats(){
    this->yaMeMoviHoy = false;
    this->yaHizoReproduccionHoy = false;

};

void Raton::comer(Pasto *pastito){
    if(pastito->energia >= 5){
        this->energia += 5;
        pastito->energia -= 5;
        }
    else {
        this->energia += pastito->energia;
        pastito->energia -= pastito->energia;
        }

    if (this->energia > 25) {this->energia = 25;}

    //reporte en consola
    cout << "Soy un (" << this->especie << ") que esta en (" << this->ubicacion[0] << "," << this->ubicacion[1] <<  ") y me comi el pasto en donde estoy parado " << endl;
};

//LISTO
void Raton::mover(Celda** Ecosistema, int x, int y){
    int i, j;

    for(i = this->ubicacion[0] - 1; i<= this->ubicacion[0] + 1; i++){
        for(j = this->ubicacion[1] - 1; j<= this->ubicacion[1] + 1; j++){
            if(!(i<0 || j<0 || j>(y-1) || i>(x-1)) ){

            if(!(Ecosistema[i][j].hayAnimal) & (this->yaMeMoviHoy == false)){
                
                
                
                Ecosistema[i][j].raton = Ecosistema[this->ubicacion[0]][this->ubicacion[1]].raton; //ojo
                Ecosistema[i][j].hayAnimal = true;
                Ecosistema[i][j].sexo = this->sexo;
                Ecosistema[i][j].cualAnimal = this->especie;

                Ecosistema[this->ubicacion[0]][this->ubicacion[1]].hayAnimal = false;
                //reporte en consola
                cout << "Soy un (" << Ecosistema[i][j].cualAnimal << ") y me movi de (" << this->ubicacion[0] << "," << this->ubicacion[1]  << ") a (" << i << "," << j << ")" << endl;
                //poniendo las direcciones del animal de nuevo donde van
                Ecosistema[i][j].raton->ubicacion[0] =  Ecosistema[i][j].x;
                Ecosistema[i][j].raton->ubicacion[1] =  Ecosistema[i][j].y;

                //esta linea es para probar funcionalidad: cout << "Me movi de" << this->ubicacion[0] << this->ubicacion[1]  << "a" << i << j << endl;
                this->yaMeMoviHoy = true;
                
                i = this->ubicacion[0] + 2;
                j = this->ubicacion[1] + 2;
                
            }
            }
        }
    }
    

};

void Raton::reproducirse(Celda** Ecosistema, int x, int y){
    int i, j;
    int a, b;
    bool hayEspacio = false;
    char miSexo = this->sexo;
    char sexoOpuesto;
    char sexo;
    int rand();
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
            if(!(i<0 || j<0 || j>(y-1) || i>(x-1)) and !(hayEspacio) ){
                if(!(Ecosistema[i][j].hayAnimal)){
                    hayEspacio = true;
                    a = i;
                    b = j;
                    
                }  // En este for se recorren todos los espacios adyacentes para verificar si hay espacio para reproducirse
                    // Se guarda en a,b el espacio donde se va a reproducir
                    
            }  
        }
    }
    
        for(i = this->ubicacion[0] - 1; i<= this->ubicacion[0] + 1; i++){
            for(j = this->ubicacion[1] - 1; j<= this->ubicacion[1] + 1; j++){
                if(!(i<0 || j<0 || j>(y-1) || i>(x-1)) ){
                    if(!(this->yaHizoReproduccionHoy)){
                        if(Ecosistema[i][j].hayAnimal and hayEspacio){
                            if(Ecosistema[i][j].cualAnimal == 'R'){ // verifica que haya otro raton
                                if (Ecosistema[i][j].raton->sexo == sexoOpuesto){ //del sexo opuesto
                                    if (this->energia >= 17 and Ecosistema[i][j].raton->energia>=17 and !(Ecosistema[i][j].raton->yaHizoReproduccionHoy)){ //que ambos tengan energia suficiente
                                                    cout << "Soy un/una (" << this->especie << ") y estoy en (" << this->ubicacion[0] << "," <<  this->ubicacion[1] << ") y me voy a reproducir con un/una (" << this->especie << ") que esta en la coordenada (" << i << "," << j << endl;
                                                    cout << "Nacio un nuevo animal tipo (" << this->especie << ") y esta en la coordenada (" << a << "," <<  b << ")" << endl;
                                                    Ecosistema[a][b].setAnimal(a,b,'R',sexo);
                                                    Ecosistema[a][b].raton->yaHizoReproduccionHoy = true; // para evitar cosas raras
                                                    this->yaHizoReproduccionHoy = true;
                                                    Ecosistema[i][j].raton->yaHizoReproduccionHoy = true;

                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    
};

void Raton::morir(Celda** Ecosistema){
    int i = this->ubicacion[0];
    int j = this->ubicacion[1];
    if (Ecosistema[i][j].raton->energia == 0){
        delete Ecosistema[i][j].raton;
        Ecosistema[i][j].hayAnimal = false;
    }
}

//******************************************************************//

Zorro::Zorro(int x, int y, int energia, char especie,char sexo){

    this->ubicacion[0] = x;
    this->ubicacion[1] = y;
    this->energia = energia;
    this->especie = especie;
    this->sexo = sexo;
    this->yaHizoReproduccionHoy = false;
    this->identificador = this;
};

Zorro::~Zorro(){

};

void Zorro::resetStats(){
    this->yaMeMoviHoy = false;
    this->yaHizoReproduccionHoy = false;

};

void Zorro::comer(Celda ** Ecosistema, int x, int y){
    int i, j; //poner ya comi en true
    int controlador = 0;
    
    for(i = this->ubicacion[0] - 1; i<= this->ubicacion[0] + 1; i++){ //filas
        for(j = this->ubicacion[1] - 1; j<= this->ubicacion[1] + 1; j++){ // columnas
            if(!(i<0 || j<0 || j>(y-1) || i>(x-1)) ){ // si se esta dentro del rango de movimientos
                    
                if((Ecosistema[i][j].hayAnimal)){ // si hay un animal
                    if(Ecosistema[i][j].cualAnimal == 'R' && controlador == 0){ //si encuentro una oveja
                            // reporte en consola
                            cout << "Soy un (" << this->especie << ") que esta en (" << this->ubicacion[0] << "," << this->ubicacion[1] <<  ") y me comi un/una (" <<  Ecosistema[i][j].cualAnimal << ") que estaba en (" << i << "," << j  << ")" << endl;
                        this->energia += 2;                            //ME LA COMO ;)
                        if (this->energia > 50) {this->energia = 50;} //ME LA COMO ;)
                        Ecosistema[i][j].hayAnimal = false; // ya no hay oveja en ecosistema
                        delete Ecosistema[i][j].raton; //OOOOOJOOOOOOOOOOOOOO VERIFICARRRRRR

                        controlador = 1;
            
                    }
 
                }
            }
        }
    } 
           
};

void Zorro::mover(Celda** Ecosistema, int x, int y){
    int i, j;

    for(i = this->ubicacion[0] - 2; i<= this->ubicacion[0] + 2; i++){
        for(j = this->ubicacion[1] - 2; j<= this->ubicacion[1] + 2; j++){
            if(!(i<0 || j<0 || j>(y-1) || i>(x-1)) ){

            if(!(Ecosistema[i][j].hayAnimal) & (this->yaMeMoviHoy == false)){
                
                
                
                Ecosistema[i][j].zorro = Ecosistema[this->ubicacion[0]][this->ubicacion[1]].zorro; //ojo
                Ecosistema[i][j].hayAnimal = true;
                Ecosistema[i][j].sexo = this->sexo;
                Ecosistema[i][j].cualAnimal = this->especie;

                Ecosistema[this->ubicacion[0]][this->ubicacion[1]].hayAnimal = false;
                //reporte en consola
                cout << "Soy un (" << Ecosistema[i][j].cualAnimal << ") y me movi de (" << this->ubicacion[0] << "," << this->ubicacion[1]  << ") a (" << i << "," << j << ")" << endl;
                //poniendo las direcciones del animal de nuevo donde van
                Ecosistema[i][j].zorro->ubicacion[0] =  Ecosistema[i][j].x;
                Ecosistema[i][j].zorro->ubicacion[1] =  Ecosistema[i][j].y;

                //esta linea es para probar funcionalidad: cout << "Me movi de" << this->ubicacion[0] << this->ubicacion[1]  << "a" << i << j << endl;
                this->yaMeMoviHoy = true;
                
                i = this->ubicacion[0] + 2;
                j = this->ubicacion[1] + 2;
                
            }
            }
        }
    }
};

void Zorro::reproducirse(Celda** Ecosistema, int x, int y){
    int i, j;
    int a, b;
    bool hayEspacio = false;
    char miSexo = this->sexo;
    char sexoOpuesto;
    char sexo;
    int rand();
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
            if(!(i<0 || j<0 || j>(y-1) || i>(x-1)) and !(hayEspacio) ){
                if(!(Ecosistema[i][j].hayAnimal)){
                    hayEspacio = true;
                    a = i;
                    b = j;
                    
                }  // En este for se recorren todos los espacios adyacentes para verificar si hay espacio para reproducirse
                    // Se guarda en a,b el espacio donde se va a reproducir
                    
            }  
        }
    }
    
        for(i = this->ubicacion[0] - 1; i<= this->ubicacion[0] + 1; i++){
            for(j = this->ubicacion[1] - 1; j<= this->ubicacion[1] + 1; j++){
                if(!(i<0 || j<0 || j>(y-1) || i>(x-1)) ){
                    if(!(this->yaHizoReproduccionHoy)){
                        if(Ecosistema[i][j].hayAnimal and hayEspacio){
                            if(Ecosistema[i][j].cualAnimal == 'Z'){ // verifica que haya otro zorro
                                if (Ecosistema[i][j].zorro->sexo == sexoOpuesto){ //del sexo opuesto
                                    if (this->energia >= 33 and Ecosistema[i][j].zorro->energia>=33 and !(Ecosistema[i][j].zorro->yaHizoReproduccionHoy)){ //que ambos tengan energia suficiente
                                                    cout << "Soy un/una (" << this->especie << ") y estoy en (" << this->ubicacion[0] << "," <<  this->ubicacion[1] << ") y me voy a reproducir con un/una (" << this->especie << ") que esta en la coordenada (" << i << "," << j << endl;
                                                    cout << "Nacio un nuevo animal tipo (" << this->especie << ") y esta en la coordenada (" << a << "," <<  b << ")" << endl;
                                                    Ecosistema[a][b].setAnimal(a,b,'Z',sexo);
                                                    Ecosistema[a][b].zorro->yaHizoReproduccionHoy = true; // para evitar cosas raras
                                                    this->yaHizoReproduccionHoy = true;
                                                    Ecosistema[i][j].zorro->yaHizoReproduccionHoy = true;
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    
};

void Zorro::morir(Celda** Ecosistema){
    int i = this->ubicacion[0];
    int j = this->ubicacion[1];
    if (Ecosistema[i][j].zorro->energia == 0){
        delete Ecosistema[i][j].zorro;
        Ecosistema[i][j].hayAnimal = false;
    }
}

//******************************************************************//


Pasto::Pasto(){
    this->energia = 50;
    this->contadorDeDias = 0;
};

Pasto::~Pasto(){

};

void Pasto::recuperarEnergiaDelSol(){
    if(this->energia > 0) {this->energia += 5;}
    if(this->energia > 50){this->energia = 50;}
};



//******************************************************************//
Celda::Celda(){
Pasto* p = new Pasto();

this->pasto = p;

};


Celda::~Celda(){
    delete this->pasto;

        if(this->cualAnimal == 'O'){
            delete this->oveja;   
        }
        if(this->cualAnimal == 'L'){
            delete this->lobo;
        }
        if(this->cualAnimal == 'Z'){
            delete this->zorro;
        }
        if(this->cualAnimal == 'R'){
            delete this->raton;
        }
};






void* Celda::getAnimal(){

    if(this->hayAnimal){

        if(this->cualAnimal == 'O'){
            return this->oveja;
        }
        if(this->cualAnimal == 'L'){
          return this->lobo;  
        }
        if(this->cualAnimal == 'Z'){
          return this->zorro;  
        }
        if(this->cualAnimal == 'R'){
          return this->raton;  
        }

    }

};

void Celda::setAnimal(int x, int y, char cualAnimal, char sexo){



        if(cualAnimal == 'O'){
            this->cualAnimal = cualAnimal;
            this->hayAnimal = true;
            Oveja *oveja = new Oveja(x,y,75,cualAnimal,sexo);
            this->oveja = oveja;
            this->sexo = sexo;
           
        }

        if(cualAnimal == 'L'){
            this->cualAnimal = cualAnimal;
            this->hayAnimal = true; 
            Lobo *lobo = new Lobo(x,y,100,cualAnimal,sexo);
            this->lobo = lobo;
            this->sexo = sexo;
            
        }

        if(cualAnimal == 'Z'){
            this->cualAnimal = cualAnimal;
            this->hayAnimal = true;
            Zorro *zorro = new Zorro(x,y,50,cualAnimal,sexo);
            this->zorro = zorro;
            this->sexo = sexo;
        }

        if(cualAnimal == 'R'){
            this->cualAnimal = cualAnimal;
            this->hayAnimal = true; 
            Raton *raton = new Raton(x,y,25,cualAnimal,sexo);
            this->raton = raton;
            this->sexo = sexo;
        }

    
};
//******************************************************************//




