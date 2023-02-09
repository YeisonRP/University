Simulador de Ecosistema II
=========================

Archivos del programa:
------------------------------------------------------------------------------------
+ Animales.cpp : En esta clase se presenta el código de los métodos de la clase Animal
+ Animales.h : Este archivo contiene los headers de las clases Oveja, Zorro, Conejo y Lobo
+ clases.h : En este archivo se presentan los headers de la clase Animal y Celda
+ Celda.cpp : En este archivo se implementan los métodos de la clase Celda
+ Conejo.cpp : EN este archivo se implementan los métodos de la clase Conejo
+ funciones.cpp : En este archivo se implementan las funciones generales del programa utilizadas en el main.
+ funciones.h : En este archivo se presentan los headers de las funciones del archivo funciones.cpp
+ Lobo.cpp : En este archivo se implementan los métodos de la clase Lobo
+ main.cpp : Función principal del programa, llama a todas las funciones necesarias para resolver el problema planteado
+ Makefile : Archivo que facilita la compilación y ejecución del programa a usuarios
+ Oveja.cpp : Archivo donde se implementan los métodos de la clase Oveja
+ plantas.cpp : Archivo donde se implementan los métodos de las clases Uva, PAsto, Roble y Zanahoria
+ plantas.h : Archivo donde se presentan los headers de las clases Uva, PAsto, Roble y Zanahoria
+ vegetal.cpp : Archivo donde se presentan los métodos de la clase vegetal
+ Vegetal.h : Archivo donde se presentan los headers de la clase Vegetal
+ zorro.cpp : Archivo donde se implementan los métodos de la clase Zorro
+ animales.txt : Archivo donde se cargan los animales y plantas junto con su energía, tipo y sexo, a continuación se muestra un ejemplo de su formato

Explicación del programa:
------------------------------------------------------------------------------------
Este programa es un simulador de un ecosistema simple, contiene 4 tipos de animales, los cuales son Lobos, Conejos, Zorros y Ovejas, los animales tienen sexo y energía.
También existen 4 tipos de plantas, que son Robles, Uvas, Pasto y , .
La simulación se da en una matriz de objetos de tamaño nxm, la cuál en cada espacio contiene una planta y puede o no tener un animal.
Los animales pueden realizar 4 acciones, que son moverse, comer, reproducirse y morir, la simulación correrá durante N días, donde N es un parámetro ingresado por el usuario al compilar con el Makefile
A continuación se presenta un ejemplo de archivo de texto en el cuál se ingresan los parámetros de los animales y plantas:
FAvor si va a utilizar este archivo, quitar los comentarios
+ 2 # Indica la cantidad de filas del arreglo
+ 2 # Indica la cantidad de columnas del arreglo
+ 0 0 25 R 30 LM # Coordenada en x y y, vida de la planta,  tipo de planta,  vida del animal, el animal y su sexo
+ 0 1 46 R 60 LH # Coordenada 0,1 un Roble con 46 de energía y un Lobo hembra con 60 de energía
+ 1 0 34 R 0 # Coordenada 1,0 , un Roble con 34 de energía y NO hay animal en esta celda
+ 1 1 66 P 100 LM # Coordenada 1,1 , un pasto con 66 de energía y un Lobo con 100 de energía

Integrantes:
-------------------------

Grupo 4:
+ Yeison Rodríguez Pacheco B56074
+ Fabián Guerra Esquivel B53207
