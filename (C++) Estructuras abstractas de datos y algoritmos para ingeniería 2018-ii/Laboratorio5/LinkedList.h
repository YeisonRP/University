#ifndef COSA2
#define COSA2


#include "List.h"

template<typename D>
class SingleNode{
    public:
        D item;
        D* next;
};

template<typename D>
class DoubleNode {
    public:
        D item;
        D* next;
        D* prev;
};

/**
 * @brief PLantilla de clase que va a recibir un tipo de dato D (int. double, etc) y un objeto tipo SingleNode
 * que es de tipo dato D 
 * 
 */
template<typename D>
class LinkedListSN : public List<D, SingleNode<D> > {
    public:
        LinkedListSN(){};
        ~LinkedListSN(){};

        void print() { //FALTA

        };

        void insert(D d){};//FALTA
        void insert(D d, SingleNode<D> p){
            p->item;
        };//FALTA
        void remove(D d){ }; //Falta
        void remove(SingleNode<D> p){ }; //Falta
        D find(int k){};//Falta
};

/**
 * @brief PLantilla de clase que va a recibir un tipo de dato D (int. double, etc) y un objeto tipo DoubleNode
 * que es de tipo dato D 
 * 
 */
template<typename D>
class LinkedListDN : public List<D, DoubleNode<D> > {
    public:
        LinkedListDN(){};
        ~LinkedListDN(){};

        void print() { //FALTA

        };

        void insert(D d){};//FALTA
        void insert(D d, DoubleNode<D> p){
            p->item;
        };//FALTA
        void remove(D d){ }; //Falta
        void remove(DoubleNode<D> p){ }; //Falta
        D find(DoubleNode<D> k){};//Falta
};

#endif
