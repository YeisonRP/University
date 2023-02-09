#include <stdio.h>
#include <stdlib.h>

void indBus(int x[], int N, int criterio);

/**
  *@brief Este programa pide al usuario un arreglo, un critrio de búsqueda
  *@param N Este parámetro indica el tamaño del arreglo
  *@param arreglo[N] Este arreglo es ingresado por el usuario
  *@param crit Este parámetro hace referencia al critério de búsqueda del usuario
  */

int main (void) {

    int N;
    int crit;

    printf("Ingrese el criterio de búsqueda\n");
    scanf("%d",&crit);

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
        indBus(arreglo, N, crit);
    }
    return 0;
}
 
/**
  *@brief Este programa calcula los números que son únicos del arreglo
  *@param tam_arreglo Indica el tamaño del arreglo que da los criterios de búsqueda
  *@param indice[tam_arreglo] Guarda los índices donde se coincidió con el criterio de búsqueda
  *@return No retorna ningún valor, imprime en pantalla el índice donde se encuentra el criterio de búsqueda
  */

void indBus(int x[], int N, int criterio){

    int i;
    int tam_arreglo = 0;

    for(i = 1; i <= N; i++){
        if(x[i] == criterio ){tam_arreglo = tam_arreglo + 1;}
    }

    int indice[tam_arreglo];
    int j = 1;

    for(i = 1; i <= N; i++){
        if(x[i] == criterio ){indice[j] = i;
        j = j + 1;
        }
    }
    if(tam_arreglo == 0){printf("No se encontró niguna coincidencia con el índice de búsqueda\n");}
    else{
    printf("Los índices que coinciden con el criterio de búsqueda son:\n");

    for(i = 1; i <= tam_arreglo; i++){

        printf("%d \n",indice[i]);
    }
}
}










