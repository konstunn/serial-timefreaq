
ACLOCAL_AMFLAGS = -I autostuff
AM_LIBTOOLFLAGS = --silent
GNUMAKEFLAGS = --no-print-directory

# Enable more compiler warnings.
AM_CFLAGS = -g -O0 -std=c99 -Wall -Wextra -pedantic -Wmissing-prototypes -Wshadow -I./libserialport

bin_PROGRAMS = stf

stf_CFLAGS = -g -O0 -std=c99

stfdir = .
stf_HEADERS = vch603.h sr620.h
stf_SOURCES = stf.c vch603.c sr620.c

stf_LDFLAGS = -all-static
