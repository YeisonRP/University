
import sys
import numpy
from numpy.polynomial import polynomial as p
import scipy


def init():
    data_file=sys.argv[1]
    data=numpy.ndarray(shape=0)
    with open(data_file, "r") as f:
        l = f.readlines()
        for i in l:
            data = numpy.append(data, numpy.float(i))
    fit_type=sys.argv[2]
    
    return [data, fit_type]

def main():
    data, fit_type = init()
    # print(data)
    # print(fit_type)
    n = numpy.ndarray(len(data))
    n = [ i for i in range(len(n)) ]


    if(fit_type == "lin" or fit_type == "linear"):
        print("AJUSTE LINEAL")
        print("intercept, slope")
        print(p.polyfit(n, data, 1))
        print("")
        print("correlacion")
    # hay que cambiar estas funciones!!! dan lo mismo para todos los ajustes    print(numpy.corrcoef(n, data))
    elif(fit_type == "poly2" or fit_type == "polynomial"):
        print("AJUSTE POLINOMIAL GRADO 2")
        print(p.polyfit(n, data, 2))
        print("")
        print("correlacion")
    # hay que cambiar estas funciones!!! dan lo mismo para todos los ajustes    print(numpy.corrcoef(n, data))
    elif(fit_type == "poly3" or fit_type == "polynomial"):
        print("AJUSTE POLINOMIAL GRADO 3")
        print(p.polyfit(n, data, 3))
        print("")
        print("correlacion")
    # hay que cambiar estas funciones!!! dan lo mismo para todos los ajustes    print(numpy.corrcoef(n, data))
    elif(fit_type == "poly4" or fit_type == "polynomial"):
        print("AJUSTE POLINOMIAL GRADO 4")
        print(p.polyfit(n, data, 4))
        print("")
        print("correlacion")
    # hay que cambiar estas funciones!!! dan lo mismo para todos los ajustes    print(numpy.corrcoef(n, data))
    elif(fit_type == "poly5" or fit_type == "polynomial"):
        print("AJUSTE POLINOMIAL GRADO 5")
        print(p.polyfit(n, data, 5))
        print("")
        print("correlacion")
    # hay que cambiar estas funciones!!! dan lo mismo para todos los ajustes    print(numpy.corrcoef(n, data))

    elif(fit_type == "log" or fit_type == "logarithmic"):
        print("AJUSTE LOGARITMICO")
        print(numpy.polyfit(numpy.log(data), n,1))
        print("")
        print("correlacion")
    # hay que cambiar estas funciones!!! dan lo mismo para todos los ajustes    print(numpy.corrcoef(n, data))
    elif(fit_type == "pow" or fit_type == "power"):
        print("AJUSTE EXPONENCIAL")
        print(numpy.polyfit(numpy.exp(n), data,1)) ######!!!!!!!!!!!!!!!!!!!!!! buscar como hacer el ajuste exponencial
        print("")
        print("correlacion")
    # hay que cambiar estas funciones!!! dan lo mismo para todos los ajustes    print(numpy.corrcoef(n, data))

    #r2??????????!!??!?!?!?!!!!!!1111oneoneoneeleventyone

main()