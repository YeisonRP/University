#ifndef COSA2
#define COSA2


#include "List.h"

template<typename D>
class SingleNode{
    public:
        D item;
        SingleNode<D>* next;
};

/**
 * @brief PLantilla de clase que va a recibir un tipo de dato D (int. double, etc) y un objeto tipo SingleNode
 * que es de tipo dato D 
 * 
 */
template<typename D>
class LinkedListSN : public List<D, SingleNode<D> > {
    public:
        SingleNode<D> *punteroAlInicio = NULL; //Puntero al inicio
        LinkedListSN(){};
        ~LinkedListSN(){
            //hacer recursivo para borrar la memoria dinamica
        };


        LinkedListSN(D d){                               //Pasarle entero, flotante, o lo que sea
            this->punteroAlInicio = new SingleNode<D>(); // se crea el arreglo dinamico
            this->punteroAlInicio->item = d;
            this->punteroAlInicio->next = NULL;
            this->size += 1;
        };


        /**
         * @brief Imprime la lista enlazada
         * 
         */
        void print() { //TERMINADO
            SingleNode<D> *punteroAuxiliar = this->punteroAlInicio;
           
             do{
                
                cout<< punteroAuxiliar->item << endl;
                punteroAuxiliar = punteroAuxiliar->next;
            
                } while(punteroAuxiliar != NULL);

        };


        
        /**
         * @brief Inserta un elemento al final de la lista enlazada
         * 
         * @param d 
         */
        void insert(D d){ //TERMINADO
            SingleNode<D> *punteroAuxiliar = this->punteroAlInicio;
            // next = new SingleNode<D>();
            int flag = 0;
            do{
             if(punteroAuxiliar->next == NULL){
                punteroAuxiliar->next = new SingleNode<D>();    //Pidiendo memoria dinamica
                punteroAuxiliar->next->item = d;                // Siguiente numero
                punteroAuxiliar->next->next = NULL;             //PUntero final NULO
                flag = 1;
                this->size += 1;
             }
              else{punteroAuxiliar = punteroAuxiliar->next;}  
            
        } while(flag == 0);

}
        
        

        /**
         * @brief Inserta un valor d en la lista en la posicion ingresada en el objeto singleNOde
         * 
         * @param d 
         * @param p 
         */
        void insert(D d, SingleNode<D> p){
            int posicion = (int) p.item;
            int flag = 0;
            int contador = 1;
            SingleNode<D> *punteroAnterior = NULL;
            SingleNode<D> *punteroActual = this->punteroAlInicio;

            if(posicion == 1){ // Si es el primer elemento de la lista
                punteroActual = new SingleNode<D>();    //Pidiendo memoria dinamica 
                punteroActual->next  = this->punteroAlInicio;
                this->punteroAlInicio = punteroActual;
                punteroActual->item = d;        // guardando el dato en el puntero agregado    
                this->size += 1;
            }
            else { 
            
        do{
 
                                    
                        if(contador == posicion && contador != 1){
                            punteroAnterior->next = new SingleNode<D>();    //Pidiendo memoria dinamica   
                            punteroAnterior->next->next = punteroActual;    // el puntero que se agrego se apunta al que estaba despues del anerior
                            punteroAnterior->next->item = d;        // guardando el dato en el puntero agregado
                            flag = 1;
                            this->size += 1;
                            
                        }
                        contador += 1;
                        
                        if(contador == this->size + 1 ){ // ultimo elemento de la lista
                                cout << "Puntero actual " << punteroActual->item << endl;
                                punteroActual->next = new SingleNode<D>(); //Guardando en el puntero final que era nulo otra direccion de memoria
                                punteroActual->next->item = d;
                                punteroActual->next->next = NULL;
                                flag = 1;
                                this->size += 1;
                            }
                        punteroAnterior = punteroActual;
                        punteroActual = punteroActual->next;
                        
                    
                
        } while(flag == 0);
            }    
        };



        void remove(D d){ //ya sirve
            SingleNode<D> *Node = this->punteroAlInicio;
            SingleNode<D> *NextNode = this->punteroAlInicio;
            NextNode = Node->next;
            int flag = 0;

            do{
                if(NextNode->item == d){
                    Node->next = NextNode->next;
                    delete NextNode;
                    flag = 1;
                    this->size -= 1;
                }
                Node = NextNode;
                NextNode=NextNode->next;

            } while(flag ==0);


        }; 



        void remove(SingleNode<D> p){ //Funciona para todos los datos
            int posicion = (int) p.item;
            int contador = 1;
            int controlador = 0;

            SingleNode<D> *Node = this->punteroAlInicio;
            SingleNode<D> *NextNode = Node->next;
            SingleNode<D> *anteriorNode;

            if(posicion == 1){ // caso inicial
                this->punteroAlInicio = Node->next;
                delete Node;
                this->size -= 1;
            }
            else {
                while(NextNode != NULL){
                    contador += 1;
                    anteriorNode = Node;
                    Node = Node->next;
                    NextNode = Node->next;
                    if( contador == posicion){
                        delete Node; //borrando nodo central
                        anteriorNode->next = NextNode; // apuntando nodo anterior a nodo siguiente
                        controlador = 1;
                        this->size -= 1;
                    }
                }

                if(controlador == 0){ // caso final
                    delete Node;
                    anteriorNode->next = NULL;
                    this->size -= 1;
                } 
            }           
  
        }; //Falta DENTRO DE UN OBJETO SINGLENODE SE PASARIA EL PARAMETRO DE LA POSICION QUE SE QUIERE BORRAR



        D find(D d){ //TERMINADO
            int flag = 0;
            SingleNode<D> *Node = this->punteroAlInicio;
            while(Node != NULL){
                if(Node->item == d){ return Node->item;}
                else{ Node = Node->next; }
            }
            cout << "No se encontro el numero que se pedia "<< endl;
            return 0;
        };


        D find(SingleNode<D> k){ //listo
            int contador;
            D num = (int) k.item;

            SingleNode<D> *Node = this->punteroAlInicio;

            for (int i = 1; i<num; i++){
                if (Node->next != NULL){
                    Node = Node->next;
                }
            }
            return Node->item;

        };

        
        D next(SingleNode<D> k){ // Listo
            D num = k.item;
            SingleNode<D> *Node = this->punteroAlInicio;

            for (int i = 1; i<num; i++){
                if (Node->next != NULL){
                    Node = Node->next;
                }
            }
            if (Node->next != NULL){
                Node = Node->next;
                return Node->item;
            }
            else {
                cout << "es el ultimo elemento de la lista" << endl;
                return 0;
            }
            


        };
        D prev(SingleNode<D> k){ // Listo
            D num = k.item;
            SingleNode<D> *PrevNode = this->punteroAlInicio;
            SingleNode<D> *Node = this->punteroAlInicio;
            Node = Node->next; //  |prevNode| --- |Node|


            for (int i = 2; i<num; i++){
                if (Node->next != NULL){
                    Node = Node->next;
                    PrevNode = PrevNode->next;
                }
            }
            return PrevNode->item;


            
        };//Falta



    
        


};



#endif
