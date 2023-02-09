#include <stdio.h>
#include <stdlib.h>


void hanoi(int d, int tower1, int tower2, int tower3);

/**
  *@brief Este programa pide al usuario el número de discos que contiene la torre de hanoi y ejecuta la función hanoi
  *@param D Este parámetro indica el número de discos
  */

int main (void) {

  int D;
  printf("Este programa soluciona el puzzle de la torre de hanoi, paso a paso\n");
  printf("Ingrese el número de discos \n");
  scanf("%d",&D);


  hanoi( D, 1, 3, 2);

return 0;

}

/**
  *@brief Esta función calcula la solución paso a paso de como resolver una torre de hanoi
  *@param d Este parámetro indica el rango inferior
  *@param tower1 Este parámetro indica la torre inicial
  *@param tower2 Este parámetro indica la torre auxiliar
  *@param tower3 Este parámetro indica la torre final
  *@return El programa no retorna nada, pero imprime en pantalla la solución
  */

void hanoi(int d, int tower1, int tower3, int tower2){

if (d == 1){printf("Mueva el disco %d de la torre %d a %d\n", d, tower1, tower3);}
else{


hanoi(d - 1, tower1,  tower2,  tower3);
printf("Mueva el disco %d de la torre %d a %d\n", d, tower1, tower3);
hanoi(d - 1, tower2, tower3, tower1);

}

	




}
