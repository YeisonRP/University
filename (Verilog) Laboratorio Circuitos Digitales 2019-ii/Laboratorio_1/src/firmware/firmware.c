#include <stdint.h>

static void putuint(uint32_t i) {
	*((volatile uint32_t *)0x10000000) = i;
}

void main() {
	uint32_t number_to_display = 0;
	uint32_t counter = 0;
	const uint32_t limit = 1000000*8;

	while (1) {
		counter = 0;
		putuint(number_to_display);
		number_to_display++;
		while (counter < limit) {
			counter++;
		}
	}
}


