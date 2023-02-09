############################################################################################################################################
################################################## VARIABLES QUE DEBE MODIFICAR EL USUARIO #################################################
############################################################################################################################################

#NOMBRE DEL ARCHIVO QUE SE VA A COMPILAR (SIN .V, GENERALMENTE BANCO_PRUEBAS)
Archivo_compilar_nombre := banco_pruebas

#NOMBRE DEL ARCHIVO PDF
Nombre_Informe_PDF := TArea_7_digitalesII_B56074.pdf

#NOMBRE DEL ARCHIVO DEL MODULO CONDUCTUAL, EL QUE SE EJECUTARA CON YOSYS
Nombre_archivo_conductual := phy_tx_cond

#NOMBRE DEL ARCHIVO ESTRUCTURAL
Nombre_archivo_estructural := phy_tx_estr

#NOMBRE DEL ARCHIVO .LIB
Nombre_archivo_lib := cmos.lib

#NOMBRE DEL ARCHIVO QUE CONTIENE LAS COMPUERTAS (.v)
Nombre_archivo_lib_v := cmos.v

#Entradas y salidas del archivo conductual
Entradas = data_in valid_in
Salidas = Paral_serial_out_0 Paral_serial_out_1



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
	@echo "module $(Nombre_archivo_conductual)(\n" > $(Nombre_archivo_conductual).v
	@echo "\n);\n" >> $(Nombre_archivo_conductual).v
	@echo "\n endmodule \n" >> $(Nombre_archivo_conductual).v
	@touch probador.v
	@echo "module probador(\n" > probador.v
	@echo "\n ); \n" >> probador.v
	@echo "\n endmodule \n" >> probador.v
	@touch $(Archivo_compilar_nombre).v

#Genera el archivo que contiene los comandos de yosys, con los respectivos nombres que deberian tener
generar_archivo_yosys:
	@touch yosys_comandos.ys
	@echo "# read design" > yosys_comandos.ys
	@echo "read_verilog $(Nombre_archivo_conductual).v\n\
		   \n# elaborate design hierarchy \
		   \nhierarchy -check -top $(Nombre_archivo_conductual)\n \
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
		   \nwrite_verilog $(Nombre_archivo_estructural).v" >> yosys_comandos.ys

llenarBancoPrueba:
	@echo "\`timescale 	1ns				/ 100ps\n" > $(Archivo_compilar_nombre).v
	@echo "\`include \"$(Nombre_archivo_conductual).v\" \
		   \n\`include \"$(Nombre_archivo_estructural).v\" \
		   \n\`include \"probador.v\"\n \
		   \nmodule $(Archivo_compilar_nombre); \n \
		   \n/*AUTOWIRE*/\n \
		   \n$(Nombre_archivo_conductual)  $(Nombre_archivo_conductual)_instance( /*AUTOINST*/  \
		   \n\t\t );\n \
		   \n$(Nombre_archivo_estructural)  $(Nombre_archivo_estructural)_instance( /*AUTOINST*/  \
		   \n\t\t);\n \
		   \nprobador  probador_inst( /*AUTOINST*/  \
		   \n\t\t );\n \
		   \nendmodule" >> $(Archivo_compilar_nombre).v

#EJECUTA YOSYS Y CAMBIA EL NOMBRE DEL MODULO SINTETIZADO POR EL NOMBRE ESTRUCTURAL, PARA PODER USAR EMACS, TAMBIEN
#HACE EL INCLUDE DEL ARCHIVO .V PARA QUE LAS COMPUERTAS SEAN RECONOCIDAS.
ejecutar_yosys:
	@yosys yosys_comandos.ys
	@sed -i 's/module $(Nombre_archivo_conductual)/module $(Nombre_archivo_estructural)/g' $(Nombre_archivo_estructural).v
	@sed  -i '1i `include "$(Nombre_archivo_lib_v)"' $(Nombre_archivo_estructural).v
	@sed -i 's/Paral_serial_out_0_c/Paral_serial_out_0_e/g' $(Nombre_archivo_estructural).v 
	@sed -i 's/Paral_serial_out_1_c/Paral_serial_out_1_e/g' $(Nombre_archivo_estructural).v 
	@sed -i 's/mux/mux_estr/g' $(Nombre_archivo_estructural).v 
	@sed -i 's/Paralelo_Serie_conductual/Paralelo_Serie_estructural/g' $(Nombre_archivo_estructural).v 
	@sed -i 's/Byte_striping_cond/Byte_striping_estr/g' $(Nombre_archivo_estructural).v 


Generacion: generar_archivos generar_archivo_yosys

auto_llenar_Banco_Prueba_con_emacs: llenarBancoPrueba emacs

#prueba:
#	for word in $(Entradas); do \
		echo $$word\_c; \
	done

#prueba:
#	echo $(words $(Entradas))	// indice de la palabra
#	echo $(word 2 ,$(Entradas))	//palabra 2 imprime, comenzando en 1