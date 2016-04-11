
#include <stdio.h>

#include <windows.h>

#include "vch603.h"
#include "sr620.h"

int test_vch603(int argc, char**argv)
{
	srand(time(NULL));

	HANDLE hport = vch603_open_config_port_by_name("COM1");

	const int DELAY_MS = 500;

	const int N = 5;
	for (int i = 0; i < N; ++i)
	{
		vch603_reset(hport);
		Sleep(DELAY_MS);
		vch603_set_input(hport, (i % 50) + 1);
		vch603_set_output(hport,(i % 5) + 1);
		vch603_switch(hport, 1);
		Sleep(DELAY_MS);
		vch603_switch(hport, 0);
	}

	CloseHandle(hport);
}

int test_sr620(int argc, char** argv)
{
	//srand(time(NULL));

	HANDLE hport = 
		sr620_open_config_port_by_name("COM2", 
			SR_EXT_CLK_FREQ_5MHZ);	

	if (hport == INVALID_HANDLE_VALUE) {
		int err = GetLastError();
		//return;
	}

	const int N = 5;

	for (int i = 0; i < N; ++i)
	{
		printf("%d : ", i);
		fflush(stdout);
		double rez = sr620_measure(hport);

		printf("%e\n", rez);
		fflush(stdout);
		//Sleep(rand() % 5000);
	}

	CloseHandle(hport);

	return 0;
}

int main(int argc, char **argv)
{
	test_sr620(argc, argv);
	test_vch603(argc, argv);
	return 0;
}
