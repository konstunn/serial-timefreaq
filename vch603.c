/* 
	Source file of module which controls Vremya-Ch high-frequency signals switch 
	through comm port.
*/

#include "vch603.h"

#include <stdint.h>
#include <stdio.h>

#include <windows.h>

#ifndef STF_RETURN_ERROR
#define STF_RETURN_ERROR(handle) { \
	DWORD err = GetLastError(); \
	CloseHandle(handle); \
	SetLastError(err); \
	return INVALID_HANDLE_VALUE; }
#endif

/*	
	Opens comm port by name and configures it to communicate with the instrument. 
	Takes port name (e.g. "COM1"), returns handle of the port opened and 
	configured. If the function fails, it returns 'INVALID_HANDLE_VALUE' and 
	the error code can be retrieved by calling GetLastError(). Returned handle 
	should be closed with CloseHandle() on exit. 
*/
HANDLE vch603_open_config_port_by_name(char *port_name)
{
	HANDLE hport = CreateFile(
			port_name, 
			GENERIC_READ | GENERIC_WRITE, 
			0, 
			NULL, 
			OPEN_EXISTING, 
			FILE_ATTRIBUTE_NORMAL,
			NULL);

	if (hport == INVALID_HANDLE_VALUE)
		return hport;

	DCB ComDCM;
	memset(&ComDCM, 0, sizeof(ComDCM));

	ComDCM.DCBlength = sizeof(DCB);

	ComDCM.BaudRate = 9600;
	ComDCM.ByteSize = 8;
	ComDCM.Parity = NOPARITY;
	ComDCM.fBinary = 1;
	ComDCM.StopBits = ONESTOPBIT;

	if (!SetCommState(hport, &ComDCM))
		STF_RETURN_ERROR(hport);	

	return hport;
}

/* 
	Selects working input of the instrument. Takes port handle and the 
	input number (from 1 to 50 for VCH-603). The number is not validated. 
	The port must be opened and configured by calling 
	vch603_open_config_port_by_name(). Returns 0 on success, on failure returns 1 
	and the error code can be retrieved with GetLastError() 
*/
int vch603_set_input(HANDLE hport, uint8_t inputNum)
{
	char buf[5];
	snprintf((char*) buf, 5, "A%02d\r\0", inputNum);
	DWORD written;
	if (!WriteFile(hport, buf, strlen(buf), &written, NULL))
		return 1;
	return 0;
}

/* 
	Selects working output of the instrument. Takes port handle and the 
	output number (from 1 to 5 for VCH-603). Prerequisites, behaviour and return 
	value are the same as for vch603_set_input()
*/
int vch603_set_output(HANDLE hport, uint8_t outputNum)
{
	char buf[5];
	snprintf((char*) buf, 5, "B%1d\r\0", outputNum);
	DWORD written;
	if (!WriteFile(hport, buf, strlen(buf), &written, NULL))
		return 1;
	return 0;
}

/* 
	Switches input to ouput on or off. Takes port handle and onOff parameter. 
	Pass 1 as onOff to switch on and 0 to switch off. The port must be opened 
	and configured by calling vch603_open_config_port_by_name(). 
	Returns 0 on success, 1 - on failure. Use GetLastError() to retrieve 
	the error code.
*/
int vch603_switch(HANDLE hport, enum VCH_SWITCH_ON_OFF switchOnOff)
{
	char buf[5];
	snprintf((char*) buf, 5, "C%1d\r\0", switchOnOff);
	DWORD written;
	if (!WriteFile(hport, buf, strlen(buf), &written, NULL))
		return 1;
	return 0;
}

/* 
	Resets the instrument - switches off previously selected terminals.
	Takes port handle. The port must be opened and configured by calling 
	vch603_open_config_port_by_name() . Returns 0 on success, on failure returns
	1 and the error code can be retrieved with GetLastError() .
	This might be similar to vch603_switch(port_handle, 0) .
*/
int vch603_reset(HANDLE hport) 
{
	char buf[5];
	snprintf((char*) buf, 5, "D\r\0");
	DWORD written;
	if (!WriteFile(hport, buf, strlen(buf), &written, NULL))
		return 1;
	return 0;
}
