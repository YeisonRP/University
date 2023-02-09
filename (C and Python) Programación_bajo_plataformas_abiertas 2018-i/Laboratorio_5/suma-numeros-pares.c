#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int sumadedosnumeros(int a, int b);

/**
  *@brief Este programa pide al usuario un límite mínimo y máximo al usuario, y ejecuta la función sumadedosnumeros
  *@param r Este parámetro indica el rango inferior
  *@param g Este parámetro indica el rango superior
  */

int main (void) {
  int resultado;
  int r;
  int g;
 printf("Este programa calcula la suma de los números pares entre los dos rangos de número ingresados\n");
  printf("Ingrese el límite inferior \n");
  scanf("%d",&r);
  printf("Ingrese el límite superior \n");
  scanf("%d",&g);


  resultado =  sumadedosnumeros( r, g);

  printf("EL resultado es %d\n", resultado);

  return 0;

}


/**
  *@brief Este programa calcula la suma de los números pares dentro de un rango de números
  *@param a Este parámetro indica el rango inferior
  *@param b Este parámetro indica el rango superior
  *@return Es el resultado de la suma de los números pares
  */
int sumadedosnumeros(int a, int b){

  int c = 0;

  for(a;a<=b;a++) {

    if(a%2 == 0){ c = c + a;}


  }

  return c;


}
