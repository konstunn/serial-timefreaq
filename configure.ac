# We require at least autoconf 2.63 (AC_INIT format changed there).
#AC_PREREQ([2.63])

AC_INIT([serial-timefreaq], [0.0.1])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_MACRO_DIR([autostuff])
AC_CONFIG_AUX_DIR([autostuff])

# We require at least automake 1.11 (needed for 'silent rules').
AM_INIT_AUTOMAKE([1.11 -Wall -Werror foreign no-define check-news])
#AM_SILENT_RULES([yes])

# Checks for programs.
AC_PROG_CC
AC_PROG_INSTALL
AC_PROG_LN_S

# Initialize libtool.
LT_INIT


AC_SYS_LARGEFILE

# Define size_t if not defined as standard.
AC_TYPE_SIZE_T

#AC_CONFIG_SUBDIRS([libserialport])
AC_CONFIG_FILES([Makefile])

AC_OUTPUT
