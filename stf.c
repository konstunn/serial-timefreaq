
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <errno.h>
#include <unistd.h>

#include <libserialport.h>

enum sp_return vch_config_port(struct sp_port *);

enum sp_return vch_set_input(struct sp_port *, uint8_t);

enum sp_return vch_set_output(struct sp_port *, uint8_t);

enum sp_return vch_switch(struct sp_port *, uint8_t);

enum sp_return vch_reset(struct sp_port *);

enum sp_return vch_get_state(struct sp_port *, int *in, int *out, int* state);

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

enum sp_return vch_config_port(struct sp_port *port)
{
	enum sp_return sp_ret;
	sp_ret = sp_set_baudrate(port, 9600);
	sp_ret = sp_set_parity(port, SP_PARITY_NONE);
	sp_ret = sp_set_stopbits(port, 1);
	sp_ret = sp_set_flowcontrol(port, SP_FLOWCONTROL_NONE);
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

void handle_error(int sp_ret)
{
	if (sp_ret != SP_OK) {
		char *strerr = sp_last_error_message();
		printf("error port: %s\n", strerr);
		sp_free_error_message(strerr);
		exit(EXIT_FAILURE);
	}
}

int main(int argc, char** argv)
{
	enum sp_return sp_ret; 

	struct sp_port *port;
	sp_ret = sp_get_port_by_name("COM1", &port);
	handle_error(sp_ret);	

	sp_ret = sp_open(port, SP_MODE_READ_WRITE);
	handle_error(sp_ret);

	vch_config_port(port);

	int input = atoi(argv[1]);

	int output = atoi(argv[2]);
	
	vch_switch(port, 0);
	vch_set_input(port, input);
	vch_set_output(port, output);
	vch_switch(port, 1);

	sp_close(port);

	sp_free_port(port);

	return 0;
}
