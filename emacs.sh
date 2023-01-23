#!/bin/bash

# Script with various utilities for GNU Emacs
# TODO: dir-locals for devkitpro, Unreal Engine C++ stuff etc.
# TODO any way I could make more general functions to help make all kinds of dir-locals files? Different modes etc.? Think about it :) 
# TODO: maybe also the possibility to modify a dir-locals file if present?

function __emacs_create_dir_locals_c_config() {
	HEADERS=$1
	HEADERS_QUOTED=$(echo $1 | tr ' ' '\n' | sed -E 's/(.*)/\"\1\"/')
	CLANG_ARGS=$(echo "$HEADERS" | tr ' ' '\n' | sed -E 's/(.*)/\"-I\1\"/')
	
	echo "((c-mode . ((company-clang-arguments . ($CLANG_ARGS))\n\
	        (company-c-headers-path-system . ($HEADERS_QUOTED)))))" > .dir-locals.el
}

# create a dir locals file for gamecube with devkitpro clang and header config
function emacs_create_dir_locals_gamecube() {
	HEADERS="$DEVKITPRO/libogc/include/"
	__emacs_create_dir_locals_c_config "$HEADERS"
}

function emacs_create_dir_locals_gamecube_portlibs() {
	HEADERS="$DEVKITPRO/libogc/include/ $DEVKITPRO/portlibs/gamecube/include/"
	__emacs_create_dir_locals_c_config "$HEADERS"
}

# create dir locals for GBA development using libgba
function emacs_create_dir_locals_gba() {
	HEADERS="$DEVKITPRO/libgba/include/"
	__emacs_create_dir_locals_c_config "$HEADERS"
}

# create dir locals for nintendo ds development using libnds
function emacs_create_dir_locals_nds() {
	HEADERS="$DEVKITPRO/libnds/include/"
	__emacs_create_dir_locals_c_config "$HEADERS"
}

function emacs_create_dir_locals_nds_portlibs() {
	HEADERS="$DEVKITPRO/libnds/include/ $DEVKITPRO/portlibs/nds/include/"
	__emacs_create_dir_locals_c_config "$HEADERS"
}


# KScript uses an environment variable to control IDEA command
# (for opening the script in IntelliJ IDEA).
# By setting this we can default to Emacs instead when running kscript --idea ourscript.kts
export KSCRIPT_IDEA_COMMAND="emacsclient -n"
