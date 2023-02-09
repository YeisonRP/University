#ifndef COSA3
#define COSA3
#include <iostream> 



template<typename D>
class MyDato;



template<typename Dat, typename Pos>
class List {
    public:
        List(){};
        ~List(){};
		unsigned long long int getSize() { return size ; };
		virtual void insert(Dat d)=0;
		virtual void insert(Dat d, Pos p)=0;
		virtual void remove(Dat d)=0;
		virtual void remove(Pos p)=0;
		virtual Dat find(Dat x)=0; 		
		virtual Dat find(Pos k)=0;
		virtual void print()=0; 			
		virtual Dat next(Pos p)=0;
		virtual Dat prev(Pos p)=0;

    
        unsigned long long int size;
};


/**
 * @brief TEMPLATE PARA FUNCION DE BUSQUEDA LINEAL
 * 
 * @tparam Dat Dato de la lista
 * @tparam Pos posicion de la lista
 * @param L Lista (cualquier tipo)
 * @param d Dato de la lista
 */
template<typename Dat, typename Pos> 
Dat busquedaLineal(List<Dat, Pos> *L, Dat d){
    return L->find(d);
};

// template<typename D> 
// D busquedaBinaria(List< MyDato<D>, int> *L, D d, int max, int min){
// 	D result;
// 	int arraySize = L->size;

// 	int mid;
// 	mid = (int) ((max+min)/2);
// 	cout << "mid = " << mid << endl;
// 	cout << (L->find(mid).dato) << endl;
// 	if(L->find(mid).dato == d.dato){
// 		result = d;
// 		return result;
// 	}
// 	else if (L->find(mid).dato < d.dato)
// 	{
// 		min = mid;
// 		return busquedaBinaria(L, d, max, min);
// 	}
// 	else if (L->find(mid).dato > d.dato)
// 	{
// 		max = mid;
// 		return busquedaBinaria(L, d, max, min);
// 	}

// };

// TERMINADO
template<typename D> //Selection Sort para lista normal, ordena la lista
void SelectionSort(List< MyDato<D>, int> *L){ // D ya es un MyDato
    int Posicion = 0;
	MyDato<D> actual;
	MyDato<D> minimo;
	D Datominimo = 10000000;
	D DatoActual;
	int i, j;
	for(i = 0; i < L->size ; i++){//L->size
	D Datominimo = 10000000;
		for(j = i; j < L->size  ; j++){ //
			actual = L->find(j+1);
			DatoActual = actual.dato;
			if(DatoActual < Datominimo){
				minimo = actual;
				Datominimo = DatoActual;
				Posicion = j;
			}
		}
	L->remove((Posicion+1));
	L->insert(minimo, (i+1));
	}
};

//LISTO, PROBADA CON SINGLE NODE y DOUBLE NODE
template<typename D, typename Node> // Selection sort para lista enlazada, ordena la lista
void SelectionSort(List<D, Node> *L){	// NODE es el nodo, ya sea doble o simple, D es el tipo de dato (entero, flotante)
	int posicion;
	Node nodoActual;
	Node minimo;
	minimo.item; //encontrando el objeto nodo primero
	Node nodoj;

	int i, j;
	for(i = 0; i < L->size ; i++){//L->size
		minimo.item = 10000000;
		for(j = i; j <L->size   ; j++){ //
			nodoActual.item = j + 1;
			nodoj.item = L->find(nodoActual);
			if(nodoj.item < minimo.item){
				minimo.item = nodoj.item;
				posicion = j+1;
			}
		}
	nodoj.item = posicion;	
	L->remove((nodoj));
	nodoj.item = i+1;
	L->insert(minimo.item, nodoj); 
	}
};

// Terminado, devuelve un 0 si el numero no esta en ninguna posicion
template<typename D> //Selection Sort para lista normal, ordena la lista
int BusquedaBinaria(List< MyDato<D>, int> *L, MyDato<D> miDato){ // miDato que tiene adentro el dato que se desea buscar

	int LimiteInferior = 0; // dato 0
	int LimiteIntermedio;
	MyDato<D> ValorIntermedio;
	int LimiteSuperior = L->size;	// dato final
	int Flag = 0;
	int contador = 0;
	while(Flag == 0){
		LimiteIntermedio = ((LimiteSuperior - LimiteInferior)/2) + LimiteInferior;
		
			//LimiteIntermedio += 1; //Revisar
		
		ValorIntermedio = L->find(LimiteIntermedio); // dato en el medio

			if(ValorIntermedio.dato == miDato.dato){
				
				return LimiteIntermedio;
				Flag += 1;
			} 
			if(((LimiteSuperior - LimiteInferior) == 1)  && ((L->find(LimiteSuperior)).dato == miDato.dato)){
				return LimiteSuperior;
				Flag += 1;				
			} 	
			if(miDato.dato < ValorIntermedio.dato){
				LimiteSuperior = LimiteIntermedio;
			}
			if(miDato.dato > ValorIntermedio.dato){
				LimiteInferior = LimiteIntermedio;
			}

		contador += 1;
		if(contador == L->size){return 0;}
	}	
};

template<typename D, typename Node> // Terminado, devuelve un 0 si el numero no esta en ninguna posicion
int BusquedaBinaria(List<D, Node> *L,Node N ){
	D LimiteInferior = 0; // dato 0
	D LimiteIntermedio;
	D LimiteSuperior = L->size;	// dato final
	Node ValorIntermedio;
	Node auxiliar;
	int Flag = 0;
	int contador = 0;
	while(Flag == 0){
		LimiteIntermedio = ((LimiteSuperior - LimiteInferior)/2) + LimiteInferior;

		ValorIntermedio.item = LimiteIntermedio;	//mandando posicion para el find
		ValorIntermedio.item = L->find(ValorIntermedio); // dato en el medio
		auxiliar.item = LimiteSuperior;
			if(ValorIntermedio.item == N.item){
				return LimiteIntermedio;
				Flag += 1;
			}	
			if(((LimiteSuperior - LimiteInferior) == 1)  && (L->find(auxiliar) == N.item)){
				return LimiteSuperior;
				Flag += 1;				
			}

			if(N.item < ValorIntermedio.item){
				LimiteSuperior = LimiteIntermedio;
			}
			if(N.item > ValorIntermedio.item){
				LimiteInferior = LimiteIntermedio;
			}
		contador += 1;
		if(contador == L->size){return 0;}
	}
}

#endif
