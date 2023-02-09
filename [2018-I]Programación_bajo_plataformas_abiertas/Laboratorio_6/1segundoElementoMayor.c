#include <stdio.h>
#include <stdlib.h>

int segMax(int  x[], int N);

/**
  *@brief Este programa pide al usuario un arreglo y ejecuta la función segMax
  *@param N Este parámetro indica el tamaño del arreglo
  *@param arreglo[N] Este arreglo es ingresado por el usuario
  */

int main (void) {

    int N;
    printf("Ingrese el tamaño del arreglo, máximo 10\n");
    scanf("%d",&N);
    if(N>10){printf("No se pueden ingresar más de 10 datos, ERROR\n");}
    else{
        int arreglo[N];

        int i;
        for(i = 1;i<=N;i++){

            printf("Ingrese el dato %d del arreglo\n",i);
            scanf("%d",&arreglo[i]);
        }
        printf("El segundo máximo es: %d\n",segMax(arreglo, N));
    }
    return 0;
}

/**
  *@brief Este programa calcula el segundo máximo de un arreglo
  *@param max Guarda el valor del máximo
  *@param segmax Guarda el valor del segundo máximo
  *@param posmax Guarda la posición del máximo
  *@return Retorna el segundo máximo en formato int
  */

int segMax(int x[], int N){

    int max = -999999;
    int segmax = -999999;
    int  i;
    int j;
    int posmax = 0;

    for(i = 1;i <= 2; i++){
        for(j = 1;j <= N; j++){
            if(x[j] > max && i == 1){
                max = x[j];
                posmax = j;
            }
            if((x[j] >= segmax) && (i == 2) && (j != posmax)){segmax = x[j];}
        }
    }

    return segmax;
}








