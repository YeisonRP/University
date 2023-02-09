###############################################################################################################
############################## Autor: Yeison Rodriguez Pacheco B56074   #######################################
############################## Curso: Estructuras de Computadoras I     #######################################
############################## Tarea 1                                  #######################################
############################## Correo: yeisonrodriguezpacheco@gmail.com #######################################  
############################## Grupo: 01                                #######################################
###############################################################################################################

# NOTA: Me disculpo por las faltas de ortografia pero tildar programando a veces es contraproducente.

# EXPLICACION DEL PROGRAMA: Este programa muestra un menu en pantalla con la ayuda de syscall y en el mismo vienen 6 opciones
# La primera (1) lo que hace es pedir al usuario que ingrese mediante el teclado una palabra, la cual sera utilizada para
# ser procesada en las demas opciones del menu, si el usuario no ingresa ninguna palabra y elige una de las otras opciones
# del menu primero, entonces el programa utilizara un string por defecto para realizar los cambios en el mismo.
# La segunda (2) opcion del menu se encarga de poner todas las letras del string en mayusculas.
# La tercera (3) opcion del menu se encagra de poner todas las letras del string en minusculas.
# La cuarta (4) opcion del menu se encagra de poner la primera letra del string en mayuscula.
# La quinta (5) opcion del menu se encarga de poner todas las primeras letras de cada palabra del string en mayuscula.
# La sexta (6) opcion del menu es para salir del programa.
# Favor no ingresar un string que contenga mas de 100 bytes ya que es el tama;o que se utilizo para el buffer
# El programa fue probado en QTspim y programado en Visual Studio Code.



        ###############################################################################################################
        #####################################     Variables del sistema        ########################################
        ###############################################################################################################


    .data
    controlador:.word 0 # Esta variable se pone en 1 cuando el usuario ingresa a la opcion 1 del menu, sirve para que...
                        #...se utilice el string ingresado en el teclado y no el string default

#Este grande y feo string guarda todo el texto del menu que se muestra en la consola:
menuOpciones: .asciiz "\n1-Leer una frase\n2-CAMBIAR TODO A MAYUSCULAS\n3-cambiar todo a minusculas\n4-Primera letra en mayuscula, las demas en minuscula\n5-Primera Letra De Cada Palabra En Mayuscula\n6-Salir\n\nIngrese un numero para elegir una opcion del menu\n"

#Este caracter aparece cuando se elige una opcion no valida del menu:
caracterNoValido: .asciiz "El caracter ingresado no es valido, por favor ingrese un caracter valido\n"

#Este string se procesa si el usuario no elige la opcion 1:
StringDefault: .asciiz "EstE Es uN StRiNG qUe SE ProcEsa Si El usuario no INgresa Otro\n"

#Este string se procesa si el usuario elige la opcion 1:
StringOpcion1: .asciiz "Por favor ingrese el string que desea procesar.\n"

#Aqui va el string ingresado por el usuario:
theString: 
    .space 100          #Haciendo un buffer de 100 espacios para guardar la palabra
    .text   
    NUMCHAR:.word 63    #Variable que indica la cantidad de chars en el string, contando \n


        ###############################################################################################################
        #####################################            main        ##################################################
        ###############################################################################################################



    main:      
        ###############################################################################################################
        #####################################        Creando Menu        ##############################################
        ###############################################################################################################

        ImprimiendoMenu:
                                # Imprimiento el menu en consola:
        li $v0, 4               #Cargando codigo en v0 para impresion de siscall
        la $a0, menuOpciones    # Cargando puntero a string menuOpciones 
        syscall                 #Imprimendo menuOciones

        MenuPrincipal:          #Entrada al menu principal:

            # Leyendo el numero ingresado por el usuario:
            li $v0, 5
            syscall

            li $t0, 1           #Para hacer el beq con la opcion elegida por el usuario

            beq $v0,$t0,Menu1   #Revisando si el usuario eligio la opcion 1
            addi $t0,$t0,1      #Ya que el usuario no eligio la opcion 1, se aumenta el contador para revisar si eligio la siguiente

            beq $v0,$t0,Menu2   #Revisando si el usuario eligio la opcion 2
            addi $t0,$t0,1      #Ya que el usuario no eligio la opcion 2, se aumenta el contador para revisar si eligio la siguiente

            beq $v0,$t0,Menu3   #Revisando si el usuario eligio la opcion 3
            addi $t0,$t0,1      #Ya que el usuario no eligio la opcion 3, se aumenta el contador para revisar si eligio la siguiente

            beq $v0,$t0,Menu4   #Revisando si el usuario eligio la opcion 4
            addi $t0,$t0,1      #Ya que el usuario no eligio la opcion 4, se aumenta el contador para revisar si eligio la siguiente

            beq $v0,$t0,Menu5   #Revisando si el usuario eligio la opcion 5
            addi $t0,$t0,1      #Ya que el usuario no eligio la opcion 5, se aumenta el contador para revisar si eligio la siguiente

            beq $v0,$t0,Menu6   #Revisando si el usuario eligio la opcion 6
            
            # Imprimiento que se ingreso un caracter no valido y volviento a preguntar por uno valido:
            li $v0, 4           #Cargando codigo en v0 para impresion de siscall
            la $a0, caracterNoValido # Cargando puntero a string caracterNoValido 
            syscall             #Imprimendo mensaje


            j MenuPrincipal #Volviendo al menu ya que se ingreso un caracter no valido


            

        ###############################################################################################################
        #################################    1-Leer una frase                ##########################################
        ###############################################################################################################
        Menu1:
            # Imprimiento Mensaje en consola
            li $v0, 4               #Cargando codigo en v0 para impresion de siscall
            la $a0, StringOpcion1   # Cargando puntero a string StringOpcion1 
            syscall                 #Imprimendo menuOciones


            li $v0, 8               #cargar string
            la $a0, theString       # Cargando el puntero a la primera direccion del string en a0
            li $a1, 100             #Maximo tama;o del buffer
            syscall

        
            addi $t0, $a0, 0        #Copiando la direccion de memoria del primer string en t0
            li $s7, 10              #Cargando el codigo ascii de salto de linea
            li $t6, 1               #Inicializando t6 en 1, para contar la cantidad de caracteres y guardarlo en NUMCHAR
             
	        
            ciclo1:
                lbu $s0, 0($t0)         #ahora tenemos en s0 la letra de 8 bits
                beq	$s0, $s7, finCiclo1	# Si el caracter leido es el de salto de linea, termina

                addi $t0,$t0,0x1    #sumando a la direccion de memoria uno mas, para encontrar el siguiente char
                addi $t6,$t6,1      #Contando Los char
                j ciclo1			#jump to ciclo

            finCiclo1:


                la $t7, NUMCHAR         # Carga direccion de NUMCHAR en t7
                sw $t6, 0($t7)		    #Guardando en NUMCHAR la cantidad de letras
                la $s1, controlador     #CArgando la direccion de la variable controlador
                li $t0, 1
                sw $t0, 0($s1)          #Guardando en controlador 1, ya que se leyo un string del teclado

                j ImprimiendoMenu
                      

        ###############################################################################################################
        #################################    2-TODO EN MAYUSCULAS            ##########################################
        ###############################################################################################################
        Menu2:
            la $t6, NUMCHAR                     #cargando direccion de numchar en t6
            lw $t7, 0($t6)                      #Cargando la cantidad de letras del arreglo en t7

            la $s1, controlador                 #CArgando la direccion de la variable controlador
            lw $t5, 0($s1)                      #cargando en t5 el valor de la variable controladora

            bne $t5,$zero,cargandoPalabraIngresadaPorUsuario2 #Si controlador = 1 carga la palabra ingresada por el usuario
            la $a0, StringDefault               #Cargando la dir de la palabra por defecto en a0 ya que el usuario no ingreso ninguna en el teclado
            
            j todoEnMayusculas2                 #Salta al algoritmo de poner todas las letras en mayusculas
            cargandoPalabraIngresadaPorUsuario2:
            la $a0, theString                   #Carga la direccion de la palabra ingresada por el usuario en el teclado en a0



            todoEnMayusculas2:                  #algoritmo que cambia todas las letras a mayusculas
                sub	$t0, $t0, $t0		        # haciendo i = 0
                addi $t4, $zero, 0x61           #inicio de las letras minusculas en hexadecimal
                addi $t5, $zero, 0x7A           #fin letras minusculas en hexadecimal
                addi $t6, $zero, 0x20           # Diferencia entre mayusculas y minusculas en hexadecimal
                ciclo2:
                    beq $t0, $t7, finTodoMayuscula2 #si i = numchar se termina
                    add $t1, $t0, $a0           #  t1 = direccion i + a0
                    lbu $t2, 0($t1)             # A[i] cargando una letra
                    blt $t2, $t4, sumar2        # Si no es una minuscula se pasa a sumar2
                    bgt $t2, $t5, sumar2        # Si no es una minuscula se pasa a sumar2
                    sub $t2, $t2, $t6           #Restando 0x20 para hacer la minuscula mayuscula
                    
                sumar2:
                    sb $t2, 0($t1)      #Guardando la letra de nuevo en el string
                    addi $t0,$t0,1      #i++
                    j ciclo2 
            finTodoMayuscula2:  
                li $v0, 4               #Cargando codigo en v0 para impresion de syscall
                syscall                 #Imprimendo el string en mayusculas
                j ImprimiendoMenu

        ###############################################################################################################
        #################################    3-todo en minusculas            ##########################################
        ###############################################################################################################
        Menu3:
            la $t6, NUMCHAR                     #cargando direccion de numchar en t6
            lw $t7, 0($t6)                      #Cargando la cantidad de letras del arreglo en t7

            la $s1, controlador                 #CArgando la direccion de la variable controlador
            lw $t5, 0($s1)                      #cargando en t5 el valor de la variable controladora

            bne $t5,$zero,cargandoPalabraIngresadaPorUsuario3 #Si controlador = 1 carga la palabra ingresada por el usuario
            la $a0, StringDefault               #Cargando la dir de la palabra por defecto en a0 ya que el usuario no ingreso ninguna en el teclado
            
            j todoEnMinusculas3                 #Salta al algoritmo de poner todas las letras en minusculas
            cargandoPalabraIngresadaPorUsuario3:
            la $a0, theString                   #Carga la direccion de la palabra ingresada por el usuario en el teclado en a0



            todoEnMinusculas3:                  #algoritmo que cambia todas las letras a minusculas
                sub	$t0, $t0, $t0		        # haciendo i = 0
                addi $t4, $zero, 0x41           #inicio de las letras mayus
                addi $t5, $zero, 0x5A           #fin letras mayus
                addi $t6, $zero, 0x20           # Diferencia entre mayusculas y minusculas
                ciclo3:
                    beq $t0, $t7, finTodoMinuscula3 #si i = numchar se termina
                    add $t1, $t0, $a0           #  t1 = direccion i + a0
                    lbu $t2, 0($t1)             # A[i]
                    blt $t2, $t4, sumar3        # Si no es una mayuscula salta a sumar 
                    bgt $t2, $t5, sumar3        # Si no es una mayuscula salta a sumar
                    add $t2, $t2, $t6           #sumando 0x20 para hacer la mayuscula minuscula 
                    
                sumar3:
                    sb $t2, 0($t1)      #Guardando la letra de nuevo en el string
                    addi $t0,$t0,1      #i++
                    j ciclo3 
            finTodoMinuscula3:  
                li $v0, 4               #Cargando codigo en v0 para impresion de siscall
                syscall                 #Imprimendo el string en mayusculas
                j ImprimiendoMenu              

        ###############################################################################################################
        #################################    4-Primera letra en mayuscula     #########################################
        ###############################################################################################################
        Menu4:
            la $t6, NUMCHAR                 #cargando direccion de numchar en t6
            lw $t7, 0($t6)                  #Cargando la cantidad de letras del arreglo en t7

            la $s1, controlador             #CArgando la direccion de la variable controlador
            lw $t5, 0($s1)                  #cargando en t5 el valor de la variable controladora

            bne $t5,$zero,cargandoPalabraIngresadaPorUsuario4 #Si controlador = 1 carga la palabra ingresada por el usuario
            la $a0, StringDefault                             #Cargando la dir de la palabra por defecto en a0 ya que el usuario no ingreso ninguna en el teclado
            
            j primeraEnMayusculas4                            #Salta al algoritmo de poner todas las letras en mayusculas
            cargandoPalabraIngresadaPorUsuario4:
            la $a0, theString                                 #Carga la direccion de la palabra ingresada por el usuario en el teclado en a0



            primeraEnMayusculas4:                         #algoritmo que cambia la primera letra a mayuscula
                sub	$t0, $t0, $t0		                  # haciendo i = 0
                sub	$t3, $t3, $t3		                  # haciendo j = 0, donde j es un controlador para saber si es la primera letra del string                
                addi $t4, $zero, 0x41                     #inicio de las letras mayus
                addi $t5, $zero, 0x5A                     #fin letras mayus
                addi $s4, $zero, 0x61                     #inicio de las letras minus
                addi $s5, $zero, 0x7A                     #fin letras minus
                addi $t6, $zero, 0x20                     # Diferencia entre mayusculas y minusculas
                ciclo4:
                    beq $t0, $t7, finprimeraEnMayusculas4 #si i = numchar se termina
                    add $t1, $t0, $a0                     #  t1 = direccion i + a0
                    lbu $t2, 0($t1)                       # A[i] cargando letra


                    bne $t3, $0, yaPasoLaPrimerLetra      #Para saber si ya paso la primera letra y hacer las demas minusculas

                    blt $t2, $t4, sumar4                  # Si es menor que una A salta a sumar
                    bgt $t2, $t5, esLetra                 # Si es mayor que una Z salta a esLetra
                    addi $t3, $t3 , 1                     #Es una mayuscula, pone el controlador j en 1 o mas
                    j sumar4 
                    
                    esLetra:
                        blt $t2, $s4, sumar4              # Si es menor que a no es letra y salta a
                        bgt $t2, $s5, sumar4              # Si es mayor que z no es letra y salta a
                        sub $t2, $t2, $t6                 #Restando 0x20 para hacer la minuscula mayuscula
                        addi $t3, $t3 , 1                 # pone el controlador j en 1 o mas
                        j sumar4

                    yaPasoLaPrimerLetra:                  #Hace las letras minusculas
                        blt $t2, $t4, sumar4              # Si es menor que una A salta a sumar
                        bgt $t2, $t5, sumar4              # Si es mayor que una Z salta a esLetra
                        add $t2, $t2, $t6                 #Restando 0x20 para hacer la mayuscula minuscula

                sumar4:
                    sb $t2, 0($t1)                        #Guardando la letra de nuevo en el string
                    addi $t0,$t0,1                        #i++
                    j ciclo4
            finprimeraEnMayusculas4:  
                li $v0, 4                                 #Cargando codigo en v0 para impresion de siscall
                syscall                                   #Imprimendo el string en mayusculas
                j ImprimiendoMenu       

        ###############################################################################################################
        #################################    5-Primera Letra Palabra Mayuscula ########################################
        ###############################################################################################################
        Menu5:
            la $t6, NUMCHAR                 #cargando direccion de numchar en t6
            lw $t7, 0($t6)                  #Cargando la cantidad de letras del arreglo en t7

            la $s1, controlador             #CArgando la direccion de la variable controlador
            lw $t5, 0($s1)                  #cargando en t5 el valor de la variable controladora

            bne $t5,$zero,cargandoPalabraIngresadaPorUsuario5 #Si controlador = 1 carga la palabra ingresada por el usuario
            la $a0, StringDefault                             #Cargando la dir de la palabra por defecto en a0 ya que el usuario no ingreso ninguna en el teclado
            
            j todasInicialesEnMayusculas5                     #Salta al algoritmo de poner todas las letras en mayusculas
            cargandoPalabraIngresadaPorUsuario5:
            la $a0, theString                                 #Carga la direccion de la palabra ingresada por el usuario en el teclado en a0



            todasInicialesEnMayusculas5:    #algoritmo que cambia todas las letras iniciales a mayusculas
                sub	$t0, $t0, $t0		    # haciendo i = 0
                sub	$t3, $t3, $t3		    # haciendo j = 0 para saber si es la primera letra de una palabra             
                addi $t4, $zero, 0x41       #inicio de las letras mayus
                addi $t5, $zero, 0x5A       #fin letras mayus
                addi $s4, $zero, 0x61       #inicio de las letras mayus
                addi $s5, $zero, 0x7A       #fin letras mayus
                addi $t6, $zero, 0x20       # Diferencia entre mayusculas y minusculas
                ciclo5:
                    beq $t0, $t7, fintodasInicialesEnMayusculas5 #si i = numchar se termina
                    add $t1, $t0, $a0       #  t1 = direccion i + a0
                    lbu $t2, 0($t1)         # A[i]

                    beq $t2, $t6 , pasoUnEspacio #Verifica si paso un espacio para poner la palabra siguiente con inicio en mayuscula, si es que la hay
                    bne $t3, $0, yaPasoLaPrimerLetra5 # si j != 0 salta a ya paso la primera letra

                    blt $t2, $t4, sumar5    # Si es menor que una A salta a sumar
                    bgt $t2, $t5, esLetra5  # Si es mayor que una Z salta a esLetra
                    addi $t3, $t3 , 1       #Es una mayuscula, pone el controlador j en 1 o mas
                    j sumar5 
                    
                    esLetra5:
                        blt $t2, $s4, sumar5    # Si es menor que a no es letra y salta a
                        bgt $t2, $s5, sumar5    # Si es mayor que z no es letra y salta a
                        sub $t2, $t2, $t6       #Restando 0x20 para hacer la minuscula mayuscula
                        addi $t3, $t3 , 1       # pone el controlador j en 1 o mas
                        j sumar5

                    yaPasoLaPrimerLetra5:
                        blt $t2, $t4, sumar5    # Si es menor que una A salta a sumar
                        bgt $t2, $t5, sumar5    # Si es mayor que una Z salta a esLetra
                        add $t2, $t2, $t5       #Restando 0x20 para hacer la mayuscula minuscula
                        j sumar5
                    pasoUnEspacio:              #Si se recibe un espacio se reinicia j
                        sub	$t3, $t3, $t3		# haciendo j = 0 
                sumar5:
                    sb $t2, 0($t1)              #Guardando la letra de nuevo en el string
                    addi $t0,$t0,1              #i++
                    j ciclo5
            fintodasInicialesEnMayusculas5:  
                li $v0, 4               #Cargando codigo en v0 para impresion de siscall
                syscall                 #Imprimendo el string en mayusculas
                j ImprimiendoMenu               

        ###############################################################################################################
        #################################                  6-Salir              #######################################
        ###############################################################################################################
        Menu6:            
            li $v0, 10 				
	        syscall 			#Terminando el programa		
     