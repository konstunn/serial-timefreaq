
#ifndef VCH_H

#define VCH_H

#include <stdint.h>
#include <windows.h>

void vch_init_config_port(HANDLE);

void vch_set_input(HANDLE, uint8_t);

void vch_set_output(HANDLE, uint8_t);

void vch_switch(HANDLE, uint8_t);

void vch_reset(HANDLE);

#endif
