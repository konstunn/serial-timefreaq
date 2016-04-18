/* 
   Header file of module which controls SR 620 universal time interval counter 
   through comm port. 
*/

#ifndef SR_H
#define SR_H

#include <windows.h>

/* SR external clock frequency */
enum SR_EXT_CLK_FREQ {
	SR_EXT_CLK_FREQ_10MHZ = 0,
	SR_EXT_CLK_FREQ_5MHZ = 1
};

/*	
  	Opens comm port by name and configures it to communicate with the instrument. 
  	Takes port name (e.g. "COM1") and external clock value 
	(SR_EXT_CLK_FREQ_10MHZ or SR_EXT_CLK_FREQ_5MHZ), returns handle of the port 
	opened and configured. If the function fails, it returns 
	'INVALID_HANDLE_VALUE' and the error code can be retrieved by calling 
	GetLastError(). Returned handle should be closed with CloseHandle() on exit. 
*/
HANDLE sr620_open_config_port_by_name(char *name, 
		enum SR_EXT_CLK_FREQ sr_ext_clk_freq);

/* 
	Start measurement and returns the result. 
	Takes port handle. The port must be opened and configured by calling 
	sr620_open_config_port_by_name() . On failure returns 0 and the error
	code can be retrieved by calling GetLastError() .
*/
double sr620_measure(HANDLE hport);

#endif
