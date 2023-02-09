############################################################################################################################################
################################################## VARIABLES QUE DEBE MODIFICAR EL USUARIO #################################################
############################################################################################################################################

#NOMBRE DEL ARCHIVO QUE SE VA A COMPILAR (SIN .V, GENERALMENTE BANCO_PRUEBAS)
Archivo_compilar_nombre := banco_pruebas

#NOMBRE DEL ARCHIVO PDF
Nombre_Informe_PDF := TArea_7_digitalesII_B56074.pdf

#NOMBRE DEL ARCHIVO DEL MODULO CONDUCTUAL, EL QUE SE EJECUTARA CON YOSYS
Nombre_archivo_conductual := Byte_un_striping_cond

#NOMBRE DEL ARCHIVO ESTRUCTURAL
Nombre_archivo_estructural := Byte_un_striping_estr

#NOMBRE DEL ARCHIVO .LIB
Nombre_archivo_lib := cmos.lib

#NOMBRE DEL ARCHIVO QUE CONTIENE LAS COMPUERTAS (.v)
Nombre_archivo_lib_v := cmos.v





############################################################################################################################################
################################################## COMANDOS DE CONSOLA USUARIO  ############################################################
############################################################################################################################################
all: generar_archivo_yosys ejecutar_yosys build run gtk clean

build:
	iverilog -o $(Archivo_compilar_nombre).o -Ttyp $(Archivo_compilar_nombre).v

run:
	@ echo "\n--------------------------------------------------------------------------------------------------------\n"
	@ echo "Ejecutando el programa...  \n"
	@vvp $(Archivo_compilar_nombre).o $(Archivo_compilar_nombre).vcd

gtk: 
	@gtkwave $(Archivo_compilar_nombre).vcd;

clean:
	@rm $(Archivo_compilar_nombre).vcd $(Archivo_compilar_nombre).o

prueba0: build run

prueba1:
	@sed -i 's/probador/probador2/g' $(Archivo_compilar_nombre).v
	@sed -i 's/parameter BUS_SIZE = 16/parameter BUS_SIZE = 20/g' $(Archivo_compilar_nombre).v
	@sed -i 's/parameter WORD_SIZE = 4/parameter WORD_SIZE = 5/g' $(Archivo_compilar_nombre).v
	make ejecutar_yosys
	make build
	@sed -i 's/parameter BUS_SIZE = 20/parameter BUS_SIZE = 16/g' $(Archivo_compilar_nombre).v
	@sed -i 's/parameter WORD_SIZE = 5/parameter WORD_SIZE = 4/g' $(Archivo_compilar_nombre).v
	
	@sed -i 's/probador2/probador/g' $(Archivo_compilar_nombre).v
	make ejecutar_yosys
	make run gtk

pdf:
	@cd ../informe; xdg-open $(Nombre_Informe_PDF)




############################################################################################################################################
################################################## COMANDOS INTERNOS #######################################################################
############################################################################################################################################

#SE ENCARGA DE HACER AUTOINST AL BANCO DE PRUEBAS
emacs:
	@emacs --batch $(Archivo_compilar_nombre).v -f verilog-auto -f save-buffer


#Genera los archivos en blanco de probador, banco conductual y el archivo conductual
generar_archivos:
	@touch $(Nombre_archivo_conductual).v
	@touch probador.v
	@touch $(Archivo_compilar_nombre).v

#Genera el archivo que contiene los comandos de yosys, con los respectivos nombres que deberian tener
generar_archivo_yosys:
	@touch yosys_comandos.ys
	@echo "# read design" > yosys_comandos.ys
	@echo "read_verilog $(Nombre_archivo_conductual).v\n" >> yosys_comandos.ys
	@echo "# elaborate design hierarchy" >> yosys_comandos.ys
	@echo "hierarchy -check -top $(Nombre_archivo_conductual)\n" >> yosys_comandos.ys
	@echo "# the high-level stuff" >> yosys_comandos.ys
	@echo "proc; opt; fsm; opt; memory; opt\n" >> yosys_comandos.ys
	@echo "# mapping to internal cell library" >> yosys_comandos.ys
	@echo "techmap; opt\n" >> yosys_comandos.ys
	@echo "# mapping flip-flops to $(Nombre_archivo_lib)" >> yosys_comandos.ys
	@echo "dfflibmap -liberty $(Nombre_archivo_lib)\n" >> yosys_comandos.ys
	@echo "# mapping logic to $(Nombre_archivo_lib)" >> yosys_comandos.ys
	@echo "abc -liberty $(Nombre_archivo_lib)\n" >> yosys_comandos.ys
	@echo "# cleanup" >> yosys_comandos.ys
	@echo "clean\n" >> yosys_comandos.ys
	@echo "# write synthesized design" >> yosys_comandos.ys
	@echo "write_verilog $(Nombre_archivo_estructural).v" >> yosys_comandos.ys

llenarBancoPrueba:
	@echo "\`timescale 	1ns				/ 100ps\n" > $(Archivo_compilar_nombre).v
	@echo "\`include \"$(Nombre_archivo_conductual).v\"" >> $(Archivo_compilar_nombre).v
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

#EJECUTA YOSYS Y CAMBIA EL NOMBRE DEL MODULO SINTETIZADO POR EL NOMBRE ESTRUCTURAL, PARA PODER USAR EMACS, TAMBIEN
#HACE EL INCLUDE DEL ARCHIVO .V PARA QUE LAS COMPUERTAS SEAN RECONOCIDAS.
ejecutar_yosys:
	@yosys yosys_comandos.ys
	@sed -i 's/module $(Nombre_archivo_conductual)/module $(Nombre_archivo_estructural)/g' $(Nombre_archivo_estructural).v
	@sed  -i '1i `include "$(Nombre_archivo_lib_v)"' $(Nombre_archivo_estructural).v
	@sed -i 's/data_out_c/data_out_e/g' $(Nombre_archivo_estructural).v
	@sed -i 's/valid_out_c/valid_out_e/g' $(Nombre_archivo_estructural).v

Generacion: generar_archivos generar_archivo_yosys

auto_llenar_Banco_Prueba_con_emacs: llenarBancoPrueba emacs


