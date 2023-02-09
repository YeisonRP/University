#!/usr/bin/python

def guardar_laberinto(labe,entrad_x,entrada_y,salida_x,salida_y):
    datos = open('laberinto_salida','w')

    columnas = 0
    filas = 0
    for fila in labe:
        columnas = 0
        for dato_fila in fila:
            
            if (filas == entrad_x) and (columnas == entrada_y):
                datos.write('E')
            elif (filas == salida_x) and (columnas == salida_y):
                datos.write('S')
                
            elif dato_fila == 'X':
                datos.write(' ')
            elif dato_fila == 'S':
                datos.write('o')
            else:
                datos.write(dato_fila)
            columnas = columnas + 1
        filas = filas + 1      
    datos.close()
    
def leer_laberinto(archiv):
    laberinto = [],[],[],[],[],[],[] 
    con_lin = 0
    linea = archivo.readline()
    columnas = len(linea)
    filas = len(laberinto)
    while(linea):

        laberinto[con_lin][:] = linea
        linea = archivo.readline()

        con_lin = con_lin + 1
        
    return laberinto

def moverse_en_lista(lista_actual, y, x):


        if lista_actual[y][x+1] == ('S'):
            lista_actual[y][x] = 'S'    
        elif lista_actual[y+1][x] == ('S'):
            lista_actual[y][x] = 'S'
        elif lista_actual[y-1][x] == ('S'):
            lista_actual[y][x] = 'S'
        elif lista_actual[y][x-1] == ('S'):
            lista_actual[y][x] = 'S'
        else:

    
        
            lista_actual[y][x] = '?'
            if lista_actual[y][x+1] == (' '):
                    moverse_en_lista(lista_actual,y,x+1)
            
            if lista_actual[y+1][x] == (' '):
                    moverse_en_lista(lista_actual,y+1,x)
            
            if lista_actual[y][x-1] == (' '):
                    moverse_en_lista(lista_actual,y,x-1)
            
            if lista_actual[y-1][x] == (' '):
                    moverse_en_lista(lista_actual,y-1,x)
            
        
            lista_actual[y][x] = 'X'

            if lista_actual[y][x+1] == ('S'):
                lista_actual[y][x] = 'S'    
            elif lista_actual[y+1][x] == ('S'):
                lista_actual[y][x] = 'S'
            elif lista_actual[y-1][x] == ('S'):
                lista_actual[y][x] = 'S'
            elif lista_actual[y][x-1] == ('S'):
                lista_actual[y][x] = 'S'



    
        return lista_actual

archivo = open('laberinto_entrada','r')
        
laberinto_aux = [],[],[],[],[],[],[]

contador_fila = 0
contador_columna = 0
laberinto_aux = leer_laberinto(archivo)
for fila in laberinto_aux:
    for dato_fila in fila:
        if dato_fila == 'E':
            num_column_ent = contador_columna
            num_fila_ent = contador_fila
        if dato_fila == 'S':
            num_column_sal = contador_columna
            num_fila_sal = contador_fila            
        contador_columna = contador_columna + 1
    contador_columna = 0
    contador_fila = contador_fila + 1

lab_sal = moverse_en_lista(laberinto_aux,num_fila_ent,num_column_ent)


guardar_laberinto(lab_sal,num_fila_ent,num_column_ent,num_fila_sal,num_column_sal)
