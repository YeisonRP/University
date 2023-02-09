#include <cstdlib>
#include <ctime>
#include <iostream>
#include <math.h>
#include <string>


using namespace std;
bool isPrime(unsigned long long int a);
unsigned long long int prime(unsigned long long int a, unsigned long long int b);
unsigned long long int gcd(unsigned long long int a, unsigned long long int b);
unsigned long long int getE(unsigned long long int phi, unsigned long long int e);
unsigned long long int getD(unsigned long long int phi, unsigned long long int e);
string encrypt(string s, int e, int n);
string decrypt(string s, int d, int n);
string randInput(int i);


//GENERACION DE NUMEROS PRIMOS
unsigned long long int prime(unsigned long long int a, unsigned long long int b){ 
    unsigned long long int p;
    p = rand()%a + b;
    //cout << p << endl;
    for(unsigned long long int i = 0; i<a; i++){

        if (isPrime(p+i)){
            return p+i;
        }
    }
    
    

};


// REVISA SI SON PRIMOS
bool isPrime(unsigned long long int n){ 
    for(unsigned long long int i = 2; i<n; i++){
        if(n%i == 0){
            return false;
        }
    }
    return true;
};


// CALCULO DE VALORES IMPORTANTES
unsigned long long int getE(unsigned long long int phi, unsigned long long int e){
    e = 2;
    
    // Calculo de e:
    while (e<phi){
        if(gcd(e, phi) == 1){
            break;
        } else{
            e++;
        }
    }
    return e;
};

unsigned long long int getD(unsigned long long int phi, unsigned long long int e){
    unsigned long long int k = 1;
    unsigned long long int d;
    while (1){
        k = k + phi;
        if (k % e == 0){
            d = k/e;
            return d;
        }
    }
};

//para encontrar funcion de maximo comun divisor
unsigned long long int gcd(unsigned long long int a, unsigned long long int b){ 
    if (a < b){
        return gcd(b, a); // se necesita que el primer argumento sea mayor
    } else{
        unsigned long long int f = a % b;
        if(f == 0){
            return b;
        } else{
            return gcd(b, f);
        }
    }
};

string encrypt(string s, unsigned long long int e, unsigned long long int n){
    string hidden = "";
    unsigned long long int a;
    char zero = 'a';
    unsigned long long int result = 1;

    for (unsigned long long int i = 0; i< s.length(); i++){
        unsigned long long int character = s.at(i);
        //cout << "Valor numerico del " << i << "-esimo caracter:" << character << endl;
        for (unsigned long long int j = 0; j < e; j++){
            result = result*character;
            result = (result % n);
        }
        //cout << "Valor encriptado del " << i << "-esimo caracter: "<< result << endl;
        zero = result;
        hidden += zero;
        zero = 'a';
        result = 1;
    }
    return hidden;
};

// string decrypt(string s, unsigned long long int d, unsigned long long int n){
//     string des = "";
//     unsigned long long int a;
//     char zero = '\0';
//     unsigned long long int result = 1;

//     for (unsigned long long int i = 0; i< s.length(); i++){
//         unsigned long long int character = s.at(i);
//         cout << "Valor numerico del " << i << "-esimo caracter:" << character << endl;
//         for (unsigned long long int j = 0; j < d; j++){
//             result = result*character;
            
//             result = result % n;
//             //cout << result << endl;
//         }
//         //cout << "Valor encriptado del " << i << "-esimo caracter: "<< result << endl;
//         //cout << result << endl;
//         zero = result;
//         des += zero;
//         //cout << des << endl;
//         zero = '\0';
//         result = 1;
//     }
//     return des;
// };

string randInput(int i){
    string s;
    for (int j=1; j<i; j++){
        int a = rand()%10 + 97;
        char c = a;
        s += c;
    }
    return s;
}