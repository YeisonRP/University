

#include <stdio.h>
#include <string.h>



/**
  *@brief Este programa compara dos cadenas de caracteres
  *@details Este programa solicita al usuario dos cadenas de caracteres, para proceder a retornar un mensaje de si son iguales o no
  *@param cadena1 cadena de strings
  *@param cadena2 cadena de strings
  *@param comparacion Tiene el valor de cero si las cadenas son iguales
  *@return Retorna un mensaje diciendo si las cadenas son iguales o no
  */


int main () {


   char cadena1[20];
   char cadena2[20];
   int comparacion;

   printf("Ingrese la cadena 1 de caracteres : ");
   fgets(cadena1, 20, stdin);
   printf("Ingrese la cadena 2 de caracteres : ");
   fgets(cadena2, 20, stdin);
   comparacion = strcmp(cadena1,cadena2);

   if(comparacion == 0) {printf("Las cadenas son iguales\n");}
   else{printf("Las cadenas no son iguales\n");}

   


   return(0);
}
