/**
 * @file treeNode.h
 * @author Yeison Rodriguez y FAbian GUerra
 * @brief Clase emplantillada de un nodo para un arbol binario
 * @version 0.1
 * @date 2018-11-16
 * 
 * @copyright Copyright (c) 2018
 * 
 */

#include <iostream>

using namespace std;
//CLASE TREENODE: cada nodo del arbol
template <typename D>
class TreeNode{
    public:
        //Atributos
        D data; 
        TreeNode<D> *left;      // No deberia ser TreeNode *left?
        TreeNode<D> *right;     // No deberia ser TreeNode *right?
        TreeNode<D> *parent;    // No deberia ser TreeNode *parent? Que era parent


        TreeNode();             //Constructor por defecto

        ~TreeNode();            //Destructor

        TreeNode(D data);       // constructor con dato

        void deleteNode();      
};

//Implementacion de los metodos:

/**
 * @brief Construct a new Tree Node< D>:: Tree Node object
 *  Constructor simple, no ingresa ningun dato en el nodo
 * @tparam D Tipo de dato que contendra el nodo
 */
template<typename D>
TreeNode<D>::TreeNode(){
    this->left = NULL;
    this->right = NULL;
    //revisar si se pone el parent  
};

template<typename D>
TreeNode<D>::~TreeNode(){
    
};
/**
 * @brief Construct a new Tree Node< D>:: Tree Node object
 * 
 * @tparam D Tipo de dato que contendra el nodo
 * @param data Dato a ingresar en el nodo
 */
template<typename D>
TreeNode<D>::TreeNode(D data){
    this->data = data;  //Guardando dato en el nodo
    this->left = NULL;
    this->right = NULL; 
    this->parent = NULL;
};

