#ifndef COSA4
#define COSA4


#include "List.h"

template<typename D>
class DoubleNode {
    public:
        D item;
        DoubleNode<D>* next;
        DoubleNode<D>* prev;
};

/**
 * @brief PLantilla de clase que va a recibir un tipo de dato D (int. double, etc) y un objeto tipo DoubleNode
 * que es de tipo dato D 
 */
template<typename D>
class LinkedListDN : public List<D, DoubleNode<D> > {
    public:
        DoubleNode<D> *punteroAlInicio = NULL;
        LinkedListDN(){};
        ~LinkedListDN(){

        };


        LinkedListDN(D d){
            this->punteroAlInicio = new DoubleNode<D>();
            this->punteroAlInicio->item = d;
            this->punteroAlInicio->next = NULL;
            this->punteroAlInicio->prev = NULL;
            this->size += 1;
        }





        void print() {
            DoubleNode<D> *punteroAuxiliar = this->punteroAlInicio;

            do {

                cout << punteroAuxiliar->item << endl;
                punteroAuxiliar = punteroAuxiliar->next;
            } while (punteroAuxiliar != NULL);
        };





        void insert(D d){
            DoubleNode<D> *punteroAuxiliar = this->punteroAlInicio;
            int flag = 0;

            do{
                if (punteroAuxiliar->next != NULL){
                    punteroAuxiliar = punteroAuxiliar->next;
                }
                if (punteroAuxiliar->next == NULL){
                    punteroAuxiliar->next = new DoubleNode<D>;
                    punteroAuxiliar->next->item = d;
                    punteroAuxiliar->next->next = NULL;
                    
                    if (punteroAuxiliar->prev != NULL){
                        punteroAuxiliar->next->prev = punteroAuxiliar->prev->next;
                    }
                    flag = 1;
                    this->size += 1;
                } 

            }while(flag == 0);
        };//FALTA





        void insert(D d, DoubleNode<D> p){//FALTA
        int posicion = (int) p.item;
        int flag = 0;
        int contador = 1;
        DoubleNode<D> *punteroAnterior = NULL;
        DoubleNode<D> *punteroActual = this->punteroAlInicio;
            
            if(posicion == 1){ // Si es el primer elemento de la lista
                punteroActual = new DoubleNode<D>();    //Pidiendo memoria dinamica 
                punteroActual->next  = this->punteroAlInicio;
                this->punteroAlInicio = punteroActual;
                punteroActual->item = d;        // guardando el dato en el puntero agregado    
                this->size += 1;
            }
            else{             
                do{
                    
                        if(contador == posicion && contador != 1){
                            punteroAnterior->next = new DoubleNode<D>();    //Pidiendo memoria dinamica   
                            punteroAnterior->next->next = punteroActual;    // el puntero que se agrego se apunta al que estaba despues del anerior
                            punteroAnterior->next->item = d;        // guardando el dato en el puntero agregado
                            punteroAnterior->next->prev = punteroAnterior->prev;
                            flag = 1;
                            this->size += 1;
                            
                        } 
                    
                    contador += 1;
                        if(contador == this->size + 1 ){ // ultimo elemento de la lista
                              
                                punteroActual->next = new DoubleNode<D>(); //Guardando en el puntero final que era nulo otra direccion de memoria
                                punteroActual->next->item = d;
                                punteroActual->next->prev = punteroActual;
                                punteroActual->next->next = NULL;   //FALTA EL PUNTERO QUE APUNTA HACIA ATRAS
                                flag = 1;
                                this->size += 1;
                            }
                    punteroAnterior = punteroActual;
                    punteroActual = punteroActual->next;
                    
                
                } while(flag == 0);

            }
        };//FALTA








        void remove(D d){ // ya
            DoubleNode<D> *Node = this->punteroAlInicio;
            DoubleNode<D> *NextNode = this->punteroAlInicio;
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






        void remove(DoubleNode<D> p){ // ya
            int posicion = (int) p.item;
            int contador = 1;
            int controlador = 0;

            DoubleNode<D> *Node = this->punteroAlInicio;
            DoubleNode<D> *NextNode = Node->next;
            DoubleNode<D> *anteriorNode;

            if(posicion == 1){ // caso inicial
                this->punteroAlInicio = Node->next;
                this->punteroAlInicio->prev = NULL;
                delete Node;
                this->size -= 1;
            }
            else {
                while(NextNode->next != NULL){
                    contador += 1;
                    anteriorNode = Node;
                    Node = Node->next;
                    NextNode = Node->next;
                    if( contador == posicion){
                       delete Node; //borrando nodo central
                        NextNode->prev = anteriorNode;  // apuntando nodo de despues a anterior
                        anteriorNode->next = NextNode; // apuntando nodo anterior a nodo siguiente
                         
                        controlador = 1;
                        this->size -= 1;
                    }
                }
                
                if(controlador == 0){ // caso final
                    delete NextNode;
                    Node->next = NULL;
                    this->size -= 1;
                } 
            }        

         }; 



        D find(D d){ //TERMINADO
            int flag = 0;
            DoubleNode<D> *Node = this->punteroAlInicio;
            while(Node != NULL){
                if(Node->item == d){ return Node->item;}
                else{ Node = Node->next; }
            }
            cout << "No se encontro el numero que se pedia "<< endl;
            return 0;
        };






        D find(DoubleNode<D> k){
            int contador;
            D num = (int) k.item;

            DoubleNode<D> *Node = this->punteroAlInicio;

            for (int i = 1; i<num; i++){
                if (Node->next != NULL){
                    Node = Node->next;
                }
            }
            return Node->item;
        };

        D next(DoubleNode<D> k){
        D num = k.item;
            DoubleNode<D> *Node = this->punteroAlInicio;

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


        };//Falta
        D prev(DoubleNode<D> k){
            D num = k.item;
            DoubleNode<D> *PrevNode = this->punteroAlInicio;
            DoubleNode<D> *Node = this->punteroAlInicio;
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