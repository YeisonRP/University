############################################################################################################################################
################################################## VARIABLES QUE DEBE MODIFICAR EL USUARIO #################################################
############################################################################################################################################

#NOMBRE DEL ARCHIVO QUE SE VA A COMPILAR (SIN .V, GENERALMENTE BANCO_PRUEBAS)
Archivo_compilar_nombre := banco_pruebas

#NOMBRE DEL ARCHIVO PDF
Nombre_Informe_PDF := TArea_8_digitalesII_B56074.pdf

#NOMBRE DEL ARCHIVO DEL MODULO CONDUCTUAL, EL QUE SE EJECUTARA CON YOSYS
Nombre_archivo_conductual := gray_counter_cond

#NOMBRE DEL ARCHIVO ESTRUCTURAL
Nombre_archivo_estructural := gray_counter_estr

#NOMBRE DEL ARCHIVO .LIB
Nombre_archivo_lib := cmos.lib

#NOMBRE DEL ARCHIVO QUE CONTIENE LAS COMPUERTAS (.v)
Nombre_archivo_lib_v := cmos.v





############################################################################################################################################
################################################## COMANDOS DE CONSOLA USUARIO  ############################################################
############################################################################################################################################
all: build run gtk clean

build:
	iverilog -o $(Archivo_compilar_nombre).o $(Archivo_compilar_nombre).v

run:
	@ echo "\n--------------------------------------------------------------------------------------------------------\n"
	@ echo "Ejecutando el programa...  \n"
	@vvp $(Archivo_compilar_nombre).o $(Archivo_compilar_nombre).vcd

gtk: 
	@gtkwave $(Archivo_compilar_nombre).vcd;

clean:
	@rm $(Archivo_compilar_nombre).vcd $(Archivo_compilar_nombre).o

prueba0: build run

pdf:
	@cd ../informe; xdg-open $(Nombre_Informe_PDF)




############################################################################################################################################
################################################## COMANDOS INTERNOS #######################################################################
############################################################################################################################################

#SE ENCARGA DE HACER AUTOINST AL BANCO DE PRUEBAS
emacs:
	@emacs --batch $(Archivo_compilar_nombre).v -f verilog-auto -f save-buffer

llenarBancoPrueba:
	@echo "\`timescale 	1ns				/ 100ps\n" > $(Archivo_compilar_nombre).v
	@echo "\`include \"$(Nombre_archivo_conductual).v\"" >> $(Archivo_compilar_nombre).v
	@echo "\`include \"$(Nombre_archivo_lib_v)\"" >> $(Archivo_compilar_nombre).v
	@echo "\`include \"$(Nombre_archivo_estructural).v\"" >> $(Archivo_compilar_nombre).v
	@echo "\`include \"probador.v\"\n" >> $(Archivo_compilar_nombre).v
	@echo "module $(Archivo_compilar_nombre); \n" >> $(Archivo_compilar_nombre).v
	@echo "/*AUTOWIRE*/\n" >> $(Archivo_compilar_nombre).v
	@echo "$(Nombre_archivo_conductual)  $(Nombre_archivo_conductual)_instance( /*AUTOINST*/ " >> $(Archivo_compilar_nombre).v
	@echo "  \t\t );\n" >> $(Archivo_compilar_nombre).v
	@echo " $(Nombre_archivo_estructural)  $(Nombre_archivo_estructural)_instance( /*AUTOINST*/ " >> $(Archivo_compilar_nombre).v
	@echo "\t\t);\n" >> $(Archivo_compilar_nombre).v
	@echo "probador  probador_inst( /*AUTOINST*/ " >> $(Archivo_compilar_nombre).v
	@echo "\t\t );\n" >> $(Archivo_compilar_nombre).v
	@echo "endmodule" >> $(Archivo_compilar_nombre).v

rename:
	@sed -i 's/salida_gray_e_e_e_e_e_e_e/salida_gray_e/g' $(Nombre_archivo_estructural).v
	@sed -i 's/contador_gray_synth/gray_counter_estr/g' $(Nombre_archivo_estructural).v

auto_llenar_Banco_Prueba_con_emacs: llenarBancoPrueba emacs


