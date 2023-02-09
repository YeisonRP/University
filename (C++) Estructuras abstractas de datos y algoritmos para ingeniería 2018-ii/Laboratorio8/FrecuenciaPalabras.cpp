#include "FrecuenciaPalabras.h"

FrecuenciaPalabras::FrecuenciaPalabras(){

};

FrecuenciaPalabras::~FrecuenciaPalabras(){

};



void FrecuenciaPalabras::llenarStopWords(){
    //abriendo archivo
    ifstream inputFile;
    inputFile.open (this->ArchivostopWords);

    if (!inputFile) {
        cerr << "No se pudo abrir el archivo" << endl;
    }

    string lectura;
    while (inputFile >> lectura) {
        this->stopWords.push_back(lectura);
    }
};


void FrecuenciaPalabras::contarLasPalabras(){
    //abriendo archivo
    ifstream inputFile;
    inputFile.open (this->ArchivosParrafo);

    if (!inputFile) {
        cerr << "No se pudo abrir el archivo" << endl;
    }

    string lectura;
    int i;
    map<string, int>::iterator itr; //iterador para el mapa

    while (inputFile >> lectura) {
        bool controlador = false;

        for (int i = 0; i < this->stopWords.size(); i++){
            if(this->stopWords[i] == lectura){ i = this->stopWords.size(); controlador = true;} //para terminar el for
        } 
        if(!controlador){   //sigue con el analisis

            itr = this->palabrasFrecuentes.find(lectura);   //encontrando el string, sino retorna el ultimo
            if(itr == this->palabrasFrecuentes.end()){      // si retorna el ultimo
                this->palabrasFrecuentes.insert(pair<string, int>(lectura, 1));
            }
            else{           // si no retorna el ultimo
                itr->second += 1;   // sumando 1 al elemento
            }
        }  
    }

    //Ya se tienen todas las palabras en el mapa

    for(int i = 0;i<25;i++){ //inicializando en 0 el vector
        this->wordsMF[i] = 0;
    }


    for (itr = this->palabrasFrecuentes.begin(); itr != this->palabrasFrecuentes.end(); ++itr) { 
        int menorPosicion=0;
        int menorNumero=100000;        
        for(i=0;i<25;i++){
            if(menorNumero > this->wordsMF[i]){menorPosicion = i; menorNumero = this->wordsMF[i];} //guardando la posicion del menor
        }

        if(itr->second > this->wordsMF[menorPosicion]){
            this->SwordsMF[menorPosicion] = itr->first;
            this->wordsMF[menorPosicion] = itr->second;
        }  
    } 

    //bubble sort
    bool flag = true;
    int auxiliarint;
    string auxiliarstr;
    while(flag){ 
        flag = false;
        for(int i = 0;i<24;i++){ //sort
            if(this->wordsMF[i] < this->wordsMF[i+1]){ // si hay que hacer cambio
                auxiliarint = this->wordsMF[i];
                auxiliarstr = this->SwordsMF[i];
                this->wordsMF[i] = this->wordsMF[i+1];
                this->SwordsMF[i] = this->SwordsMF[i+1];
                this->wordsMF[i+1] = auxiliarint;
                this->SwordsMF[i+1] = auxiliarstr;
                flag = true;
            }
        }
    }

    cout << '\t' << "Palabra" << '\t' << '\t'  << "Frecuencia"<< '\n';
    for(int i = 0;i<25;i++){ //inicializando en 0 el vector
        cout << '\t' << this->SwordsMF[i]  << '\t' << '\t' << this->wordsMF[i]  << '\n';
    }

};