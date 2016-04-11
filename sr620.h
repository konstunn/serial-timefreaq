
#ifndef SR_H

#define SR_H

#include <windows.h>

enum SR_EXT_CLK_FREQ {
	SR_EXT_CLK_FREQ_10MHZ = 0,
	SR_EXT_CLK_FREQ_5MHZ = 1
};

HANDLE sr620_open_config_port_by_name(char *name, 
		enum SR_EXT_CLK_FREQ sr_ext_clk_freq);

void sr620_mode_init(HANDLE hport);

void sr620_config_port(HANDLE hport);

double sr620_measure(HANDLE hport);

#endif
