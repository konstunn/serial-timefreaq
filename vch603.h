/* 
	Header file of module which controls Vremya-Ch high-frequency signals switch 
	through comm port.
*/

#ifndef VCH_H
#define VCH_H

#include <windows.h>

enum VCH_SWITCH_ON_OFF {
	VCH_SWITCH_OFF = 0,
	VCH_SWITCH_ON = 1,
};

/*	
	Opens comm port by name and configures it to communicate with the instrument. 
	Takes port name (e.g. "COM1"), returns handle of the port opened and 
	configured. If the function fails, it returns 'INVALID_HANDLE_VALUE' and 
	the error code can be retrieved by calling GetLastError(). Returned handle 
	should be closed with CloseHandle() on exit. 
*/
HANDLE vch603_open_config_port_by_name(char *);

/* 
	Selects working input of the instrument. Takes port handle and the 
	input number (from 1 to 50 for VCH-603). The number is not validated. 
	The port must be opened and configured by calling 
	vch603_open_config_port_by_name(). Returns 0 on success, on failure returns 1 
	and the error code can be retrieved with GetLastError() 
*/
int vch603_set_input(HANDLE, int);

/* 
	Selects working output of the instrument. Takes port handle and the 
	output number (from 1 to 5 for VCH-603). Prerequisites, behaviour and return 
	value are the same as for vch603_set_input()
*/
int vch603_set_output(HANDLE, int);

/* 
	Switches input to ouput on or off. Takes port handle and onOff parameter. 
	Pass 1 as onOff to switch on and 0 to switch off. The port must be opened 
	and configured by calling vch603_open_config_port_by_name(). 
	Returns 0 on success, 1 - on failure. Use GetLastError() to retrieve 
	the error code.
*/
int vch603_switch(HANDLE, enum VCH_SWITCH_ON_OFF);

/* 
	Resets the instrument - switches off previously selected terminals.
	Takes port handle. The port must be opened and configured by calling 
	vch603_open_config_port_by_name() . Returns 0 on success, on failure returns
	1 and the error code can be retrieved with GetLastError() .
	This might be similar to vch603_switch(port_handle, 0) .
*/
int vch603_reset(HANDLE);

#endif
