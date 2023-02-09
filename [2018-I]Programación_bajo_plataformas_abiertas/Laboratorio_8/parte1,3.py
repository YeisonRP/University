#!/usr/bin/python
import random

def numrandom():
    aleatorio = random.randint(0, 51)
    return aleatorio

def obtenerInt():
    a = input('Ingrese un numero\n')
    return int(a)

def respuesta(obt_int, rand):

    if obt_int == rand:
        print('Adivinaste el numero secreto, cuyo valor es de:\n')
        print(obt_int)
        return 0

    if obt_int > rand:
        print('El numero es menor al ingresado\n')
        return -1

    if obt_int < rand:
        print('El numero es mayor al ingresado\n')
        return 1

def adivinanza():
    aleatorio = numrandom()
    controlador = 1
    while(controlador != 0):
        entero = obtenerInt()
        controlador = respuesta(entero,aleatorio)



adivinanza()
