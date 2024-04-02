#include <stdint.h>
#include "../include/utils.h"
#include "../include/uart.h"
#include "../include/xprintf.h"
#include <math.h>

int main()
{
	int i, a, b, c;
	for (i = 100; i <= 999; i++)
	{
		a = i % 10;
		b = i / 10 % 10;
		c = i / 100;
		if (pow(a, 3) + pow(b, 3) + pow(c, 3) == i)
			xprintf("%d ", i);
	}
#ifdef SIMULATION
    set_test_pass();
#else
    while (1) ;
#endif
    return 0;
}
