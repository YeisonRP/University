#!/usr/bin/python

def primer_ultimo(lista):
    ''' Esta funcion retorna el primer
        y ultimo dato de la lista
'''
    a = lista[(len(lista) - 1)]
    b = lista[0]
    lista_retorno = [a,b]

    return lista_retorno

    
#main

lista2 = primer_ultimo([1,4,6,2,'asd'])
print(lista2[0])
print(lista2[1])
