#!/bin/bash

# various helpers for C64 development

# gives prg version of name, based upon the assembly file. Utility function 
function __prg_file_from_asm_file() {
	echo "$(echo $1 | cut -d '.' -f 1).prg"
}

# assembles source file to runnable program with BASIC sys instruction with address generated
function c64a() {
	outfile=$(__prg_file_from_asm_file $1)
	cl65 -o $outfile -u __EXEHDR__  -t c64 -C c64-asm.cfg $1
}

# assemble program, then run in VICE
function runC64() {
	prg=$(__prg_file_from_asm_file $1)
	c64a $1
	x64 $prg 
}
