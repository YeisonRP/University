#include <stdio.h>
#include <stdlib.h>
#include <math.h>



void ordenar(double  x[], int N);

/**
  *@brief Este programa pide al usuario que ingrese un arreglo de máximo 10 números y ejecuta a la funcion ordenar
  *@param N Este parámetro indica el tamaño del arreglo, se le solicita al usuario
  *@param arreglo[N] Este es el arrego de tamaño N
  */

int main (void) {

    int N;
    printf("Ingrese el tamaño del arreglo, máximo 10\n");
    scanf("%d",&N);
    if(N>10){printf("No se pueden ingresar más de 10 datos, ERROR\n");}
    else{
        double arreglo[N];

        int i;
        for(i = 1;i<=N;i++){

            printf("Ingrese el dato %d del arreglo\n",i);
            scanf("%lf",&arreglo[i]);
        }
        ordenar(arreglo, N);
    }
    return 0;
}

/**
  *@brief Este función ordena el vector ingresado de manera descendente
  *@param x[] es el arreglo que recibe la función
  *@param N Este parámetro indica el tamaño del arreglo
  *@return No retorna ningún valor numérico pero imprime en pantalla el vector ordenado
  */
void ordenar(double x[], int N){

    double aux1 = 0.0;
    double aux2 = 0.0;
    int fin = 1;
    int i;

    while(fin == 1) {


        fin = 0;
        for(i = 1; i < N; i++){

            if(x[i] < x[i+1]){

                aux1 = x[i+1];
                aux2 = x[i];

                x[i+1] = aux2;
                x[i] = aux1;

                fin = 1;

            }
        }
    }

    printf("Su vector ordenado es:\n");

    for(i = 1;i<=N;i++){
    	if(i == N) {printf("(%f)\n",x[i]);} 
else{
        printf("(%f), ",x[i]);}


    }


}
