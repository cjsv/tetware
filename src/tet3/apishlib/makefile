#
#	SCCS: @(#)makefile	1.4 (03/03/31)
#
#	UniSoft Ltd., London, England
#
# Copyright (c) 1998 The Open Group
# All rights reserved.
#
# No part of this source code may be reproduced, stored in a retrieval
# system, or transmitted, in any form or by any means, electronic,
# mechanical, photocopying, recording or otherwise, except as stated in
# the end-user licence agreement, without the prior permission of the
# copyright owners.
# A copy of the end-user licence agreement is contained in the file
# Licence which accompanies this distribution.
# 
# Motif, OSF/1, UNIX and the "X" device are registered trademarks and
# IT DialTone and The Open Group are trademarks of The Open Group in
# the US and other countries.
#
# X/Open is a trademark of X/Open Company Limited in the UK and other
# countries.
#
# ************************************************************************
#
# SCCS:   	@(#)makefile	1.4 03/03/31 TETware release 3.8
# NAME:		makefile
# PRODUCT:	TETware
# AUTHOR:	Andrew Dingwall, UniSoft Ltd.
# DATE CREATED:	August 1998
#
# DESCRIPTION:
#	makefile used to build the shared version of the API library
# 
# MODIFICATIONS:
# 
#	Andrew Dingwall, UniSoft Ltd., July 1999
#	now that we build tcm.o with ld -r, we almost don't need a
#	static portion of the shared library
#
#	Andrew Dingwall, The Open Group, January 2002
#	updated to align with UNIX 2003
#
# ************************************************************************


include ../../defines.mk
include ../ts.mk

LOCAL_TET_CDEFS = $(TET_CDEFS)
LOCAL_DTET_CDEFS = $(DTET_CDEFS)
LOCAL_CDEFS = -DTET_SHLIB_SOURCE
LOCAL_COPTS = $(COPTS) $(SHLIB_COPTS)
LOCAL_CC = $(SHLIB_CC)

# TET_CFLAGS and DTET_CFLAGS are set in ../common.mk
include ../common.mk


# the main shared library name;
# on Win32 systems this is the name of the import library
SHARED_LIBNAME = libapi_s$(SO)

# the name of the static part of the shared API library
STATIC_LIBNAME = libtcm_s$A

# The name of the DLL on Win32 systems.
# The DLL is a byproduct of the process that builds the shared library.
# Since this file is only generated on a Win32 system, it can't be used
# as a target or as a dependency in a platform-independent makefile;
# instead, a proxy target called lib_installed is used to determine when
# the DLL needs to be installed.
DLLNAME = libapi_s.dll

ALL = $(SHARED_LIBNAME) $(STATIC_LIBNAME)

TARGETS = $(LIB)/$(SHARED_LIBNAME) $(LIB)/$(STATIC_LIBNAME) lib_installed


all: $(ALL)

install: $(TARGETS)

$(LIB)/$(SHARED_LIBNAME): $(SHARED_LIBNAME)
	rm -f $@
	cp $? $@

$(LIB)/$(STATIC_LIBNAME): $(STATIC_LIBNAME)
	rm -f $@
	cp $? $@

lib_installed: $(SHARED_LIBNAME)
	@set -x;					\
	case `uname -s` in				\
	Windows_*)					\
		rm -f $(BIN)/$(DLLNAME);		\
		cp $(DLLNAME) $(BIN)/$(DLLNAME);	\
		;;					\
	esac
	touch $@

# single-threaded shared libraries are not supported on Win32 systems
dynlink.gen:
	touch $@

# apilib/shared.mk contains a definition of API_SHARED_OFILES
APISRC = ../apilib/
include ../apilib/shared.mk

# the include ../servlib/shared.mk is done in ts.mk if needed

# dtet2lib/shared.mk contains a definition of DTET_SHARED_OFILES
DTETSRC = ../dtet2lib/
include ../dtet2lib/shared.mk

# ts.mk contains a definition of TS_SHARED_OFILES and SERV_SHARED_OFILES
include ts.mk

SHARED_OFILES = $(API_SHARED_OFILES) $(SERV_SHARED_OFILES) \
	$(TS_SHARED_OFILES) $(DTET_SHARED_OFILES)

STATIC_OFILES = $(API_STATIC_OFILES) $(SERV_STATIC_OFILES) \
	$(TS_STATIC_OFILES) $(DTET_STATIC_OFILES)

$(SHARED_LIBNAME): $(SHARED_OFILES)
	$(SHLIB_BUILD) -o $@ $(SHARED_OFILES) $(SHLIB_BUILD_END)
	$(MCS) -c $@

$(STATIC_LIBNAME): $(STATIC_OFILES)
	@set -x;							\
	if test -f $@; then						\
		$(AR) -rv $@ $? ;					\
	else								\
		$(AR) -rv $@ `$(LORDER) $(STATIC_OFILES) | $(TSORT)` ;	\
	fi
	$(RANLIB) $@


CLEAN clean:
	rm -f $(ALL) $(SHARED_OFILES) $(STATIC_OFILES) *.sym dynlink.gen

CLOBBER clobber: clean
	rm -f $(TARGETS)
	@set -x;				\
	case `uname -s` in			\
	Windows_*)				\
		rm -f $(BIN)/$(DLLNAME);	\
		;;				\
	esac

FORCE FRC: clobber all


# remove suffix rules from this makefile
# all .o files are made by explicit rules
.SUFFIXES:

.SUFFIXES: .none


