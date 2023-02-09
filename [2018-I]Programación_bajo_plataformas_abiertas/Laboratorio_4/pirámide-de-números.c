
/*AUTOR: YEISON RODRÍGUEZ PACHECO */
/*FECHA: 21/04/18  */
/*dESCRIPCIÓN: ESTE PROGRAMA CREA UNA PIRÁMIDE DE NÚMEROS*/

#include <stdio.h>
#include <stdlib.h>
/**
  *@brief Este programa crea una pirámide de números.
  *@details Este programa solicita al usuario que ingrese la cantidad de lineas que va a tener su pirámide, para proceder a desplegarla en la pantalla.
  *@param a Número ingresado por el usuario que indica la longitud de la pirámide
  *@return Retorna una pirámide de números con la longitud del parámetro a
  */

int main() {

  int a, i, c;
  a = 1;
  
  printf("¿De cuántas líneas desea hacer la pirámide?\n");
  scanf("%d",&c);
 
  for (i = 1; i <= c; i++){
      
       for(a = 1;a <= i; a++) {

            if(a == i) { printf("%d \n",a); }
            else{ printf("%d",a); }        
       }
  }

  
  printf("Fue un placer\n");

  return 0;

}
