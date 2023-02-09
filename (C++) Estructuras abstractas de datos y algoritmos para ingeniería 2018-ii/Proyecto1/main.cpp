#include <iostream>
#include <string>
#include "rsa.h"
#include "des.h"
//#include <chrono>
//#include <ctime>
#include <unistd.h>

using namespace std;
//using namespace std::chrono;

void init(float x)
{
    sleep((int)x);
    return;
}



int main(int c, char** v){

    unsigned long long int p,q, n, phi, e, d, a, b;

    string input;
    string encriptado;
    string desencriptado;

    int a2=0;
    int nada;
    int flag = 0;
    while(flag == 0){ 
    cout << endl;
    cout << "Que desea hacer:" << endl;
    cout << "1. Encriptar con DES:" << endl;
    cout << "2. Encriptar con RSA:" << endl;
    cout << "3. Salir:" << endl;
    cin >> a2;
    if(a2==1){
        cout << endl << endl;
        des DES;
        string llave;
        cout << "Ingrese la llave de encriptacion de 8 bytes:" << endl;
        cin >> llave;
        
        string mensaje;
        cout << "Ingrese el mensaje a encriptar:" << endl;
        cin >> mensaje;
        DES.encriptar(mensaje,llave);
    }
    else if(a2==2){
// SECCION DE PROGRAMA //
    cout << "Ingrese el texto que quiere encriptar: " << endl;
    cin >> input;
    cout << "Ingrese el limite inferior de numeros primos por generar: "<< endl;
    cin >> a;
    cout << "Ingrese el limite superior de numeros primos por generar: "<< endl;
    cin >> b;
    while (b<=a){
        cout << "Ingrese un numero mayor a "<< a<< endl;
        cin >> b;
    }
    srand(time(NULL));
    p = prime(a, b);
    srand(p);
    q = prime(a, b);
    /////////////////////////

    //SECCION DE TIEMPOS //
    // string in = v[1];
    // int i = atoi(in.c_str());
    // p = prime(i, (i+50));
    // srand(p);
    // q = prime(i, (i+50));
    // //input = randInput(i);
    // input = "String de prueba";
    ////////////////////////


   // init(0);
    //steady_clock::time_point t0 = steady_clock::now();

    
    
    n = p*q;
    phi = (p-1)*(q-1);
    e = getE(phi, e);
    d = getD(phi, e);

    /// programa ////////////////////////
    cout << "p = " << p << endl;
    cout << "q = " << q << endl;
    cout << "n = " << n << endl;
    cout << "phi = " << phi << endl;
    cout << "e = " << e << endl;
    cout << "d = " << d << endl;
    cout << "texto original: " << input << endl;

    /////////////////////////////////////


    encriptado = encrypt(input, e, n);


   // steady_clock::time_point t1 = steady_clock::now();
        //time_t t1 = time(0);

  //  unsigned long long tiempito = duration_cast<nanoseconds>(t1-t0).count();
   // cout << tiempito << endl;

    /////////////////////////////////////
    //desencriptado = decrypt(encriptado, d, n); // le falta corregir unas cosas
    cout << "texto encriptado: ";
    cout << encriptado << endl;
    //cout << "texto desencriptado: " << desencriptado << endl;
    cout << "clave publica: (" << n << ", " << e << ")" << endl; 
    cout << "clave privada: (" << d << ")" << endl; 
    // ///////////////////////////////////
    }
    else if(a2==3){flag=1;}
    else{ cout << "ingrese un codigo valido en el menu" << endl;}
    }
    
    return 0;
};
