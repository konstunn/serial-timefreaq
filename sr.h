
#ifndef SR_H

#define SR_H

#include <windows.h>

void sr_mode_init(HANDLE hport);

void sr_config_port(HANDLE hport);

double sr_measure(HANDLE hport);

#endif
