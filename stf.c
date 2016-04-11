
#include <stdio.h>

#include <windows.h>

#include "vch.h"
#include "sr.h"


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
