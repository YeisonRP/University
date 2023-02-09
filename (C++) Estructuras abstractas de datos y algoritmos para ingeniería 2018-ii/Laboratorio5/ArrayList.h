#ifndef COSA
#define COSA

using namespace std;
#include "List.h"

/**
 * @brief Esta clase en plantilla representa dentro de si misma cualquier otro tipo de dato (int, double, float)
 * Es el dato que se guarda en la lista, el tipo D
 * @tparam D Es el tipo de dato que se le va a otorgar a la misma
 */
template<typename D>
class MyDato{
    public:
        D dato;
};

/**
 * @brief Esta es la lista en forma de arreglo, recibe un dato tipo D (en nuestro caso seria un objeto MyDato que puede ser cualquier tipo de dato)
 * 
 * @tparam D objeto plantilla MyDato que representa cualquier tipo de dato que se le quiera dar
 */
template <typename D>
class ArrayList : public List<D, int> {
    public:
    
        //TERMINADO
        ArrayList(){

        };

        /**
         * @brief Constructor que le da el tama;o maximo que va a tener la lista aun sin llenar
         * 
         * @param maxSize tama;o maximo de la lista
         */
        //TERMINADO
        ArrayList(int maxSize) {            //SE le pasa el tam;o maximo y crea un (arreglo) de punteros tipo D de tama;o maxsize
            this->items = new D[maxSize](); // se crea el arreglo de objetos D (MyDato)
            this->size = 0;                 // Tama;o del arreglo actual 
            this->arraySize = maxSize;      // Tama;o del arreglo maximo
        };

        /**
         * @brief Destruye la memoria dinamica reservada en este caso
         * 
         */
        //TERMINADO
        ~ArrayList() {
            delete[] this->items;           // Borrando todos los items
        };

/**
 * @brief Imprime la lista
 * 
 */
        //TERMINADO
        void print() { //FIN
            int i = 0;
            
            for(i = 0; i < this->size ;i++){
                    
                cout << this->items[i].dato  << endl;
            }

        };

/**
 * @brief Inserta un dato (objeto con un dato) al final de la lista, si hay espacio
 * 
 */ 
        //TERMINADO
        void insert(D d){   //FIN
        
            if(this->size < this->arraySize){   // si hay espacio

                this->items[this->size] = d;    // insertar numero d tipo D
                this->size += 1;                // sumar 1 a this size
            
            } else {cout<< "Esta lista esta llena, no se pudo ingresar el dato" <<endl;}
        };


 /**
  * @brief Inserta un dato tipo D (en nuestro caso un objeto tipo MyDato con cualquier dato dentro)
  * En una posicion especifica de la lista, corriendo los demas datos respectivamente
  * @param d DAto a ingresar
  * @param p int que representa la posicion
  */
        //TERMINADO
        void insert(D d, int p){ //FIN
            if((p-1) <= this->size){   // si hay espacio

                this->size += 1;                // sumar 1 a this size
                int i;
                for(i=(this->size - 2);i >= (p - 1);i--){
                    this->items[i+1].dato = this->items[i].dato;
                }

                this->items[p-1] = d;       // insertar numero d tipo D
                
            
            } else {cout<< "La posicion ingresada no es valida" <<endl;}
        };

/**
 * @brief Remueve un elemento de la lista y corre los demas valores respectivamente
 * 
 * @param d Parametro que desea encontrar para eliminar
 */

        //TERMINADO
       void remove(D d){   //FIN
            int i;
            int j;
          
            for(i = 0; i < this->size; i++){
                if(this->items[i].dato == d.dato){   // si se encuentra el dato
                    for(j = i; j < (this->size-1); j++){ 
                        this->items[j].dato = this->items[j+1].dato;   
                        i = this->size;
                     
                    } 
                this->size -= 1; 
                }
                else if ((i+1) == this->size)
                {
                    {cout<< "No  se encontro el dato a eliminar" <<endl;}   
                }          
            }
        };

        /**
         * @brief Remueve el elemento de la lista en la posicion p
         * 
         * @param p posicion p donde se va a eliminar el elemento
         */
        //TERMINADO
        void remove(int p){   //
                int j;
                
                if(p <= this->size){   // si es una posicion valida
                    for(j = p; j < (this->size); j++){ 
                        this->items[j-1].dato = this->items[j].dato;   
                        
                    } 
                this->size -= 1; 
                }
                else {
                    {cout   << "No  se pudo encontrar esta posicion en la lista" << endl;}   
                }          
            
        };

        //TERMINADO
        D find(int k){   //
            if (k <= this->size){ 
            return this->items[k-1];
            } 
            else {cout<< "No se pudo encontrar el elemento" <<endl;
            
            }
        };

        //TERMINADO
        D find(D d){   //BUsca el dato en la lista
            int i;
            int flag = 0;

            for(i = 0; i <= this->size; i++){
                if(this->items[i-1].dato == d.dato){ 
                    return this->items[i-1];
                    i = this->size + 1; //PAra terminar el for
                    flag = 1;
                }
                if(i == this->size && flag == 1) {cout<< "No se pudo encontrar el elemento" <<endl;}  
            }       
        };

        //TERMINADO
        D next(int k){   //Se ingresa una posicion y se accede a la siguiente
            if (k < this->size){ 
            return this->items[k];
            } else {cout<< "No se pudo encontrar el elemento" <<endl;
            
            }           
        };
        //TERMINADO
        D prev(int k){   // se ingresa una posicion y se accede a la anterior
            if (k <= this->size){ 
            return this->items[k-2];
            } else {cout<< "No se pudo encontrar el elemento" <<endl;
            
            }
        };
       

    private:
        D* items;                           // puntero al arreglo de objetos d
        int arraySize;                      // Tama;o del arreglo
};

#endif

