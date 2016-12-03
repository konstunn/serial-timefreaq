/*
	Source file of module which controls SR620 universal time interval counter
	through comm port.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sr620.h"

#if WIN32

#ifndef STF_RETURN_ERROR
#define STF_RETURN_ERROR(handle) { \
	DWORD err = GetLastError(); \
	CloseHandle(handle); \
	SetLastError(err); \
	return INVALID_HANDLE_VALUE; }
#endif

#ifndef snprintf

const auto& snprintf = _snprintf;

#endif

#else

#include <termios.h>
#include <sys/file.h>
#include <unistd.h>
#include <errno.h>

#ifndef STF_RETURN_ERROR
#define STF_RETURN_ERROR(fd) { \
        int err = errno; \
        close(fd); \
        errno = err; \
        return -1; }
#endif

#endif

HANDLE sr620_open_config_helper(
        char *name, enum SR_EXT_CLK_FREQ sr_ext_clk_freq )
{

#if WIN32

    HANDLE hport =
            CreateFileA(
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
    CommTimeouts.ReadTotalTimeoutConstant = 10000;
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

    BOOL ret = PurgeComm(hport,
                    PURGE_RXABORT | PURGE_RXCLEAR | PURGE_TXABORT | PURGE_TXCLEAR);
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

    char sr_mode_str[255];
    snprintf((char*) sr_mode_str, 255,
            "MODE0;CLCK1;CLKF%1d;LOCL1;TCPL0;SRCE0;AUTM0;ARMM1;SIZE1"
            "LEVL2,1;LEVL3,1;TSLP2,0;TSLP3,0\n",
            sr_ext_clk_freq);

    if (!WriteFile(hport, sr_mode_str, strlen(sr_mode_str), &written, NULL))
            STF_RETURN_ERROR(hport);

    return hport;

#else

    int fd = open( name, O_RDWR | O_NOCTTY );
    if (fd == -1)
        return fd;

    struct termios config;

    if ( tcgetattr( fd, &config ) < 0 )
        STF_RETURN_ERROR(fd);

    //
    // Input flags - Turn off input processing
    //
    // convert break to null byte, no CR to NL translation,
    // no NL to CR translation, don't mark parity errors or breaks
    // no input parity check, don't strip high bit off,
    // no XON/XOFF software flow control
    //
    config.c_iflag &= ~(IGNBRK | BRKINT | ICRNL |
                        INLCR | PARMRK | INPCK | ISTRIP | IXON);

    //
    // Output flags - Turn off output processing
    //
    // no CR to NL translation, no NL to CR-NL translation,
    // no NL to CR translation, no column 0 CR suppression,
    // no Ctrl-D suppression, no fill characters, no case mapping,
    // no local output processing
    //
    // config.c_oflag &= ~(OCRNL | ONLCR | ONLRET |
    //                     ONOCR | ONOEOT| OFILL | OLCUC | OPOST);
    config.c_oflag = 0;

    //
    // No line processing
    //
    // echo off, echo newline off, canonical mode off,
    // extended input processing off, signal chars off
    //
    config.c_lflag &= ~(ECHO | ECHONL | ICANON | IEXTEN | ISIG);

    //
    // Turn off character processing
    //
    // clear current char size mask, no parity checking,
    // no output processing, force 8 bit input
    //
    config.c_cflag &= ~(CSIZE | PARENB);
    config.c_cflag |= CS8 | CSTOPB;

    //
    // One input byte is enough to return from read()
    // Inter-character timer off
    //
    config.c_cc[VMIN]  = 1;
    config.c_cc[VTIME] = 0;

    //
    // Communication speed (simple version, using the predefined
    // constants)
    //
    config.c_ospeed = B9600;
    config.c_ispeed = B9600;

    //
    // Finally, apply the configuration
    //
    if ( tcsetattr(fd, TCSAFLUSH, &config) < 0 )
        STF_RETURN_ERROR(fd);

    char sr_mode_str[255];
    snprintf((char*) sr_mode_str, 255,
            "MODE0;CLCK1;CLKF%1d;LOCL1;TCPL0;SRCE0;AUTM0;ARMM1;SIZE1"
            "LEVL2,1;LEVL3,1;TSLP2,0;TSLP3,0\n",
            sr_ext_clk_freq);

    if ( write(fd, (const void *) sr_mode_str, strlen(sr_mode_str)) < 0 )
        STF_RETURN_ERROR(fd);

    return fd;

#endif
}

/*	
	Opens comm port by name and configures it to communicate with the
	instrument. Takes port name (e.g. "COM1") and external clock value
	(SR_EXT_CLK_FREQ_10MHZ or SR_EXT_CLK_FREQ_5MHZ), returns handle of the
	port opened and configured. If the function fails, it returns
	'INVALID_HANDLE_VALUE' and the error code can be retrieved by calling
	GetLastError(). Returned handle should be closed with CloseHandle() on
	exit.
*/
HANDLE sr620_open_config_port_by_name(
		char *name, enum SR_EXT_CLK_FREQ sr_ext_clk_freq)
{

    char pname[80];

#if WIN32
    strcpy(pname, "\\\\.\\");
    strcat(pname, name);
#else
    strcpy(pname, "/dev/");
    strcat(pname, name);
#endif

    return sr620_open_config_helper( pname, sr_ext_clk_freq );

}

/*
        Opens comm port by number and configures it to communicate with the instrument.
        Takes port number (e.g. 1 for "COM1" or "ttyS0") and external clock value
        (SR_EXT_CLK_FREQ_10MHZ or SR_EXT_CLK_FREQ_5MHZ), returns handle of the port
        opened and configured. If the function fails, it returns
        'INVALID_HANDLE_VALUE' and the error code can be retrieved by calling
        GetLastError(). Returned handle should be closed with CloseHandle() on exit.
*/
HANDLE sr620_open_config_port(
        int number,
        enum SR_EXT_CLK_FREQ sr_ext_clk_freq )
{
    char pname[80], numbuf[20];

#if WIN32
    strcpy(pname, "\\\\.\\COM");
    sprintf(numbuf, "%d", number);
    strcat(pname, numbuf);
#else
    strcpy(pname, "/dev/ttyS");
    sprintf(numbuf, "%d", number-1);
    strcat(pname, numbuf);
#endif

    return sr620_open_config_helper( pname, sr_ext_clk_freq );
}


/* 
	Start measurement and returns the result. 
	Takes port handle. The port must be opened and configured by calling 
	sr620_open_config_port_by_name() . On failure returns 0 and the error
	code can be retrieved by calling GetLastError() .
*/
double sr620_measure(HANDLE hport)
{
    // These are seem to be the same
    //const char *sr_meas_str = "STRT;*WAI;XAVG?\n";
    const char *sr_meas_str = "MEAS? 0;*WAI\n";

    char buf[80];

#if WIN32

    DWORD written, rd;
    if (!WriteFile(hport, sr_meas_str, strlen(sr_meas_str), &written, NULL))
        return 0.0;

    if (!ReadFile(hport, buf, 80, &rd, NULL))
        return 0.0;

#else

    ssize_t rd;

    if ( write(hport, sr_meas_str, strlen(sr_meas_str)) < 0 )
        return 0.0;

    rd = read(hport, buf, 80);

#endif

    if ( rd < 2 )
        return 0;

    buf[rd-2] = '\0';

    //#if DEBUG
    //printf("\'%s\' : ", buf);
    //fflush(stdout);
    //#endif

    return strtod(buf, NULL);
}
