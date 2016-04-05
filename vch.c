
#include "vch.h"

#include <stdint.h>
#include <stdio.h>

#include <libserialport.h>

enum sp_return vch_init_config_port(struct sp_port *port)
{
	enum sp_return sp_ret = sp_set_baudrate(port, 9600);
	sp_ret |= sp_set_parity(port, SP_PARITY_NONE);
	sp_ret |= sp_set_stopbits(port, 1);
	sp_ret |= sp_set_flowcontrol(port, SP_FLOWCONTROL_NONE);
	return sp_ret;
}

enum sp_return vch_set_input(struct sp_port *port, uint8_t input)
{
	char *buf[5];
	snprintf((char*) buf, 5, "A%02d\r", input); 
	return sp_blocking_write(port, buf, 4, 0);
}

enum sp_return vch_set_output(struct sp_port *port, uint8_t output)
{
	char *buf[5];
	snprintf((char*) buf, 5, "B%1d\r", output);
	return sp_blocking_write(port, buf, 3, 0);
}

enum sp_return vch_switch(struct sp_port *port, uint8_t on)
{
	char *buf[5];
	snprintf((char*) buf, 5, "C%1d\r", on);
	return sp_blocking_write(port, buf, 3, 0);
}

enum sp_return vch_reset(struct sp_port *port) 
{
	char *buf[5];
	snprintf((char*) buf, 5, "D\r");
	return sp_blocking_write(port, buf, 2, 0);
}
