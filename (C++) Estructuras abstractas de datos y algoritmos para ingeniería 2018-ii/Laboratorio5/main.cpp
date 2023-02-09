#include "ArrayList.h"
#include "SingleLinkedList.h"
#include "DoubleLinkedList.h"
#include <ctime>
#include <unistd.h>
#include <iostream>
#include <string>
#include <chrono>


using namespace std;
using namespace std::chrono;



int main(int c, char** v) {


    


    int n = 10;
    List< MyDato<int>, int  > *al0;     // creando un puntero tipo LISTA
    al0 = new ArrayList< MyDato<int> >(n); // Haciendo un puntero a una lista tipo arreglo de hasta 7 elementos, aun sin llenar
    MyDato<int> datoPrueba1;
    MyDato<int> datoPrueba2;

    for (int i =1; i<=n; i++){
        int r = rand()%10;
        datoPrueba1.dato = r;
        if(i==5 ){ datoPrueba2.dato = r;}
        al0->insert(datoPrueba1);
    };
    cout << "Se lleno una lista de arreglos con los siguientes valores:" << endl<< endl;
    al0->print();  

    cout << "Ahora se presenta la lista de arreglos ordenada por el metodo SelectionSort :" << endl<< endl;
    SelectionSort(al0);
    al0->print();
    
      
    cout << "Ahora se busca el dato " << datoPrueba1.dato << " por medio de busqueda lineal, y se obtiene que la funcion retorna :" << busquedaLineal(al0, datoPrueba1).dato << endl;
    cout << "Ahora se busca el dato " << datoPrueba2.dato << " por medio de busqueda binaria, y se obtiene que la funcion retorna :" << BusquedaBinaria(al0, datoPrueba2) << endl;
    



    List< int, DoubleNode<int>  > *ll0;     // creando un puntero tipo LISTA
    ll0 = new LinkedListDN< int >(7);

    ll0->insert(8);
    ll0->insert(1);
    ll0->insert(10);
    ll0->insert(6); 

    cout << "Se lleno una lista enlazada con los siguientes valores:" << endl<< endl;
    ll0->print();
    SelectionSort(ll0);
    cout << "Ahora se presenta la lista enlazada ordenada por el metodo SelectionSort :" << endl<< endl;
    ll0->print();

        
    return 0;
}
