#!/usr/bin/python

def ordenar(lista,letra):
    if letra == 'a':
        lista.sort()
        for letter in lista:
            print(letter)

    elif letra == 'd':
        lista.sort()
        lista.reverse()
        for letter in lista:
            print(letter)
    else:
        print('valor no valido')


    return lista




vector = [3,5,7,2,1,4,6,3,2]
lista = ordenar(vector,'d')
print('------')
lista = ordenar(vector,'a')

