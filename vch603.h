
#ifndef VCH_H

#define VCH_H

#include <stdint.h>
#include <windows.h>

HANDLE vch603_open_port_by_name(char *);

void vch603_set_input(HANDLE, uint8_t);

void vch603_set_output(HANDLE, uint8_t);

void vch603_switch(HANDLE, uint8_t);

void vch603_reset(HANDLE);

#endif
