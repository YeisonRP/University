#include "tree.h"
int main(int argc, char** args)
{   
    //Creando arbol
    Tree<int, TreeNode<int> > *arbolitoBinario = new Tree<int, TreeNode<int> >();
    

        //Inicio: SECCION PARA PROBAR METODOS DEL ARBOL O NODO
        //////////////////////////////////////////////////////////////////////////////////////
            
            // arbolitoBinario->insert(20);
            cout << "   INSERTANDO LOS VALORES INICIALES DEL ARBOL" << endl;
            arbolitoBinario->insert(11);
            arbolitoBinario->insert(5);
            arbolitoBinario->insert(20);            
            arbolitoBinario->insert(25);
            arbolitoBinario->insert(35);
            arbolitoBinario->insert(45);
            arbolitoBinario->insert(46);
            //arbolitoBinario->insert(49);

            cout << "   Imprimiendo arbol en modo InOrden" << endl;
            arbolitoBinario->inOrder();
            cout << endl;
            //cout << arbolitoBinario->size << endl;

            cout << "   Imprimiendo arbol en modo posOrder" << endl;
            arbolitoBinario->posOrder();
            cout << endl;

            cout << "   Imprimiendo arbol en modo preOrder" << endl;            
            arbolitoBinario->preOrder();
            cout << endl;

            cout << "   REMOVIENDO DATOS" << endl;

            arbolitoBinario->remove(10);
            arbolitoBinario->remove(25);
            arbolitoBinario->remove(45);

            cout << "   Imprimiendo arbol en modo InOrden" << endl;
            arbolitoBinario->inOrder();
            cout << endl;
            //cout << arbolitoBinario->size << endl; //pruebo tamano

            cout << "   Imprimiendo arbol en modo posOrder" << endl;
            arbolitoBinario->posOrder();
            cout << endl;

            cout << "   Imprimiendo arbol en modo preOrder" << endl;            
            arbolitoBinario->preOrder();
            cout << endl;



            cout << "************************************" << endl << endl;
            cout << "   BALANCEANDO EL ARBOL" << endl;
            arbolitoBinario->insert(26);
            arbolitoBinario->insert(45);

            cout << "   El arbol sin balancear es (preOrder)" << endl;
            arbolitoBinario->preOrder();
            arbolitoBinario->balance();
            cout << endl << "   Imprimiendo en preOrder el arbol balanceado" << endl;
            arbolitoBinario->preOrder();
            cout << endl;

            cout << "   REALIZANDO BUSQUEDAS" << endl;
            arbolitoBinario->find(25);
            arbolitoBinario->find(26);
            arbolitoBinario->find(5);
            arbolitoBinario->find(11);
            arbolitoBinario->find(46);
            arbolitoBinario->find(90);

        //Fin: SECCION PARA PROBAR METODOS DEL ARBOL O NODO
        /////////////////////////////////////////////////////////////////////////////////////

    delete arbolitoBinario; //borrando el arbol

    return 0;
}