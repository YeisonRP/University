#include <stdint.h>

static void putuint(uint32_t i, uint32_t direccion) {
	*((volatile uint32_t *)direccion) = i;
}
void main() {
	uint32_t aux = 0;
	uint32_t direccion_1 = 0x0FFFFFF0;
	uint32_t direccion_2 = 0x0FFFFFF4;
	uint32_t direccion_3 = 0x0FFFFFF8;
	uint32_t numero_1 = 100;
	uint32_t numero_2 = 90;
	putuint(numero_1,direccion_1);	//Guardando los numeros en las direcciones correspondientes
	putuint(numero_2,direccion_2); 	//Guardando los numeros en las direcciones correspondientes
	while (1) { // para iterar infinitamente y evitar lecturas incorrectas en memoria
		aux = *((volatile uint32_t *)direccion_3);
		putuint(aux,direccion_3);
	}
}


