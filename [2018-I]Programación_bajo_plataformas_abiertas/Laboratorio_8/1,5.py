#!/usr/bin/python

def divisores(a):
    contador = 1
    contador2 = 0
    lista = []
    while(contador <= a):
        d = a % contador
        if d == 0:
            lista.insert(contador2,contador)
            contador2 = contador2 + 1
        contador = contador + 1
    return lista

print(divisores(8))
