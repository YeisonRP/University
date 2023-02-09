#include <stdio.h>
#include "lista.h"

int main()
{   
int primer;
    int decision;
    const char* escribir_path = "listaenlazada.txt"; //documento para guardar los valores de la lista

    printf("Hola, este programa es una biblioteca para una lista enlazada.\n");
    printf("Seleccione la opción que desea con el número indicado en el índice.\n");
    printf("1. Crear una lista enlazada desde cero\n");
    printf("2. Crear una lista enlazada desde un archivo binario\n");
    scanf("%d",&decision);

    if(decision == 1){
    printf("Ingrese el primer elemento de la lista.\n");
    scanf("%d",&primer);

    pos_t *primer_puntero = createList(primer);
    pos_t **puntero_a_primer_puntero = &primer_puntero;



    int terminar = 0;
    int menu = 0;
    int agregar_final = 0;
    int agregar_inicio = 0;
    int eliminar_elemento = 0;
        int controlador_eliminar_elemento = 0;
    int obtener_elemento = 0;
        int indice = 0;
        int verif = 0;
        int *verificador = &verif;
        int guardador = 0;
    int insertar_elemento_verif = 0;
        int insertar_elemento = 0;
        int posicion_de_elemento_a_insertar = 1;
    int ordenar = 0;
        char up = 'a';
        char down = 'd';

    while(terminar == 0){
        printf("¿Qué desea hacer?\n");
        printf("1. Imprimir la lista. \n");
        printf("2. Agregar elemento al final de la lista. \n");
        printf("3. Agregar elemento al inicio de la lista. \n");
        printf("4. Eliminar elemento al final de la lista. \n");
        printf("5. Eliminar elemento al inicio de la lista. \n");
        printf("6. Insertar elemento a la lista. \n");
        printf("7. Remover elemento de la lista. \n");
        printf("8. Obtener elemento de la lista. \n");
        printf("9. Ordenar la lista. \n");
        printf("10. Guardar lista en archivo de texto. \n");
        printf("11. Borrar memoria de la lista. (el programa terminará) \n");
        printf("12. Salir del programa (se borrará la memoria de la lista) \n");
        scanf("%d",&menu);
        printf("\n");

        if(menu == 1){
            printf("La lista actual es:\n");
            printList(primer_puntero);
        }

        if(menu == 2){
            printf("Indique el valor del elemento a agregar al final de la lista\n");
            scanf("%d",&agregar_final);
            push_back(primer_puntero, agregar_final);
        }

        if(menu == 3){
            printf("Indique el valor del elemento a agregar al inicio de la lista\n");
            scanf("%d",&agregar_inicio);
            push_front(puntero_a_primer_puntero, agregar_inicio);
        }

        if(menu == 4){
            printf("El número eliminado al final es %d \n", pop_back(primer_puntero));
            printf("\n");
        }

        if(menu == 5){
            printf("El número eliminado al comienzo es %d \n", pop_front(puntero_a_primer_puntero));
            printf("\n");
        }

        if(menu == 6){
            printf("Indique el valor del elemento a agregar en la lista\n");
            scanf("%d",&insertar_elemento);

            printf("Indique la posición del elemento a agregar en la lista\n");
            scanf("%d",&posicion_de_elemento_a_insertar);

            insertar_elemento_verif = insertElement(puntero_a_primer_puntero, posicion_de_elemento_a_insertar, insertar_elemento);

            if(insertar_elemento_verif == 1){
                printf("No se pudo agregar el elemento a la lista\n");
            }
            else{
                printf("El elemento fue agregado a la lista\n");
            }
        }

        if(menu == 7){ //CUIDADO CON ESTA FUNCIÓN, SI SE ELIMINA UN -1 POR LA NATURALEZA QUE TIENE DARA UN ERROR
        //NO ES CULPA MIA SINO DEL ENUNCIADO, QUE LO PIDE ASI
        printf("Indique la posición del número en la lista que desea eliminar. comenzando por 1\n");
        scanf("%d",&eliminar_elemento);
        controlador_eliminar_elemento = removeElement(puntero_a_primer_puntero,eliminar_elemento);

        if(controlador_eliminar_elemento == -1){
            printf("No se pudo eliminar este elemento\n ");
        }
        else{
            printf("Se eliminó el numero %d \n ",controlador_eliminar_elemento);
            printf("\n");
            menu = 1;
        }

        }

        if(menu == 8){
        printf("Cual es la posición del número en la lista que desea encontrar\n ");
        scanf("%d",&indice);
        guardador = getElement(primer_puntero, indice, verificador);
            if(*verificador == 1){
                printf("EL valor ingresado no fue válido\n ");
            }
            else{
                printf("El número encontrado tiene el valor de %d\n ",guardador);
            }

        }

        if(menu == 9){
            printf("Ingrese un 0 para ordenar la lista de manera ascendente o un 1 de manera descendente\n ");
            scanf("%d",&ordenar);

            if(ordenar == 0){

                    sort(primer_puntero, up);
                    printf("La lista fue ordenada de manera ascendente\n ");
                    printf("\n");
            }
            if(ordenar == 1){

                    sort(primer_puntero, down);
                    printf("La lista fue ordenada de manera descendente\n ");
                    printf("\n");
            }

            if(ordenar != 0 && ordenar != 1){
                printf("Valor no válido, no se hizo nada\n ");
                printf("\n");
            }
        }

        if(menu == 10){
            writeList(primer_puntero, escribir_path);
            printf("Se guardó la lista en el archivo de texto.\n");
        }


        if(menu == 11){
            freeList(primer_puntero);
            terminar = 1;
        }

        if(menu == 12){
	    freeList(primer_puntero);
            terminar = 1;
        }

    }

    }

    if(decision == 2){


    const char* asd = "datos.bin";



        pos_t *primer_puntero = readList(asd);
        pos_t **puntero_a_primer_puntero = &primer_puntero;



    int terminar = 0;
    int menu = 0;
    int agregar_final = 0;
    int agregar_inicio = 0;
    int eliminar_elemento = 0;
        int controlador_eliminar_elemento = 0;
    int obtener_elemento = 0;
        int indice = 0;
        int verif = 0;
        int *verificador = &verif;
        int guardador = 0;
    int insertar_elemento_verif = 0;
        int insertar_elemento = 0;
        int posicion_de_elemento_a_insertar = 1;
    int ordenar = 0;
        char up = 'a';
        char down = 'd';

    while(terminar == 0){
        printf("¿Qué desea hacer?\n");
        printf("1. Imprimir la lista. \n");
        printf("2. Agregar elemento al final de la lista. \n");
        printf("3. Agregar elemento al inicio de la lista. \n");
        printf("4. Eliminar elemento al final de la lista. \n");
        printf("5. Eliminar elemento al inicio de la lista. \n");
        printf("6. Insertar elemento a la lista. \n");
        printf("7. Remover elemento de la lista. \n");
        printf("8. Obtener elemento de la lista. \n");
        printf("9. Ordenar la lista. \n");
        printf("10. Guardar lista en archivo de texto \n");
        printf("11. Borrar memoria de la lista. (el programa terminará) \n");
        printf("12. Salir del programa (se borrará la memoria de la lista) \n");
        scanf("%d",&menu);
        printf("\n");

        if(menu == 1){
            printf("La lista actual es:\n");
            printList(primer_puntero);
        }

        if(menu == 2){
            printf("Indique el valor del elemento a agregar al final de la lista\n");
            scanf("%d",&agregar_final);
            push_back(primer_puntero, agregar_final);
        }

        if(menu == 3){
            printf("Indique el valor del elemento a agregar al inicio de la lista\n");
            scanf("%d",&agregar_inicio);
            push_front(puntero_a_primer_puntero, agregar_inicio);
        }

        if(menu == 4){
            printf("El número eliminado al final es %d \n", pop_back(primer_puntero));
            printf("\n");
        }

        if(menu == 5){
            printf("El número eliminado al comienzo es %d \n", pop_front(puntero_a_primer_puntero));
            printf("\n");
        }

        if(menu == 6){
            printf("Indique el valor del elemento a agregar en la lista\n");
            scanf("%d",&insertar_elemento);

            printf("Indique la posición del elemento a agregar en la lista\n");
            scanf("%d",&posicion_de_elemento_a_insertar);

            insertar_elemento_verif = insertElement(puntero_a_primer_puntero, posicion_de_elemento_a_insertar, insertar_elemento);

            if(insertar_elemento_verif == 1){
                printf("No se pudo agregar el elemento a la lista\n");
            }
            else{
                printf("El elemento fue agregado a la lista\n");
            }
        }

        if(menu == 7){ //CUIDADO CON ESTA FUNCIÓN, SI SE ELIMINA UN -1 POR LA NATURALEZA QUE TIENE DARA UN ERROR
        //NO ES CULPA MIA SINO DEL ENUNCIADO, QUE LO PIDE ASI
        printf("Indique la posición del número en la lista que desea eliminar. comenzando por 1\n");
        scanf("%d",&eliminar_elemento);
        controlador_eliminar_elemento = removeElement(puntero_a_primer_puntero,eliminar_elemento);

        if(controlador_eliminar_elemento == -1){
            printf("No se pudo eliminar este elemento\n ");
        }
        else{
            printf("Se eliminó el numero %d \n ",controlador_eliminar_elemento);
            printf("\n");
            menu = 1;
        }

        }

        if(menu == 8){
        printf("Cual es la posición del número en la lista que desea encontrar\n ");
        scanf("%d",&indice);
        guardador = getElement(primer_puntero, indice, verificador);
            if(*verificador == 1){
                printf("EL valor ingresado no fue válido\n ");
            }
            else{
                printf("El número encontrado tiene el valor de %d\n ",guardador);
            }

        }

        if(menu == 9){
            printf("Ingrese un 0 para ordenar la lista de manera ascendente o un 1 de manera descendente\n ");
            scanf("%d",&ordenar);

            if(ordenar == 0){

                    sort(primer_puntero, up);
                    printf("La lista fue ordenada de manera ascendente\n ");
                    printf("\n");



            }
            if(ordenar == 1){

                    sort(primer_puntero, down);
                    printf("La lista fue ordenada de manera descendente\n ");
                    printf("\n");
            }

            if(ordenar != 0 && ordenar != 1){
                printf("Valor no válido, no se hizo nada\n ");
                printf("\n");
            }
        }

        if(menu == 10){
            writeList(primer_puntero, escribir_path);
            printf("Se guardó la lista en el archivo de texto.\n");
        }

        if(menu == 11){
            freeList(primer_puntero);
            terminar = 1;
        }

        if(menu == 12){
	    freeList(primer_puntero);
            terminar = 1;
        }

    }

    }




     return 0;
}
