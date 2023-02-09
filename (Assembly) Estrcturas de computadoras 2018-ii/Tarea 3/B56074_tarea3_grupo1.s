###############################################################################################################
############################## Autor: Yeison Rodriguez Pacheco B56074   #######################################
############################## Curso: Estructuras de Computadoras I     #######################################
############################## Tarea 3                                  #######################################
############################## Correo: yeisonrodriguezpacheco@gmail.com #######################################  
############################## Grupo: 01                                #######################################
###############################################################################################################

# EXPLICACION DEL PROGRAMA: Esta es una calculadora polaca inversa, la cual opera con la siguiente notacion:
# (1+2)*(3+4) en RPN es : 1 2 + 3 4 + * = 21
# Algunos ejemplos probados son:
#                  150,564 / ((35 + -23,4)*250,32) en RPN es: 150,564 250,32 35 -23,4 + * /
#
#                  1+2*3+4 en RPN es : 1 2 3 * 4 + + = 11
#
#                  -120 + 60 - ((30 * 2)/30) en RPN es : -120 60 30 2 * 30 / - + = -62
# Esta calculadora opera con numeros enteros y flotantes
# Si se intenta operar y no se tienen suficientes elementos para realizar la operacion, se vuelve al menu dando un mensaje de error
#
# Menu de opciones de la calculadora:
# C o c: al ingresar una c o C, se hace un clear en la pila y se guarda el numero 0 en el primer elemento de la misma.
# P o p: Al utilizar la P o p se calcula el cuadrado del ultimo numero ingresado en la pila.
# Space: Al ingresar el espacio se imprime en pantalla el ultimo numero ingresado en la pila, sirve para ver resultados de operaciones.
# S o s: al ingresar una s o S se calcula la raiz cuadrada del ultimo numero ingresado a la pila
#
#   Nota: Esta calculadora funciona con enteros y flotantes, ingresando cadenas de texto como esta:
#   150,564 250,32 35 -23,4 + * /  
#  En la cual cada numero u operacion esta separado por un espacio. 
#   Si se quisiera ver el resultado de la operacion se envia un espacio a la calculadora, y la misma imprimiria el ultimo numero guardado en pila, en este caso el resultado
# Tambien la calculadora funciona ingresando numero por numero, u operacion por operacion, de la siguiente forma
#   150,2
#   100,0
#   +
# y si se envia un espacio imprimiria el resultado

.data 
        input: .asciiz "                                     "  #entrada de la calculadora
        MensajeBienvenida: .asciiz "\nIngrese la operacion en RPN que desea realizar:\n"
        MensajeErrorInsuficientesOperadores: .asciiz "\nOcurrio un error, puede ser que no se tengan suficientes numeros para realizar la operacion o que se ingresara un caracter no valido.\n"
        err: .asciiz "\n\nCaracter no valido, acaba de morir un gatito\n"
        NUMCHAR:.word 0     #numero caracteres



        
        ###############################################################################################################
        #####################################            main        ##################################################
        ###############################################################################################################

    .text

    main:
        sub $a3, $a3, $a3               # a3 = 0, para futuros usos
        inicio:

        la $a0, MensajeBienvenida       #Imprimiendo el primer mensaje
        li $v0, 4
        syscall

        la $a0, input                   #Guardando en a0 la entrada que ingresara el usuario

        li $v0, 8                       #Leyendo string, a0 primera direccion puntero
        syscall

        #CICLO PROGRAMA PRINCIPAL

            jal getNUMCHAR              #Obteniendo el numero de caracteres del arreglo
            move $s0, $v0               #NUMCHAR = $s0
            addi $s0, $s0, -1           #NUMCHAR - 1
            sub $s1, $s1, $s1           # i = 0
            li $s3, 48                  # numero 0 en ascii
            li $s4, 58                  # numero 9 + 1 en ascii

            
            li $s5, 0                   # bandera para saber cuantos numeros seguidos se han encontrado
            li $t5, 0                   #bandera por si un numero es negativo

                 ciclo1:
                    li $t6, 32          #codigo para el espacio            
                    li $s6, 10          #codigo para salto de linea 
                    li $t7, 45          #codigo para el menos
                    li $s3, 48                  # numero 0 en ascii
                    li $s4, 58                  # numero 9 + 1 en ascii
                            li $s7, 44                  #codigo para la ,
                    


                    addu $t2, $s1, $a0                      # i + a0
                    lbu $s2, 0($t2)                         # s2 = [i]
                    beq $t7, $s2,seLeyoUnMenos              # si es un -, brincar a se leyo un menos, que es un codigo especial




                        lbu $t0, 1($t2) #cargando siguiente numero
                        beq $t0, $s7, seLeyoUnaComa         #si es una , saltar a se leyo una ,                    
                    slt $t0, $s2, $s3                       # t0 es 1 si s2 no es un numero
                    bne $t0, $0, noEsUnNumero               #si no es un numero
                    slt $t0, $s2, $s4                       # t0 es 1 si s2 es un numero
                    beq $t0, $0, noEsUnNumero               #si no es un numero 

                    
                    lbu $t0, 1($t2)                             #cargando siguiente numero
                    beq $t0, $t6, guardarEnPilaConSigno         #si es un espacio, guardar en pila con signo
                    beq $t0, $s6, guardarEnPilaConSigno         #si es un salto de linea, guardar en pila con signo
                            
                    addi $s5, $s5, 1                            #se han encontrado s5 numeros seguidos
                                       
                    move $a1, $s2                               #moviendo el numero a a1
                    jal getNUMBER                               #Obteniendo el numero en int
                    addi $sp, $sp, -4                           #pidiendo un espacio en la pila
                    sw $v0, 0($sp)                              #Guardando el numero en la pila
                    addi $s1, $s1, 1                            #i++
                    j ciclo1                                    #brincando a ciclo 1

                    seLeyoUnMenos:                              #si se leyo un menos
                        lbu $t0, 1($t2)                         #cargando siguiente numero
                        beq $t0, $t6, restar                    #Si el siguiente caracter es un espacio, salta a restar
                        beq $t0, $s6, restar                    #Si el siguiente caracter es un salto de linea, salta a restar
                        li $t5, 1                               #bandera para saber que es un numero negativo
                        addi $s1, $s1, 1                        #i++
                        j ciclo1                                # vuelve al ciclo1

                            seLeyoUnaComa:  #registro s2 sin tocar pls #si lo que sigue es una ,
                                li $t3, 0                   # cargando el 0 en el registro f20
                                mtc1 $t3, $f20              # Cargando f20 = 0, f0 es el numero en decimal 
                                cvt.s.w $f20, $f20          # Pasando de registro normal a float

                                li $t3, 10                      #para dividir 10
                                mtc1 $t3, $f3      #se transfiere un valor de un registro entero a uno flotante
                                cvt.s.w $f3, $f3  # Convierte un valor entero en un registro punto flotante en un valor en punto flotante

                                li $t4, 10                      #para dividir 10
                                mtc1 $t4, $f4      #se transfiere un valor de un registro entero a uno flotante
                                cvt.s.w $f4, $f4  # Convierte un valor entero en un registro punto flotante en un valor en punto flotante                    #para multiplicar por decenas, centenas, etc
                                
                                
                                addi $s1, $s1, 2        #sumar 2 al contador principal del ciclo
                                addu $t2, $s1, $a0      #direccion mas el contador
                                li $t0, 0               #contador

                                cicleDecimales:                     #ciclo  
                                    lbu $t0, 0($t2)                 #cargando el numero que sigue despues de la ,
                                    move $a1, $t0                   #moviendo el numero a a1
                                    jal getNUMBER                   #Obteniendo el numero en int, lo devuelve en v0
                                    mtc1 $v0, $f15                  #se transfiere un valor de un registro entero a uno flotante
                                    cvt.s.w $f15, $f15              #f15 = numero leido
                                    div.s $f15, $f15, $f4           #dividir numero entre 10, o 100, o etc
                                    mul.s $f4, $f4, $f3             #hacer el 10 que divide * 10 para que sea 100 y etc
                                    add.s $f20, $f20, $f15          #sumar el numero dividido al anterior
                                    #verificar si sigue un espacio o salto de linea, si es asi brincar a guardarEnPilaConSigno:
                                    lbu $t0, 1($t2)                 #cargando el numero que sigue despues de la ,
                                    beq $t0, $t6, guardarEnPilaConSigno         #si es un espacio, guardar en pila con signo
                                    beq $t0, $s6, guardarEnPilaConSigno         #si es un salto de linea, guardar en pila con signo
                                    addi $t2, $t2, 1                #sumar 1 al contador t2 para las palabras
                                    addi $s1, $s1, 1                #i++ #sumar 1 al contador del ciclo principal
                                    beq $s1, $s0, fin               #si se llega a salto de linea, termina la lectura
                                    j cicleDecimales                #saltar al ciclo nuevamente                               
                                



                    guardarEnPilaConSigno:              #Esta seccion procede a guardar un numero con su respectivo signo cuando ya se termino de leer
                        move $a1, $s2                   #moviendo el numero a a1
                        jal getNUMBER                   #Obteniendo el numero en int
                        li $t0, 0                       #contador = 0
                        li $t3, 10                      #para multiplicar 10
                        li $t4, 10                      #para multiplicar por decenas, centenas, etc
                        beq $s5, $0, fincicloGuardar    #Si es solo un numero solo, se procede a guardarse sin realizar este ciclo
                        cicloGuardar:
                            lw $t1, 0($sp)                  #numero anterior
                            addi $sp, $sp, 4                #dejando pila como deberia estar
                            mult $t1, $t4			        #numero anterior por decenas, centenas, o lo que corresponda
                            mflo $t2					    #resultado de la multiplicacion en t2

                            mult $t4, $t3                   #haciendo que crezca una decena, centena, etc
                            mflo $t4					    #guardando decenas, centenas, o lo que sea

                            add $v0, $v0, $t2               # sumando el numero total
                            addi $t0, $t0, 1                # sumando al contador para saber si ya termino de leer todo el numero
                            beq $t0, $s5, fincicloGuardar   #si ya termino, salta al fincicloGuardar
                            j cicloGuardar                  #si no es asi, vuelve de nuevo al cicloGuardar

                        

                        fincicloGuardar:                    #Aqui es donde se guarda en la pila el numero calculado anteriormente
                            beq $t5, $0, guardanndo         #Si el flag de numero negativo es 0, se brinca a guardanndo
                            #Calculando complemento a2 ya que el numero es negativo:
                            nor $v0, $v0, $0                #v0 negado
                            addi $v0, $v0, 0x1              #sumando 1 para calcular el complemento a2 del numero
                            li $t3, -1                      #cargando el -1 en el registro f13
                            mtc1 $t3, $f13                  #Cargando f13 = -1, f0 es el numero en decimal 
                            cvt.s.w $f13, $f13              # Pasando de registro normal a float 
                            mul.s $f20, $f20, $f13          #haciendo negativos los decimales                  

                        guardanndo:
                            addi $sp, $sp, -4               #Pidiendo espacio en la pila
                            mtc1 $v0, $f1                   #se transfiere un valor de un registro entero a uno flotante
                            cvt.s.w $f1, $f1                #Convierte un valor entero en un registro punto flotante en un valor en punto flotante	
                            add.s $f1, $f1, $f20            #sumando los decimales calculados si es que hay
                            li $v0, 2
                            s.s $f1, 0($sp)                 #guardando v0 flotante f1 en la pila
                            addi $a3, $a3, 1                #a3++ que indica la cantidad de numeros presentes en la pila

                        

                            #reiniciando todas las banderas:
                            li $t3, 0                       # cargando el 0 en el registro f20
                            mtc1 $t3, $f20                  # Cargando f20 = 0, f0 es el numero en decimal 
                            cvt.s.w $f20, $f20              # Pasando de registro normal a float
                            li $s5, 0                       #bandera para saber cuantos numeros seguidos se han encontrado
                            li $t5, 0                       #bandera por si un numero es negativo                        
                            addi $s1, $s1, 1                #i++
                            beq $s1, $s0, fin               #si se llega a salto de linea, termina la lectura
                            j ciclo1                        #Volviendo a repetir el ciclo

                    #Si el caracter leido no es un numero, se salta aqui para verificar si es un operando
                    noEsUnNumero:                       #se salta aqui cuando el caracter encontrado no es un numero
                        
                        
                        

                        beq $s2, $t6, esEspacio     #saltando si el caracter es un espacio a esEspacio (esta mas abajo)

                        li $t4, 67                  # Cargando codigo ascii para la C
                        beq $s2, $t4, esC           # Saltando a esC que limpia la pila dejando el primer elemento en 0

                        li $t4, 99                  # Cargando codigo ascii para la c
                        beq $s2, $t4, esC           # Saltando a esC que limpia la pila dejando el primer elemento en 0

                        li $t4, 80                      #Codigo para la potencia
                        beq $s2, $t4, potencia          # si es una p, brinca a potencia

                        li $t4, 112                     #Codigo para la potencia
                        beq $s2, $t4, potencia          #si es una P, brinca a potencia

                        li $t4, 83                      #Codigo para la raiz
                        beq $s2, $t4, raiz              # si es una S, brinca a raiz

                        li $t4, 115                     #Codigo para la raiz
                        beq $s2, $t4, raiz              #si es una s, brinca a raiz

                        li $t0, 1                                       #cargando el 1 para hacer un slt
                        sltu $t1, $t0, $a3                              # t7 vale 1 si hay mas de un elemento en la pila
                        beq $t1, $0, noSePuedeRealizarLaOperacion       #salta a noSePuedeRealizarLaOperacion

                        li $t4, 43                      #Codigo para la suma
                        beq $s2, $t4, sumar             # si es una suma, brinca a sumar

                        li $t4, 45                      #Codigo para la resta
                        beq $s2, $t4, restar            # si es una resta, brinca a restar

                        li $t4, 42                      #Codigo para la multiplicacion
                        beq $s2, $t4, multiplicar       # si es una multiplicacion, brinca a multiplicar

                        li $t4, 47                      #Codigo para la division
                        beq $s2, $t4, dividir           # si es una division, brinca a dividir



                        j error                         #salta a un error ya que el caracter no es valido

                        #Aqui adelante se encuentran todas las operaciones de la calculadora:
                        sumar:  
                            
                            l.s $f0, 0($sp)              #cargando ultimo numero de la pila

                            l.s $f1, 4($sp)              #cargando penultimo numero de la pila

                            add.s $f2, $f1, $f0         #sumando los ultimos dos numeros de la pila
                            addi $sp, $sp, 4            #quitando un espacio que ya no se utiliza a la pila
                            s.s $f2, 0($sp)             #Guardando el resultado de la suma en la pila
                            addi $a3, $a3, -1           #Contador de cuantos numeros hay en la pila - 1
                            j finOperacion              #finalizando la operacion


                        restar:
                            
                            l.s $f0, 0($sp)              #cargando ultimo numero de la pila
                            l.s $f1, 4($sp)              #cargando penultimo numero de la pila
                            sub.s $f2, $f1, $f0          #restando los ultimos dos numeros de la pila
                            addi $sp, $sp, 4             #quitando un espacio que ya no se utiliza a la pila
                            s.s $f2, 0($sp)              #Guardando el resultado de la suma en la pila
                            addi $a3, $a3, -1            #Contador de cuantos numeros hay en la pila - 1
                            j finOperacion               #finalizando la operacion

                            
                        multiplicar:

                            l.s $f0, 0($sp)              #cargando ultimo numero de la pila
                            l.s $f1, 4($sp)              #cargando penultimo numero de la pila
                            mul.s $f2 ,$f1, $f0          #multiplicando los ultimos dos numeros de la pila
                            addi $sp, $sp, 4             #quitando un espacio que ya no se utiliza a la pila
                            s.s $f2, 0($sp)              #Guardando el resultado de la suma en la pila
                            addi $a3, $a3, -1            #Contador de cuantos numeros hay en la pila - 1
                            j finOperacion               #finalizando la operacion

            
                        

                        dividir:
                            l.s $f0, 0($sp)             #cargando ultimo numero de la pila
                            l.s $f1, 4($sp)             #cargando penultimo numero de la pila
                            div.s $f2, $f1, $f0         #dividiendo los ultimos dos numeros de la pila
                            addi $sp, $sp, 4            #quitando un espacio que ya no se utiliza a la pila
                            s.s $f2, 0($sp)             #Guardando el resultado de la suma en la pila
                            addi $a3, $a3, -1           #Contador de cuantos numeros hay en la pila - 1
                            j finOperacion              #finalizando la operacion

                        
                        potencia:                       #Calcula el cuadrado del ultimo numero ingresado en la pila
                            l.s $f0, 0($sp)             #cargando ultimo numero de la pila
                            mul.s $f2, $f0, $f0         #calculando el cuadrado del ultimo numero ingresado a la pila
                            s.s $f2, 0($sp)             #Guardando el resultado de la suma en la pila
                            j finOperacion              #finalizando la operacion                            

                        raiz:
                            l.s $f0, 0($sp)             #$f0=N
                            
                            addi $t0, $0, 2
                            mtc1 $t0, $f1               #se transfiere un valor de un registro entero a uno flotante
                            cvt.s.w $f1, $f1            #f1=2 Convierte un valor entero en un registro punto flotante en un valor en punto flotante	

                            div.s $f2, $f0, $f1         #$f2=x=N/2 valor inicial de la semilla

                            addi $t0, $0, 20            #numero de iteraciones

                            iteracionRaiz:
                                div.s $f3, $f0, $f2     #$f3=N/x
                                add.s $f3, $f2, $f3     #$f3=x+N/x
                                div.s $f2, $f3, $f1     ##$f2=(x+N/x)/2

                                beq $t0, $0, finalRaiz
                                addi $t0, $t0, -1
                                j iteracionRaiz

                            finalRaiz:
                                s.s $f2, 0($sp)	                           
                                j inicio                # saltando nuevamente al inicio

                                
                        imprimirUltimoP:
                            
                            l.s $f12, 0($sp)            #ultimo numero de la pila
                            li $v0, 2                   #imprimiendo el ultimo numero de la pila
                            syscall
                            j inicio                    # saltando nuevamente al inicio

                        
                        noSePuedeRealizarLaOperacion:   #se ejecuta cuando no hay suficientes elementos en pila para realizar una operacion

                            addi $sp, $sp, -4       #pidiendo a la pila para guardar a0
                            sw $a0, 0($sp)          #guardando a0

                            la $a0, MensajeErrorInsuficientesOperadores #IMPRIMIENDO EL MENSAJE DE ERROR
                            li $v0, 4
                            syscall

                            lw $a0, 0($sp)          #cargando de nuevo a0
                            addi $sp, $sp, 4        # dejando la pila como estaba
                            j inicio                # saltando nuevamente al inicio




                        finOperacion:           #Cuando se finaliza una operacion se salta aqui
                            addi $s1, $s1, 1    #i++
                            beq $s1, $s0, fin   #si se llega a salto de linea, termina la lectura del string
                            j ciclo1            #Vuelve al ciclo1       



                        # si es un espacio, y sigue salto de linea, imprimir ultimo numero de la pila
                        # si es un espacio y no sigue salto de linea, seguir en el ciclo1 y hacer i++   
                        esEspacio:
                            
                            addu $t2, $s1, $a0                      # i + a0
                            lbu $t0, 1($t2)                         #cargando siguiente numero
                            beq $t0, $s6, imprimirUltimoP           #si el siguiente elemento es un salto de linea, salta a seccion que imprime el ultimo numero ingresado a la pila
                            addi $s1, $s1, 1                        #i++
                            beq $s1, $s0, fin                       #si se llega a salto de linea, termina la lectura
                            j ciclo1                                #Salta nuevamente al ciclo 1


                                                
                        esC:                    #limpia toda la Pila y deja el ultimo elemento en 0
                            move $t0, $a3       # moviendo el numero total de elementos en la pila
                            sll $t0, $t0, 4     #Numero de elmentos en la pila x 4
                            add $sp, $sp, $t0   #dejando la pila como deberia estar
                            mtc1 $0, $f0        #se transfiere un valor de un registro entero a uno flotante
                            cvt.s.w $f0, $f0    #Convierte un valor entero en un registro punto flotante en un valor en punto flotante
                            s.s $f0, 0($sp)     #Guardando en la pila el 0
                            li $a3, 1           #porque hay un elemento en la pila, el cero
                            j inicio            #saltando a inicio


                        fin:                    #Finaliza el ciclo1, vuelve al inicio
                            j inicio            #Volver al inicio de la calculadora
                    
                        error:                  #Imprime un mensaje de error si se ingresa un caracter invalido
                            la $a0, err
                            li $v0, 4
                            syscall
                            li $v0, 10
                            syscall


        ###############################################################################################################
        #####################################        funciones      ###################################################
        ###############################################################################################################




        #Listo
        #Funcion que retorna en v0 la cantidad de caracteres del string, recibe el string en a0
        getNUMCHAR:
            sub $t6, $t6, $t6                   #i = 0
            li $t5, 10                          #codigo asccii salto linea
            getNUMCHARciclo1:
                add $t7, $t6, $a0               #a0 + i  ****
                lbu $t7, 0($t7)		            # a[i]
                addi $t6, $t6, 1                #i++
                bne $t7, $t5, getNUMCHARciclo1  #repitiendo ciclo 
            move $v0, $t6                       #NUMCHAR = v0
            la $a1, NUMCHAR                     #puntero a NUMCHAR
            sw $v0, 0($a1)                      # Guardando en NUMCHAR la cantidad de caracteres
            jr $ra                              #fin funcion


        #Listo
        #Funcion que retorna un int a partir de un char en ASCII, lo recibe en a1, retorna el entero en v0
        getNUMBER:
            addi $sp, $sp, -8   # Pidiendo espacio en la pila
            sw $t7, 4($sp)      #Guardando en pila
            sw $t6, 0($sp)      #Guardando en pila

            li $t7, 48          #caracter 0 en asccii
            move $t6, $a1       #numero ingresado en asccii copiado en t6
            sub $t6, $t6, $t7   # t6 - t7  Calculando el entero
            move $v0, $t6       #copiando el numero en entero a v0 para retornarlo

            lw $t6, 0($sp)      #Cargando de pila
            lw $t7, 4($sp)      #Cargando de pila
            addi $sp, $sp, 8    #dejando pila como estaba
            jr $ra              #Fin funcion
