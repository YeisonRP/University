#include <stdint.h>

static void putuint(uint32_t i, uint32_t direccion) {
	*((volatile uint32_t *)direccion) = i;
	}


void main() {
	uint32_t direccion_1 = 0x10000000;
	uint32_t direccion_2 = 0x10000004;
	uint32_t direccion_3 = 0x10000008;
	uint32_t AUX = 0;
	uint32_t VERDE = 0X00000030;
	uint32_t ROJO = 0X00000F00;
	uint32_t AMARILLO = 0X00000022;
	uint32_t AZUL = 0X0000000F;
	
	while (1) { // para iterar infinitamente y evitar lecturas incorrectas en memoria
		for (int i = 0; i < 8; i++)
		{
			for (int j = 0; j < 8; j++)
			{	
				AUX = (j << 3);
				AUX += i;
				if (i < 2){
					putuint(AUX,direccion_1);
					putuint(VERDE,direccion_2);
					putuint(1,direccion_3);
					putuint(0,direccion_3);
				}
				if(i < 4 & i >= 2){
					putuint(AUX,direccion_1);
					putuint(ROJO,direccion_2);
					putuint(1,direccion_3);
					putuint(0,direccion_3);
				}
				if(i < 6 & i >= 4){
					putuint(AUX,direccion_1);
					putuint(AMARILLO,direccion_2);
					putuint(1,direccion_3);
					putuint(0,direccion_3);
				}	
				if(i < 8 & i >= 6){
					putuint(AUX,direccion_1);
					putuint(AZUL,direccion_2);
					putuint(1,direccion_3);
					putuint(0,direccion_3);
				}									
			}	
		}		
		//temp = *((volatile uint32_t *)direccion_3);		
	}
}
