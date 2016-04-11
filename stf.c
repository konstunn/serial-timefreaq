
#include <stdio.h>

#include <windows.h>

/*void handle_error(int sp_ret);
void handle_error(int sp_ret)
{
	if (sp_ret < 0) {
		// replace with switch()
		if (sp_ret == SP_ERR_FAIL) {
			char *strerr = sp_last_error_message();
			printf("error: %s\n", strerr);
			sp_free_error_message(strerr);
		}
		if (sp_ret == SP_ERR_ARG)
			printf("error: invalid arguments were passed to function\n");
		if (sp_ret == SP_ERR_MEM)
			printf("error: a memory allocation failed while executing operation");
		if (sp_ret == SP_ERR_SUPP)
			printf("error: requested operation is not supported by this system or device");
		exit(EXIT_FAILURE);
	}
}*/

void sr_mode_init(HANDLE hport);
void sr_mode_init(HANDLE hport)
{
	// TODO customize depending on what mode do you want (parametrize)
	const char *init_str = "MODE0;CLCK1;CLKF1;AUTM0;ARMM1;SIZE1\n";

	DWORD written;
	WriteFile(hport, init_str, strlen(init_str), &written, NULL);
}

void sr_config_port(HANDLE hport);
void sr_config_port(HANDLE hport) 
{
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
}

double sr_measure(HANDLE hport);
double sr_measure(HANDLE hport)
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

HANDLE stf_open_port_by_name(char *name);
HANDLE stf_open_port_by_name(char *name)
{
	return 
		CreateFile(
				name, 
				GENERIC_READ | GENERIC_WRITE, 
				0, 
				NULL, 
				OPEN_EXISTING, 
				FILE_ATTRIBUTE_NORMAL,
				NULL);
}

int test_vch(int argc, char**argv)
{
	srand(time(NULL));

	HANDLE hport = stf_open_port_by_name("COM1");

	vch_init_config_port(hport);

	const int DELAY_MS = 500;

	for (int i = 0; i < 10; ++i)
	{
		vch_reset(hport);
		Sleep(DELAY_MS);
		vch_set_input(hport, (i % 50) + 1);
		vch_set_output(hport,(i % 5) + 1);
		vch_switch(hport, 1);
		Sleep(DELAY_MS);
		vch_switch(hport, 0);
	}

	CloseHandle(hport);
}

int test_sr(int argc, char** argv)
{
	srand(time(NULL));

	HANDLE hport = stf_open_port_by_name("COM2");	

	sr_config_port(hport);

	sr_mode_init(hport);

	const int N = 10;

	for (int i = 0; i < N; ++i)
	{
		printf("%d : ", i);
		fflush(stdout);
		double rez = sr_measure(hport);

		printf("%e\n", rez);
		fflush(stdout);
		//Sleep(rand() % 5000);
	}

	CloseHandle(hport);

	return 0;
}

int main(int argc, char **argv)
{
	test_sr(argc, argv);
	test_vch(argc, argv);
	return 0;
}
