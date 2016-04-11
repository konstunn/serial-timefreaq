
#include <stdio.h>
#include "sr620.h"

#ifndef STF_RETURN_ERROR(handle)
#define STF_RETURN_ERROR(handle) { \
	DWORD err = GetLastError(); \
	CloseHandle(handle); \
	SetLastError(err); \
	return INVALID_HANDLE_VALUE; }
#endif

HANDLE sr620_open_config_port_by_name(char *name, enum SR_EXT_CLK_FREQ sr_ext_clk_freq)
{
	HANDLE hport = 
		CreateFile(
				name, 
				GENERIC_READ | GENERIC_WRITE, 
				0, 
				NULL, 
				OPEN_EXISTING, 
				FILE_ATTRIBUTE_NORMAL,
				NULL);

	if (hport == INVALID_HANDLE_VALUE)
		return hport;

	COMMTIMEOUTS CommTimeouts;
	memset(&CommTimeouts, 0, sizeof(COMMTIMEOUTS));
	CommTimeouts.ReadIntervalTimeout = 2;

	if (!SetCommTimeouts(hport, &CommTimeouts))
		STF_RETURN_ERROR(hport);

	DCB ComDCM;
	memset(&ComDCM, 0, sizeof(ComDCM));

	ComDCM.DCBlength = sizeof(DCB);

	ComDCM.BaudRate = 9600;
	ComDCM.ByteSize = 8;
	ComDCM.Parity = NOPARITY;
	ComDCM.fBinary = 1;
	ComDCM.StopBits = TWOSTOPBITS;
	ComDCM.fDtrControl = DTR_CONTROL_ENABLE;

	if (!SetCommState(hport, &ComDCM))
		STF_RETURN_ERROR(hport);

	BOOL ret = PurgeComm(hport, PURGE_RXABORT | PURGE_RXCLEAR | PURGE_TXABORT | PURGE_TXCLEAR);
	if (ret == 0)
		STF_RETURN_ERROR(hport);

	if (!EscapeCommFunction(hport, CLRDTR))
		STF_RETURN_ERROR(hport);

	ComDCM.fDtrControl = DTR_CONTROL_HANDSHAKE;
	if (!SetCommState(hport, &ComDCM))
		STF_RETURN_ERROR(hport);

	DWORD written;
	//char *sn = "\n\n\n";
	//if (!WriteFile(hport, sn, strlen(sn), &written, NULL)) // purge SR buffer this way
		//STF_RETURN_ERROR(hport);

	char sr_mode_str[80]; 	
	snprintf((char*) sr_mode_str, 80,
		"MODE0;CLCK1;CLKF%1d;AUTM0;ARMM1;SIZE1\n\0", 
		sr_ext_clk_freq);

	if (!WriteFile(hport, sr_mode_str, strlen(sr_mode_str), &written, NULL))
		STF_RETURN_ERROR(hport);

	return hport;
}

double sr620_measure(HANDLE hport)
{
	// These seem to be the same
	//const char *sr_meas_str = "STRT;*WAI;XAVG?\n";
	const char *sr_meas_str = "MEAS? 0;*WAI\n";

	DWORD written, read;
	if (!WriteFile(hport, sr_meas_str, strlen(sr_meas_str), &written, NULL))
		return 0;	
		
	char buf[80];
	if (!ReadFile(hport, buf, 80, &read, NULL))
		return 0;

	buf[read-2] = '\0';

	// TODO: remove this out
//#if DEBUG
	//printf("\'%s\' : ", buf);
	//fflush(stdout);
//#endif

	return strtod(buf, NULL);
}
