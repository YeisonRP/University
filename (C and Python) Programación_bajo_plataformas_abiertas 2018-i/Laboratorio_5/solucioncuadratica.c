#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int solucioncuadratica(double a, double b, double c);

/**
  *@brief Este programa pide al usuario los tres parámetros de una ecuación cuadrática y ejecuta a la función solucion cuadrática
  *@param a Este parámetro indica el primer factor de la ecuación
  *@param b Este parámetro indica el segundo factor de la ecuación
  *@param c Este parámetro indica el tercer factor de la ecuación
  */

int main (void) {

  double r;
  double g;
  double b;
 printf("Este programa soluciona ecuaciones cuadráticas de la siguiente forma:\n ax^2 + b*x + c = 0\n");
  printf("Ingrese el parámetro a\n");
  scanf("%lf",&r);
  printf("Ingrese el parámetro b\n");
  scanf("%lf",&g);
  printf("Ingrese el parámetro c\n");
  scanf("%lf",&b);


  solucioncuadratica( r, g, b);

return 0;

}


/**
  *@brief Esta función calcula la solución de una ecación cuadrática
  *@param a Este parámetro indica el primer factor de la ecuación
  *@param b Este parámetro indica el segundo factor de la ecuación
  *@param c Este parámetro indica el tercer factor de la ecuación
  *@return No retorna ningún valor útil, imprime en pantalla las soluciones de la ecuación.
  */

int solucioncuadratica(double a, double b, double c){

	double discriminante;
	double solucion1;
	double solucion2;
	double parteimag1;
	double partereal1;
	double partereal2;

	discriminante = (b*b) - (4*a*c);

	if(discriminante > 0.0){

	solucion1 = (-b + sqrt(discriminante))/(2*a);
	solucion2 = (-b - sqrt(discriminante))/(2*a);

	printf("La ecuación que ingresó tiene dos soluciones, las cuales son:\n %f y %f\n",solucion1,solucion2);
	}

	if(discriminante == 0.0){

	solucion1 = (-b)/(2*a);

	printf("La ecuación que ingresó tiene una solución real, la cual es:\n %f\n",solucion1);
}

	if(discriminante < 0.0){

	partereal1 = -b/(2*a);
    parteimag1 = sqrt(-discriminante)/(2*a);
	partereal2 = -b/(2*a);

if(a > 0) {printf("La ecuación que ingresó tiene soluciones complejas, las cuales son:\n (%f + j%f)\n (%f - j%f)\n",partereal1,parteimag1,partereal2,parteimag1);}

}

return 0;


}
