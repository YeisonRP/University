#include <stdint.h>

static void putuint(uint32_t i, uint32_t direccion) {
	*((volatile uint32_t *)direccion) = i;
	}


void main() {
	uint32_t direccion_1 = 0x10000000;


	uint32_t puntero = 0x00004000;
	uint32_t dato = 0;
	while(puntero <= 0x00010000){
		putuint((puntero + 8),puntero); 	// Guardar direccion a sig puntero
		puntero += 4;
		putuint(dato,puntero);
		puntero += 4;
		dato += 1;
	}

	uint32_t contador = 0;
	puntero -= 4;
	while (contador < 6)
	{
		if(*((volatile uint32_t *)puntero) % 2 == 1){
			putuint(*((volatile uint32_t *)puntero),direccion_1);	// Guardando dato impar
			contador += 1;
		}
		puntero -= 8;
	}
		
	while(1);	
}
