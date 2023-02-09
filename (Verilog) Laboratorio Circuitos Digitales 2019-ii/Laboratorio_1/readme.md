# IE 424

*[Trabajando con subtree en git](https://www.atlassian.com/blog/git/alternatives-to-git-submodule-git-subtree)*


## Uso

```bash
cd scripts

# crear proyecto y correr síntesis, implementación y generación del bitstream.
./create_project.sh -ic -ir

# programar dispositivo(está conectado a la computadora y encendido)
# el bitstream debe haber sido generado previamente
./create_project.sh -ip

# abrir vivado
vivado
# usar /opt/Xilinx/Vivado/2018.2/bin/vivado si vivado no está en $PATH

# alternativamente abrir el proyecto en vivado sin journal ni logs
# estando en la carpeta scripts se correría
vivado -nojournal -nolog ../vivado/picorv32.xpr

# mostrar ayuda de vivado
vivado -help
```
