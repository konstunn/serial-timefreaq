
#ifndef VCH_HPP
#define VCH_HPP

#include <windows.h>

enum VCH_SWITCH_ON_OFF {
	VCH_SWITCH_OFF = 0,
	VCH_SWITCH_ON = 1,
};

class Vch603 
{
	private:
		HANDLE hport;
	public:
		Vch603(char* name);
		~Vch603();
		int setInput(int);
		int setOutput(int);
		int switch_(enum VCH_SWITCH_ON_OFF);
		int reset();
};

#endif
