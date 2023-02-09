#include "lista.h"
#include <stdio.h> // asd
#include <stdlib.h> // asd
#include <string.h> //asd

/**
 *		front
 * 	_________________
 * 	|_____head______|
 * 	|_______________|
 * 	|_______________|
 * 	|_______________|
 *      |_____tail______|
 *
 * 		back
 **/


pos_t* createList(int first_value){
	

	pos_t *head = NULL;

	head = (pos_t *)malloc(sizeof(pos_t));
	(*head).data = first_value;
	(*head).next = NULL;


	return head;
}


pos_t* readList(const char* filePath){

    int i;
    int DATOS = 10000;
    int x;
    pos_t *current;


	FILE* file = fopen(filePath, "rb");

        for(i=1;i<=DATOS;i++) {
		if (file != NULL) {
			fread (&x, sizeof (x), 1, file);

			if(i == 1){current = createList(x);}
			else{push_back(current, x);}


			}
		}
        //Cerrando archivo
        fclose(file);

    printf("Se ha creado una lista con %d elementos\n\n",DATOS);
	return current;
}


void writeList(pos_t* head, const char* filePath){

	pos_t *auxiliar = head;

	FILE *archivo;
	char num[10]={0};
	int n;
	archivo=fopen(filePath,"w"); //se cambió a write para que escriba la lista nueva cada vez que el usuario quiera

	if (!archivo) {
        printf("No se pudo abrir el archivo");
        exit(1);
        }

    while((*auxiliar).next != NULL){

        fprintf(archivo, "%d\n", (*auxiliar).data);
        auxiliar = (*auxiliar).next;

    }

       fprintf(archivo, "%d\n", (*auxiliar).data);

    fclose(archivo);
}

int push_back(pos_t* head, int new_value){
 

    int retorno = 0;
    pos_t *auxiliar = head;

// Obteniendo ultimo puntero actual
    while((*auxiliar).next != NULL){
        auxiliar = (*auxiliar).next;
    }

	pos_t *auxiliar2 = (pos_t *)malloc(sizeof(pos_t)); // Reservando memoria para nuevo dato pos_t

	if(auxiliar2 == NULL){
        retorno = 1;
        free(auxiliar2);

    }
	else{
		(*auxiliar2).data = new_value;  // Agregando el dato
        (*auxiliar2).next = NULL;  // PUntero final NULL

        (*auxiliar).next = auxiliar2; // PUntero penultimo apunta al ultimo

	}



return retorno;
}


/**TERMINADA, FALTA ENTERO QUE RETORNA **/
int push_front(pos_t** head, int new_value){

    int retorno = 0;
    pos_t *auxiliar = *head;

    pos_t *auxiliar2 = (pos_t *)malloc(sizeof(pos_t)); //memoria nuevo dato
    if(auxiliar2 == NULL){
    retorno = 1;

    free(auxiliar2);
    }
    else{
	(*auxiliar2).data = new_value;  // Agregando el dato
	(*auxiliar2).next = auxiliar;  // PUntero final a dato posterior
    *head = auxiliar2;

    }

    return retorno;
}


int pop_front(pos_t **head){//Remueve el head!

    pos_t *auxiliar = *head;

    int numero = (*auxiliar).data;

    pos_t *auxiliar2 = (*auxiliar).next;

    free(*head);
    *head = NULL;

    *head = auxiliar2;

    return numero;
}


int pop_back(pos_t* head){

    pos_t *auxiliar = head;
    pos_t *auxiliar2 = head;

        while((*auxiliar).next != NULL){
            auxiliar2 = auxiliar;
            auxiliar = (*auxiliar).next;
        }
    int a = (*auxiliar).data;
    free(auxiliar);
    auxiliar = NULL;

    (*auxiliar2).next = NULL;

    return a;
	
}


int insertElement(pos_t** head, int pos, int new_value){

    pos_t *auxiliar = *head; //guarda el puntero posterior en donde se desea ingresar la variable
    pos_t *auxiliar2 = *head; // guarda el puntero anterior en donde se desea ingresar la variable
    int contador = 1; //contador
    int controlador = 0;
    int retorno = 0;

    if(pos == 1){push_front(head, new_value);}
    else{

        while((*auxiliar).next != NULL){


            if(contador == pos){
                pos_t *auxiliar3 = (pos_t *)malloc(sizeof(pos_t)); // reserva memoria en dato que se va a ingresar
                (*auxiliar3).data = new_value;
                (*auxiliar3).next = auxiliar;
                (*auxiliar2).next = auxiliar3;
                controlador = controlador + 1;
            }

            auxiliar2 = auxiliar;
            auxiliar = (*auxiliar).next;

            contador = contador + 1;
        }



        if(controlador == 0){   // REVISAR AQUI CUANDO SE QUIERE AGREGAR UN NUMERO FINAL

            if(contador == pos){ //repite el ciclo una vez más
                pos_t *auxiliar3 = (pos_t *)malloc(sizeof(pos_t)); // reserva memoria en dato que se va a ingresar
                (*auxiliar3).data = new_value;
                (*auxiliar3).next = auxiliar;
                (*auxiliar2).next = auxiliar3;

            }
            if(contador + 1 == pos){    // REVISAR ESTA FUNCION
            push_back(*head, new_value);
            retorno = 0;
            }
            else{
            printf("NO se pudo ingresar el valor");
            retorno = 1;}
        }
    }
    return retorno;

}


int removeElement(pos_t** head, int pos){
    pos_t *auxiliar = *head; //busqueda
    pos_t *auxiliar2 = *head; //apunta de atras
    pos_t *auxiliar3 = *head; //apunta adelante
    int retorno = 0;
    int contador = 1;
    int controlador = 0;

    if(pos == 1){ //caso especial si se elimina el inicial
        retorno = pop_front(head);
    }else{

        while((*auxiliar).next != NULL && controlador == 0){

            if(contador == pos){
                controlador = 1;
                retorno = (*auxiliar).data;
                (*auxiliar2).next = auxiliar3;
                free(auxiliar);
                auxiliar = NULL;
                goto finalizar; //cuando se elimina la variable y se libera memoria, se termina la funcion
            }
            contador = contador + 1;
            if(controlador == 0){

                auxiliar2 = auxiliar;
                auxiliar = (*auxiliar).next;
                auxiliar3 = (*auxiliar).next;
            }
        }
        if(contador == pos){
            retorno = pop_back(*head); //caso especial si se elimina el final
        }
        else{retorno = -1;}
    }
	finalizar:
    return retorno;
}



int freeList(pos_t* head){


    pos_t *auxiliar = head;

    if((*head).next != NULL){
        freeList((*head).next);
        }

    free(head);
    auxiliar = head;
    head = NULL;
}


int getElement(pos_t* head, int index, int* valid){

    int retorno = 0;
    pos_t *auxiliar = head;
    int contador = 1;
    int controlador = 0;


        while((*auxiliar).next != NULL && controlador == 0){
            if(contador == index){
                retorno = (*auxiliar).data ;
                controlador = 1;
                *valid = 0;
                goto finalmetodo;

            }
            contador = contador + 1;
            auxiliar = (*auxiliar).next;
        }
        if(contador == index && controlador == 0){retorno = (*auxiliar).data ;
            *valid = 0;
        }
        if(index > contador){*valid = 1;}

    finalmetodo:
    return retorno;	   
 
}


int printElement(const int value){
	printf("%d \n", value);
	return 0;
}


void sort(pos_t* head, char dir){

    pos_t *auxiliar = head; //variable que se quiere comparar
    pos_t *auxiliar2 = (*auxiliar).next; //variable que se quiere comparar, va adelante de auxiliar
    int cambio = 0; // variable necesaria para hacer el cambio
    int controlador = 0; //controla si ya se ordeno todo el arreglo

    char letra_a = 'a';
    char letra_d = 'd';
    char auxi_dir = dir;

    while(controlador == 0){

        auxiliar = head;
        auxiliar2 = (*auxiliar).next;
        controlador = 1;

        while((*auxiliar).next != NULL){


            if( ((*auxiliar).data > (*auxiliar2).data ) && (letra_a == auxi_dir)) { //ordena ascendente

                cambio = (*auxiliar).data;
                (*auxiliar).data = (*auxiliar2).data;
                (*auxiliar2).data = cambio;
                controlador = 0;

            }

            if( ((*auxiliar).data < (*auxiliar2).data ) && letra_d == auxi_dir) { // ordena descendente

                cambio = (*auxiliar).data;
                (*auxiliar).data = (*auxiliar2).data;
                (*auxiliar2).data = cambio;
                controlador = 0;

            }

            auxiliar = (*auxiliar).next;
            auxiliar2 = (*auxiliar).next;

        }

        }


	
	
}


void printList(pos_t* head){

int contador = 1;

pos_t *auxiliar = head;


     while ((*auxiliar).next != NULL){

        printf("Posición: %d     Valor: %d \n", contador, (*auxiliar).data);
        auxiliar = (*auxiliar).next;
        contador = contador + 1;
     }

     printf("Posición: %d     Valor: %d \n",contador, (*auxiliar).data);

}



