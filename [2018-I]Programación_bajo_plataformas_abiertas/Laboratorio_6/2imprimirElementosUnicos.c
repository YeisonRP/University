#include <stdio.h>
#include <stdlib.h>

void numUnic(int x[], int N);

/**
  *@brief Este programa pide al usuario un arreglo y ejecuta la función numUnic
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
        numUnic(arreglo, N);
    }
    return 0;
}

/**
  *@brief Este programa calcula los números que son únicos del arreglo
  *@param controlador Controla si se encontró algún número repetido.
  *@return No retorna ningún valor, imprime en pantalla los números únicos
  */

void numUnic(int x[], int N){

    int  i;
    int j;
    int controlador;
    printf("Acá se muestra si existen elementos único en el arreglo:\n");

    for(i = 1;i <=  N; i++){
        controlador = 0;
        for(j = 1;j <= N; j++){
            if( i != j && x[i] ==  x[j]){controlador = 1;}
        }
    if(controlador == 0){printf("%d ",x[i]);}
    }
    printf("\n");

}










