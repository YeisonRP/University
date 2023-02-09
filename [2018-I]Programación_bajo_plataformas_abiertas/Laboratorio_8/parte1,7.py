#!/usr/bin/python
def recursivo(lista):

    a = lista.pop()
    
    if len(lista) != 0:
        recursivo(lista)
    print(a)


listaa = [1, 4, 10, 7, 2, 'asd', 3.4, 2.1]
recursivo(listaa)
