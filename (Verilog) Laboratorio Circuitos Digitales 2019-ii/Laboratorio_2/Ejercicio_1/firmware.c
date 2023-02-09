#include <stdint.h>

static void putuint(uint32_t i) {
	*((volatile uint32_t *)0x10000000) = i;
	}

	uint32_t factorial(int n) {
		if(n == 0) {
			return 1;
		}
		if (n == 1){ 
			return 1; 
		}
		else{ 
			return n * factorial(n-1);
		}
	}

void main() {
	uint32_t fact_n = factorial(6);
	putuint(fact_n);
	while (1) {
	}

}