#include <stdint.h>

static void putuint(uint32_t i, uint32_t direccion) {
	*((volatile uint32_t *)direccion) = i;
	}


void main() {
	uint32_t direccion_1 = 0x10000000;
	uint32_t direccion_2 = 0x10000004;
	uint32_t direccion_3 = 0x10000008;
	uint32_t AUX = 0;
	uint32_t NEGRO = 0X00000000;
	uint32_t BLANCO = 0X00000FFF;
	
	while (1) { // para iterar infinitamente y evitar lecturas incorrectas en memoria
		for (int i = 0; i < 8; i++)
		{
			for (int j = 0; j < 8; j++)
			{	
				AUX = (j << 3);
				AUX += i;
				if ((i + j) % 2 == 1) //blanco
				{
					putuint(AUX,direccion_1);
					putuint(BLANCO,direccion_2);
					putuint(1,direccion_3);
					putuint(0,direccion_3);					
				}
				else 	//negro
				{
					putuint(AUX,direccion_1);
					putuint(NEGRO,direccion_2);
					putuint(1,direccion_3);
					putuint(0,direccion_3);
				}									
			}	
		}		
		//temp = *((volatile uint32_t *)direccion_3);		
	}
}
