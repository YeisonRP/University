#include <stdint.h>

static void putuint(uint32_t i, uint32_t direccion) {
	*((volatile uint32_t *)direccion) = i;
}
void main() {
	uint32_t aux = 0;
	uint32_t aux2 = 0;
	uint32_t direccion_1 = 0x0FFFFFF0;
	uint32_t direccion_2 = 0x0FFFFFF4;
	uint32_t direccion_3 = 0x0FFFFFF8;
	uint32_t direccion_4 = 0x0FFFFFFC;
	uint32_t numero_1 = 5;
	uint32_t empezar = 1;

	putuint(empezar,direccion_2);	// pone un 1 para empezar a calcular el fact	
	putuint(numero_1,direccion_1);	//Guardando los numeros en las direcciones correspondientes

	while (1) { // para iterar infinitamente y evitar lecturas incorrectas en memoria
		aux = *((volatile uint32_t *)direccion_3);
		putuint(aux,direccion_3);
		aux2 = *((volatile uint32_t *)direccion_4);
		putuint(aux2,direccion_4);
	}
}


