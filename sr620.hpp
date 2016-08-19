
#ifndef SR_HPP
#define SR_HPP

#include <windows.h>

/* SR external clock frequency */
enum SR_EXT_CLK_FREQ 
{
	SR_EXT_CLK_FREQ_10MHZ = 0,
	SR_EXT_CLK_FREQ_5MHZ = 1
};

class Sr620 
{
	private:
		HANDLE hport;
	public:
		Sr620(char* name, enum SR_EXT_CLK_FREQ);
		~Sr620();
		double measure();
};

#endif
