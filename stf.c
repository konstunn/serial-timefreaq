
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <errno.h>
#include <unistd.h>

#include <libserialport.h>
#include "vch.h"

void print_ports_list(struct sp_port **);

void print_ports_list(struct sp_port **ports_list_ptr)
{
	printf("\nEnumerating serial ports\n\n");

	struct sp_port **ptr = ports_list_ptr;
	do 
	{
		char *port_name = sp_get_port_name(*ptr);
		char *port_description = sp_get_port_description(*ptr);

		printf("%s : %s\n", port_name, port_description);
	} 
	while (*(++ptr)); 

	printf("\nEnumerating is over.\n");
}

void handle_error(int sp_ret)
{
	if (sp_ret < 0) {
		// replace with switch
		if (sp_ret == SP_ERR_FAIL) {
			char *strerr = sp_last_error_message();
			printf("error: %s\n", strerr);
			sp_free_error_message(strerr);
		}
		if (sp_ret == SP_ERR_ARG)
			printf("error: invalid arguments were passed to function\n");
		if (sp_ret == SP_ERR_MEM)
			printf("error: a memory allocation failed while executing operation");
		if (sp_ret == SP_ERR_SUPP)
			printf("error: requested operation is not supported by this system or device");
		exit(EXIT_FAILURE);
	}
}

enum sp_return srs_init_config(struct sp_port *port);

enum sp_return srs_init_config_port(struct sp_port *port);

enum sp_return srs_init_config_port(struct sp_port *port) 
{
	enum sp_return sp_ret = sp_set_baudrate(port, 9600);
	sp_ret |= sp_set_parity(port, SP_PARITY_NONE);
	sp_ret |= sp_set_stopbits(port, 2);
	sp_ret |= sp_set_flowcontrol(port, SP_FLOWCONTROL_NONE);
	sp_ret |= sp_set_dtr(port, SP_DTR_ON);
	return sp_ret;

}

enum sp_return srs_init_config(struct sp_port *port)
{
	char *buf = "MODE0;CLCK1;CLKF0;AUTM0;ARMM1;SIZE1\r\n\0"; 
	return sp_blocking_write(port, buf, strlen(buf), 0);
}

double sr_measure(struct sp_port *port)
{
	char *buf = "MEAS? 0;*WAI\r\n\0";	
	enum sp_return sp_ret = sp_blocking_write(port, buf, strlen(buf), 0);
	//sp_ret = sp_blocking_read_next(:					
	return 0;
}

int main(int argc, char** argv)
{
	enum sp_return sp_ret; 

	struct sp_port *port;
	sp_ret = sp_get_port_by_name("COM2", &port);
	handle_error(sp_ret);	

	// open
	sp_ret = sp_open(port, SP_MODE_READ_WRITE);
	handle_error(sp_ret);

	sp_ret = srs_init_config_port(port);

	//sp_ret = vch_init_config_port(port);
	//handle_error(sp_ret);

	//int input = atoi(argv[1]);

	//int output = atoi(argv[2]);

	sp_ret = srs_init_config(port);
	handle_error(sp_ret);
	
	//sp_ret = vch_switch(port, 0);
	//handle_error(sp_ret);

	//sp_ret = vch_set_input(port, input);
	//handle_error(sp_ret);

	//sp_ret = vch_set_output(port, output);
	//handle_error(sp_ret);

	//sp_ret = vch_switch(port, 1);
	//handle_error(sp_ret);

	sp_close(port);

	sp_free_port(port);

	return 0;
}
