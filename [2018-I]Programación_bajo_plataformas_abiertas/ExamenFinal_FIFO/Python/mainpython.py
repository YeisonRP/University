#!/usr/bin/python
TRUE = 1
FALSE = 0
from fifo_t import fifo_t


# CREANDO UN OBJETO DEL TIPO FIFO DE TAMAnO 5
print('Se esta creando la lista \n')
fifo = fifo_t(5)

print('Se estn agregando datos a la lista \n')
# AGREGANDO DATOS AL FIFO     
fifo.writeData(5)
fifo.writeData(3)
fifo.writeData(2)
fifo.writeData(1)

print('Se va a imprimir la lista \n')
#IMPRIMIENTO LA LISTA
fifo.printFifo()
print(' \n')

print('Se van a a leer los datos de la lista \n')
# LEYENDO DATOS DEL FIFO
print(fifo.readData())
print(fifo.readData())
print(fifo.readData())
print(fifo.readData())
 
print('Ya que se leyeron todos los datos del FIFO, se flushea automaticamente el FIFO\n')
print('Vemos que el retorno de la funcion print es de: ',fifo.printFifo(),' ,ya que la lista esta vacia \n')

print('Ahora se van a agregar datos al FIFO hasta que se llene, y ver que hace la funcion writeData \n')

fifo.writeData(2)
fifo.writeData(3)
fifo.writeData(4)
fifo.writeData(5)
fifo.writeData(6)

print('Los datos agregados son: \n')
fifo.printFifo()



print('Al intentar agregar otro dato extra vemos que la funcion writeData retorna un:',fifo.writeData(6),' ,esto ocurre porque se lleno el fifo \n')

