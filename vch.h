
#include <libserialport.h>
#include <stdint.h>

enum sp_return vch_init_config_port(struct sp_port *);

enum sp_return vch_set_input(struct sp_port *, uint8_t);

enum sp_return vch_set_output(struct sp_port *, uint8_t);

enum sp_return vch_switch(struct sp_port *, uint8_t);

enum sp_return vch_reset(struct sp_port *);
