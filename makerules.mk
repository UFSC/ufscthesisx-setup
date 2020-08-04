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

# Print the usage instructions
# https://gist.github.com/prwhite/8168133
## Usage:
##   make <target> [debug=1]
##

# Default target
all: thesis

help:
	@fgrep -h "##" ${MAKEFILE_LIST} | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

# The main latex file
THESIS_MAIN_FILE := main

## Use debug=1 to run make in debug mode. Use this if something does not work!
## Examples:
##   make help
##   make debug=1
##   make latex debug=1
##   make thesis debug=1
##
## If you are using Windows Command Prompt `cmd.exe`, you must use the
## command like this:
##  make help
##  set "debug=1" && make
##  set "debug=1" && make latex
##  set "debug=1" && make thesis
##
# Uncomment this if you have problems or call `make latex debug=1`
# ENABLE_DEBUG_MODE := true
ifdef debug
	ifneq (0,${debug})
		ENABLE_DEBUG_MODE := true
	endif
endif

ifeq (${UFSCTHESISX_RSYNC_DIRECTORY},)
	UFSCTHESISX_RSYNC_DIRECTORY := .
endif

ifeq (${UFSCTHESISX_MAINTEX_DIRECTORY},)
	UFSCTHESISX_MAINTEX_DIRECTORY := .
endif

ifeq (${UFSCTHESISX_ROOT_DIRECTORY},)
	UFSCTHESISX_ROOT_DIRECTORY := LatexBuild
endif

ifeq (${UFSCTHESISX_REMOTE_PASSWORD},)
	UFSCTHESISX_REMOTE_PASSWORD := admin123
endif

ifeq (${UFSCTHESISX_REMOTE_ADDRESS},)
	UFSCTHESISX_REMOTE_ADDRESS := root@192.168.0.222
endif

ifeq (${UFSCTHESISX_RSYNC_ARGUMENTS},)
	ifneq (${args},)
		UFSCTHESISX_RSYNC_ARGUMENTS := ${args}
	endif
endif

## Use halt=1 to stop running on errors instead of continuing the compilation!
## Also, use debug=1 to halt on errors and fix the errors dynamically.
##
## Examples (Linux):
##   make halt=1
##   make latex halt=1
##   make thesis halt=1
##
##   make debug=1 halt=1
##   make latex debug=1 halt=1
##   make thesis debug=1 halt=1
##
## Examples (Windows):
##   set "halt=1" && make halt=1
##   set "halt=1" && make latex halt=1
##   set "halt=1" && make thesis halt=1
##
##   set "debug=1" && "halt=1" && make halt=1
##   set "debug=1" && "halt=1" && make latex halt=1
##   set "debug=1" && "halt=1" && make thesis halt=1
##
# Uncomment this if you have problems or call `make latex debug=1`
# HALT_ON_ERROR_MODE := true
ifdef halt
	ifneq (0,${halt})
		HALT_ON_ERROR_MODE := true
	endif
endif

# This will be the pdf generated
THESIS_OUTPUT_NAME := main

# This is the directory where the temporary files are going to be
CACHE_DIRECTORY := latexcache
THESIS_MAIN_FILE_PATH := ${CACHE_DIRECTORY}/${THESIS_MAIN_FILE}.pdf

# Find all files ending with `main.tex`
LATEX_SOURCE_FILES := $(wildcard *main.tex)

# Create a new variable within all `LATEX_SOURCE_FILES` file names ending with `.pdf`
LATEX_PDF_FILES := ${LATEX_SOURCE_FILES:.tex=.pdf}

# https://stackoverflow.com/questions/24005166/gnu-make-silent-by-default
ifeq (,${ENABLE_DEBUG_MODE})
	MAKEFLAGS += --silent
endif

# https://stackoverflow.com/questions/55642491/how-to-check-whether-a-file-exists-outside-a-makefile-rule
FIND_EXEC := $(if $(wildcard /bin/find),,/usr)/bin/find

LATEXMK_THESIS := thesis
LATEXMK_REPLACEMENT := latexmk
GITIGNORE_SOURCE_PATH := .gitignore

GITIGNORE_DESTINE_PATH := ./setup/.gitignore
FIX_GITIGNORE := $(if $(wildcard ${GITIGNORE_DESTINE_PATH}),,${GITIGNORE_DESTINE_PATH})

# http://stackoverflow.com/questions/1789594/how-do-i-write-the-cd-command-in-a-makefile
.ONESHELL:

# https://tex.stackexchange.com/questions/91592/where-to-find-official-and-extended-documentation-for-tex-latexs-commandlin
# https://tex.stackexchange.com/questions/52988/avoid-linebreaks-in-latex-console-log-output-or-increase-columns-in-terminal
PDF_LATEX_COMMAND = pdflatex -shell-escape --synctex=1 $(if ${HALT_ON_ERROR_MODE},-halt-on-error,) -file-line-error
PDF_LATEX_COMMAND += $(if $(shell pdflatex --help | grep time-statistics),--time-statistics,)
PDF_LATEX_COMMAND += $(if $(shell pdflatex --help | grep max-print-line),--max-print-line=10000,)

ifeq (,${ENABLE_DEBUG_MODE})
	PDF_LATEX_COMMAND +=  --interaction=nonstopmode
endif

# https://www.ctan.org/pkg/latexmk
# http://docs.miktex.org/manual/texfeatures.html#auxdirectory
# https://tex.stackexchange.com/questions/258814/what-is-the-difference-between-interaction-nonstopmode-and-halt-on-error
# https://tex.stackexchange.com/questions/25267/what-reasons-if-any-are-there-for-compiling-in-interactive-mode
LATEXMK_COMMAND := latexmk \
	-f \
	--pdf \
	--aux-directory="${CACHE_DIRECTORY}" \
	--output-directory="${CACHE_DIRECTORY}" \
	--pdflatex="${PDF_LATEX_COMMAND}"

ifeq (,${ENABLE_DEBUG_MODE})
	LATEXMK_COMMAND += --silent
endif

LATEX =	${PDF_LATEX_COMMAND}
LATEX += $(if $(shell pdflatex --help | grep aux-directory),-aux-directory="${CACHE_DIRECTORY}",)
LATEX += $(if $(shell pdflatex --help | grep output-directory),-output-directory="${CACHE_DIRECTORY}",)

ifeq (,${ENABLE_DEBUG_MODE})
	LATEX += --interaction=batchmode
endif

# biber settings
BIBER_FLAGS := --input-directory="${CACHE_DIRECTORY}" --output-directory="${CACHE_DIRECTORY}"

ifeq (,${ENABLE_DEBUG_MODE})
	BIBER_FLAGS += --quiet
endif

# https://stackoverflow.com/questions/55681576/how-to-send-input-on-stdin-to-a-python-script-defined-inside-a-makefile
define NEWLINE


endef

define LATEX_VERSION_CODE :=
import re, sys;
match = re.search(r"Copyright (\d+)", """$(shell tex --version)""");
if match:
	if int( match.group(1) ) >= 0:
		sys.stdout.write("1");
	else:
		sys.stdout.write(match.group(1));
else:
	sys.stdout.write("0");
endef

ifneq (,${ENABLE_DEBUG_MODE})
	# https://stackoverflow.com/questions/55662085/how-to-print-text-in-a-makefile-outside-a-target
	ifeq (,$(shell tex --version >/dev/null 2>&1 || (echo "Your command failed with $$?")))
		useless := $(shell printf 'Success: latex is installed!\n' 1>&2)
	else
		useless := $(error Error: latex was not installed!)
	endif

	# https://stackoverflow.com/questions/5618615/check-if-a-program-exists-from-a-makefile
	ifeq (,$(shell latexmk --version >/dev/null 2>&1 || (echo "Your command failed with $$?")))
		useless := $(shell printf 'Success: latexmk is installed!\n' 1>&2)
	else
		useless := $(shell printf 'Warning: latexmk is not found installed!\n' 1>&2)
	endif

	# https://stackoverflow.com/questions/5618615/check-if-a-program-exists-from-a-makefile
	ifeq (,$(shell python --version >/dev/null 2>&1 || (echo "Your command failed with $$?")))
		useless := $(shell printf 'Success: python is installed!\n' 1>&2)

		# https://stackoverflow.com/questions/55681576/how-to-send-input-on-stdin-to-a-python-script-defined-inside-a-makefile
		LATEX_VERSION := $(shell echo \
			'$(subst ${NEWLINE},@NEWLINE@,${LATEX_VERSION_CODE})' | \
			sed 's/@NEWLINE@/\n/g' | python -)
	else
		useless := $(shell printf 'Warning: python is not found installed!\n' 1>&2)
		LATEX_VERSION := 0
	endif

	# https://stackoverflow.com/questions/5618615/check-if-a-program-exists-from-a-makefile
	ifeq (,$(shell fgrep --version >/dev/null 2>&1 || (echo "Your command failed with $$?")))
		useless := $(shell printf 'Success: fgrep is installed!\n' 1>&2)
	else
		useless := $(shell printf 'Warning: fgrep is not found installed!\n' 1>&2)
	endif

	# https://stackoverflow.com/questions/5618615/check-if-a-program-exists-from-a-makefile
	ifeq (,$(shell passh -h -V >/dev/null 2>&1 || (echo "Your command failed with $$?")))
		useless := $(shell printf 'Success: passh is installed!\n' 1>&2)
	else
		useless := $(shell printf 'Warning: passh is not found installed!\n' 1>&2)
	endif

	# https://stackoverflow.com/questions/5618615/check-if-a-program-exists-from-a-makefile
	ifeq (,$(shell rsync --version >/dev/null 2>&1 || (echo "Your command failed with $$?")))
		useless := $(shell printf 'Success: rsync is installed!\n' 1>&2)
	else
		useless := $(shell printf 'Warning: rsync is not found installed!\n' 1>&2)
	endif

	# https://stackoverflow.com/questions/5618615/check-if-a-program-exists-from-a-makefile
	ifeq (,$(shell ssh -V >/dev/null 2>&1 || (echo "Your command failed with $$?")))
		useless := $(shell printf 'Success: ssh is installed!\n' 1>&2)
	else
		useless := $(shell printf 'Warning: ssh is not found installed!\n' 1>&2)
	endif

	ifeq (${LATEX_VERSION}, 1)
		useless := $(shell printf 'Success: Your latex version is compatible!\n' 1>&2)
	else
		ifneq (${LATEX_VERSION}, 0)
			useless := $(shell printf '\n' 1>&2)
			useless := $(shell printf 'Warning: Your latex installation is Tex Live from %s which is very bugged!\n' "${LATEX_VERSION}" 1>&2)
			useless := $(shell printf '         See more informations about this on: https://tex.stackexchange.com/questions/484878\n' 1>&2)
			useless := $(shell printf '\n' 1>&2)
		endif
	endif

	useless := $(if ${ENABLE_DEBUG_MODE},$(shell printf '\n' 1>&2),)
endif

# Calculate the elapsed seconds and print them to the screen
define print_results =
printf '%s/main.log:10000000 ' "${CACHE_DIRECTORY}"; \
printf '\n'
endef

# Copies the PDF to the current directory
# https://stackoverflow.com/questions/55671541/how-define-a-makefile-condition-and-reuse-it-in-several-build-rules/
define copy_resulting_pdf =
printf 'LATEX_PDF_FILES: %s\n' "${LATEX_PDF_FILES}"; \
${print_results}; \
if [[ -f "${THESIS_MAIN_FILE_PATH}" ]]; \
then \
	printf 'Coping PDF...\n'; \
	cp "${THESIS_MAIN_FILE_PATH}" "${CURRENT_DIR}/${THESIS_OUTPUT_NAME}.pdf"; \
else \
	printf '\nError: The PDF %s was not generated!\n' "${THESIS_MAIN_FILE_PATH}"; \
	exit 1; \
fi
printf '\n'
endef

# https://stackoverflow.com/questions/4210042/exclude-directory-from-find-command
# https://tex.stackexchange.com/questions/323820/i-cant-write-on-file-foo-aux
# https://stackoverflow.com/questions/11469989/how-can-i-strip-first-x-characters-from-string-using-sed
pre_setup_envinronment: ${FIX_GITIGNORE}
	$(eval CURRENT_DIR := $(shell pwd)) echo ${CURRENT_DIR} > /dev/null

setup_envinronment: pre_setup_envinronment
	printf '\n';
	readarray -td' ' DIRECTORIES_TO_CREATE <<<"$(shell "${FIND_EXEC}" \
			-not -path "./**.git**" \
			-not -path "./pictures**" -type d \
			-not -path "./${CACHE_DIRECTORY}**" -type d \
			-not -path "./setup**" -type d) "; \
	unset 'DIRECTORIES_TO_CREATE[-1]'; \
	declare -p DIRECTORIES_TO_CREATE $(if ${ENABLE_DEBUG_MODE},,> /dev/null); \
	for directory_name in "$${DIRECTORIES_TO_CREATE[@]}"; \
	do \
		full_cache_directory="${CACHE_DIRECTORY}/$${directory_name:2}"; \
		printf 'Creating %s\n' "$${full_cache_directory}" $(if ${ENABLE_DEBUG_MODE},,> /dev/null); \
		mkdir -p "$${full_cache_directory}"; \
	done
	printf '\n' $(if ${ENABLE_DEBUG_MODE},,> /dev/null);


## Targets:
##   all        Call the `thesis` make rule
##   index      Build the main file with index pass
##   biber      Build the main file with bibliography pass
##   latex      Build the main file with no bibliography pass
##   pdflatex   The same as latex rule, i.e., an alias for it
##   latexmk    Build the main file with pdflatex biber pdflatex pdflatex
##              pdflatex makeindex biber pdflatex
##
##   thesis     Completely build the main file with minimum output logs
##   verbose    Completely build the main file with maximum output logs
##   clean      Remove all cache directories and generated pdf files
##   veryclean  Same as `clean`, but searches for all generated files outside
##              the cache directories.
##
# Keep updated our copy of the .gitignore
# https://stackoverflow.com/questions/55886204/how-to-use-make-to-keep-a-file-synced
${GITIGNORE_DESTINE_PATH}: ${GITIGNORE_SOURCE_PATH}
	if [[ ! -z "${ENABLE_DEBUG_MODE}" ]]; \
	then \
		printf 'Copying %s file...\n' "${GITIGNORE_SOURCE_PATH}"; \
	fi
	cp -$(if ${ENABLE_DEBUG_MODE},v,)r "${GITIGNORE_SOURCE_PATH}" "${GITIGNORE_DESTINE_PATH}"


# https://stackoverflow.com/questions/46135614/how-to-call-makefile-recipe-rule-multiple-times
${LATEXMK_REPLACEMENT}: setup_envinronment pdflatex_hook1 biber_hook1 pdflatex_hook2 pdflatex_hook3 index pdflatex_hook4 biber_hook2 pdflatex_hook5
	${copy_resulting_pdf}


# https://tex.stackexchange.com/questions/98204/index-not-working
index_hook1 index_hook2 index_hook3 index_hook4 index_hook5:
	makeindex "${CACHE_DIRECTORY}/${THESIS_MAIN_FILE}.idx"
	printf '\n'


index: setup_envinronment $(if $(wildcard ${CACHE_DIRECTORY}/${THESIS_MAIN_FILE}.idx),,pdflatex_hook1) index_hook1
	${copy_resulting_pdf}


index1: setup_envinronment $(if $(wildcard ${CACHE_DIRECTORY}/${THESIS_MAIN_FILE}.idx),,pdflatex_hook2) index_hook2
	${copy_resulting_pdf}


index2: setup_envinronment $(if $(wildcard ${CACHE_DIRECTORY}/${THESIS_MAIN_FILE}.idx),,pdflatex_hook3) index_hook3
	${copy_resulting_pdf}


index3: setup_envinronment $(if $(wildcard ${CACHE_DIRECTORY}/${THESIS_MAIN_FILE}.idx),,pdflatex_hook4) index_hook4
	${copy_resulting_pdf}


index4: setup_envinronment $(if $(wildcard ${CACHE_DIRECTORY}/${THESIS_MAIN_FILE}.idx),,pdflatex_hook5) index_hook5
	${copy_resulting_pdf}


# Call biber to process the bibliography and does not attempt to show the elapsed time
# https://www.mankier.com/1/biber --debug
# https://stackoverflow.com/questions/35552028/gnu-make-add-a-file-as-a-dependency-only-if-it-doesnt-exist-yet
biber_hook1 biber_hook2 biber_hook3 biber_hook4 biber_hook5: $(if $(wildcard ${CACHE_DIRECTORY}/${THESIS_MAIN_FILE}.bcf),,pdflatex_hook1)
	printf 'Running biber...\n'
	biber ${BIBER_FLAGS} "${THESIS_MAIN_FILE}.bcf" $(if ${ENABLE_DEBUG_MODE},--validate_datamodel,)
	printf '\n'


# Run pdflatex, biber, pdflatex
biber: setup_envinronment index_hook1 biber_hook1 $(if ${ENABLE_DEBUG_MODE},,pdflatex_hook1)
	${copy_resulting_pdf}


biber1: setup_envinronment index_hook2 biber_hook2 $(if ${ENABLE_DEBUG_MODE},,pdflatex_hook2)
	${copy_resulting_pdf}


biber2: setup_envinronment index_hook3 biber_hook3 $(if ${ENABLE_DEBUG_MODE},,pdflatex_hook3)
	${copy_resulting_pdf}


biber3: setup_envinronment index_hook4 biber_hook4 $(if ${ENABLE_DEBUG_MODE},,pdflatex_hook4)
	${copy_resulting_pdf}


biber4: setup_envinronment index_hook5 biber_hook5 $(if ${ENABLE_DEBUG_MODE},,pdflatex_hook5)
	${copy_resulting_pdf}


# https://stackoverflow.com/questions/46135614/how-to-call-makefile-recipe-rule-multiple-times
pdflatex_hook1 pdflatex_hook2 pdflatex_hook3 pdflatex_hook4 pdflatex_hook5 pdflatex_hook6:
	printf 'LATEX_SOURCE_FILES: %s\n' "${LATEX_SOURCE_FILES}"
	@${LATEX} ${LATEX_SOURCE_FILES} || $(if ${HALT_ON_ERROR_MODE},eval "${print_results}; exit $$?",)
	printf '\n'


# This rule will be called for every latex file and pdf associated
latex pdflatex: setup_envinronment pdflatex_hook1
	${copy_resulting_pdf}


latex1 pdflatex1: setup_envinronment pdflatex_hook2
	${copy_resulting_pdf}


latex2 pdflatex2: setup_envinronment pdflatex_hook3
	${copy_resulting_pdf}


latex3 pdflatex3: setup_envinronment pdflatex_hook4
	${copy_resulting_pdf}


latex4 pdflatex4: setup_envinronment pdflatex_hook5
	${copy_resulting_pdf}


latex5 pdflatex5: setup_envinronment pdflatex_hook6
	${copy_resulting_pdf}


# MAIN LATEXMK RULE
${LATEXMK_THESIS}: setup_envinronment
	${LATEXMK_COMMAND} ${THESIS_MAIN_FILE}.tex || $(if ${HALT_ON_ERROR_MODE},eval "${print_results}; exit $$?",)
	${copy_resulting_pdf}


# Dynamically generated recipes for all PDF and latex files
%.pdf: %.tex
	@${LATEX} $< || $(if ${HALT_ON_ERROR_MODE},eval "${print_results}; exit $$?",)
	printf '\n'


clean:
	${RM} -rv ${CACHE_DIRECTORY}
	${RM} -v ${THESIS_OUTPUT_NAME}.pdf
	printf '\n'


# https://stackoverflow.com/questions/4210042/exclude-directory-from-find-command
# https://stackoverflow.com/questions/10586153/split-string-into-an-array-in-bash
# https://stackoverflow.com/questions/11289551/argument-list-too-long-error-for-rm-cp-mv-commands
# https://stackoverflow.com/questions/55527923/how-to-stop-makefile-from-expanding-my-shell-output
# https://stackoverflow.com/questions/55545253/how-to-expand-wildcard-inside-shell-code-block-in-a-makefile
veryclean: veryclean_hidden clean
veryclean_hidden:
	$(if ${ENABLE_DEBUG_MODE},printf '\n',)
	readarray -td' ' DIRECTORIES_TO_CLEAN <<<"$(shell "${FIND_EXEC}" -not -path "./**.git**" -not -path "./pictures**" -type d) "; \
	unset 'DIRECTORIES_TO_CLEAN[-1]'; \
	declare -p DIRECTORIES_TO_CLEAN; \
	readarray -td' ' GITIGNORE_CONTENTS <<<"$(shell printf '%s' \
		"$(shell while read -r line; do printf "$$line "; done < "${GITIGNORE_DESTINE_PATH}")" \
		| sed -E $$'s/[^\#]+\# //g' \
		| sed -E 's/\r//g') "; \
	unset 'GITIGNORE_CONTENTS[-1]'; \
	declare -p GITIGNORE_CONTENTS; \
	for filename in "$${DIRECTORIES_TO_CLEAN[@]}"; \
	do \
		arraylength="$${#GITIGNORE_CONTENTS[@]}"; \
		printf 'Cleaning %s extensions on %s\n' "$${arraylength}" "$$filename"; \
		for extension in "$${GITIGNORE_CONTENTS[@]}"; \
		do \
			[[ ! -z "$$filename" ]] || continue; \
			[[ ! -z "$$extension" ]] || continue; \
			full_expression="$${filename}/$${extension}" ;\
			rm -vf $${full_expression}; \
		done; \
	done;


# https://stackoverflow.com/questions/39767904/create-zip-archive-with-multiple-files
# https://stackoverflow.com/questions/47588379/zip-multiple-files-with-multiple-result-in-python
# https://stackoverflow.com/questions/16091904/python-zip-how-to-eliminate-absolute-path-in-zip-archive-if-absolute-paths-for
define RELEASE_CODE :=
from __future__ import print_function
import os
import zipfile

version = "${version}"
version_prefix = "${version_prefix}".strip()
if not version:
	print( "Error: You need pass the release version. For example: make release version=1.1", end="@NEWNEWLINE@" )
	exit(1)

CURRENT_DIRECTORY = os.path.dirname( os.path.abspath( __file__ ) )
print( "Packing files on %s" % CURRENT_DIRECTORY, end="@NEWNEWLINE@" )

file_names = set()
initial_file_names = [
	"Makefile",
	"build.bat",
	"fc-portuges.def",
	os.path.join("setup", "README.md"),
	os.path.join("setup", ".gitignore"),
	os.path.join("setup", "makefile.mk"),
	os.path.join("setup", "makerules.mk"),
	os.path.join("setup", "abntex2.cls"),
	os.path.join("setup", "remove_lang.py"),
	os.path.join("setup", "ufscthesisx.cls"),
	os.path.join("setup", "UFSC_sigla_fundo_claro.png"),
	os.path.join("setup", "ufscthesisx.sublime-project"),
	os.path.join("setup", "_generic_timer.sh"),
]

for direcory_name, dirs, files in os.walk(CURRENT_DIRECTORY, followlinks=True):

	for filename in files:
		filepath = os.path.join( direcory_name, filename )

		if ".git" in filepath or not (
					filepath.endswith( ".tex" )
					or filepath.endswith( ".png" )
					or filepath.endswith( ".jpg" )
					or filepath.endswith( ".svg" )
					or filepath.endswith( ".bib" )
					or filepath.endswith( ".pdf" )
				):
			continue

		file_names.add( filepath )

for filename in initial_file_names:
	filepath = os.path.join( CURRENT_DIRECTORY, filename )
	file_names.add( filepath )

versionname = version if version.endswith( ".zip" ) else version + ".zip"
versiondirectory = version_prefix

zipfilepath = os.path.join( CURRENT_DIRECTORY, versionname )
zipfileobject = zipfile.ZipFile(zipfilepath, mode="w")
zipfilepathreduced = os.path.dirname( zipfilepath )

if not version_prefix:
	zipfilepathreduced = os.path.dirname( zipfilepathreduced )

try:
	for filename in file_names:
		relative_filename = filename.replace( zipfilepathreduced, versiondirectory )
		print( relative_filename, end="@NEWNEWLINE@" )
		zipfileobject.write( filename, relative_filename, compress_type=zipfile.ZIP_DEFLATED )

except Exception as error:
	print( "", end="@NEWNEWLINE@" )
	print( "An error occurred: %s" % error, end="@NEWNEWLINE@" )
	exit(1)

finally:
	zipfileobject.close()

print( "", end="@NEWNEWLINE@" )
print( "Successfully created the release version on:@NEWNEWLINE@  %s!" % zipfilepath , end="" )
endef

##   release version=1.1
##       creates the zip file `1.1.zip` on the root of this project,
##       within all latex required files. This is useful to share or
##       public your thesis source files with others. If you are using
##       Windows Command Prompt `cmd.exe`, you must use this command like this:
##       set "version=1.1" && make release
##
# https://stackoverflow.com/questions/55839773/how-to-get-the-exit-status-and-the-output-of-a-shell-command-before-make-4-2
release:
	$(if ${ENABLE_DEBUG_MODE},printf '\n',)
	printf '%s\n' "$(shell echo \
		'$(subst ${NEWLINE},@NEWLINE@,${RELEASE_CODE})' | \
		sed 's/@NEWLINE@/\n/g' | python - || \
		( printf 'Error: Could not create the zip file!\n'; exit 1 ) )" | sed 's/@NEWNEWLINE@/\n/g'
	exit "${.SHELLSTATUS}"


define REMOTE_COMMAND_TO_RUN :=
cd "${UFSCTHESISX_ROOT_DIRECTORY}/${UFSCTHESISX_MAINTEX_DIRECTORY}"; \
printf '\nThe current directory is:\n'; pwd; \
if [[ "w--delete" == "w$(findstring --delete,${UFSCTHESISX_RSYNC_ARGUMENTS})" ]]; \
	then \
		printf '\nRemoving cache directory...\n'; \
		rm -rfv "${CACHE_DIRECTORY}"; \
	fi; \
printf '\nRunning the command: make ${rules}\n'; \
make ${rules};
endef

##   remote     Runs the make command remotely on another machine by ssh.
##              This requires `passh` program installed. You can download it from:
##              https://github.com/clarkwang/passh
##
##       You can define the following parameters:
##       4. args - arguments to pass to the rsync program, see 'rsync --help'
##       3. rules - the rules/arguments to pass to the remote invocation of make
##       5. UFSCTHESISX_ROOT_DIRECTORY  - the directory to put the files, defaults to 'LatexBuild'
##       1. UFSCTHESISX_REMOTE_PASSWORD - the remote machine SHH password, defaults to 'admin123'
##       2. UFSCTHESISX_REMOTE_ADDRESS  - the remote machine 'user@ipaddress', defaults to 'linux@192.168.0.222'
##
##     Example usage for Linux:
##       make remote rules="latex debug=1" &&
##              debug=1 &&
##              args="--delete"
##              UFSCTHESISX_ROOT_DIRECTORY="Downloads/Thesis" &&
##              UFSCTHESISX_REMOTE_ADDRESS="linux@192.168.0.222" &&
##              UFSCTHESISX_REMOTE_PASSWORD="123" &&
##
##     Example usage for Windows:
##       set "rules=latex debug=1" &&
##              set "debug=1" &&
##              set "args=--delete" &&
##              set "UFSCTHESISX_ROOT_DIRECTORY=Downloads/Thesis" &&
##              set "UFSCTHESISX_REMOTE_ADDRESS=linux@192.168.0.222" &&
##              set "UFSCTHESISX_REMOTE_PASSWORD=123" &&
##              make remote
##
#https://serverfault.com/questions/330503/scp-without-known-hosts-check
#https://stackoverflow.com/questions/4780893/use-expect-in-bash-script-to-provide-password-to-ssh-command
remote: pre_setup_envinronment
	$(if ${ENABLE_DEBUG_MODE},printf '\n',)

	printf '\nJust ensures the directory '%s' is created...\n' "${UFSCTHESISX_ROOT_DIRECTORY}"
	passh -p "${UFSCTHESISX_REMOTE_PASSWORD}" \
		ssh -o StrictHostKeyChecking=no \
		"${UFSCTHESISX_REMOTE_ADDRESS}" \
		'mkdir -p "${UFSCTHESISX_ROOT_DIRECTORY}"'

	printf '\nRunning the command which will actually send the files...\n'
	passh -p "${UFSCTHESISX_REMOTE_PASSWORD}" \
		rsync ${UFSCTHESISX_RSYNC_ARGUMENTS} \
		--recursive \
		--verbose \
		--update \
		--copy-links \
		--exclude ".git" \
		--exclude "_gsdata_" \
		--exclude ".tmp.drivedownload" \
		--exclude "${CACHE_DIRECTORY}" \
		--exclude "${THESIS_MAIN_FILE}.pdf" \
		"${CURRENT_DIR}/${UFSCTHESISX_RSYNC_DIRECTORY}/./" \
		"${UFSCTHESISX_REMOTE_ADDRESS}:${UFSCTHESISX_ROOT_DIRECTORY}"

	printf '\nRunning the command which will actually run make...\n'
	passh -p "${UFSCTHESISX_REMOTE_PASSWORD}" \
		ssh -o StrictHostKeyChecking=no \
		"${UFSCTHESISX_REMOTE_ADDRESS}" \
		"${REMOTE_COMMAND_TO_RUN}" || $(if ${HALT_ON_ERROR_MODE},exit "$$?",)

	printf '\nRunning the command which will copy back the generated PDF...\n';
	-passh -p "${UFSCTHESISX_REMOTE_PASSWORD}" \
		scp -o StrictHostKeyChecking=no \
		"${UFSCTHESISX_REMOTE_ADDRESS}:${UFSCTHESISX_ROOT_DIRECTORY}/${UFSCTHESISX_MAINTEX_DIRECTORY}/${CACHE_DIRECTORY}/main.log" \
		"${CURRENT_DIR}/" || printf '\nNo log file to copy back!\n';
	-passh -p "${UFSCTHESISX_REMOTE_PASSWORD}" \
		scp -o StrictHostKeyChecking=no \
		"${UFSCTHESISX_REMOTE_ADDRESS}:${UFSCTHESISX_ROOT_DIRECTORY}/${UFSCTHESISX_MAINTEX_DIRECTORY}/main.pdf" \
		"${CURRENT_DIR}/" || printf '\nNo PDF to copy back!\n';

