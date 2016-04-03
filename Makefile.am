
ACLOCAL_AMFLAGS = -I autostuff
AM_LIBTOOLFLAGS = --silent
GNUMAKEFLAGS = --no-print-directory

# Enable more compiler warnings.
AM_CFLAGS = -std=c99 -Wall -Wextra -pedantic -Wmissing-prototypes -Wshadow -I./include

bin_PROGRAMS = stf

stf_SOURCES = stf.c

stf_LDFLAGS = -all-static
stf_LDADD = -L./lib -lserialport
