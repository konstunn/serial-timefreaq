
SUBDIRS = libserialport

ACLOCAL_AMFLAGS = -I autostuff
AM_LIBTOOLFLAGS = --silent
GNUMAKEFLAGS = --no-print-directory

# Enable more compiler warnings.
AM_CFLAGS = -O0 -std=c99 -Wall -Wextra -pedantic -Wmissing-prototypes -Wshadow -I./libserialport

bin_PROGRAMS = stf

stf_SOURCES = stf.c vch.c vch.h

stf_LDFLAGS = -all-static
stf_LDADD = -L./libserialport -lserialport
