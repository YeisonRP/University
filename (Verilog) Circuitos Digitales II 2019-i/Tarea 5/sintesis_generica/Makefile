#VARIABLES QUE DEBE MODIFICAR EL USUARIO
#NOMBRE DEL ARCHIVO QUE SE VA A COMPILAR (SIN .V, GENERALMENTE BANCO_PRUEBAS)
Archivo_compilar_nombre := banco_pruebas
#NOMBRE DEL ARCHIVO PDF
Nombre_Informe_PDF := TArea_5_digitalesII_B56074.pdf
#NOMBRE DEL ARCHIVO DEL MODULO CONDUCTUAL, EL QUE SE EJECUTARA CON YOSYS
Nombre_archivo_conductual := demux_conductual
#NOMBRE DEL ARCHIVO ESTRUCTURAL
Nombre_archivo_estructural := demux_estructural_sintetizado
#NOMBRE DEL ARCHIVO .LIB
Nombre_archivo_lib := cmos.lib
#NOMBRE DEL ARCHIVO QUE CONTIENE LAS COMPUERTAS (.v)
Nombre_archivo_lib_v := cmos.v

###############COMANDOS DE CONSOLA DEL USUARIO####################3
all: build run gtk

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
	@sed -i 's/probador/probador1/g' $(Archivo_compilar_nombre).v;make; sed -i 's/probador1/probador/g' $(Archivo_compilar_nombre).v

prueba2:
	@sed -i 's/probador/probador2/g' $(Archivo_compilar_nombre).v;make; sed -i 's/probador2/probador/g' $(Archivo_compilar_nombre).v

pdf:
	@cd ../informe; xdg-open $(Nombre_Informe_PDF)






#######################3#COMANDOS INTERNOS (NO DEL USUARIO)########################
################################################# COMANDOS INTERNOS #########################################3

#SE ENCARGA DE HACER AUTOINST AL BANCO DE PRUEBAS
emacs:
	@emacs --batch $(Archivo_compilar_nombre).v -f verilog-auto -f save-buffer


#Genera los archivos en blanco de probador, banco conductual y el archivo conductual
generar_archivos:
	@touch $(Nombre_archivo_conductual).v touch probador.v; touch $(Archivo_compilar_nombre).v

#Genera el archivo que contiene los comandos de yosys, con los respectivos nombres que deberian tener
generar_archivo_yosys:
	@touch yosys_comandos.ys; echo "# read design\nread_verilog $(Nombre_archivo_conductual).v\n\n# elaborate design hierarchy\nhierarchy -check -top $(Nombre_archivo_conductual)\n\n# the high-level stuff\nproc; opt; fsm; opt; memory; opt\n\n# mapping to internal cell library\ntechmap; opt\n\n# mapping flip-flops to $(Nombre_archivo_lib)\ndfflibmap -liberty $(Nombre_archivo_lib)\n\n# mapping logic to $(Nombre_archivo_lib)\nabc -liberty $(Nombre_archivo_lib)\n\n# cleanup\nclean\n\n# write synthesized design\nwrite_verilog $(Nombre_archivo_estructural).v"  > yosys_comandos.ys;

llenarBancoPrueba:
	@echo "\`timescale 	1ns				/ 100ps\n\n\`include \"$(Nombre_archivo_conductual).v\"\n\`include \"$(Nombre_archivo_estructural).v\"\n\`include \"probador.v\"\n\nmodule $(Archivo_compilar_nombre); \n\n /*AUTOWIRE*/\n\n$(Nombre_archivo_conductual)  $(Nombre_archivo_conductual)_instance( /*AUTOINST*/ \n \t\t );\n\n $(Nombre_archivo_estructural)  $(Nombre_archivo_estructural)_instance( /*AUTOINST*/ \n\t\t);\n\nprobador  probador_inst( /*AUTOINST*/ \n\t\t );\n\n endmodule"	> $(Archivo_compilar_nombre).v

#EJECUTA YOSYS Y CAMBIA EL NOMBRE DEL MODULO SINTETIZADO POR EL NOMBRE ESTRUCTURAL, PARA PODER USAR EMACS, TAMBIEN
#HACE EL INCLUDE DEL ARCHIVO .V PARA QUE LAS COMPUERTAS SEAN RECONOCIDAS.
ejecutar_yosys:
	@yosys yosys_comandos.ys; sed -i 's/module $(Nombre_archivo_conductual)/module $(Nombre_archivo_estructural)/g' $(Nombre_archivo_estructural).v


Generacion: generar_archivos generar_archivo_yosys

auto_llenar_Banco_Prueba_con_emacs: llenarBancoPrueba emacs









#Archivo_compilar_nombre_o := $(Archivo_compilar_nombre_v:.v=.o)
#Archivo_compilar_nombre_vcd := $(Archivo_compilar_nombre_v:.v=.vcd)
#Nombre_archivo_conductual := $(Nombre_archivo_conductual_v:.v=)










