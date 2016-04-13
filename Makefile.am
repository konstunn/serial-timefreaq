
ACLOCAL_AMFLAGS = -I autostuff
AM_LIBTOOLFLAGS = --silent
GNUMAKEFLAGS = --no-print-directory

# Enable more compiler warnings.
AM_CFLAGS = -g -O0 -std=c99 -Wall -Wextra -pedantic -Wmissing-prototypes -Wshadow -I./libserialport

bin_PROGRAMS = test

test_CFLAGS = -g -O0 -std=c99

testdir = .
test_HEADERS = vch603.h sr620.h
test_SOURCES = test.c vch603.c sr620.c

test_LDFLAGS = -all-static
