/* 
   Header file of module which controls SR 620 universal time interval counter 
   through comm port. 
*/

#pragma once

#if WIN32

#include <windows.h>

#else

typedef int HANDLE;

#endif

/* SR external clock frequency */
enum SR_EXT_CLK_FREQ {
	SR_EXT_CLK_FREQ_10MHZ = 0,
	SR_EXT_CLK_FREQ_5MHZ = 1
};

/*	
  	Opens comm port by name and configures it to communicate with the instrument. 
        Takes port name (e.g. "COM1" or "ttyS0") and external clock value
	(SR_EXT_CLK_FREQ_10MHZ or SR_EXT_CLK_FREQ_5MHZ), returns handle of the port 
	opened and configured. If the function fails, it returns 
	'INVALID_HANDLE_VALUE' and the error code can be retrieved by calling 
	GetLastError(). Returned handle should be closed with CloseHandle() on exit. 
*/
HANDLE sr620_open_config_port_by_name(char *name, 
		enum SR_EXT_CLK_FREQ sr_ext_clk_freq);

/*
        Opens comm port by number and configures it to communicate with the instrument.
        Takes port number (e.g. 1 for "COM1" or "ttyS0") and external clock value
        (SR_EXT_CLK_FREQ_10MHZ or SR_EXT_CLK_FREQ_5MHZ), returns handle of the port
        opened and configured. If the function fails, it returns
        'INVALID_HANDLE_VALUE' and the error code can be retrieved by calling
        GetLastError(). Returned handle should be closed with CloseHandle() on exit.
*/
HANDLE sr620_open_config_port(int number,
                enum SR_EXT_CLK_FREQ sr_ext_clk_freq);


/* 
	Start measurement and returns the result. 
	Takes port handle. The port must be opened and configured by calling 
	sr620_open_config_port_by_name(). On failure returns error	code.
*/
int sr620_measure(HANDLE hport, double &meas);

/*
	Close sr620 port.
*/
void sr620_close( HANDLE hport );
