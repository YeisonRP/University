#!/usr/bin/python
import random

def numrandom(x,y):
    aleatorio = random.randint(x, y)
    return aleatorio

def obtenerInt():
    a = input('Ingrese un numero\n')
    return int(a)

def respuesta(d):
    print('La computadora dice que el numero podria ser el: ')
    print(d)
    c = int(input('Si el numero es mayor. ingrese 1, si es menor -1, si es el numero correcto ingrese 0\n'))
    return c

def adivinanza():
    aleatorio = obtenerInt()
    controlador = 1
    x = 0
    y = 50
    entero = numrandom(x,y)
    while(controlador != 0):
        
        controlador = respuesta(entero)
        if controlador == 1:
            x = entero + 1
            entero = numrandom(x,y)
            
        if controlador == -1:
            y = entero - 1          
            entero = numrandom(x,y)
        
        if controlador == 0:
            print('La computadora adivino')

print('ESte juego solamente funciona si el usuario es honesto, no le mienta a la computadora')
adivinanza()
