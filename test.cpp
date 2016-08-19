
#include <stdio.h>

#include <windows.h>
#include <time.h>

#include "vch603.hpp"
#include "sr620.hpp"

int test_vch603(int argc, char**argv)
{
	Vch603 vch603("COM1");

	const int DELAY_MS = 250;

	const int N = 5;

	for (int i = 0; i < N; ++i)
	{
		vch603.reset();

		Sleep(DELAY_MS);

		vch603.setInput((i % 50) + 1);
		vch603.setOutput((i % 5) + 1);
		vch603.switch_(VCH_SWITCH_ON);

		Sleep(DELAY_MS);

		vch603.switch_(VCH_SWITCH_OFF);
	}
}

int test_sr620(int argc, char** argv)
{
	Sr620 sr620("COM2", SR_EXT_CLK_FREQ_5MHZ);

	const int N = 15;

	for (int i = 0; i < N; ++i)
	{
		printf("%d : ", i);
		fflush(stdout);
		double rez = sr620.measure();

		printf("%e\n", rez);
		fflush(stdout);
		Sleep(rand()%10000);
	}

	return 0;
}

int main(int argc, char **argv)
{
	srand(time(NULL));

	test_sr620(argc, argv);
	test_vch603(argc, argv);

	return 0;
}
