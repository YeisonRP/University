#include <iostream>
#include <cstdio>
#include <string>

using namespace std;

int verificar_codones_finales(string cadena, int longi);
char traducir_codones(char A, char B, char C);

/**
 * @brief Programa que se encarga de decodificar bases nitrogenadas
 * 
 * @param argc numero de entradas que recibe el main
 * @param args puntero a char que guarda el nombre del programa junto con las entradas brindadas por el usuario
 */
int main(int argc, char** args){

    int controlador = 0;
    string str = args[1];
    int longitud = str.length();
 
    // Para ver si es multiplo de 3
    if((longitud) % 3 != 0) { 
        cout << "La longitud de la entrada no es multiplo de 3." << endl;
        controlador = 1;
        }

    // para ver si los codones iniciales y finales terminan en parada
   if (verificar_codones_finales(str,longitud) == 1){
       controlador = 1;
       cout << "Los codones iniciales o finales no terminan en parada." << endl;
   }  

    // para traducir el texto intermedio de los codones
   if (controlador == 0){
       char a;
       int i;
       cout <<  endl;
       for (i = 3; i < (longitud - 3); i += 3){
           
          a = traducir_codones(str[i],str[i+1],str[i+2]);
          
          if(a == 'Z'){
             cout <<  endl << "Se encontro que un segmento del dato ingresado no coincide con ningun valor valido, por lo que termina el programa";
             break;
          }
          else {cout << a;}
        }
        cout <<  endl;
    }
   

return 0;
}

/**
 * @brief Esta funcion verifica si los codonse del inicio y final son de parada
 * 
 * @param cadena es la cadena de entrada con los codigos a analizar
 * @param longi es la longitud de la cadena de texto entrante
 * @return retorna 0 si existen ambos codones de parada (inicio y fin), retorna un 1 en caso contrario 
 */
int verificar_codones_finales(string cadena, int longi){
    int control = 0;
    if ( (cadena[0] == 'U') && ( (cadena[1] == 'A') &&  ((cadena[2] =='A') || (cadena[2] =='G')) ) || ( (cadena[1] =='G') && (cadena[2] =='A'))) {
        control += 1;    
    }
    if ( (cadena[longi - 3] == 'U') && ( (cadena[longi - 2] == 'A') &&  ((cadena[longi - 1] =='A') || (cadena[longi - 1] =='G')) ) || ( (cadena[longi - 2] =='G') && (cadena[longi - 1] =='A'))) {
        control += 1;    
    }

    if (control == 2){ return 0;}
    else {return 1;}
}

/**
 * @brief Esta funcion traduce las bases nitrogenadas y retorna la letra correspondiente a cada una
 * 
 * @param A Primera letra de la base nitrogenada
 * @param B SEgunda letra de la base nitrogenada
 * @param C Tercera letra de la base nitrogenada
 * @return char 
 */
char traducir_codones(char A, char B, char C){
    
    if ((A != 'A') & (A != 'C') & (A != 'U') & (A != 'G')){ //Revisando si las entradas son validas
        return 'Z';
    }
    if ((B != 'A') & (B != 'C') & (B != 'U') & (B != 'G')){ //Revisando si las entradas son validas
        return 'Z';
    }
    if ((C != 'A') & (C != 'C') & (C != 'U') & (C != 'G')){ //Revisando si las entradas son validas
        return 'Z';
    }

    //if que traducen el codigo
    if (A == 'U'){// TODOS LOS QUE EMPIEZAN POR U YA ESTAN
        if (B == 'U'){ // segundo circulo que empiezan con B
            if((C == 'U') || (C == 'C')){return 'F';}
            else{return 'L';}
        }

        if (B == 'C'){return 'S';} // segundo circulo que empiezan con C

        if (B == 'A'){//segundo circulo que empieza con A
            if (C == 'U' || C == 'C'){return 'Y';}
        }

        if (B == 'G') { // segundo circulo que empieza con G
            if ((C == 'U') || (C == 'C')) {return 'C';}
            if (C == 'G'){ return 'W';}
        }

    // FALTA LOS QUE EMPIEZAN POR C, A y G
    } 


    if (A == 'C'){ //todos los que empiezan con C circulo 1
        if (B == 'U'){return 'L';}//segundo circulo los que empiezan con U
        if (B == 'C'){return 'P';}// Segundo circulo los que empiezan con C
        if (B == 'A'){// segundo circulo los que empiezan con A
            if (C=='U' || C == 'C'){return 'H';}
            else {return 'Q';}
        }
        if (B == 'G'){return 'R';} // segundo circulo las que comienzan con G
    } 

    if (A == 'A') {//Todos los que comienzan con A circulo 1
        if (B=='U'){// Todos los que empiezan con U del segundo circulo
            if (C=='G'){return 'M';}
            else{return 'I';}
        }

        if(B=='C'){return 'T';} // TOdos los que empiezan con C del segundo circulo

        if (B == 'A'){ //todos los que empiezan con A del segundo circulo
            if (C == 'C' || C == 'U'){return 'N';}
            else {return 'K';}
        }

        if (B == 'G'){ // todos los que empiezan con G del segundo circulo
            if (C == 'C' || C == 'U'){return 'S';}
            else {return 'R';}
        }
    } 

    if(A == 'G'){ //Primer circulo, los del G

        if(B == 'U'){return 'V';} // segundo circulo que comienzan con U
        if (B == 'C'){return 'A';}// segundo circulo que comienzan con C
        if (B == 'G'){return 'G';}// segundo circulo que comienzan con G
        if (B == 'A') {// segundo circulo que comienzan con A
            if(C == 'U' || C == 'C' ) {return 'D';}
            else {return 'E';}
        }
    } 


}
