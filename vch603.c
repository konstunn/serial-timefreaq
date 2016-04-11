
#include "vch603.h"

#include <stdint.h>
#include <stdio.h>

#include "windows.h"

#ifndef STF_RETURN_ERROR(handle)
#define STF_RETURN_ERROR(handle) { \
	DWORD err = GetLastError(); \
	CloseHandle(handle); \
	SetLastError(err); \
	return INVALID_HANDLE_VALUE; }
#endif

HANDLE vch603_open_config_port_by_name(char *name)
{
	HANDLE hport = CreateFile(
			name, 
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

int vch603_set_input(HANDLE hport, uint8_t inputNum)
{
	char buf[5];
	snprintf((char*) buf, 5, "A%02d\r\0", inputNum);
	DWORD written;
	if (!WriteFile(hport, buf, strlen(buf), &written, NULL))
		return 1;
	return 0;
}

int vch603_set_output(HANDLE hport, uint8_t outputNum)
{
	char buf[5];
	snprintf((char*) buf, 5, "B%1d\r\0", outputNum);
	DWORD written;
	if (!WriteFile(hport, buf, strlen(buf), &written, NULL))
		return 1;
	return 0;
}

int vch603_switch(HANDLE hport, uint8_t onOff)
{
	char buf[5];
	snprintf((char*) buf, 5, "C%1d\r\0", onOff);
	DWORD written;
	if (!WriteFile(hport, buf, strlen(buf), &written, NULL))
		return 1;
	return 0;
}

int vch603_reset(HANDLE hport) 
{
	char buf[5];
	snprintf((char*) buf, 5, "D\r\0");
	DWORD written;
	if (!WriteFile(hport, buf, strlen(buf), &written, NULL))
		return 1;
	return 0;
}
