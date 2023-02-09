# Proyecto I IE523 Diseño de la capa PHY de la interfaz PCIe - Yeison Rodriguez B56074 - Pablo Vargas B57564 - Luis Soto B57082

## NOTA PARA EL PROFESOR
El módulo phy se encuentra en la carpeta Modulo_Phy, para ejecutar simplemente ejecute los siguientes comandos:
```
>> cd Modulo_Phy
>> make
```
Inmedi


## Compilación y ejecución
Para compilar y ejecutar simplemente ejecute el siguiente comando en las carpetas que contienen los Makefile
```
>> make
```
Inmediatamente se mostrará una simulación en el programa Gtkwave de las formas de onda

## Bitácora
### Avance 1: 15de mayo, 17:00
Para este avance se decidió que Luis Soto iba a trabajar más módulos ya que se ofreció porque tenía
más tiempo libre que los demás integrantes del grupo. Pero lo establecido es que en el recuento final
del proyecto todos tengamos una participación equivalente.

Las reuniones que realizamos son principalmente virtuales por medio de un grupo de whatsapp, en ellas
discutimos los módulos realizados por los compañeros para que en un futuro no existan problemas de conexión
y también se discute la sintaxis a utilizar en los módulos conductuales y estructurales con el fin de utilizar 
de manera correcta autoinst

A continuacón se pesentan las tareas que realizó cada estudiante para este avance

Luis Soto: Módulos del clk_gen, Mux, Demux y Revisión de módulos de los compañeros. 
El trabajo de este integrante fue realizado entre los días 12 y 15 del mes de Mayo

Pablo Vargas: Módulo de Paralelo a serial y revisión de módulos de los compañeros
El trabajo de este integrante fue realizado entre los días 12 y 15 del mes de Mayo

Yeison Rodríguez: Bitácora, plan de trabajo y revisión de módulos de los compañeros
El trabajo de este integrante fue realizado entre los días 12 y 15 del mes de Mayo



Los problemas que se tuvieron fueron los siguientes:
1. Problemas de discusión del diseño del generador de relojes, ya que no sabíamos si los relojes debían compartir todos un ciclo de reloj positivo al menos en algún punto.
2. Algunos bugs en el paralelo serial y mux que fueron reparados




### Avance 2: 22 de mayo, 17:00
Para este avance se siguió codificando según lo planeado en el plan de trabajo durante toda la semana. Cada vez que un integrante termina un módulo es subido a git para que los demás puedan realizar revisiones. Las reuniones siguen siendo virtuales ya que es más cómodo y no ha sido necesaria una reunión física.

A continuacón se pesentan las tareas que realizó cada estudiante para este avance

Luis Soto: Revisión de módulos de los compañeros. 
El trabajo de este integrante fue realizado entre los días 17 y 22 del mes de Mayo

Pablo Vargas: Módulo de serial a paralelo y revisión de módulos de los compañeros
El trabajo de este integrante fue realizado entre los días 17 y 22 del mes de Mayo

Yeison Rodríguez: Modulos: Byte striping, Byte un striping y phy_tx. También revisión de módulos de los compañeros
El trabajo de este integrante fue realizado entre los días 17 y 22 del mes de Mayo
 

Los problemas que se tuvieron fueron los siguientes:
1. Problemas a la hora de conectar el módulo phy_tx ya que se tuvo dificultades a la hora de sincronizar el funcionamiento de todos los elementos
2. El módulo byte_un_triping parecía funcionar de manera correcta pero al ingresar paquetes de datos que no eran múltiplos de 2 se tenían problemas, por lo que se tuvo que hacer un nuevo diseño a partir de una máquina de estados.


### Avance 3: 29 de mayo, 17:00
Para este avance se suguió nuevamente el plan de trabajo propuesto para entregas anteriores. Los módulos fueron subidos al repositorio de GIT. Las reuniones siguen siendo de manera virtual y todos los integrantes del grupo siguen trabajando de manera equitativa

A continuacón se pesentan las tareas que realizó cada estudiante para este avance

Luis Soto: Aporte en creación de módulos Phy_rx y Phy. 
El trabajo de este integrante fue realizado entre los días 23 y 29 del mes de Mayo

Pablo Vargas:  Aporte en creación de módulos Phy_rx y Phy. 
El trabajo de este integrante fue realizado entre los días 23 y 29 del mes de Mayo

Yeison Rodríguez: Aporte en creación de módulos Phy_rx y Phy. 
El trabajo de este integrante fue realizado entre los días 23 y 29 del mes de Mayo

Los problemas que se tuvieron fueron los siguientes:
1. Problemas a la hora de conectar el módulo Phy_Rx debido a sincronización de los módulos
2. Problemas a la hora de conectar el módulo Phy para realizar la sincronización entre los relojes.
### Avance 4: 1° de junio, 08:00

Para este avance simplemente se realizó el informe del proyecto entre todos los integrantes. No se presentó ningún problema


### Presentación final: 5 de junio, 17:00



## Requisitos previos

### Instalar Icarus Verilog
Herramienta que opera como un compilador de código escrito en verilog

Para instalar en Linux ejecutar:
```
>> sudo apt-get install iverilog
```

### Instalar Gtkwave
Herramienta de visualización de archivos VCD, en este caso generados por Icarus Verilog 

Para instalar en Linux ejecutar:
```
>> sudo apt-get install gtkwave
```

### Instalar yosys
Herramienta utilizada para generar una síntesis a partir de un modelo conductual

Para instalar en Linux ejecutar:
```
>> sudo apt-get install yosys
```

