#include <stdint.h>
#include "../include/utils.h"
#include "../include/uart.h"
#include "../include/xprintf.h"
#include <math.h>

int main()
{
	uart_init();
	int i, a, b, c;
	float sum = 0.0;
	for (i = 100; i <= 200; i++)
	{
		a = i % 10;
		b = i / 10 % 10;
		c = i / 100;
		if ((pow(a, 3) + pow(b, 3) + pow(c, 3)) == i) {
			xprintf("%d\n", i);              
		}
			
	}


	set_test_pass();

    return 0;
}
