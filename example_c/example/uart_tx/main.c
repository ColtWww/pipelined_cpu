#include <stdint.h>

#include "../include/uart.h"
#include "../include/xprintf.h"
#include "../include/utils.h"


int main()
{
    uart_init();

    xprintf("hello world\n");
    xprintf("%d\n", 1234);
    xprintf("%6d,%3d%%\n", -200, 5);
    xprintf("%-6u\n", 100);
    xprintf("%ld\n", 12345678L);
    xprintf("%04x\n", 0xA3);
    xprintf("%08LX\n", 0x123ABC);
    xprintf("%016b\n", 0x550F);
    xprintf("%s\n", "String");
    xprintf("%-4s\n", "abc");
    xprintf("%4s\n", "abc");
    xprintf("%c\n", 'a');
	xprintf("%f\n", 123456789.1415926);
#ifdef SIMULATION
    set_test_pass();
#else
    while (1) ;
#endif
}
