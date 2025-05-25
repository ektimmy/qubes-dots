#!/bin/bash
#

# Set colors for console
if [ "$TERM" = "linux" ]; then
	# reset all colors
	echo -en "\033[39m\\033[49m"

	# colors 1 through 16
	echo -en "\e]PO141b1e"
	echo -en "\e]P1e57474"
	echo -en "\e]P28ccf7e" 
	echo -en "\e]P3e5c76b" 
	echo -en "\e]P467b0e8" 
	echo -en "\e]P5c47fd5" 
	echo -en "\e]P66cbfbf"
	echo -en "\e]P7dadada" 
	
	echo -en "\e]P8232a2d"
	echo -en "\e]P9e57474"
	echo -en "\e]Pa8ccf7e"
	echo -en "\e]Pbe5c76b"
	echo -en "\e]Pc67b0e8"
	echo -en "\e]Pdc47fd5"
	echo -en "\e]Pe6cbfbf" 
	echo -en "\e]Pf141b1e" 

	clear

	# background
	printf %b '\e]40m''\e[8]'
	printf %b '\e]P0141b1e'
	clear
fi
