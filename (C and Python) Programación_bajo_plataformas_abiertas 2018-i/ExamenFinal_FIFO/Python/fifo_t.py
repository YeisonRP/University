#!/usr/bin/python
TRUE = 1
FALSE = 0

class fifo_t:
    def __init__(self,size):
        '''
        Funcion que inicializa el FIFO, es el analogo a create list     
        '''
        self.__tail = 0
        self.__head = 0
        self.__size = size
        self.__data = []
        i = 0
        while (i < size):
            self.__data.append(0)
            i += 1
        

    def writeData(self, new_value):
        '''
        Funcion que escribe un dato en el FIFO, recibe como parametro el valor a ingresar    
        '''
        if self.fifoIsFull() == 1:
            return 1
        self.__data[self.__head] = new_value
        self.__head += 1
        return 0

    def fifoIsFull(self):
        '''
        Funcion que dice si el FIFO se lleno   
        '''
        if (self.__head == self.__size) and (self.__tail == 0):
            return TRUE
        else:
            return FALSE

    def fifoIsEmpty(self):
        '''
        Funcion que dice si el FIFO esta vacio  
        '''
        if (self.__head == 0) and (self.__tail == 0):
            return TRUE
        else:
            return FALSE
        
    def printFifo(self):
        '''
        Funcion que imprime los datos del FIFO   
        '''
        if self.fifoIsEmpty() == TRUE:
            return 1
        else:
            t = self.__tail
            h = self.__head
            while (t < h):
                print('Dato [',t,'] es igual a ',self.__data[t])
                t += 1
            return 0
    def flushFifo(self):
        '''
        Funcion que reinicia el FIFO    
        '''
        self.__tail = 0
        self.__head = 0
        i = 0
        while (i < self.__size):
            self.__data[self.__head] = 0
            i += 1
            
    def readData(self):
        '''
        Funcion que lee datos del FIFO    
        '''
        if self.fifoIsEmpty() == TRUE:
            return 1
        dato = self.__data[self.__tail]
        self.__tail += 1
        if (self.__tail == self.__head):
            self.flushFifo()
            
        return dato
        
            


