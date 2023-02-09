/**
 * @file tree.h
 * @author Yeison Rodriguez y FAbian GUerra
 * @brief Clase emplantillada de un arbol binario
 * @version 0.1
 * @date 2018-11-16
 * 
 * @copyright Copyright (c) 2018
 * 
 */

#include "treeNode.h"
#include <array>
#include <iostream>

//CLASE TREE: arbol

template <typename D, typename node> // D: dato    node: nodo
class Tree{
    public:
        /**
         * @brief Construct a new Tree object
         * 
         */
        Tree(); //YA
        /**
         * @brief Destroy the Tree object
         * 
         */
        ~Tree(); //YA

        /**
         * @brief Construct a new Tree object
         * 
         * @param data 
         */
        Tree(D data); //YA

        node *root;        //PUNTERO AL PRIMER ELEMENTO DEL ARBOL

        /**
         * @brief Inserta un dato en el arbol
         * 
         * @param d DAto a ingresar
         */
        void insert(D d);   //YA

        /**
         * @brief Remueve un dato del arbol
         * 
         * @param d DAto a borrar
         * @return true Si pudo borrar el dato a borrar
         * @return false Si no encontro el dato a borrar
         */
        bool remove (D d);  //YA

        /**
         * @brief Encuentra un dato
         * 
         * @param d Dato a encontrar
         */
        void find (D d);    //YA

        /**
         * @brief Recorre el arbol de una manera especifica para encontrar el nodo mas largo a la izq
         * 
         * @param n nodo padre de donde se quiere correr el algoritmo
         * @return node* REtorna el nodo encontrado
         */
        node *findLargestToTheLeft(node* n); //YA

        /**
         * @brief Recorre el arbol de una manera especifica para encontrar el nodo mas largo a la derecha
         * 
         * @param n nodo padre de donde se quiere correr el algoritmo
         * @return node* REtorna el nodo encontrado
         */
        node *findLargestToTheRight(node* n); //YA

        /**
         * @brief Recorre el arbol en preOrder y lo imprime
         * 
         */
        void preOrder();    //YA

        /**
         * @brief  Recorre el arbol en preOrder y lo imprime
         * 
         */
        void posOrder();    //YA

        /**
         * @brief  Recorre el arbol en preOrder y lo imprime
         * 
         */
        void inOrder();     //YA

        /**
         * @brief Hace un balance del arbol binario
         * 
         */
        void balance();     //YA 

        /**
         * @brief SE llena un array en inOrden, requisito de la funcion balance
         * 
         * @param n 
         * @param p 
         */
        void LlenarArrayInOrden(node* n, D p[]); //LO puse para el balance

        /**
         * @brief Inserta en el arbol de manera balanceada
         * 
         * @param min 
         * @param max 
         * @param valores 
         */
        void insertBalanceado(int min, int max, D* valores); //YA

        void deleteTreeData(node* n); //YA

        int size;
        int contador;
    private:
        int height;
       
        //MEtodos extras, el profe dijo que se debian agregar mas de fijo:
        /**
         * @brief Es un metodo que arranca un nodo de un arbol, utilizado para remove, el nodo arrancado es utilizado para reconstruir el arbol cuando se hace un remove
         * 
         * @param n nodo padre 
         * @return node* REtorna el puntero al nodo arrancado del arbol
         */
        node *detachLargestToTheLeft(node* n); //arranca un nodo del arbol, es para el metodo de remover
        /**
         * @brief Es un metodo que arranca un nodo de un arbol, utilizado para remove, el nodo arrancado es utilizado para reconstruir el arbol cuando se hace un remove
         * 
         * @param n nodo padre 
         * @return node* REtorna el puntero al nodo arrancado del arbol
         */
        node *detachLargestToTheRight(node* n); //arranca un nodo del arbol, es para el metodo de remover

        /**
         * @brief FUncion para hacer llamados recursivos e imprimir en InOrden
         * 
         * @param padre 
         */
        void imprimirArbolitoInOrden(node *padre);      //YA

        /**
         * @brief FUncion para hacer llamados recursivos e imprimir en PreOrden
         * 
         * @param padre 
         */
        void imprimirArbolitoPreOrden(node *padre);     //YA

        /**
         * @brief FUncion para hacer llamados recursivos e imprimir en PostOrden
         * 
         * @param padre 
         */
        void imprimirArbolitoPostOrden(node *padre);    //YA

        /**
         * @brief Funcion que se utiliza para hacer llamados recursivos y borrar el arbol
         * 
         * @param n 
         */
        void deleteTree(node *n); //YA
};


//constructor de arbol binario    
template<typename D, typename node>
Tree<D, node>::Tree(){

    this->root = NULL;
    this->size = 0;
    this->contador =0;
    
};

//constructor con dato de arbol binario
template<typename D, typename node>
Tree<D, node>::Tree(D data){

    this->root = new TreeNode<D>(data);
    this->size = 1;
    cout << "Se creo el nodo raiz con el dato: "<< data << endl;

};

//destructor arbol binario
template<typename D, typename node>
Tree<D, node>::~Tree(){
    deleteTree(this->root);
};

template<typename D, typename node>
void Tree<D, node>::deleteTree(node *n){

    if( (n->left == NULL) && (n->right == NULL) ){delete n;}
    else {
        if(n->left != NULL){ deleteTree(n->left);}
        if(n->right != NULL){deleteTree(n->right);}
        delete n;
    }
}

template<typename D, typename node>
void Tree<D, node>::preOrder(){
    this->imprimirArbolitoPreOrden(this->root);
}

template<typename D, typename node>
void Tree<D, node>::posOrder(){
    this->imprimirArbolitoPostOrden(this->root);
}

template<typename D, typename node>
void Tree<D, node>::inOrder(){
    this->imprimirArbolitoInOrden(this->root);
}

//Se inserta un dato en el arbol, si es el primero debe crear el nodo raiz
// Terminado, falta probar
template<typename D, typename node>
void Tree<D, node>::insert(D d){

    node* padre = this->root;
    if (this->root == NULL){ //si el arbol esta vacio, lo crea.
    cout << "insertando " << d << endl;
        this->root = new TreeNode<D>(d);  
    }
    else{                   //Si el arbol no esta vacio...
        int i = 0;
        while(i == 0){
            if(d < padre->data){ //si es menor el dato que el padre, va a la izq
                if(padre->left == NULL){ 
                    cout << "insertando " << d << endl;
                   padre->left = new TreeNode<D>(d);
                   this->size +=1;
                   i = 1; 
                }
                padre = padre->left;
                
            }
            else{
                if(d > padre->data){ // si es mayor va a la derecha
                    if(padre->right == NULL){ 
                    cout << "insertando " << d << endl;
                    padre->right = new TreeNode<D>(d);
                    this->size +=1;
                    i = 1; 
                    }
                    padre = padre->right;
                    
                }
                else{
                    if(padre->data == d){ // si es igual no se ingresa
                        //cout << "El dato no se ingreso porque ya existia en el arbol" << endl;
                        i = 1;
                    }
                }
            }
        }
    }
};



template<typename D, typename node>
void Tree<D, node>::imprimirArbolitoInOrden(node *padre){

    if( (padre->left == NULL) && (padre->right == NULL) ){cout << padre->data << endl;}
    else {
        if(padre->left != NULL){ imprimirArbolitoInOrden(padre->left);}
        cout << padre->data << endl;
        if(padre->right != NULL){imprimirArbolitoInOrden(padre->right);}
    }
};


template<typename D, typename node>
void Tree<D, node>::imprimirArbolitoPreOrden(node *padre){

    if( (padre->left == NULL) && (padre->right == NULL) ){cout << padre->data << endl;}
    else {
        cout << padre->data << endl;
        if(padre->left != NULL){ imprimirArbolitoPreOrden(padre->left);}
        if(padre->right != NULL){imprimirArbolitoPreOrden(padre->right);}
    }
};


template<typename D, typename node>
void Tree<D, node>::imprimirArbolitoPostOrden(node *padre){

    if( (padre->left == NULL) && (padre->right == NULL) ){cout << padre->data << endl;}
    else {
        if(padre->left != NULL){ imprimirArbolitoPostOrden(padre->left);}
        if(padre->right != NULL){imprimirArbolitoPostOrden(padre->right);}
        cout << padre->data << endl;
    }
};


template<typename D, typename node>
node *Tree<D, node>::findLargestToTheLeft(node* n){
    
    if(n->left == NULL){    //Si no se puede encontrar el nodo a la izq que esta mas largo
        return NULL;
    }

    node* padre = n->left;
    while(true){
        if(padre->right == NULL){  return padre;  }
        else{  padre = padre->right;  }
    }
};

template<typename D, typename node>
node *Tree<D, node>::findLargestToTheRight(node* n){
    
    if(n->right == NULL){    //Si no se puede encontrar el nodo a la der que esta mas largo
        return NULL;
    }

    node* padre = n->right;
    while(true){
        if(padre->left == NULL){  return padre;  }
        else{  padre = padre->left;  }
    }
};


template<typename D, typename node>
bool Tree<D, node>::remove(D d){
    int direccion = 2; // 0 a izq, 1 a derecha, 2 nodo raiz
    node *padre = this->root;
    node *padreDelPadre = NULL; //apunta hacia el padre del padre  actual (abuelo?)

    while(true){
        if(padre == NULL){  // por si el elemento no estaba en el arbol
            cout << "El elemento " << d << " no estaba en el arbol para eliminarlo" << endl;
            return false;
        }
        
        if(d < padre->data){//buscando dato en la izq del arbol
            direccion = 0;
            padreDelPadre = padre;
            padre = padre->left;
        } 
        else if(d > padre->data){//buscando dato en la derecha del arbol
            direccion = 1;
            padreDelPadre = padre;
            padre = padre->right;
        } 
        else if(d == padre->data){// se encontro el dato


            // cuatro posibles casos

            // que sea una hoja el elemento a eliminar: YA SIRVE, PROBADO
            if(padre->left == NULL && padre->right == NULL){
                if(padreDelPadre == NULL){ // si es el nodo raiz
                    this->size -=1;
                    cout << "eliminando " << d << endl;
                    delete padre;
                    this->root = NULL; 
                    return true;
                } 
                 
                if(direccion == 0){ // si el padre del padre tomo camino izq
                    padreDelPadre->left = NULL;
                }
                if(direccion == 1){ // si el padre del padre tomo camino der
                    padreDelPadre->right = NULL;
                }         
                this->size -=1;
                cout << "eliminando " << d << endl;       
                delete padre;
                return true;
                
            }
            

            // que tenga un hijo el elemento a eliminar a la izq: YA SIRVE, PROBADO
            if((padre->left != NULL && padre->right == NULL)){
                if(padreDelPadre == NULL){ // si es el nodo raiz
                    this->root = padre->left;
                    this->size -=1;
                    cout << "eliminando " << d << endl;
                    delete padre; 
                    return true;
                }  
                if(direccion == 0){ // si el padre del padre tomo camino izq
                    padreDelPadre->left = padre->left;
                }
                if(direccion == 1){ // si el padre del padre tomo camino der
                    padreDelPadre->right = padre->left;
                }
                this->size -=1;
                cout << "eliminando " << d << endl;
                delete padre; 
                return true;
            }


            // que tenga un hijo el elemento a eliminar a la derecha: YA SIRVE, PROBADO
            if(padre->left == NULL && padre->right != NULL){

                if(padreDelPadre == NULL){ // si es el nodo raiz
                    this->root = padre->right;
                    this->size -=1;
                    cout << "eliminando " << d << endl;
                    delete padre; 
                    return true;
                }  
                if(direccion == 0){ // si el padre del padre tomo camino izq
                    padreDelPadre->left = padre->right;
                }
                if(direccion == 1){ // si el padre del padre tomo camino der
                    padreDelPadre->right = padre->right;
                }
                this->size -=1;
                cout << "eliminando " << d << endl;
                delete padre; 
                return true;
            }

            // que tenga 2 hijos el elemento a eliminar CASO MIEDO
            if(padre->left != NULL && padre->right != NULL){
                //hacer detach to the left al nodo o detach to the right
                node* NodoAPegarDondeEstaElQueSeElimina = this->detachLargestToTheLeft(padre);
                if(padreDelPadre == NULL){ // si es el nodo raiz
                    this->root = NodoAPegarDondeEstaElQueSeElimina;
                    NodoAPegarDondeEstaElQueSeElimina->left = padre->left;
                    NodoAPegarDondeEstaElQueSeElimina->right = padre->right;
                    this->size -=1;
                    cout << "eliminando " << d << endl;
                    delete padre;
                    return true;
                }  
                
                if(direccion == 0){ //izq el padre del padre
                    padreDelPadre->left = NodoAPegarDondeEstaElQueSeElimina;
                }
                if(direccion == 1){ //dere el padre del padre
                    padreDelPadre->right = NodoAPegarDondeEstaElQueSeElimina;
                }
                NodoAPegarDondeEstaElQueSeElimina->left = padre->left;
                NodoAPegarDondeEstaElQueSeElimina->right = padre->right;
                this->size -=1;
                cout << "eliminando " << d << endl;
                delete padre;
                return true;
            }
        }
    }
};

// el caso de la izq que busca el mas largo a la derecha
// el unico problema es si el que se quiere poner arriba tiene un hijo a la izq
// es imposible que tenga un hijo a la derecha, porque sino el algoritmo se iria ahi


template<typename D, typename node>
node *Tree<D, node>::detachLargestToTheLeft(node* n){
    
    if(n->left == NULL){    //Si no se puede encontrar el nodo a la izq que esta mas largo
        return NULL;
    }
    int flag = 0;
    int contador = 0;
    node* padreDelPadre = n;
    node* padre = n->left;
    
    
    while(flag == 0){
        
        if(padre->right == NULL){
              flag = 1;  
              }
        else{  
            padreDelPadre = padre;
            padre = padre->right; 
            }
        contador += 1;
    }
    // si padreDelPadre es nulo, se esta arrancando el nodo raiz, caso especial
    
    // si es la primer iteracion
    if(padre->left == NULL && padre->right == NULL && contador != 1){    // retorna el nodo arrancado
        padreDelPadre->right = NULL;
        return padre;
    }
    // si es la sig iteracion
    if(padre->left == NULL && padre->right == NULL && contador == 1){    // retorna el nodo arrancado
        padreDelPadre->left = NULL;
        return padre;
    }

    if(padre->left != NULL && contador != 1){
        padreDelPadre->right = padre->left;
        padre->left = NULL;
        return padre;
    }

    if(padre->left != NULL && contador == 1){
        padreDelPadre->left = padre->left;
        padre->left = NULL;
        return padre;
    }
    //siempre padre izq cambiar
    //aqui ya se tiene en padre el nodo a remplazar
};


template<typename D, typename node>
node *Tree<D, node>::detachLargestToTheRight(node* n){
    
    if(n->right == NULL){    //Si no se puede encontrar el nodo a la izq que esta mas largo
        return NULL;
    }
    int flag = 0;
    int contador = 0;
    node* padreDelPadre = n;
    node* padre = n->right;
    
    
    while(flag == 0){
        
        if(padre->left == NULL){
              flag = 1;  
              }
        else{  
            padreDelPadre = padre;
            padre = padre->left; 
            }
        contador += 1;
    }
    // si padreDelPadre es nulo, se esta arrancando el nodo raiz, caso especial
    
    // si es la primer iteracion
    if(padre->right == NULL && padre->left == NULL && contador != 1){    // retorna el nodo arrancado
        padreDelPadre->left = NULL;
        return padre;
    }
    // si es la sig iteracion
    if(padre->right == NULL && padre->left == NULL && contador == 1){    // retorna el nodo arrancado
        padreDelPadre->right = NULL;
        return padre;
    }

    if(padre->right != NULL && contador != 1){
        padreDelPadre->left = padre->right;
        padre->right = NULL;
        return padre;
    }

    if(padre->right != NULL && contador == 1){
        padreDelPadre->right = padre->right;
        padre->right = NULL;
        return padre;
    }
    //siempre padre izq cambiar
    //aqui ya se tiene en padre el nodo a remplazar
};


template<typename D, typename node>
void Tree<D, node>::balance(){
    
    D valores[this->size];
    LlenarArrayInOrden(this->root, valores);
    deleteTreeData(this->root);   
    int t = sizeof(valores) / sizeof(*valores);
    insert(valores[(t+1)/2]);
    insertBalanceado(0, t,valores);
    this->contador =0;
};

template<typename D,typename node>
void Tree<D,node>::insertBalanceado(int min, int max, D valores[]){
    int mid = static_cast<int>((min+max+1)/2);
    int midLeft = static_cast<int>((min+mid+1)/2);
    int midRight = static_cast<int>((max+mid+1)/2);
     insert(valores[mid]);
     cout << "se ingreso de forma balanceada " << valores[mid] << endl;

    if(min!=max){
        insertBalanceado(min, mid-1, valores);
        insertBalanceado(mid, max, valores);
    } 
    
};





template<typename D, typename node>
void Tree<D, node>::LlenarArrayInOrden(node *padre, D* valores){

    if( (padre->left == NULL) && (padre->right == NULL) ){
        valores[this->contador] = padre->data;
        //cout << "se ingreso de forma balanceada " << padre->data << endl;
        this->contador++;
        
    }
    else {
        if(padre->left != NULL){LlenarArrayInOrden(padre->left, valores);}
        valores[this->contador] = padre->data;
        //cout << "se ingreso de forma balanceada " << padre->data << endl;
        this->contador++;
        if(padre->right != NULL){LlenarArrayInOrden(padre->right, valores);}
    }
};


template<typename D, typename node>
void Tree<D, node>::deleteTreeData(node *n){

    if( (n->left == NULL) && (n->right == NULL) ){n->data=NULL;}
    else {
        if(n->left != NULL){ deleteTree(n->left);}
        if(n->right != NULL){deleteTree(n->right);}
        delete n;
    }
    this->size = 0;
};






template<typename D, typename node>
void Tree<D, node>::find(D d){

    node* padre = this->root;
    if (this->root->data == d){ //si encuentra el dato en el root
        cout << "se encontro el dato " << d << " en el root " << endl;
    }
    else{                   //Si el arbol no esta vacio...
        int i = 0;
        while(i == 0){
            if(d < padre->data){ //si es menor el dato que el padre, va a la izq

                if(padre->left != NULL){
                        padre = padre->left;
                    }else {
                        cout << "no se encontro el dato " << d << endl;
                        i =1;
                    }
                
            }
            else{
                if(d > padre->data){ // si es mayor va a la derecha
                    
                    if(padre->right != NULL){
                        padre = padre->right;
                    }else {
                        cout << "no se encontro el dato " << d << endl;
                        i =1;
                    }
                }
                else{
                    if(padre->data == d){ // si es igual  ingresa
                        cout << "se encontro el dato " << d  << endl;
                        i = 1;
                    } 
                }
            }
        }
    }
};