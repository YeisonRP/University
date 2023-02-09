/*
 * main.c
 * 
 * Copyright 2017 marco <marco@demiurgo>
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 * 
 * 
 */


#include "fifo.h"
#define TAMANOFIFO 12

int main(int argc, char **argv)
{
	

	fifo_t *mififo = NULL;

	mififo=createFifo(TAMANOFIFO);
	srand(time(NULL)); //Para semilla de rand
	for(int i=0;i<TAMANOFIFO;i++){
		int n = rand()%10;
		writeData(mififo,n);
	}
	
	printFifo(mififo);
	int firstin=readData(mififo);
	int segundoin=readData(mififo);
	
	printf("Primer dato introducido es = %d \n",firstin);
	printf("Segundo dato introducido es = %d \n",segundoin);
	
	flushFifo(mififo);
	
	// PROCEDERE CON OTRAS PRUEBAS AL PROGRAMA

	printf("ESTAS PRUEBAS FUERON AGREGADAS PARA DEMOSTRAR OTRAS FUNCIONALIDADES\n\n\n");
	printf("INGRESANDO TRES DATOS NUEVOS\n");
	// INGRESANDO NUEVAMENTE TRES DATOS
	writeData(mififo,1);
	writeData(mififo,4);
	writeData(mififo,6);
	printf("IMPRIMIENDO LA LISTA\n");
	// IMPRIMIENDO LISTA
	printFifo(mififo);

	printf("LEYENDO LOS DATOS DE LA LISTA\n");
	printf("El dato leido es = %d \n",readData(mififo));
	printf("El dato leido es = %d \n",readData(mififo));
	printf("El dato leido es = %d \n",readData(mififo));
	
	printf("Vemos que si se intenta leer un dato que no ha sido ingresado al FIFO con anterioridad\n");
	printf("La funcion readData retorna un %d \n",readData(mififo));

	printf("Esto ocure porque autimaticamente al leer el ultimo dato flushea la lista y esta queda vacia, para evitar errores\n");
	
	// LIBERANDO LA MEMORIA
	freeFifo(mififo);
	
	return 0;
}

