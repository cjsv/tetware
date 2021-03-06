#
#      SCCS:  @(#)qnx4.mk	1.1 (98/09/07) 
#
#
# ************************************************************************
#
# SCCS:   	@(#)qnx4.mk	1.1 98/09/07 TETware release 3.2
# NAME:		qnx4.mk
# PRODUCT:	TETware
# AUTHOR:	Kirk Russell
# DATE CREATED:	September 1998
#
# DESCRIPTION:
#	template for the defines.mk file that contains common
#	machine-dependent definitions used in makefiles
#	the defines.mk file is included in lower level makefiles
#
#	use this file to build your own defines.mk, which should be
#	installed in TET_ROOT/src
#
#	please refer to the section entitled "Preparing to build TETware"
#	in the TETware Installation Guide for instructions on how to use
#	this file
#
# MODIFICATIONS:
# 
# ************************************************************************

# tccd can be started:
#	from /etc/inittab (SYSV systems)
#	from /etc/inetd (BSD4.3 style)
#	from /etc/rc (BSD4.2 style)
#	interactively by a user
#
# inittab systems should include -DINITTAB in DTET_CDEFS below
# inetd systems should include -DINETD in DTET_CDEFS below
# [ Not relevant for TETware-Lite ]

# TCCD specifies the name by which tccd is to be known; this should be in.tccd
# if you define INETD, otherwise it should be tccd
# [ Not used when building TETware-Lite ]
TCCD = in.tccd

# parallel build indicator (mainly for DYNIX)
# leave this blank for most systems
P =

# make utilities - these don't usually change
MAKE = make
SHELL = /bin/ksh

# TET and DTET defines; one of these is added to CDEFS in each compilation
#	TET_CDEFS are used to compile most source files
#	    these should include -D_POSIX_SOURCE 
#	    you may want to define TET_SIG_IGNORE and TET_SIG_LEAVE here
#
#	DTET_CDEFS are used to compile source files which use non-POSIX
#	features, such as networking and threads
#	    for example:
#	    inet:  DTET_CDEFS = -D_ALL_SOURCE -DINETD
#	    xti:   DTET_CDEFS = -D_ALL_SOURCE -DTCPTPI
#
TET_CDEFS =
#DTET_CDEFS = -DINETD

# sgs component definitions and flags
# CC - the name of the C compiler
CC = cc
# CDEFS may be passed to lint and cc, COPTS to cc only
# CDEFS usually defines NSIG (the highest signal number plus one)
CDEFS = -I$(INC) -I$(DINC) -DNSIG=_SIGMAX -DO_NDELAY=O_NONBLOCK
COPTS = -O
# THR_COPTS is used instead of COPTS when compiling the thread API library.
# To disable thread support, set THR_COPTS = THREADS_NOT_SUPPORTED.
# For POSIX threads, include -DTET_POSIX_THREADS (default is UI threads).
THR_COPTS = THREADS_NOT_SUPPORTED
# LDFLAGS - loader flags used by make's built-in rules
LDFLAGS = -M
# C_PLUS - the name of the C++ compiler
# To disable C++ support, set C_PLUS = CPLUSPLUS_NOT_SUPPORTED.
C_PLUS = CPLUSPLUS_NOT_SUPPORTED
# C_SUFFIX - suffix for C++ source files
C_SUFFIX = C
# if your system's a.out format includes a .comment section that can be
# compressed by using mcs -c, set MCS to mcs; otherwise set MCS to @:
MCS = @:
# AR is the name of the archive library maintainer
AR = ar
# LORDER and TSORT are the names for lorder and tsort, used to order an archive
# library; if they don't exist on your system or don't work, set LORDER to echo
# and TSORT to cat
LORDER = echo
TSORT = cat
# if your system needs ranlib run after an archive library is updated,
# set RANLIB to ranlib; otherwise set RANLIB to @:
RANLIB = @:

# Source and object file suffixes that are understood by the sgs
# on this platform.
# Note that all these suffixes may include an initial dot - this convention
# permits an empty suffix to be specified.
# O - suffix that denotes an object file (e.g.: .obj or .o)
O = .o
# A - suffix that denotes an archive library (e.g.: .lib or .a)
A = .lib
# E - suffix that denotes an executable file (e.g.: .exe or nothing)
E =

# system libraries for inclusion at the end of cc command line
SYSLIBS = -lunix -lsocket

# lint libraries for inclusion at the end of lint command line
LINTLIBS =

# Definitions for xpg3sh API and TCM
#
# standard signal numbers - change to correct numbers for your system
# SIGHUP, SIGINT, SIGQUIT, SIGILL, SIGABRT, SIGFPE, SIGPIPE, SIGALRM,
# SIGTERM, SIGUSR1, SIGUSR2, SIGTSTP, SIGCONT, SIGTTIN, SIGTTOU
# 
# Example: SH_STD_SIGNALS = 1 2 3 4 6 8 13 14 15 16 17 25 26 27 28
SH_STD_SIGNALS = 1 2 3 4 6 8 13 14 15 16 17 24 25 26 27

# signals that are always unhandled - change for your system
# May need to include SIGSEGV and others if the shell can't trap them
# SIGKILL, SIGCHLD, SIGSTOP, (SIGSEGV, ...)
#
# Example: SH_SPEC_SIGNALS = 9 18 24 11
SH_SPEC_SIGNALS = 9 18 23 11

# highest shell signal number plus one
# May need to be less than the value specified with -DNSIG in CDEFS
# if the shell can't trap higher signal numbers
SH_NSIG = 32

# Definitions for ksh API and TCM
KSH_STD_SIGNALS = $(SH_STD_SIGNALS)
KSH_SPEC_SIGNALS = $(SH_SPEC_SIGNALS)
KSH_NSIG = $(SH_NSIG)

# rules to make the lint libraries
# To include threads functions in the lint libraries, add -DTET_THREADS
# or -DTET_POSIX_THREADS to the lint command
#.SUFFIXES: .ln

# the following should work for more recent SYSV-derived lints
# .c.ln:
#	lint $(CDEFS) -c $<
#
# if you have a BSD-style lint and you want lint libraries, you will probably
# have to make them by hand



