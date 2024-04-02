/*------------------------------------------------------------------------/
/  Universal string handler for user console interface
/-------------------------------------------------------------------------/
/
/  Copyright (C) 2011, ChaN, all right reserved.
/
/ * This software is a free software and there is NO WARRANTY.
/ * No restriction on use. You can use, modify and redistribute it for
/   personal, non-profit or commercial products UNDER YOUR RESPONSIBILITY.
/ * Redistributions of source code must retain the above copyright notice.
/
/-------------------------------------------------------------------------*/

#include "../include/xprintf.h"

#include <stdarg.h>
#include <math.h>
#include <stdint.h>
#include <string.h>

void (*xfunc_out)(unsigned char);	/* Pointer to the output stream */
static char *outptr;





/*----------------------------------------------*/
/* FLOAT EXTEND                                 */
/*----------------------------------------------*/
static void reverse(char s[], int l) {
  int i, j;
  char c;

  for (i = 0, j = l - 1; i < j; i++, j--) {
    c = s[i];
    s[i] = s[j];
    s[j] = c;
  }
}

static char *ltoa(int num, char *str, int base) {
  uint32_t i = 0;
  int isNegative = 0;

  /* Handle 0 explicitely, otherwise empty string is printed for 0 */
  if (num == 0) {
    str[i++] = '0';
    str[i] = '\0';
    return str;
  }

  // In standard itoa(), negative numbers are handled only with
  // base 10. Otherwise numbers are considered unsigned.
  if ((num) < 0 && base == 10) {
    isNegative = 1;
    num = -num;
  }

  // Process individual digits
  while (num != 0) {
    int rem = num % base;
    str[i++] = (rem > 9) ? (rem - 10) + 'a' : rem + '0';
    num = num / base;
  }

  // If number is negative, append '-'
  if (isNegative) {
    str[i++] = '-';
  }

  str[i] = '\0'; // Append string terminator

  // Reverse the string
  reverse(str, i);

  return str;
}

void floatToStr(float val, char *buffer, int prec) {
  int valInt = val * (int)pow(10, prec);
  ltoa(valInt, buffer, 10);

  int len = strlen(buffer);

  if (prec > 0) {
    for (int i = 0; i < prec; i++) {
      buffer[len - i] = buffer[len - i - 1];
    }
    buffer[len - prec] = '.';
    buffer[len + 1] = '\0';
  }
}
/*----------------------------------------------*/
/* FLOAT EXTEND                                 */
/*----------------------------------------------*/

/*----------------------------------------------*/
/* Put a character                              */
/*----------------------------------------------*/

void xputc (char c)
{
	if (_CR_CRLF && c == '\n') xputc('\r');		/* CR -> CRLF */

	if (outptr) {
		*outptr++ = (unsigned char)c;
		return;
	}

	if (xfunc_out) xfunc_out((unsigned char)c);
}


/*----------------------------------------------*/
/* Put a null-terminated string                 */
/*----------------------------------------------*/

void xputs (					/* Put a string to the default device */
	const char* str				/* Pointer to the string */
)
{
	while (*str)
		xputc(*str++);
}


/*----------------------------------------------*/
/* Formatted string output                      */
/*----------------------------------------------*/
/*  xprintf("%d", 1234);			"1234"
    xprintf("%6d,%3d%%", -200, 5);	"  -200,  5%"
    xprintf("%-6u", 100);			"100   "
    xprintf("%ld", 12345678L);		"12345678"
    xprintf("%04x", 0xA3);			"00a3"
    xprintf("%08LX", 0x123ABC);		"00123ABC"
    xprintf("%016b", 0x550F);		"0101010100001111"
    xprintf("%s", "String");		"String"
    xprintf("%-4s", "abc");			"abc "
    xprintf("%4s", "abc");			" abc"
    xprintf("%c", 'a');				"a"
    xprintf("%f", 10.0);            <support float by extend xprintf function>
*/

static
void xvprintf (
	const char*	fmt,	/* Pointer to the format string */
	va_list arp			/* Pointer to arguments */
)
{
	unsigned int r, i, j, w, f;
	unsigned long v;
	char s[16], c, d, *p;


	for (;;) {
		c = *fmt++;					/* Get a char */
		if (!c) break;				/* End of format? */
		if (c != '%') {				/* Pass through it if not a % sequense */
			xputc(c); continue;
		}
		f = 0;
		c = *fmt++;					/* Get first char of the sequense */
		if (c == '0') {				/* Flag: '0' padded */
			f = 1; c = *fmt++;
		} else {
			if (c == '-') {			/* Flag: left justified */
				f = 2; c = *fmt++;
			}
		}
		for (w = 0; c >= '0' && c <= '9'; c = *fmt++)	/* Minimum width */
			w = w * 10 + c - '0';
		if (c == 'l' || c == 'L') {	/* Prefix: Size is long int */
			f |= 4; c = *fmt++;
		}
		if (!c) break;				/* End of format? */
		d = c;
		if (d >= 'a') d -= 0x20;
		switch (d) {				/* Type is... */
		case 'S' :					/* String */
			p = va_arg(arp, char*);
			for (j = 0; p[j]; j++) ;
			while (!(f & 2) && j++ < w) xputc(' ');
			xputs(p);
			while (j++ < w) xputc(' ');
			continue;
		case 'F': { /* Float */
		  float value;
		  value = va_arg(arp, double);
		  char valueString[32];
				floatToStr(value, valueString, 3); //小数点后三位精度，总共32bit浮点数 整数部分-536,870,911~536,870,911，小数部分0~999
				xputs(valueString);
		  continue;
		}
		case 'C' :					/* Character */
			xputc((char)va_arg(arp, int)); continue;
		case 'B' :					/* Binary */
			r = 2; break;
		case 'O' :					/* Octal */
			r = 8; break;
		case 'D' :					/* Signed decimal */
		case 'U' :					/* Unsigned decimal */
			r = 10; break;
		case 'X' :					/* Hexdecimal */
			r = 16; break;
		default:					/* Unknown type (passthrough) */
			xputc(c); continue;
		}

		/* Get an argument and put it in numeral */
		v = (f & 4) ? va_arg(arp, long) : ((d == 'D') ? (long)va_arg(arp, int) : (long)va_arg(arp, unsigned int));
		if (d == 'D' && (v & 0x80000000)) {
			v = 0 - v;
			f |= 8;
		}
		i = 0;
		do {
			d = (char)(v % r); v /= r;
			if (d > 9) d += (c == 'x') ? 0x27 : 0x07;
			s[i++] = d + '0';
		} while (v && i < sizeof(s));
		if (f & 8) s[i++] = '-';
		j = i; d = (f & 1) ? '0' : ' ';
		while (!(f & 2) && j++ < w) xputc(d);
		do xputc(s[--i]); while(i);
		while (j++ < w) xputc(' ');
	}
}

void xprintf (			/* Put a formatted string to the default device */
	const char*	fmt,	/* Pointer to the format string */
	...					/* Optional arguments */
)
{
	va_list arp;


	va_start(arp, fmt);
	xvprintf(fmt, arp);
	va_end(arp);
}
