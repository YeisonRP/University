#!/usr/bin/python
'''
DESCRIPCION DEL PROGRAMA: ESTE PROGRAMA ES UN CONTADOR DE TRAFICO
PROGRAMA CREADO POR: YEISON RODRIGUEZ PACHECO B56074, FABIAN GUERRA ESQUIVEL B53207
PROYECTO FINAL DEL CURSO PROGRAMACION BAJO PLATAFORMAS ABIERTAS, UNIVERSIDAD DE COSTA RICA
IE-0117
I-SEMESTRE-2018
16/07/18
SE PERMITE SU USO Y MODIFICACION PARA FINES EDUCATIVOS

LINK DEL VIDEO UTILIZADO (GRATIS): https://www.youtube.com/watch?v=dTdsjKRyMuU

NOTAS.
---LA EFECTIVIDAD DEL PROGRAMA PUEDE VARIAR DEPENDIENDO DEL VIDEO, ADEMAS SE DEBEN MODIFICAR CIERTOS PARAMETROS SI SE QUIERE UTILIZAR CON OTRO VIDEO
---TODO EL CODIGO ESTA COMENTADO, PARA FACILITAR SU COMPRENSION Y MODIFICACION EN CASO DE QUE SE QUIERA MEJORAR
'''




import numpy as np
import cv2 #Funciones de OpenCV

def centroide_de_objeto(x, y, w, h):

    '''Esta funcion se encarga de calcular el centroide en una imagen
       Args:
       	   x = posicion en el eje x que se encuentra la esquina superior izq del cuadrado
           y = posicion en el eje y que se encuentra la esquina superior izq del cuadrado
           w = ancho del cuadrado
           h = alto del cuadrado
    '''
    centro_del_cuadrado_x = int(w / 2)
    centro_del_cuadrado_y = int(h / 2)

    centro_x = x + centro_del_cuadrado_x
    centro_y = y + centro_del_cuadrado_y

    return (centro_x, centro_y)

#------------------------------------INICIO: VARIABLES CONTROLADAS POR EL USUARIO------------------------------------------------------#
FRAMES_INICIO_CONTEO = 40 ##Esta variable indica el numero de frame en el que se inicia el conteo. NO PONER EN CERO
imprimir_centroides_en_consola = 0 ##Si se coloca en 1 se imprimen los centroides en consola, esto hace que el video se ejecute mas lentamente
pasar_frame_por_frame = 1 ##Si es 0 el video sera pasado por el usuatio de manera manual cualquier tecla, dejar en 1 si se quiere reproducir normalmente el video
#------------------------------------FINAL: VARIABLES CONTROLADORAS POR EL USUARIO-----------------------------------------------------#

#------------------------------------INICIO:VARIABLES GLOBALES DEL PROGRAMA:----------------------------------------------#
CONTADOR_CARROS_TOTAL = 0 ##Total de carros contados
Contador_primer_imagen = 0 ##para que la primer imagen no se realice el analisis
centroidex_ant = [] ## Inicializando Vector de centroides de Frame anterior
centroidey_ant = [] ## Inicializando Vector de centroides de Frame anterior
asd = 0
frames = 1 ##Para que solo se cuente el primer frame
#------------------------------------FIN:VARIABLES GLOBALES DEL PROGRAMA:-------------------------------------------------#


cap = cv2.VideoCapture('video5.avi') ##Capturando el video desde un archivo .avi 
kernel = cv2.getStructuringElement(cv2.MORPH_ELLIPSE,(6,6)) ##Obteniendo kernel eliptico de tamano 6x6
fgbg = cv2.createBackgroundSubtractorMOG2() ##SUstractor de fondo

while(1): #While general del sistema, cuando termina se acaba el programa, cada ciclo del while analiza una foto (frame) del video
    
     
    ret, frame = cap.read() ##capturando imagen del video en variable frame
    
    #----------------------------INICIO: FUNCIONES PARA MEJORAR EL ANALISIS-------------------------------------------------#
    fgmask = fgbg.apply(frame) ##fgmask es una imagen en blanco y negro
    
    fgmask = cv2.morphologyEx(fgmask, cv2.MORPH_OPEN, kernel) #Se remueve el ruido EXTERIOR fgmask

    fgmask = cv2.morphologyEx(fgmask, cv2.MORPH_CLOSE, kernel) #Se remueve el ruido INTERIOR (HUECOS ADENTRO) fgmask
    
    fgmask[fgmask < 245] = 0 #Quitando las sombras porque son de color gris
    #----------------------------FIN: FUNCIONES PARA MEJORAR EL ANALISIS----------------------------------------------------#
     
    
    im, contornos, hierarchy = cv2.findContours(fgmask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_TC89_L1) #Calculando contornos en imagen fgmask, im no es utilizada, contornos es lista de contornos
    
    contador = 0 ##inicializando contador que sirve para saber la cantidad de contornos validos encontrados
    centroidex_act = np.zeros(len(contornos)) ##Inicializando vector de centroides en X
    centroidey_act = np.zeros(len(contornos)) ##Inicializando vector de centroides en Y

    for (i, contorno) in enumerate(contornos): #For para recorrer todos los contornos

        (x, y, w, h) = cv2.boundingRect(contorno) #Obteniendo coordenadas para rectangulo
        if (w > 55) and (h > 55) and (frames >= FRAMES_INICIO_CONTEO) : #Verificando si el contorno actual pasa un criterio de tamano
            
            frame = cv2.rectangle(frame,(x,y),(x+w,y+h),(255,0,0),2) #Dibujando rectangulos en la imagen de video orignal, esto no es necesario para el algoritmo, es algo visual          
            centroide = centroide_de_objeto(x,y,w,h) ## Encontrando el centroide de un carro con ayuda de los parametros encontrados para su respectivo rectangulo
            
            if (centroide[1] <= 719) and (centroide[1] >= 500): #Si el centroide se encuentra dentro del area especificada en estos parametros se entra en este if
                centroidex_act[contador] = centroide[0] #Agregando centroide a la lista de centroides validos
                centroidey_act[contador] = centroide[1] #Agregando centroide a la lista de centroides validos
 
                cv2.circle(frame,(centroide[0], centroide[1]), 7, (0,255,0), -1) #Dibujando circulo en el centro del carro actual
                contador += 1 #Aumentando contador para saber cuantos centroides validos hay
                
       
    centroidex_act = centroidex_act[centroidex_act != 0] #Eliminando los valores de cero en los vectores de centroides   
    centroidey_act = centroidey_act[centroidey_act != 0] #Eliminando los valores de cero en los vectores de centroides   
    if imprimir_centroides_en_consola == 1:
        print('Frame numero: ', frames)
        print("Centroide x", centroidex_act, "Centroide y",centroidey_act,"Centroides totales = ",len(centroidey_act)) #Imprimiendo en consola las coordenadas, es algo visual
        
    #------------------------------------------------------EN ESTE PUNTO YA SE TIENEN TODOS LOS CENTROIDES DE LOS CARROS EN LOS VECTORES CENTROIDEX Y CENTROIDEY-------------------------------------------------#
    
   
    
    #------------------------------------------ESTE ES EL PRIMER Y PRINCIPAL ALGORITMO DE CUENTA DEL PROGRAMA----------------------------------------------------
    if Contador_primer_imagen == 1 and (frames >= FRAMES_INICIO_CONTEO): #Verificar que no sea la primer imagen procesada por el programa, ya que daria problemas
               
        if (len(centroidex_ant)+1) == len(centroidex_act):  #Contando si entra un carro al area especificada
            CONTADOR_CARROS_TOTAL += 1 

        if (len(centroidex_ant)+2) == len(centroidex_act): #Contando si entran dos carros al area especificada
            CONTADOR_CARROS_TOTAL += 2
            
        if (len(centroidex_ant)+3) == len(centroidex_act): #Contando si entran dos carros al area especificada
            CONTADOR_CARROS_TOTAL += 3


    #--------------------------INICIO: MEJORA DEL ALGORITMO DE CONTEO POR SI ENTRA UN CARRO EN EL MISMO FRAME QUE SALE OTRO-------------------------------------------
   
    if len(centroidex_act) == len(centroidex_ant): #Si el vector de centroides anterior es igual al actual, entra en este if
        controlador = 0 ##controlador para que ya no analice los for
        a = 0
        for (i, centroide_ant) in enumerate(centroidex_ant): #Recorriendo el vector de centroides viejos
            a = 0
            for (j, centroide_act) in enumerate(centroidex_act): #Recorriendo el vector de centroides nuevos
                
                dist_etre_centroid = abs(centroidex_ant[i]-centroide_act) + abs(centroidey_ant[i]-centroidey_act[j]) #Calculando la distancia entre el centroide anterior y el actual

                if (dist_etre_centroid >= 100) and (controlador == 0): #Este if se encarga de verificar junto con la variable 'a' si todos los carros del frame anterior son los mismos del frame actual
                    a += 1
            if a == len(centroidex_act):
                CONTADOR_CARROS_TOTAL += 1
                if imprimir_centroides_en_consola == 1:
                    print("Se encontro un carro aunque no cambio el numero de centroides de un frame a otro")
                   

    #--------------------------FIN: MEJORA DEL ALGORITMO DE CONTEO POR SI ENTRA UN CARRO EN EL MISMO FRAME QUE SALE OTRO-------------------------------------------

    #--------------------------INICIO: SI SALE UN CARRO EN UN FRAME Y ENTRAN N EN EL SEGUNDO-----------------------------------------------------------------------
    # Esta seccion de codigo es para el caso especial que entren dos o mas vehiculos al area de conteo y en el frame anterior salio uno
    # Ya que si no se tuviera este metodo, solo contaria uno en lugar de dos
    
    if (len(centroidex_act) != len(centroidex_ant)) and (len(centroidex_ant) != 0) and (len(centroidex_act) != 0) and (len(centroidex_act) > len(centroidex_ant)): #Si el vector de centroides anterior es distinto al actual, entra en este if
     
        a = 0
        for (i, centroide_ant) in enumerate(centroidex_ant): #Recorriendo el vector de centroides viejos
            a = 0
            for (j, centroide_act) in enumerate(centroidex_act): #Recorriendo el vector de centroides nuevos
                
                dist_etre_centroid = abs(centroidex_ant[i]-centroide_act) + abs(centroidey_ant[i]-centroidey_act[j]) #Calculando la distancia entre el centroide anterior y el actual

                if (dist_etre_centroid <= 100): #Este if se encarga de verificar junto con la variable 'a' si no se encontro alguno de los carros del frame anterior, para agregarlo
                    a += 1

                if (a == 0) and (j == (len(centroidex_act)-1)):
                    CONTADOR_CARROS_TOTAL += 1
                    if imprimir_centroides_en_consola == 1:
                        print("Se encontro un carro faltante ya que salio uno un momento antes y entraron dos un momento despues")
                        
                        
    #--------------------------FIN: SI SALE UN CARRO EN UN FRAME Y ENTRAN N EN EL SEGUNDO-----------------------------------------------------------------------
               
    if imprimir_centroides_en_consola == 1: #Imprimiendo el numero de vehiculos
            print("Se han contado ",CONTADOR_CARROS_TOTAL, "vehiculos")
            print("")



    if len(centroidex_ant) != 0:  #Dibujando en imagen centroides anteriores si existen                     
        for (i, centroide_ant) in enumerate(centroidex_ant): #Dibujando circulos en los frames anteriores               
            cv2.circle(frame,(int(centroidex_ant[i]), int(centroidey_ant[i])), 7, (0,0,255), -1) #Dibujando circulo en el centro del carro anterior
    

    #Guardando distancias de los centroides actuales en los vectores de centroides anteriores para utilizarlos en el siguiente analisis
    centroidex_ant = centroidex_act
    centroidey_ant = centroidey_act

    cv2.putText(frame, "Cantidad de vehiculos: " + str(CONTADOR_CARROS_TOTAL), (500, 100), cv2.FONT_HERSHEY_DUPLEX, 1, (0, 0, 0), 1)
    cv2.putText(frame, "Cantidad de imagenes procesadas: " + str(frames), (0, 50), cv2.FONT_HERSHEY_DUPLEX, .8, (0, 0, 0), 1)
    
    #haciendo lineas que representan el area de conteo del programa
    cv2.line(frame, (0, 500), (1279,500), (255, 0, 0), 3)
    cv2.line(frame, (0, 717), (1279,717), (255, 0, 0), 3)

    #Mostrando imagenes originales y con mascara
    cv2.imshow('Video original',frame)
    cv2.imshow('Mascara',fgmask)

    #contando frame
    frames += 1
    asd += 1
    Contador_primer_imagen = 1 #ya paso la primer imagen
    
    #Termina el programa con la tecla esc, tomado de: https://docs.opencv.org/3.4/db/d5c/tutorial_py_bg_subtraction.html
    k = cv2.waitKey(pasar_frame_por_frame) & 0xff

    if k == 27:
         break
        
#Cerrando las ventanas y terminando el programa
cap.release()
cv2.destroyAllWindows()


'''
Frames especiales
68-69 se pasa el carro aunque no cambia el numero de contornos
385-386 El camion cuenta 2
1210 1211 cuando sale un carro y entran 2

'''
