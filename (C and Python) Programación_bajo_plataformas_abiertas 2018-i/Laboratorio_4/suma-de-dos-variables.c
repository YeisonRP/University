
 
/*AUTOR: YEISON RODRÍGUEZ PACHECO */
/*FECHA: 21/04/18  */
/*dESCRIPCIÓN: ESTE PROGRAMA SUMA DOS VARIABLES QUE INGRESA EL USUARIO */

#include <stdio.h>
 
/**
  *@brief Este programa suma dos números
  *@details Este programa solicita al usuario que ingrese dos números enteros cualesquiera para retornar a la salida la suma de estos.
  *@param a primer número ingresado por el usuario
  *@param b segundo número ingresado por el usuario
  *@return Resultado de la suma de ambos números
  */

int main() {

  int a, b , c;
  printf("Ingrese el primer número que desea sumar\n");
  scanf("%d",&a);
  printf("Ingrese el segundo número que desea sumar\n");
  scanf("%d",&b);


  c = a + b;

  printf("EL resultado es %d\n",c);

  return 0;

}
