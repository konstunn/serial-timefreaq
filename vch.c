
#include "vch.h"

#include <stdint.h>
#include <stdio.h>

#include "windows.h"

void vch_init_config_port(HANDLE hport) 
{
	DCB ComDCM;
	memset(&ComDCM, 0, sizeof(ComDCM));

	ComDCM.DCBlength = sizeof(DCB);

	ComDCM.BaudRate = 9600;
	ComDCM.ByteSize = 8;
	ComDCM.Parity = NOPARITY;
	ComDCM.fBinary = 1;
	ComDCM.StopBits = ONESTOPBIT;

	BOOL ret = SetCommState(hport, &ComDCM);
	if (ret == 0) { // bad case
		// DWORD ret = GetLastError();
		int a;
		//return;
	}
}

void vch_set_input(HANDLE hport, uint8_t inputNum)
{
	char buf[5];
	snprintf((char*) buf, 5, "A%02d\r\0", inputNum);
	DWORD written;
	WriteFile(hport, buf, strlen(buf), &written, NULL);
}

void vch_set_output(HANDLE hport, uint8_t outputNum)
{
	char buf[5];
	snprintf((char*) buf, 5, "B%1d\r\0", outputNum);
	DWORD written;
	WriteFile(hport, buf, strlen(buf), &written, NULL);
}

void vch_switch(HANDLE hport, uint8_t onOff)
{
	char buf[5];
	snprintf((char*) buf, 5, "C%1d\r\0", onOff);
	DWORD written;
	WriteFile(hport, buf, strlen(buf), &written, NULL);
}

void vch_reset(HANDLE hport) 
{
	char buf[5];
	snprintf((char*) buf, 5, "D\r\0");
	DWORD written;
	WriteFile(hport, buf, strlen(buf), &written, NULL);
}
