
#ifndef SR_H

#define SR_H

#include <windows.h>

HANDLE sr620_open_port_by_name(char *);

void sr620_mode_init(HANDLE hport);

void sr620_config_port(HANDLE hport);

double sr620_measure(HANDLE hport);

#endif
