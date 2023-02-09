#include "fifo.h"

/**
 *	Push/Write
 * 	_________________
 * 	|_____tail______|
 * 	|_______________|
 * 	|_______________|
 * 	|_______________|
 * 	|_____head______|
 *
 * 	Pull/Read
 **/

fifo_t* createFifo(int size){

    //reservar memoria
    int *A = (int *)calloc(size,sizeof(int));
    fifo_t *FIFO = (fifo_t *)(malloc(sizeof(fifo_t)));
    FIFO->tail = 0;
    FIFO->head = 0;
    FIFO->data = A;
    FIFO->size = size;
	//Inicializar FIFO

    return FIFO;
	//Regresar un fifo_t*

}

int writeData(fifo_t *fifo, int new_value){

    if(fifoIsFull(fifo) == TRUE)
       return 1;


    int *arreglo = fifo->data;
    int head = fifo->head;
    arreglo[head] = new_value;

    //Escribir dato
    fifo->head += 1;
    //Recuerde que tiene que modificar el head

    return 0;

}

int readData(fifo_t *fifo){

    if (fifoIsEmpty(fifo) == TRUE)
        return 1;


	//Leer el primer dato que se introdujo sin borrar nada!

    int tail = fifo->tail;
    int *arreglo = fifo->data;
    int dato = arreglo[tail];

    fifo->tail += 1;
    if(fifo->tail == fifo->head){
        flushFifo(fifo);
	}
	//Devolver dato leido
    return dato;
}

int printFifo(fifo_t *fifo){

	if (fifoIsEmpty(fifo) == TRUE)
		return 1;
    	int i;
	for(i =fifo->tail;i < fifo->head;i++)
		printf("Dato[%d] es igual a %d \n",i,fifo->data[i]);

	return 0;
}

int fifoIsFull(fifo_t *fifo){
    if (( (fifo->head == (fifo->size)) && (fifo->tail == 0)) )
        return TRUE;
    else
        return FALSE;
}

int fifoIsEmpty(fifo_t *fifo){
	//Devolver TRUE si esta vacio
	//Devolver FALSE si no esta vacio
    if (( (fifo->head == 0) && (fifo->tail == 0)) )
        return TRUE;
    else
        return FALSE;
}

void flushFifo(fifo_t *fifo){
	fifo->head = 0;
	fifo->tail = 0;
	int i;
	for(i = 0;i < fifo->size;i++)
		fifo->data[i]=0;

}

int freeFifo(fifo_t *fifo){

	//Liberar memoria asignada al FIFO
	free(fifo->data);
	fifo->data = NULL;
	free(fifo);
	fifo = NULL;
	return 0;
}

