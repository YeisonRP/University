############################################################################################################################################
################################################## VARIABLES QUE DEBE MODIFICAR EL USUARIO #################################################
############################################################################################################################################

#NOMBRE DEL ARCHIVO QUE SE VA A COMPILAR (SIN .V, GENERALMENTE BANCO_PRUEBAS)
NAME_BANCO_PRUEBAS := banco_pruebas

#NOMBRE DEL ARCHIVO DEL MODULO CONDUCTUAL, EL QUE SE EJECUTARA CON YOSYS
NAME_MODULO_CONDUCTUAL := RAM_c

#NOMBRE DEL ARCHIVO ESTRUCTURAL
NAME_MODULO_ESTRUCTURAL := RAM_e

# LIBRERIAS
#NOMBRE DEL ARCHIVO .LIB
Nombre_archivo_lib := cmos.lib

#NOMBRE DEL ARCHIVO QUE CONTIENE LAS COMPUERTAS (.v)
Nombre_archivo_lib_v := cmos.v


############################################################################################################################################
################################################## COMANDOS DE CONSOLA USUARIO  ############################################################
############################################################################################################################################

all: generar_archivo_yosys ejecutar_yosys build run gtk clean

build:
	iverilog -o $(NAME_BANCO_PRUEBAS).o -Ttyp $(NAME_BANCO_PRUEBAS).v

run:
	@echo "\n--------------------------------------------------------------------------------------------------------\n"
	@echo "Ejecutando el programa...  \n"
	@vvp $(NAME_BANCO_PRUEBAS).o $(NAME_BANCO_PRUEBAS).vcd

gtk: 
	@gtkwave $(NAME_BANCO_PRUEBAS).vcd;

clean:
	@rm $(NAME_BANCO_PRUEBAS).vcd $(NAME_BANCO_PRUEBAS).o

generar: generar_banco_pruebas generar_archivo_yosys llenarBancoPrueba emacs


############################################################################################################################################
################################################## COMANDOS INTERNOS #######################################################################
############################################################################################################################################



#SE ENCARGA DE HACER AUTOINST AL BANCO DE PRUEBAS
emacs:
	@emacs --batch $(NAME_BANCO_PRUEBAS).v -f verilog-auto -f save-buffer


#Genera los archivos en blanco de probador, banco conductual y el archivo conductual
generar_banco_pruebas:
	@touch $(NAME_BANCO_PRUEBAS).v


#Genera el archivo que contiene los comandos de yosys, con los respectivos nombres que deberian tener
generar_archivo_yosys:
	@touch yosys_comandos.ys
	@echo "# read design" > yosys_comandos.ys
	@echo "read_verilog $(NAME_MODULO_CONDUCTUAL).v\n\
		   \n# elaborate design hierarchy \
		   \nhierarchy -check -top $(NAME_MODULO_CONDUCTUAL)\n \
		   \n# the high-level stuff  \
		   \nproc; opt; fsm; opt; memory; opt\n \
		   \n# mapping to internal cell library \
		   \ntechmap; opt\n\
		   \n# mapping flip-flops to $(Nombre_archivo_lib)\
		   \ndfflibmap -liberty $(Nombre_archivo_lib)\n\
		   \n# mapping logic to $(Nombre_archivo_lib)\
		   \nabc -liberty $(Nombre_archivo_lib)\n\
		   \n# cleanup\
		   \nclean\n\
		   \n# write synthesized design  \
		   \nwrite_verilog $(NAME_MODULO_ESTRUCTURAL).v" >> yosys_comandos.ys

llenarBancoPrueba:
	@echo "\`timescale 	1ns				/ 100ps\n" > $(NAME_BANCO_PRUEBAS).v
	@echo "\`include \"$(NAME_MODULO_CONDUCTUAL).v\" \
		   \n\`include \"$(NAME_MODULO_ESTRUCTURAL).v\" \
		   \n\`include \"probador.v\"\n \
		   \nmodule $(NAME_BANCO_PRUEBAS); \n \
		   \n/*AUTOWIRE*/\n \
		   \n$(NAME_MODULO_CONDUCTUAL)  $(NAME_MODULO_CONDUCTUAL)_instance( /*AUTOINST*/  \
		   \n\t\t );\n \
		   \n$(NAME_MODULO_ESTRUCTURAL)  $(NAME_MODULO_ESTRUCTURAL)_instance( /*AUTOINST*/  \
		   \n\t\t);\n \
		   \nprobador  probador_inst( /*AUTOINST*/  \
		   \n\t\t );\n \
		   \nendmodule" >> $(NAME_BANCO_PRUEBAS).v

#EJECUTA YOSYS Y CAMBIA EL NOMBRE DEL MODULO SINTETIZADO POR EL NOMBRE ESTRUCTURAL, PARA PODER USAR EMACS, TAMBIEN
#HACE EL INCLUDE DEL ARCHIVO .V PARA QUE LAS COMPUERTAS SEAN RECONOCIDAS.
ejecutar_yosys:
	@yosys yosys_comandos.ys
	@sed -i 's/module $(NAME_MODULO_CONDUCTUAL)/module $(NAME_MODULO_ESTRUCTURAL)/g' $(NAME_MODULO_ESTRUCTURAL).v
	@sed  -i '1i `include "$(Nombre_archivo_lib_v)"' $(NAME_MODULO_ESTRUCTURAL).v
	@sed -i 's/_c/_e/g' $(NAME_MODULO_ESTRUCTURAL).v 


help:
	@echo "make: Crea el estructural con las variables con nombres ya arregaldos, \
	compila y ejecuta finalmente gtkwave"
	@echo "make generar: Crea el banco de pruebas y el archivo de comandos de yosys \
	de manera automatica, tambien instancia los modulos conductual y estructural en el \
	banco de pruebas y finalmente ejecuta emacs"


