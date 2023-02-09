#!/usr/bin/python
class Contador:
    '''
    Clase que se encarga de contar, recibe como parametros el maximo del contador y el numero de la cuenta
    '''   
    def __init__(self,c,m):
        '''
        Funcion con la cual se setea un objeto clase contador
        Args:
            c: entero que indica por donde inicia la cuenta
            m: entero que indica el maximo de la cuenta         
        '''
        self.__cuenta = c
        self.__max = m
        self.__revase = 0

    def getCuenta(self):

        '''
        Returns:
            Retorna el valor actual de la cuenta     
        '''
        return self.__cuenta

    def getMax(self):
        '''
        Returns:
            Retorna el valor maximo de la cuenta     
        '''
        return self.__max

    def getRebase(self):
        '''
        Returns:
            Retorna el valor del rebase     
        '''
        return self.__revase

    def setCuenta(self,c):
        '''
        Funcion que se encarga de poner la cuenta en el numero ingresado por el usuario
        Args:
            c: entero que indica por donde seguira la cuenta        
        '''
        self.__cuenta = c

    def setMax(self,m):
        '''
        Funcion que se encarga de poner el valor maximo en el numero ingresado por el usuario
        Args:
            m: NUevo valor maximo     
        '''
        self.__max = m

    def setRebase(self,r):
        '''
        Funcion que se encarga de poner el valor del rebase en el numero ingresado por el usuario
        Args:
            r: NUevo valor de rebase     
        '''
        self.__revase = r

    def contar(self):
        '''
        Funcion que se encarga de aumentar la cuenta en uno, si el valor llega al maximo se reinicia la cuenta y se aumenta el revase en uno    
        '''
        self.__cuenta += 1
        if self.__cuenta == self.__max:
            self.__revase += 1
            self.__cuenta = 0        
            
    def borrarRebase(self):
        '''
        Funcion que se encarga resetear el rebase a cero    
        '''
        self.__revase = 0


class Mes(Contador):
    '''
    Clase Mes, se encarga de guardar el nombre de un objeto mes, asi como sus dias, esta clase hereda de contador
    '''
    def __init__(self,n,c,m):
        '''
        Funcion con la cual se setea un objeto clase mes   
        Args:
            n: string que indica el nombre del mes
            c: entero que indica el dia de inicio del mes
            m: entero que indica el maximo dia del mes
        '''
        Contador.__init__(self,c,m)
        self.__nombre = n

    def getNombre(self):
        '''
        Returns:
            Retorna el nombre del mes    
        '''
        return self.__nombre

    def setNombre(self,n):
        '''
        Funcion que se encarga de poner el nombre a un mes
            n: Nombre del mes  
        '''
        self.__nombre = n


class Reloj(Contador):
    '''
    Clase Reloj, se encarga de funcionar como un reloj que cuenta segundos, minutos y horas, hereda de la clase Contador
    '''
    def __init__(self,s,m,h):
        '''
        Funcion con la cual se setea un objeto clase Reloj   
        Args:
            s: entero que indica el segundo del reloj
            m: entero que indica el minuto del reloj
            h: entero que indica la hora del reloj
        '''
        self.__segundo = Contador(s,60)
        self.__minuto = Contador(m,60)
        self.__hora = Contador(h,24)

    def set(self,s,m,h):
        '''
        Funcion con la cual se coloca una hora nueva en el reloj  
        Args:
            s: entero que indica el segundo del reloj
            m: entero que indica el minuto del reloj
            h: entero que indica la hora del reloj
        '''
        self.__segundo.setCuenta(s) 
        self.__minuto.setCuenta(m)
        self.__hora.setCuenta(h)

    def tic(self):
        '''
        Funcion con la cual se aumenta un segundo en el reloj  
        '''
        self.__segundo.contar()
        if self.__segundo.getRebase() == 1:
            self.__segundo.borrarRebase()
            self.__minuto.contar()
            if self.__minuto.getRebase() == 1:
                self.__minuto.borrarRebase()
                self.__hora.contar()
                '''OJO'''
                
    def display(self):
        '''
        Returns:
            Retorna un sitrng con la hora actual, en formato hh:mm:ss    
        '''
        segundos = str(self.__segundo.getCuenta())
        minutos = str(self.__minuto.getCuenta())
        horas = str(self.__hora.getCuenta())
        return horas + ':' + minutos + ':' + segundos

    def __str__(self):
        '''
        Returns:
            Retorna un sitrng con la hora actual, en formato hh:mm:ss    
        '''
        segundos = str(self.__segundo.getCuenta())
        minutos = str(self.__minuto.getCuenta())
        horas = str(self.__hora.getCuenta())
        return horas + ':' + minutos + ':' + segundos


class Calendario(Mes):
    '''
    Clase que se encarga de ser un calendario, necesita de la clase Mes para existir
    '''
    
    def __init__(self,d,m,a):
        '''
        Funcion con la cual se setea un objeto clase calendario   
        Args:
            d: entero que indica el de dia
            m: entero que indica el mes
            a: entero que indica el ano
        '''        
        self.__mesActual = m
        self.__ano = a
        self.__Meses = [0,1,2,3,4,5,6,7,8,9,10,11]
        self.__Meses[0] = Mes('Enero',d,32)
        self.__Meses[1] = Mes('Febrero',d,29)
        self.__Meses[2] = Mes('Marzo',d,32)
        self.__Meses[3] = Mes('Abril',d,31)
        self.__Meses[4] = Mes('Mayo',d,32)
        self.__Meses[5] = Mes('Junio',d,31)
        self.__Meses[6] = Mes('Julio',d,32)
        self.__Meses[7] = Mes('Agosto',d,32)
        self.__Meses[8] = Mes('Septiembre',d,31)
        self.__Meses[9] = Mes('Octubre',d,32)
        self.__Meses[10] = Mes('Noviembre',d,31)
        self.__Meses[11] = Mes('Diciembre',d,32)
        if self.__anoBisiesto() == True:
            self.__Meses[1] = Mes('Febrero',d,30)           
                        

    def get(self):
        '''
        Returns:
            Retorna un sitrng con la fecha actual, en formato dia de mes de ano:    
        '''
        return str(self.__Meses[self.__mesActual].getCuenta()) + ' de ' + str(self.__Meses[self.__mesActual].getNombre()) + ' del ' + str(self.__ano)


    def set(self,d,m,a):
        '''
        Funcion con la cual se coloca una fecha nueva de comienzo para el calendario 
        Args:
            d: entero que indica el dia en el calendario
            m: entero que indica el mes en el calendario
            a: entero que indica el ano en el calendario
        '''
        self.__Meses[m].setCuenta(d)
        self.__mesActual = m
        self.__ano = a
        if self.__anoBisiesto() == True:
            self.__Meses[1] = Mes('Febrero',d,30) 
        

    def avanzar(self):
        '''
        Funcion con la se avanza un dia en el calendario
        '''

        self.__Meses[self.__mesActual].contar()  
        if self.__Meses[self.__mesActual].getRebase() == 1:
            self.__Meses[self.__mesActual].borrarRebase()
            self.__mesActual += 1        
            if self.__mesActual == 12:
                
                self.__mesActual = 0
                self.__Meses[self.__mesActual].setCuenta(1)
                self.__ano += 1
                if self.__anoBisiesto() == True:
                    self.__Meses[1] = Mes('Febrero',1,30)

                self.__Meses[self.__mesActual].setCuenta(1)

            else:
                self.__Meses[self.__mesActual].setCuenta(1)   

        
    def __str__(self):
        '''
        Returns:
            Retorna un sitrng con la fecha actual, en formato dia de mes de ano:    
        '''
        return str(self.__Meses[self.__mesActual].getCuenta()) + ' de ' + str(self.__Meses[self.__mesActual].getNombre()) + ' del' + str(self.__ano)
        
    def __anoBisiesto(self):
        '''
        Funcion privada que se encarga de analizar si un ano es bisiesto
        Returns:
            Retorna un booleano que retorna True si el ano es bisiesto
        '''
        if (self.__ano % 4) == 0:
            if (self.__ano % 100) != 0:
                return True
            elif (self.__ano % 400) == 0:
                return True
            else:
                return False
        else:
            return False



class Fecha(Reloj, Calendario):
    '''
    Clase que se encarga de dar la fecha en el formato dia de mes del ano, hh:mm:ss, hereda de las clases Reloj y Calendario
    '''
    def __init__(self,d,m,a,h,minuto,s):
        '''
        Funcion con la cual se setea un objeto Fecha
        Args:
            d: entero que indica el dia en el calendario
            m: entero que indica el mes en el calendario
            a: entero que indica el ano en el calendario
            h: entero que indica la hora en el reloj
            minuto: entero que indica el minutoes en el reloj
            s: entero que indica el segundo en el reloj
        '''
        Reloj.__init__(self,s,minuto,h)
        Calendario.__init__(self,d,m,a)
        self.__reloj = Reloj(s,minuto,h)
        self.__calendario = Calendario(d,m,a)
            
    def avanzar(self):
        '''
        Funcion que avanza un segundo en la Fecha   
        '''
        self.__reloj.tic()
        if  self.__reloj._Reloj__hora.getRebase() == 1:
            self.__calendario.avanzar()
            self.__reloj._Reloj__hora.borrarRebase()
        
    def __str__(self):
        '''
        Returns:
            Retorna un string con la fecha en el formato dia de mes del ano, hh:mm:ss
        '''
        return self.__calendario.get() + ', ' + self.__reloj.display() 

'''EJEMPLO BASE 1 '''
fecha = Fecha(17,10,2016,19,0,0)
print(str(fecha))
i = 0
while (i < 1000000):
    fecha.avanzar()
    i += 1
print(str(fecha))

'''EJEMPLO BASE 2 '''
fecha2 = Fecha(31,11,2018,23,59,59)
print(str(fecha2))
i = 0
while (i < 365*86400):
    fecha2.avanzar()
    i += 1
    if (i % (86400*30)) == 0:
        print(str(fecha2))

