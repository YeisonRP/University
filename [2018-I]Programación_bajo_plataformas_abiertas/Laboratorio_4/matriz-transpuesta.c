
/*AUTOR: YEISON RODRÍGUEZ PACHECO */
/*FECHA: 21/04/18  */
/*dESCRIPCIÓN: ESTE PROGRAMA CALCULA LA TRANSPUESTA DE UNA MATRIZ*/

#include <stdio.h>
#include <stdlib.h>
/**
  *@brief Este programa calcula la transpuesta de una matriz de cualquier dimensión
  *@details Este programa solicita al usuario que ingrese las dimensiones de la matriz a analizar, luego solicita todos los valores para finalizar calculando su transpuesta
  *@param filas Son las filas de la matriz
  *@param Columnas Son las columnas de la matriz
  *@param m Matriz que ingresa el usuario
  *@param mt Matriz transpuesta
  *@return Retorna la matriz ingresada y la matriz transpuesta
  */


int main( void ) {

  int filas, columnas; 
  int i, j;
  
  
  printf("¿De cuántas filas es su matriz?\n");
  scanf("%d",&filas);
 
  printf("¿De cuántas columnas es su matriz?\n");
  scanf("%d",&columnas);

  int m[filas][columnas];
  int mt[columnas][filas];

  for (i = 1; i <= filas; i++){
      for (j = 1; j <= columnas; j++){
            
          m[i][j] = 0;
        
      }  
  }

  i = 1;
  j = 1;

  for (i = 1; i <= filas; i++){
      for (j = 1; j <= columnas; j++){
            
          
          mt[j][i] = 0;
      }  
  }

  i = 1;
  j = 1;

  for (i = 1; i <= filas; i++){
      for (j = 1; j <= columnas; j++){
            
          printf("Ingrese el valor %d x %d de su matriz\n", i, j);
          scanf("%d",&m[i][j]);
       
          mt[j][i] = m[i][j];
      }  
  }
  
  i = 1;
  j = 1;

  printf("La matriz ingresada es: \n");

  for (i = 1; i <= filas; i++){
      for (j = 1; j <= columnas; j++){
            
          if(columnas != j) {printf("%d",m[i][j]);}
          else{printf("%d\n", m[i][j]);}
      }  
  }

  i = 1;
  j = 1;

  printf("La matriz transpuesta es: \n");

  for (i = 1; i <= columnas; i++){
      for (j = 1; j <= filas; j++){
            
          if(filas != j) {printf("%d",mt[i][j]);}
          else{printf("%d\n", mt[i][j]);}
      }  
  }

  printf("Fue un placer\n");

  return 0;

}
