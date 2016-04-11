
#SUBDIRS = libserialport

ACLOCAL_AMFLAGS = -I autostuff
AM_LIBTOOLFLAGS = --silent
GNUMAKEFLAGS = --no-print-directory

# Enable more compiler warnings.
AM_CFLAGS = -g -O0 -std=c99 -Wall -Wextra -pedantic -Wmissing-prototypes -Wshadow -I./libserialport

bin_PROGRAMS = stf

stf_CFLAGS = -g -O0 -std=c99

stf_SOURCES = stf.c vch.h vch.c

stf_LDFLAGS = -all-static
#stf_LDADD = -L./libserialport -lserialport
