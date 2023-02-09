###############################################################################################################
############################## Autor: Yeison Rodriguez Pacheco B56074   #######################################
############################## Curso: Estructuras de Computadoras I     #######################################
############################## Tarea 2                                  #######################################
############################## Correo: yeisonrodriguezpacheco@gmail.com #######################################  
############################## Grupo: 01                                #######################################
###############################################################################################################

# NOTA: Me disculpo por las faltas de ortografia pero tildar programando a veces es contraproducente.

# EXPLICACION DEL PROGRAMA: Este programa recibe un arreglo de numeros enteros en DIRACU, donde el primer numero es el mas significativo.
# Seguidamente en NP va la cantidad de palabras (numeros enteros) a desplazar
# En nbD va la cantidad de desplazamientos a la derecha que se desean realizar
# Es importante notar que no se encontro forma de imprimir los numeros en hexadecimal, por lo que los numeros siempre aparecen como enteros separados por una ','
# Asi que el desplazamiento para revisar si es correcto se debe realizar manualmente con ayuda de alguna herramienta online.
# Aca se deja un convertidor a complemento a dos de ser necesario https://es.planetcalc.com/747/
# Si desea agregar mas numeros se debe modificar en el .data la variable DIRACU, y cambiar respectivamente la variable NP que es el numero de palabras
# Si desea agregar mas desplazamientos se modifica la variable nbD


        ###############################################################################################################
        #####################################     Variables del sistema        ########################################
        ###############################################################################################################

    .data #0x80000002,0x00000008,0x00000030,0x00000005
        DIRACU:.word 0x80000002,0x00000008,0x00000030,0x00000005   # Numeros en hexadecimal a desplazar.
        NP:.word 4                                      # Numero de palabras ingresadas
        NbD:.word 63                                    # Numero de desplazamientos a realizar       
        comma: .asciiz ","                              # Una simple ,
        salto: .asciiz "\n"                             # Salto de linea
        Mensaje1: .asciiz "Este es el numero que se ingreso para desplazar (cada palabra separada por una ','):\n"
        Mensaje2: .asciiz "Este es el resultado de realizar "
        Mensaje3: .asciiz " desplazamientos a la derecha:\n "
        MensajeError: .asciiz "ERROR: Se ingreso una cantidad de desplazamientos que supera el numero de bits del numero, por lo que no se puede realizar la operacion\n "

        
        ###############################################################################################################
        #####################################            main        ##################################################
        ###############################################################################################################

    .text

    main:  
        la $a0, Mensaje1    #Imprimiendo el primer mensaje
        li $v0, 4
        syscall

        la $a0, DIRACU      # Direccion de memoria del bit mas significativo
        la $s0, NP          # Direccion de memoria del numero de palabras
        la $s1, NbD         # Direccion de memoria del numero de desplazamientos
        lw $a1, 0($s0)      # Numero de palabras
        lw $a2, 0($s1)      # Numero de bits a desplazar
        
        #Verificando si el numero de desplazamientos esta entre el rango valido
        #5
        move $s5, $a1           #moviendo al registro s5 por prevencion
        sll $s5, $s5, 5         #numero de palabras*32
        slt $s7, $a2, $s5        #comparando el si el numero de desplazamientos es menor que el numero de palabras
        beq $s7, $0, error      # si no es asi, da un error


        jal sra_MP          # SAltando a la funcion sra_MP

        move $t7, $v0       #moviendo el resultado de sra_MP a t7

        la $a0, Mensaje2    #Imprimiendo el segundo mensaje
        li $v0, 4
        syscall

        move $a0, $a2      # imprimiend numero de desplazamientos
        li $v0,1
        syscall

        la $a0, Mensaje3    #Imprimiendo el tercer mensaje
        li $v0, 4
        syscall       
        
        move $a0, $t7       # Devolviendo a0 como estaba, apuntando al arreglo ya solucionado

        jal imprimirArregloMultiplePrecision # Funcion que imprime un arreglo, en a0 recibe el puntero al arreglo y en a1 el tama;o del mismo

          
        li $v0, 10 				
	    syscall 			# Terminando el programa	

        error:                              # Se ejecuta si hay un error
                    la $a0, MensajeError    #Imprimiendo el mensaje de error
                    li $v0, 4
                    syscall  
                     
                    li $v0, 10 				
	                syscall 			# Terminando el programa

        ###############################################################################################################
        #####################################        funciones      ###################################################
        ###############################################################################################################


    #Funcion que hace un srl aritmetico de multiple presicion, recibe en a0 el puntero al arreglo, en a1 
    # el numero de palabras y en a2 el numero de desplazamientos
    sra_MP:

        addi $sp, $sp, -16  # pidiendo espacio en la pila
        sw $ra, 0($sp)      # GUardando ra en sp 0 #direccion de retorno
        sw $a0, 4($sp)      # GUardando a0 en sp 4 #primera direccion a la palabra
        sw $a1, 8($sp)      # GUardando a1 en sp 8  #  numero de palabras
        sw $a2, 12($sp)     # GUardando a2 en sp 12 # numero de bits a desplazar

        jal imprimirArregloMultiplePrecision # Funcion que imprime un arreglo, en a0 recibe el puntero al arreglo y en a1 el tama;o del mismo

        lw $a0, 4($sp)      # dejanto todo como estaba antes
        lw $a1, 8($sp)      # dejanto todo como estaba antes
        lw $a2, 12($sp)     # dejanto todo como estaba antes

        #datos necesarios para la ejecucion de la funcion:
        addi $s0, $0, 0     # s0 = 0 -> bitSigno
        addi $t7, $0, 0     # t7 = 0 -> acarreo2
        addi $s1, $0, 0     # s1 = 0 -> sumar
        addi $s2, $0, 1     # s2 = 0 -> i = 1 
        sub $s3, $s3, $s3   # s3 = 0 -> mascara
        lui $s3, 0x8000     # cargando 100000....000 #mascara
        move $s4, $a1      # s4 = numero de palabras
        move $s5, $a2      # s5 = numero de desplazamientos
        addi $s6, $0, 1     # s6 = 1 contador de desplazamientos
        

            ciclo1srl:          # Ciclo principal, se repite las mismas veces que el numero de desplazamientos

                lw $t0, 0($a0)          # cargando la palabra mas significativa del arreglo    
                andi $t3,$t0,0x1        # dejando solo el bit menos significativo en t3
                bne $t3, $0, acarreo1   # verificando si el bit menos significativo es 1 o 0
                lui $t7, 0x0            # si el bit menos significativo es 0
                j verificandoSigno
                acarreo1:               
                    lui $t7, 0x8000     # si el bit menos significativo es 1           
                

                verificandoSigno:
                and $t1, $t0, $s3       # dejando solo el bit mas significativo
                bne $t1, $0, negativo   # si no es cero es porque el primer bit es negativo
                lui $s0, 0x0000         # cargando un 0 en bitSigno
                j guardandoPrimeraPalabra
                negativo:
                    lui $s0, 0x8000     # cargando un 1 en bitSigno

                guardandoPrimeraPalabra:
                srl $t0,$t0,1               # srl de la primera palabra
                addu $t0, $t0, $s0          # metiendo un 1 si el desplazamiento es de un numero negativo o un 0 si el desplazamiento es de un numero positivo
                sw $t0,0($a0)               # guardando la primera palabra ya con el shift right
                addi $s2, $0, 1             # s2 = 0 -> i = 1 #contador

                #Caso especial si solo hay una palabra
                li $a3, 1                    # Cargando un 1
                beq $a1, $a3, finciclo2srl   #Si solo hay una palabra, se brinca el ciclo 2

                    ciclo2srl:
                        sll $t0, $s2, 2             # ix4
                        addu $t1, $t0, $a0          # A + ix4
                        lw $t2, 0($t1)              # cargando i-esima palabra
                        andi $t3,$t2,0x1            # dejando solo el bit menos significativo en t3
                        bne $t3, $0, acarreo        # Verificando si el bit menos significativo es 1 o 0 para pasarlo a la otra palabra
                        lui $s1, 0x0000             # Guardando que el bit menos significativo es 0 para pasarlo a la otra palabra
                        j continuandoAlgoritmo
                        acarreo:
                        lui $s1, 0x8000         # Guardando que el bit menos significativo es 1 para pasarlo a la otra palabra

                        continuandoAlgoritmo:
                        srl $t3, $t2, 1         # haciendo srl de la palabra actual
                        addu $t3, $t3,$t7       # Sumando si hay acarreo sumando el acarreo de la palabra anterior, si el bit mas significativo era 1
                        sw $t3, 0($t1)          # guardando la nueva palabra
                        move $t7, $s1           # Guardando el acarreo del bit menos significativo de esta palabra antes de haberse modificado

                        addi $s2, $s2, 1            # i++
                        beq $s2, $s4, finciclo2srl  # verificando si se llego a la ultima palabra, si no es asi se repite el ciclo

                        
                        j ciclo2srl

                finciclo2srl:
                beq $s6, $s5, finciclo1srl      # verificando si ya se hicieron todos los desplazamientos
                addi $s6, $s6, 1                # sumando 1 al contador de desplazamientos
                j ciclo1srl                     # volviendo a la primera palabra para desplazar nuevamente

            finciclo1srl:                       # fin de todos los desplazamientos

            move $v0, $a0       # Guardando la direccion del nuevo arreglo en v0
                                                    
            lw $ra, 0($sp)      # cargando direccion de retorno
            addi $sp, $sp, 16   # dejando sp como estaba antes
            
            jr $ra              # terminar funcion






    #Funcion que recibe un arreglo de enteros cuyo puntero inicial esta en $a0
    # y en $a1 el tamano del arreglo, y procede a imprimir el mismo
    imprimirArregloMultiplePrecision:
        move $t0, $a0           # Guardando en t0 la direccion de la primera palabra
        move $s1, $a1           # Numero de palabras en s1
        sub $s0, $s0, $s0       # i = 0

        cicloImprimir:
            
            sll $s4, $s0, 2     # ix4
            add $t3, $s4, $t0   # t3 = A+ix4
            lw $a0, 0($t3)      # imprimiend numero en a0
            li $v0,1
            syscall
            addi $s0, $s0, 1    # i++
            beq $s1, $s0, finFuncionImprimir # si i es igual a la cantidad de numeros, termina
            la $a0, comma       # Para imprimir una ,
            li $v0, 4
            syscall
            j cicloImprimir     # avanzando al siguiente numero
           
        finFuncionImprimir:
            
            la $a0, salto       # Para imprimir un salto de linea
            li $v0, 4           # ya que es el ultimo numero
            syscall

            jr $ra              # Volviendo donde se llamo la funcion