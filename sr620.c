
#include <stdio.h>
#include "sr620.h"

HANDLE sr620_open_port_by_name(char *name)
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

	COMMTIMEOUTS CommTimeouts;
	memset(&CommTimeouts, 0, sizeof(COMMTIMEOUTS));
	CommTimeouts.ReadIntervalTimeout = 2;
	BOOL ret = SetCommTimeouts(hport, &CommTimeouts);
	if (ret == 0) { // bad case 
		// DWORD ret = GetLastError();
		int a;
		//return;  
	}

	DCB ComDCM;
	memset(&ComDCM, 0, sizeof(ComDCM));

	ComDCM.DCBlength = sizeof(DCB);

	ComDCM.BaudRate = 9600;
	ComDCM.ByteSize = 8;
	ComDCM.Parity = NOPARITY;
	ComDCM.fBinary = 1;
	ComDCM.StopBits = TWOSTOPBITS;
	ComDCM.fDtrControl = DTR_CONTROL_HANDSHAKE;

	SetCommState(hport, &ComDCM);
	if (ret == 0) {
		// DWORD ret = GetLastError();
		int a;
		//return;  // bad case
	}

	EscapeCommFunction(hport, SETDTR);

	DWORD written;
	char *sn = "\n\n\n";
	WriteFile(hport, sn, strlen(sn), &written, NULL); // purge SR buffer this way

	PurgeComm(hport, PURGE_RXABORT | PURGE_RXCLEAR | PURGE_TXABORT | PURGE_TXCLEAR);

	EscapeCommFunction(hport, CLRDTR);

	// TODO customize depending on what mode do you want (parametrize)
	const char *init_str = "MODE0;CLCK1;CLKF1;AUTM0;ARMM1;SIZE1\n";

	WriteFile(hport, init_str, strlen(init_str), &written, NULL);

	return hport;
}

double sr620_measure(HANDLE hport)
{
	// These seem to be the same
	//const char *meas_str = "STRT;*WAI;XAVG?\n";
	const char *meas_str = "MEAS? 0;*WAI\n";

	DWORD written, read;
	WriteFile(hport, meas_str, strlen(meas_str), &written, NULL);

	char buf[80];
	ReadFile(hport, buf, 80, &read, NULL);
	buf[read-2] = '\0';

	// TODO: remove this out
	printf("\'%s\' : ", buf);
	fflush(stdout);

	double rez = strtod(buf, NULL);
	return rez;
}
