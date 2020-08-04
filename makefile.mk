#!/usr/bin/make -f
# https://stackoverflow.com/questions/7123241/makefile-as-an-executable-script-with-shebang
#
#   Copyright 2017-2019 @ Evandro Coan
#   Helper functions and classes
#
#  Redistributions of source code must retain the above
#  copyright notice, this list of conditions and the
#  following disclaimer.
#
#  Redistributions in binary form must reproduce the above
#  copyright notice, this list of conditions and the following
#  disclaimer in the documentation and/or other materials
#  provided with the distribution.
#
#  Neither the name Evandro Coan nor the names of any
#  contributors may be used to endorse or promote products
#  derived from this software without specific prior written
#  permission.
#
#  This program is free software; you can redistribute it and/or modify it
#  under the terms of the GNU General Public License as published by the
#  Free Software Foundation; either version 3 of the License, or ( at
#  your option ) any later version.
#
#  This program is distributed in the hope that it will be useful, but
#  WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
#  General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
ECHOCMD:=/bin/echo -e
SHELL := /bin/bash

# Uncomment this if you have problems or call `make latex debug=1`
# ENABLE_DEBUG_MODE := true
ifdef debug
	ifneq (0,${debug})
		ENABLE_DEBUG_MODE := true
	endif
endif

# http://stackoverflow.com/questions/1789594/how-do-i-write-the-cd-command-in-a-makefile
.ONESHELL:

# https://stackoverflow.com/questions/24005166/gnu-make-silent-by-default
ifeq (,${ENABLE_DEBUG_MODE})
	MAKEFLAGS += --silent
endif

# https://stackoverflow.com/questions/58367235/how-to-detect-if-the-makefile-silent-quiet-command-line-option
# https://stackoverflow.com/questions/20582006/force-makefile-to-execute-script-after-building-any-target-just-before-exiting
define DEFAULTTARGET :=
	. ./setup/_generic_timer.sh

	$(eval current_dir := $(shell pwd)) echo ${current_dir} > /dev/null
	printf '\nCalling setup/makerules.mk "%s" %s\n' "${MAKECMDGOALS}" "${MAKEFLAGS}";

	if make -f setup/makerules.mk ${MAKECMDGOALS};
	then :
		showTheElapsedSeconds "${current_dir}";
	else
	    exitcode="$$?"
		showTheElapsedSeconds "${current_dir}";
	    exit "$${exitcode}";
	fi;
endef

%:
	@:
	$(if ${ENABLE_DEBUG_MODE},printf 'IS_MAKEFILE_RUNNING_TARGETS="%s"\n' "${IS_MAKEFILE_RUNNING_TARGETS}",)

	$(if ${IS_MAKEFILE_RUNNING_TARGETS},,${DEFAULTTARGET})
	$(eval IS_MAKEFILE_RUNNING_TARGETS=1)

all:
	@:
	$(if ${ENABLE_DEBUG_MODE},printf 'IS_MAKEFILE_RUNNING_TARGETS="%s"\n' "${IS_MAKEFILE_RUNNING_TARGETS}",)

	$(if ${IS_MAKEFILE_RUNNING_TARGETS},,${DEFAULTTARGET})
	$(eval IS_MAKEFILE_RUNNING_TARGETS=1)
