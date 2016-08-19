
ACLOCAL_AMFLAGS = -I autostuff
AM_LIBTOOLFLAGS = --silent
GNUMAKEFLAGS = --no-print-directory

# Enable more compiler warnings.
AM_CFLAGS = -g -O0 --Wall -Wextra -pedantic -Wmissing-prototypes -Wshadow

bin_PROGRAMS = test

test_CFLAGS = -g -O0 

testdir = .
test_HEADERS = vch603.hpp sr620.hpp
test_SOURCES = test.cpp vch603.cpp sr620.cpp

#test_LDFLAGS = -all-static
