#include <ctime>
#include <unistd.h>
#include <iostream>
#include <string>
#include <chrono>

using namespace std;
using namespace std::chrono;

void init(float x)
{
    // hace cosas: MARISOL!!!!!111oneone
    sleep((int)x);
    return;
}

void f(float x)
{
    // hace cosas: MARISOL!!!!!111oneone
    sleep((int)x);
    return;
}


void f_poly3(unsigned long long n){

    for(unsigned long long i = 0; i < n; i++ ) {
        for(unsigned long long j = 0; j < n; j++ ){
            for(unsigned long long k = 0; k < n; k++ )
            {
                i*i;
            }
        }
    }
    return;
}

void f_lineal(unsigned long long x)
{
    for (unsigned long long i=0; i < x; i++) {
        i*x;
    }
    return;
}




int main(int c, char** v)
{
    unsigned long long x = stoull(v[1]);
    
    init(0);

    //time_t t0 = time(0);
    steady_clock::time_point t0 = steady_clock::now();
    //f(0);
    f_lineal(x);

    steady_clock::time_point t1 = steady_clock::now();
    //time_t t1 = time(0);

    unsigned long long tiempito = duration_cast<nanoseconds>(t1-t0).count();
    //time_t tiempito = t1-t0;

    
    cout << tiempito << endl;

    return 0;

}