#!/bin/bash

################################################################################
# MIT License
# 
# Copyright (c) 2020 BlueChip
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
################################################################################

# https://www.utf8-chartable.de/unicode-utf8-table.pl?start=00&names=-&utf8=string-literal
# https://www.utf8-chartable.de/unicode-utf8-table.pl?start=00&number=256&utf8=oct
#nbsp="$(echo -e '\u00a0')"     # Nope - Mac's come with BASh v3
#nbsp="$(echo -e '\xc2\xa0')"   # Nope - Mac's come with BASh v3
nbsp="$(echo -e '\0302\0240')"

AZEN="ABCDEFGHIJKLMNOPQRSTUVWXYZ☺☻♣♦♥♠♂♀♪☼0123456789-.${nbsp}"
AZRU="АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ☺☻♣♦♥♠♂♀♪☼0123456789-.${nbsp}"

maskC=$((0x0F))

maskB=$((0x00))
maskL=$((0x08))
maskD=$((0x04))
maskU=$((0x02))
maskR=$((0x01))
maskLD=$(($maskL |$maskD))
maskLU=$(($maskL |$maskU))
maskLR=$(($maskL |$maskR))
maskDU=$(($maskD |$maskU))
maskDR=$(($maskD |$maskR))
maskUR=$(($maskU |$maskR))

maskLRU=$(($maskL |$maskR |$maskU))
maskLRD=$(($maskL |$maskR |$maskD))
maskUDL=$(($maskU |$maskD |$maskL))
maskUDR=$(($maskU |$maskD |$maskR))

maskLDUR=$(($maskL |$maskD |$maskU |$maskR))

maskT=$((0xF0))

tetiO=$((0x10))
tetiI=$((0x20))
tetiT=$((0x30))
tetiL=$((0x40))
tetiJ=$((0x50))
tetiS=$((0x60))
tetiZ=$((0x70))
tetiB=$((0x80)) # empty space

tetiV=$((0x90))
tetiG=$((0xA0))

tetiVV=$((0xB0))
tetiGG=$((0xC0))

tetiW=$((0xF0))  # pit wall

gridP=$((0xF0))
gridPl=$(($gridP |$maskL))
gridPbl=$(($gridP |$maskD | $maskL))
gridPb=$(($gridP |$maskD))
gridPbr=$(($gridP |$maskD |$maskR))
gridPr=$(($gridP |$maskR))

#****************************************************************************** ****************************************
#                                ,----------.
#                               (  FOREWORD  )
#                                `----------'
#****************************************************************************** ****************************************
#
# So. It dawned on me, I've never written a Тетрис clone
# and my BASh scripting could probably do with a work-out
#
# This whole thing grew organically, it is:
#   * An utter mess
#   * Lacking in any coding standard/consistency
#   * In need of beautification
#   * A fully working Tetris clone
#
# So don't bother critiquing the style - I know, I was learning as I went along,
#   and I did not go back and clean up old code when I learned a better method.
#   So don't be surprised when you see the same thing done four different ways!
# If you see a thing I could do better (which I haven't already done somewhere 
#   else), let me know - *ALL* feedback is appreciated. 
#   Yep, even trolls - after years on IRC, I think it's /fun/ to feed them - lol
#
# Who knows, one day I might actually clean up the code; it's not like I don't
#   have a hundred ideas on what I could add ...In the mean time: 
#   * Steal ideas (eg. multi-threaded graphics, function pointers, 
#                      self-modifying code, etc.)
#   * Steal chunks of code (eg. the PRNG)
#     ...Crediting me is appreciated, but not required.
#     ...All this code is MIT licenced
#   * Improve it and make pull requests
#   * Offer ideas about how it could be improved
#   * Report bugs
#   * etc.
#
# But above all:
#   * Enjoy the game
#

#****************************************************************************** ****************************************
#                              ,--------------.
#                             (  BIBLIOGRAPHY  )
#                              `--------------'
#****************************************************************************** ****************************************
#
# This probably isn't complete, but it's a list of handy references:
#   * https://en.wikipedia.org/wiki/Code_page_437
#   * http://ascii-table.com/ansi-escape-sequences.php
#   * https://www.linuxquestions.org/questions/programming-9/bash-case-with-arrow-keys-and-del-backspace-etc-523441/
#   * http://asciiqr.com/
#   * https://www.utf8-chartable.de/unicode-utf8-table.pl?start=00&utf8=oct
#
# Comments:  #-  data
#            =+  function
#            #!! todo

#------------------------------------------------------------------------------ ----------------------------------------
# ANSI Colour definitions
#
# use : ${atPFX}  {at};{fg};{bg}  ${atSFX}
# EG. : ${atPFX}${atBLD};{$fgYEL};${bgRED}${atSFX}
#       ${atPFX}{$fgBLU};${bgBLK}${atSFX}
#
atPFX="\033[0;"  # Mac's come with BASh v3 - so no "\e" or "\x1b"
atSFX=m

fgBLK=30
fgRED=31
fgGRN=32
fgYEL=33
fgBLU=34
fgMAG=35
fgCYN=36
fgWHT=37

bgBLK=$((fgBLK +10))
bgRED=$((fgRED +10))
bgGRN=$((fgGRN +10))
bgYEL=$((fgYEL +10))
bgBLU=$((fgBLU +10))
bgMAG=$((fgMAG +10))
bgCYN=$((fgCYN +10))
bgWHT=$((fgWHT +10))

atBLD=1  # bold/bright
atUSC=4  # underscore
atBLN=5  # blink
atREV=7  # reverse
atCON=8  # conceal

#atOFF="${atPFX}0${atSFX}"  # off
atOFF="${atPFX}0;${fgWHT};${bgBLK}${atSFX}"  # for weirdos with "light skin" terminals!

# Text colours
MAG="${atPFX}${atBLD};${fgMAG};${bgBLK}${atSFX}"
RED="${atPFX}${atBLD};${fgRED};${bgBLK}${atSFX}"
GRN="${atPFX}${atBLD};${fgGRN};${bgBLK}${atSFX}"
YEL="${atPFX}${atBLD};${fgYEL};${bgBLK}${atSFX}"
BLU="${atPFX}${atBLD};${fgBLU};${bgBLK}${atSFX}"
CYN="${atPFX}${atBLD};${fgCYN};${bgBLK}${atSFX}"
WHT="${atPFX};${fgWHT};${bgBLK}${atSFX}"

BBLK="${atPFX}${atBLD};${fgBLK};${bgBLK}${atSFX}"
BWHT="${atPFX}${atBLD};${fgWHT};${bgBLK}${atSFX}"

#****************************************************************************** ****************************************
#                              ,--------------.
#                             (  PROGRAM INFO  )
#                              `--------------'
#****************************************************************************** ****************************************
NAME="BAShTris"
VER=0.7

AUTHOR="${BBLK}cs${GRN}ßlúè${BLU}Çhîp${atOFF}"
GROUP="${CYN}Çybôrg Sÿstem$"

DBGpipe=$NAME.debug

#****************************************************************************** ****************************************
#                                  ,------.
#                                 (  PRNG  )
#                                  `------'
#****************************************************************************** ****************************************
# "Linear Congruency" Pseudo Random Number Generator [PRNG]
# Full docs here: https://github.com/csBlueChip/simplePRNG
#

#------------------------------------------------------------------------------ ----------------------------------------
# Constansts
#
RNDm=$((0x100000000 -1))               # m: >2^30, precise ^2 allows for boolean optimisation
RNDa=$((0x5D635DBA & 0xFFFFFFF0 | 5))  # a: no binary pattern, as M is a ^2 A%8==5
RNDc=1                                 # c: no factor in common with m

# The wider (in bits) your result is, the less entropy will appear in the LSb's
RNDw=3                                 # w= width of result
RNDb=$((RNDr = 1 <<$RNDw, --RNDr))     # b= bitmask (variable (p)reuse)
RNDr=$((32 -$RNDw))                    # r= right shift amount

#------------------------------------------------------------------------------ ----------------------------------------
# Variables
#
# There is no algorithmic requirement to store RNDs or RNDn
# These are merely for convenience, and may be removed.
#
RNDs=$RANDOM                           # s= seed
RNDx=$RNDs                             # x= most recent state
RNDn=$(($RNDx & $RNDm))                # n= most recent PRN

#+============================================================================= ========================================
RND() {  # ([seed, n])
	[[ $1 == seed ]] && {
		RNDs=$2
		RNDx=$RNDs
		return
	}

	RNDx=$((RNDn = $RNDa *$RNDx +$RNDc, RNDn %$RNDm))  # x <- (ax+c)%m  (reuse RNDn as tmp)
	RNDn=$(($RNDx >>$RNDr))                            # upper bits have greater entropy

	return $RNDn
}

#****************************************************************************** ****************************************
#                          ,-------------------------.
#                         (  CYBORG SYSTEMS BRANDING  )
#                          `-------------------------'
#****************************************************************************** ****************************************

CSmini=()
CSmini+=("╓────╖")
CSmini+=("║ °╓─╖")
CSmini+=("║${nbsp}${nbsp}╙─╖")
CSmini+=("╙─╜╙─╜")
CSminiW=6
CSminiH=4
CSminiClr="${atPFX}${fgRED};${bgBLK}${atSFX}"

CS=()
#        0         1         2         3         4         5        6          7         8
#        012345678901234567890123456789012345678901234567890123456789012345678901234567890
   CS+=("                                                                                 ") # 0
   CS+=("  ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄   ▄     ▄   ▄▄▄▄▄▄▄   ▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄   ▄▄▄▄▄▄▄            ") # 1
   CS+=(" ███             ███ ███   ███ ██▄   ███ ███   ███ ▄▄▄   ███ ███   ███           ") # 2
   CS+=(" █▓█             █▒█ █▒█ ░ █▒█ █▓█ ░ █▒█ █▓█ ░ █▓█ █▓█ ░ █▒█ █▓█ ░ █▒█           ") # 3
   CS+=(" █▓█             █░█ █░█ ░ █░█ █▒█ ░ █░█ █▒█ ░ █▒█ █▒█ ░ █░█ █▒█ ░ █░█           ") # 4
   CS+=(" █▒█             ▀▀▀ █ █ ░ █ █ █░█ ░ █ █ █░█ ░ █░█ █░█ ░ █ █ █░█ ░ ▀▀▀   _▄▄▄_   ") # 5
   CS+=(" █▒█                 █ █   █ █ █ █▄▄▄█▀▀ █ █ ▲ █ █ █ █▄▄▄██▀ █ █         ―█▒█―   ") # 6  chip legs are 
   CS+=(" █░█                 ▀███▀███▀ █ █▀▀▀█▄▄ █ █ ▼ █ █ █ █  █ █  █ █ ▀▀███   ―█▒█―   ") # 7  \u2015 'cos Kali
   CS+=(" █░█                    █ █    █░█ ░ █ █ █░█ ░ █░█ █░█  █ █  █░█ ░ █ █    ▀▀▀    ") # 8
   CS+=(" █░█                    █░█    █▒█ ░ █░█ █▒█ ░ █▒█ █▒█  █░█  █▒█ ░ █░█           ") # 9
   CS+=(" █ █                    █▒█    █▓█ ░ █▒█ █▓█ ░ █▓█ █▓█  █▒█  █▓█ ░ █▒█           ") #10
   CS+=(" █1█                    ███    ███   ███ ███   ███ ███  ███  ██▀   ███           ") #11
   CS+=(" █9█                   ▀▀▀▀▀    ▀▀▀▀▀▀▀   ▀▀▀▀▀▀▀  ▀▀▀   ▀▀▀  ▀▀▀▀▀▀▀            ") #12
   CS+=(" █8█        ▄▄▄▄▄▄▄   ▄     ▄   ▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄   ▄▄▄▄▄▄▄   ▄▄▄▄▄▄▄  ") #13
   CS+=(" █4█       ██▄   ███ ███   ███ ██▄   ███ ██▀███▀██ ██▄ █████ ███ █ ███ ██▄   ███ ") #14
   CS+=(" █ █       █▓█ ░ █▒█ █▒█ ░ █▒█ █▓█ ░ █▒█    █▓█    █▓█       █▓█ █ █▓█ █▓█ ░ █▒█ ") #15
   CS+=(" █░█       █▒█ ░ █░█ █░█ ░ █░█ █▒█ ░ █░█    █▒█    █▒█       █▒█ █ █▒█ █▒█ ░ █░█ ") #16
   CS+=(" █░█       █░█   ▀▀▀ █ █ ░ █ █ █░█   ▀▀▀    █░█    █░█       █░█ █ █░█ █░█   ▀▀▀ ") #17
   CS+=(" █░█       ▀██▄▄▄▄   █ █   █ █ ▀██▄▄▄▄      █ █    █ █▄▄█▀▀  █ █ ▓ █ █ ▀██▄▄▄▄   ") #18
   CS+=(" █▒█         ▀▀▀▀██▄ ▀███▀███▀   ▀▀▀▀██▄    █ █    █ █▀▀█▄▄  █ █ ▒ █ █   ▀▀▀▀██▄ ") #19
   CS+=(" █▒█       ███   █ █    █ █    ███   █ █    █░█    █░█       █░█ ░ █░█ ███   █ █ ") #20
   CS+=(" █▓█     ▄ █░█ ░ █░█    █░█    █░█ ░ █░█    █▒█    █▒█       █▒█   █▒█ █░█ ░ █░█ ") #21
   CS+=(" █▓█     █ █▒█ ░ █▒█    █▒█    █▒█ ░ █▒█    █▓█    █▓█       █▓█   █▓█ █▒█ ░ █▒█ ") #22
   CS+=(" ███     █ ███   ▀██    ███    ███   ▀██    ███    ██▀ █████ ███   ███ ███   ▀██ ") #23
   CS+=("  ▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀    ▀▀▀▀▀    ▀▀▀▀▀▀▀     ▀▀▀     ▀▀▀▀▀▀▀  ▀▀▀   ▀▀▀  ▀▀▀▀▀▀▀  ") #24
   CS+=("                             #-#ENTERTAINING#YOU#-#                             ")  #25
#        01234567890123456789012345678901234567890123456789012345678901234567890123456789
#        0          1        2         3         4         5        6          7         8

#+============================================================================= ========================================
CSdrawBackdrop() {
	echo -en "$CSminiClr"
	for ((y = 1;  y <= 25; y += $CSminiH)); do
		for ((h = 0;  h < $CSminiH;  h++)); do
			((yy = $y +$h))
			[ $(($yy)) -gt 24 ] && break
			for ((x = 2;  x < 80; x += $CSminiW)); do
				GOTO $yy $x
				echo -en "${CSmini[$h]}"
			done
		done
	done
}

#+============================================================================= ========================================
# Plot a single character on the screen
# Colour according to position & character
#
CSdrawPlot() {  # (x, y, chr)
	[ $1 -eq 99 ] && goto= || goto="\033[$1;$2H"
#	if [ $1 -ge 6 ] && [ $1 -le 9 ] && [ $2 -ge 9 ] && [ $2 -le 14 ]; then  # BC
	if [[ ($1 -ge 5) && ($1 -le 8) && ($2 -ge 73) && ($2 -le 78) ]]; then  # BC
		case $3 in
			"_" )  echo -en "${goto}${atPFX}${atBLD};${fgYEL};${bgBLK}${atSFX}$3"  ;;
			"―" )  echo -en "${goto}${atPFX}${atBLD};${atUSC};${fgYEL};${bgBLK}${atSFX}$3"  ;;
			*   )  echo -en "${goto}${atPFX}${fgBLU};${bgBLK}${atSFX}$3" ;;
		esac

	else  # CS
		case $3 in
			"▀"     )  echo -en "${goto}${atPFX}${fgCYN};${bgBLK}${atSFX}$3"  ;;  # up
			"█"     )  echo -en "${goto}${atPFX}${fgCYN};${bgBLK}${atSFX}$3"  ;;  # full
			"▄"     )  echo -en "${goto}${atPFX}${atBLD};${fgCYN};${bgBLK}${atSFX}$3"  ;;  # down

			"░"     )  echo -en "${goto}${atPFX}${fgCYN};${bgBLK}${atSFX}$3"  ;;  # dark
			"▒"     )  echo -en "${goto}${atPFX}${fgCYN};${bgBLK}${atSFX}$3"  ;;  # med
			"▓"     )  echo -en "${goto}${atPFX}${fgCYN};${bgBLK}${atSFX}$3"  ;;  # light
			[▲▼]    )  echo -en "${goto}${atPFX}${fgCYN};${bgBLK}${atSFX}$3"  ;;  # light

			[0-9]   )  echo -en "${goto}${atPFX}${fgBLU};${bgBLK}${atSFX}$3"  ;;

			[A-Z\-] )  echo -en "${goto}${atPFX}${atBLD};${fgYEL};${bgRED}${atSFX}$3"  ;;
			[#]     )  echo -en "${goto}${atPFX}${atBLD};${fgYEL};${bgRED}${atSFX} "   ;;

			" "     )  echo -en "${goto}${atOFF}$3" ;;
			*       )  echo -en "${goto}${atOFF}" ;;
		esac
	fi
}

#+============================================================================= ========================================
# Draw an full ANSI letter
#
CSdrawChar() {  # (y, x, speed)
	local bry=$(($1 +12))
	local brx=$(($2 + 9))
	local spd=$3

	local x=
	local y=
	for ((y = $1;  y < $bry;  y++)); do
		for ((x = $2;  x < $brx;  x++)); do
			CSdrawPlot $y $x ${CS[$y]:$x:1}
			sleep $spd
		done
	done
}

#+============================================================================= ========================================
# Draw a tetromino at the given coords (full screen)
#
#	CSdrawTet() {  # (y, x, tet$, colour)
#		local ty=$1
#		local tx=$2
#		local tet=$3
#		local clr=$4
#	
#		for ((h = 0;  h < $tetH;  h++)); do
#			local y=$(($ty +$h))
#			for ((w = 0;  w < $tetW;  w++)); do
#				local x=$(($tx + $w*2))
#				local z=$(($h*$tetW +$w))
#				[ ${tet:$z:1} == "#" ]  &&  echo -en ${clr}"\033[${y};${x}H"${tetGR}
#			done
#		done
#	}

#+============================================================================= ========================================
# Un-Draw a tetromino at the given coords (restore logo)
#
#	CSundrawTet() {  # (y, x, tet$)
#		for ((h = 0;  h < $tetH;  h++)); do
#			local y=$(($1 +$h))
#			for ((w = 0;  w < $tetW;  w++)); do
#				local z=$(($h*$tetW +$w))
#				local tet=$3
#				[ ${tet:$z:1} == "#" ]  &&  {
#					((x = $2 + $w*2))
#					CSdrawPlot $y $x "${CS[$y]:$x:1}"  # undraw
#					((x++))
#					CSdrawPlot $y $x "${CS[$y]:$x:1}"  # undraw
#				}
#			done
#		done
#	}

#+============================================================================= ========================================
# Draw the big C, downwards
#
CSdrawCdown() {  # (spd)
	local spd=$1
	for ((y = 5;  y >=  2;  y--)); do
		for ((x = 17;  x <= 19;  x++)); do     CSdrawPlot $y $x ${CS[$y]:$x:1} ; done ; sleep $spd
	done
	y=1   ; for ((x = 18;  x >= 2;  x--)); do  CSdrawPlot $y $x ${CS[$y]:$x:1} ; sleep $spd ; done
	for ((y = 2;  y <=  23;  y++)); do
		for ((x = 1;  x <=  3;  x++)); do      CSdrawPlot $y $x ${CS[$y]:$x:1} ; done ; sleep $spd
	done
	y=24 ; for ((x =  1;  x <=  8;  x++)); do  CSdrawPlot $y $x ${CS[$y]:$x:1} ; sleep $spd ; done
	x=9  ; for ((y = 24;  y >= 21;  y--)); do  CSdrawPlot $y $x ${CS[$y]:$x:1} ; sleep $spd ; done
}

#+=============================================================================
# Draw the first C, upwards
#
#	CSdrawCup() {  # (spd)
#		local spd=$1
#		x=9  ; for ((y = 21;  y <= 24;  y++)); do  CSdrawPlot $y $x ${CS[$y]:$x:1} ; sleep $spd ; done
#		y=24 ; for ((x =  8;  x >=  1;  x--)); do  CSdrawPlot $y $x ${CS[$y]:$x:1} ; sleep $spd ; done
#		for ((y = 23;  y >=  2;  y--)); do
#			for ((x = 1;  x <=  3;  x++)); do      CSdrawPlot $y $x ${CS[$y]:$x:1} ; done ; sleep $spd
#		done
#		y=1  ; for ((x =  2;  x <= 18;  x++)); do  CSdrawPlot $y $x ${CS[$y]:$x:1} ; sleep $spd ; done
#		for ((y = 2;  y <=  5;  y++)); do
#			for ((x = 17;  x <= 19;  x++)); do     CSdrawPlot $y $x ${CS[$y]:$x:1} ; done ; sleep $spd
#		done
#	}

#+============================================================================= ========================================
# Draw the first S, downwards
#
CSdrawSdown() {  # (spd)
	local spd=$1
	for ((y = 17;  y >= 14;  y--)); do
		for ((x = 17;  x <= 19;  x++)); do      CSdrawPlot $y $x ${CS[$y]:$x:1} ; done ; sleep $spd
	done
	y=13 ; for ((x = 18;  x >=  12;  x--)); do  CSdrawPlot $y $x ${CS[$y]:$x:1} ; sleep $spd ; done
	for ((y = 14;  y <= 18;  y++)); do
		for ((x = 11;  x <= 13;  x++)); do      CSdrawPlot $y $x ${CS[$y]:$x:1} ; done ; sleep $spd
	done
	for ((x = 13;  x <= 19;  x++)); do
		for ((y = 18;  y <= 19;  y++)); do      CSdrawPlot $y $x ${CS[$y]:$x:1} ; done ; sleep $spd
	done
	for ((y = 19;  y <= 23;  y++)); do
		for ((x = 17;  x <= 19;  x++)); do      CSdrawPlot $y $x ${CS[$y]:$x:1} ; done ; sleep $spd
	done
	y=24 ; for ((x = 18;  x >=  12;  x--)); do  CSdrawPlot $y $x ${CS[$y]:$x:1} ; sleep $spd ; done
	for ((y = 23;  y >= 20;  y--)); do
		for ((x = 11;  x <= 13;  x++)); do      CSdrawPlot $y $x ${CS[$y]:$x:1} ; done ; sleep $spd
	done
}

#+=============================================================================
# Draw the first S, upwards
#
#	CSdrawSup() {  # (spd)
#		local spd=$1
#		for ((y = 20;  y <= 23;  y++)); do
#			for ((x = 11;  x <= 13;  x++)); do      CSdrawPlot $y $x ${CS[$y]:$x:1} ; done ; sleep $spd
#		done
#		y=24 ; for ((x = 12;  x <=  18;  x++)); do  CSdrawPlot $y $x ${CS[$y]:$x:1} ; sleep $spd ; done
#		for ((y = 23;  y >= 19;  y--)); do
#			for ((x = 17;  x <= 19;  x++)); do      CSdrawPlot $y $x ${CS[$y]:$x:1} ; done ; sleep $spd
#		done
#		for ((x = 19;  x >= 13;  x--)); do
#			for ((y = 19;  y >= 18;  y--)); do      CSdrawPlot $y $x ${CS[$y]:$x:1} ; done ; sleep $spd
#		done
#		for ((y = 18;  y >= 14;  y--)); do
#			for ((x = 11;  x <= 13;  x++)); do      CSdrawPlot $y $x ${CS[$y]:$x:1} ; done ; sleep $spd
#		done
#		y=13 ; for ((x = 12;  x <=  18;  x++)); do  CSdrawPlot $y $x ${CS[$y]:$x:1} ; sleep $spd ; done
#		for ((y = 14;  y <= 17;  y++)); do
#			for ((x = 17;  x <= 19;  x++)); do      CSdrawPlot $y $x ${CS[$y]:$x:1} ; done ; sleep $spd
#		done
#	}

#+============================================================================= ========================================
# EFFECT: Lightning effect on the shading characters
#
CSfxFlash() {
	for ((i = 1;  i <= 6;  i++)); do
		(($i & 1)) && fg="${atBLD};${fgCYN}" || fg="${fgBLU}"
		(($i & 1)) && fgn="${atBLD};${fgWHT}" || fgn="${fgBLU}"
		for ((y = 2;  y <= 22;  y++)); do
			for ((x = 2;  x <= 78;  x++)); do
				local chr=${CS[$y]:$x:1}
				case $chr in
					"░"|"▒"|"▓"|"▲"|"▼" )
						echo -en "\033[${y};${x}H${atPFX}${fg};${bgBLK}${atSFX}$chr"
						;;
					[0-9] )
						echo -en "\033[${y};${x}H${atPFX}${fgn};${bgBLK}${atSFX}$chr"
						;;
				esac;
			done
		done
		[ $i -eq  2 ] && sleep 0.5
	done
}

#+============================================================================= ========================================
# EFFECT: Interlace effect on the whole logo
#
CSfxIlace() {
	for ((i = 1;  i <= 3;  i++)); do
		for ((y = 1;  y <= $((24 -$i));  y += 3)); do

			yy=$(($y +$i -1))
			for ((x = 1;  x <= 79;  x++)); do  CSdrawPlot $yy $x "${CS[$yy]:$x:1}" ; done
			echo -en "\033[${yy};${x}H "

			yy=$(($y +$i))
			echo -en "\033[${yy};1H "
			for ((x = 1;  x <= 79;  x++)); do  CSdrawPlot $yy $(($x +1)) "${CS[$yy]:$x:1}" ; done
		done
	done

	for ((yy = $i;  yy <= 23;  yy += 3)); do
		for ((x = 1;  x <= 80;  x++)); do      CSdrawPlot $yy $x "${CS[$yy]:$x:1}" ; done
		echo -en "\033[${yy};${x}H "
	done
	for ((x = 1;  x <= 80;  x++)); do          CSdrawPlot 24 $x "${CS[24]:$x:1}" ; done
	CSdrawPlot 23 1 "${CS[23]:1:1}" # WHY?!
}

#+============================================================================= ========================================
# EFFECT: WIPE - erase
#
CSwipeUnplot() {  # (y, x)
	[ $1 -lt  1 ] || [ $1 -gt 25 ] || [ $2 -lt  1 ] || [ $2 -gt 80 ] && return
	[ $2 -lt 79 ] && ch="   " || ch="  "
	echo -en "${atOFF}\033[${1};${2}H${ch}"
}

#+=============================================================================
# EFFECT: WIPE - redraw
#
CSwipeReplot() {  # (y, x)
	[ $1 -lt  1 ] || [ $1 -gt 25 ] || [ $2 -lt  1 ] || [ $2 -gt 80 ] && return
	[ $2 -lt 79 ] && c=3 || c=2
	for ((i = 0;  i < $c;  i++)); do
		local x=$(($2 +$i))
		CSdrawPlot $1 $x "${CS[$1]:$x:1}"
	done
}

#+=============================================================================
# EFFECT: WIPE - redraw with CONTROLLER screen
#
CTRLwipeReplot() {  # (y, x)
	[ $1 -lt  1 ] || [ $1 -gt 25 ] || [ $2 -lt  1 ] || [ $2 -gt 80 ] && return
	[ $2 -lt 79 ] && c=3 || c=2
	for ((i = 0;  i < $c;  i++)); do
		local x=$(($2 +$i))
		CTRLplot $1 $x "${CTRL[$1]:$x:1}"
	done
}

#+=============================================================================
# EFFECT: WIPE - expanding box
#
CSfxWipe() {  # (unplot|replot, spd)
	local w=3
	local y=13  # start seed point
	local x=37  # (N *w) +1
	local sz=1
	while [ $sz -le $((80/$w + 1)) ]; do
		$1 $y $x # seed
		for ((u = 0;  u < $sz;  u++)); do  $1 $((y -= 1)) $x           ; done
		for ((r = 0;  r < $sz;  r++)); do  $1 $y          $((x += $w)) ; done
		((sz++))
		for ((d = 0;  d < $sz;  d++)); do  $1 $((y += 1)) $x           ; done
		for ((l = 1;  l < $sz;  l++)); do  $1 $y          $((x -= $w)) ; done
		((x -= $w)) # next seed point
		((sz++))
		sleep $2
	done
}

#+============================================================================= ========================================
# test harness
#
#	CSdrawTEST() {
#		# draw logo
#		CLS
#		for ((y = 1;  y <= 25;  y++)); do
#			GOTO $y 1
#			echo -en "${CS[$y]:1}"
#		done
#	
#		# overlay tetromino - demo
#		for ((i=1; i<=5; i++)); do
#			CSdrawTet 6 43 ${tetL[0]} ${tetL[4]}
#			sleep 0.5
#			CSundrawTet 6 43 ${tetL[0]}
#			sleep 0.5
#		done
#	
#		# wait key
#		while ! keyGet ; do : ; done
#		[ "$KEY" == "BKSP" ] && Quit 0
#	}

#+============================================================================= ========================================
# This is it!!
#
CSdraw() {
	local y=.
	local x=.

	CLS

	# CS
	CSdrawCdown 0.02 &
	CSdrawSdown 0.03
	wait

	# YBORG
	for ((x = 21;  x < 62;  x += 10)); do
		CSdrawChar 1 $x 0.0001 &
		sleep 0.1
	done
	wait

	# YSTEMS
	for ((x = 21;  x < 72;  x += 10)); do
		CSdrawChar 13 $x 0.0001 &
		sleep 0.1
	done
	wait

	# Chip
	for ((y = 5;  y <= 8;  y++)); do
		for ((x = 73;  x <= 77;  x++)); do
			CSdrawPlot $y $x "${CS[$y]:$x:1}"
		done
	done
	sleep 0.2

	# slogan
	GOTO 25 29
	echo -en "${atPFX}${atBLD};${fgYEL};${bgRED}${atSFX}"
	echo -en "                      "
	for ((x = 29;  x <= 50;  x++)); do
		CSdrawPlot 25 $x "${CS[25]:$x:1}"
		sleep 0.02
	done

	# anykey
	keyFlush
	local anykey=1
	local i=0
	while (($anykey)); do
		[ $i -eq  0 ] && echo -en "\033[24;80H${atPFX}${fgWHT};${bgBLK}${atSFX}■"
		[ $i -eq 10 ] && echo -en "\033[24;80H${atPFX}${fgWHT};${bgBLK}${atSFX}${nbsp}"
		sleep 0.05
		((i++))
		[ $i -ge 14 ] && i=0

		keyGet && break

		# maybe do an animation
		if [ $(($RANDOM & 31)) -eq 0 ]; then
			case $(($RANDOM %4)) in
				[0]  )
					CSfxIlace &
					;;
				[12] )
					CSfxFlash &
					;;
				[3]  )
					CSfxWipe CSwipeUnplot 0.01 &
					CSfxWipe CSwipeReplot 0.01 &
					;;
			esac
		fi
	done
	echo -en "\033[24;80H${atPFX}${fgWHT};${bgBLK}${atSFX}√"
	wait
	echo -en "\033[25;79H${atPFX}${fgWHT};${bgBLK}${atSFX}${nbsp}"

	[ "$KEY" == "BKSP" ] && Quit 0
}

#****************************************************************************** ****************************************
#                               ,---------------.
#                              (  SPLASH SCREEN  )
#                               `---------------'
#****************************************************************************** ****************************************
CTRLbuild() {

	CTRL=()
#        0         1         2         3         4         5        6          7         8
#        012345678901234567890123456789012345678901234567890123456789012345678901234567890
 CTRL+=("                                                                                 ")   # 0
 CTRL+=(" ∙                                                                              ∙")   # 1
 CTRL+=(" ∙    IIIIIIII                                                                  ∙")   # 2
 CTRL+=(" ∙    TT                                  TTTTTT                                ∙")   # 3
 CTRL+=(" ∙    TTTT      JJJJJJ  II                  TT    LLLLLL                        ∙")   # 4
 CTRL+=(" ∙    TTJJJJJJ  II  JJ  II  LL  II          LL    LL    LL  II    II  LLLLLL    ∙")   # 5
 CTRL+=(" ∙    TT    JJ  IILLLL  II  LL  II  JJJJJJ  LL    TTLLLLLL  II  ZZII  LL        ∙")   # 6
 CTRL+=(" ∙    TTTT  LL  II  LL  II  LLLLII  JJ  JJ  LL    TTTT      IIZZZZII  JJ        ∙")   # 7
 CTRL+=(" ∙    TTLLLLLL  II  LL  IIIIIIIIII  JJJJJJ  LLLL  TT        IIZZ  II  JJJJJJ    ∙")   # 8
 CTRL+=(" ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀")   # 9
 CTRL+=("                                                                                 ")   #10
 CTRL+=("         ▐Q▌ ▐Del▌                   ▐◄──▌                                       ")   #11
 CTRL+=("         ▄▄▄▄▄▄▄▄▄                     ┌┴┐                                       ")   #12

if [ $DEBUG -eq 1 ]; then
 CTRL+=(" ▐Ins▌  █▄▄▄▄▄▄▄▄▄███████████████████▄▄▄▄▄████████████████████████████████   ▐0▌ ")   #13
 CTRL+=(" Place  ██         ▐W▌ ▐↑▌             Θ                                ██ NoDrop")   #14
 CTRL+=("        ██        __//▲||__                                   ▐X▌ ▐.▌   ██       ")   #15
 CTRL+=(" ▐End▌  ██       /    ║    \                                   ,--.     ██       ")   #16
 CTRL+=(" Ditch  ██ ▐A▌  /  °  ║  °  \  ▐→▌        ___                 ( @► )    ██       ")   #17
 CTRL+=("        ██     <◄═════╬═════►>           ( ☼ )          ,--.   ¬--'     ██       ")   #18
 CTRL+=(" ▐6▌▐^▌ ██ ▐←▌  \  .  ║  .  /  ▐D▌        ▐P▌          ( ◄@ )           ██       ")   #19
 CTRL+=(" Move↑  ██       \__  ║  __/                            ¬--'            ██       ")   #20
 CTRL+=("        ██          ||▼//                             ▐Z▌ ▐,▌           ██       ")   #21
 CTRL+=(" ▐PgUp▌ ██         ▐S▌ ▐↓▌                                              ██       ")   #22
 CTRL+=(" Lvl-Up ██████████████████████████████████████████████████████████████████       ")   #23

else
 CTRL+=("        █▄▄▄▄▄▄▄▄▄███████████████████▄▄▄▄▄████████████████████████████████       ")   #13
 CTRL+=("        ██         ▐W▌ ▐↑▌             Θ                                ██       ")   #14
 CTRL+=("        ██        __//▲||__                                   ▐X▌ ▐.▌   ██       ")   #15
 CTRL+=("        ██       /    ║    \                                   ,--.     ██       ")   #16
 CTRL+=("        ██ ▐A▌  /  °  ║  °  \  ▐→▌        ___                 ( @► )    ██       ")   #17
 CTRL+=("        ██     <◄═════╬═════►>           ( ☼ )          ,--.   ¬--'     ██       ")   #18
 CTRL+=("        ██ ▐←▌  \  .  ║  .  /  ▐D▌        ▐P▌          ( ◄@ )           ██       ")   #19
 CTRL+=("        ██       \__  ║  __/                            ¬--'            ██       ")   #20
 CTRL+=("        ██          ||▼//                             ▐Z▌ ▐,▌           ██       ")   #21
 CTRL+=("        ██         ▐S▌ ▐↓▌                                              ██       ")   #22
 CTRL+=("        ██████████████████████████████████████████████████████████████████       ")   #23
fi

 CTRL+=("                                                                                 ")   #24
 CTRL+=("                           #-#PUTTING#YOU#IN#CONTROL-#                           ")    #25
#        012345678901234567890123456789012345678901234567890123456789012345678901234567890
#        0         1         2         3         4         5        6          7         8
}

#+============================================================================= ========================================
# Plot a single character on the screen
# Colour according to position & character
#
CTRLplot() {  # (x, y, chr)
	goto="\033[$1;$2H"
	ch=$3
	[ "$ch" == "¬" ] && ch="\`"
	[ "$ch" == "|" ] && ch="\\"
	if [ $1 -le 11 ]; then  # TETRIZ
		case $ch in
			"L"      )  echo -en "${goto}${tetL[4]}${tetGR:0:6}"  ;;
			"J"      )  echo -en "${goto}${tetJ[4]}${tetGR:0:6}"  ;;
			"T"      )  echo -en "${goto}${tetT[4]}${tetGR:0:6}"  ;;
			"O"      )  echo -en "${goto}${tetO[4]}${tetGR:0:6}"  ;;
			"I"      )  echo -en "${goto}${tetI[4]}${tetGR:0:6}"  ;;
			"S"      )  echo -en "${goto}${tetS[4]}${tetGR:0:6}"  ;;
			"Z"      )  echo -en "${goto}${tetZ[4]}${tetGR:0:6}"  ;;
			"∙"      )  echo -en "${goto}${clrGRIDv}$ch"  ;;
			"▀"      )  echo -en "${goto}${clrGRIDh}$ch"  ;;
			" "      )  echo -en "${goto}${clrGRIDb}$ch"  ;;
			[▐▌]     )  echo -en "${goto}${atPFX}${fgBLU};${bgBLK}${atSFX}$ch"  ;;  # key sides
			[QDel◄─] )  echo -en "${goto}${atPFX}${atBLD};${fgYEL};${bgBLU}${atSFX}$ch"  ;;  # keys
			*        )  echo -en "${goto}${atOFF}$ch" ;;
		esac

	elif [ $1 -eq 25 ]; then  # slogan
		case $ch in
			[A-Z\-] )  echo -en "${goto}${atPFX}${atBLD};${fgYEL};${bgRED}${atSFX}$ch"  ;;
			[#]     )  echo -en "${goto}${atPFX}${atBLD};${fgYEL};${bgRED}${atSFX} "   ;;
			" "     )  echo -en "${goto}${atOFF}$ch" ;;
		esac

	else  # controller
		if [[ $DEBUG -eq 1 && ($2 -le 6  || $2 -ge 75) ]]; then  # DEBUG
			case $ch in
				[▐▌]    )  echo -en "${goto}${atPFX}${fgMAG};${bgBLK}${atSFX}$ch"  ;;  # key sides
				" "     )  echo -en "${goto}${atOFF}$ch" ;;
				*       )
					if [ $(($1 %3)) -eq 1 ]; then
						echo -en "${goto}${atPFX}${atBLD};${fgYEL};${bgMAG}${atSFX}$ch"  # keys
					else
						echo -en "${goto}${atPFX}${atBLD};${fgMAG};${bgBLK}${atSFX}$ch"  # text
					fi
					;;
			esac
			return

		elif [[ $1 -eq 15 || $1 -eq 21 ]]; then  # keys
			case $ch in
				"."|",")
					echo -en "${goto}${atPFX}${atBLD};${fgYEL};${bgBLU}${atSFX}$ch"
					return  ;;
			esac

		elif [[ $2 -ge 56 ]]; then  # outlines
			case $ch in
				"."|",")
					echo -en "${goto}${atPFX}${atBLD};${fgYEL};${bgBLK}${atSFX}$ch"
					return  ;;
			esac

		else  # detail
			case $ch in
				"."|",")
					echo -en "${goto}${atPFX}${fgRED};${bgBLK}${atSFX}$ch"
					return  ;;
			esac
		fi

		case $ch in
			[▐▌]    )  echo -en "${goto}${atPFX}${fgBLU};${bgBLK}${atSFX}$ch"  ;;  # key sides
			[▄█]    )  echo -en "${goto}${atPFX}${fgYEL};${bgBLK}${atSFX}$ch"  ;;  # border
			[┌┴┐]   )  echo -en "${goto}${atPFX}${fgWHT};${bgBLK}${atSFX}$ch"  ;;  # switch
			[☼◄▼▲►@])  echo -en "${goto}${atPFX}${atBLD};${fgCYN};${bgBLK}${atSFX}$ch"  ;;  # caps
			[°]     )  echo -en "${goto}${atPFX}${fgRED};${bgBLK}${atSFX}$ch"  ;;  # detail
			[ΦΘ]    )  echo -en "${goto}${atPFX}${atBLD};${fgRED};${bgBLK}${atSFX}$ch"  ;;  # LED
			[═╬║]   )  echo -en "${goto}${atPFX}${fgWHT};${bgBLK}${atSFX}$ch"  ;;  # cross
			[QDELWASDZXP◄─←↓↑→] )
				echo -en "${goto}${atPFX}${atBLD};${fgYEL};${bgBLU}${atSFX}$ch"  ;;  # keys
			"<"|">"|"-"|"_"|"("|")"|"/"|"\`"|"'"|"\\" )
				echo -en "${goto}${atPFX}${atBLD};${fgYEL};${bgBLK}${atSFX}$ch"  ;;  # outlines

			" "     )  echo -en "${goto}${atOFF}$ch" ;;
		esac
	fi
}

#+============================================================================= ========================================
CSdrawBackdropReveal() {
	CSbd=()
	CSbd+=("")
	for ((y = 0;  y < 6;  y++)); do
		CSbd+=(${nbsp})
		CSbd+=(${nbsp})
		CSbd+=(${nbsp})
		CSbd+=(${nbsp})
		for ((x = 1;  x <= 13;  x++)); do
			for ((i = 0;  i < 4;  i++)); do
				CSbd[$(($y*4 +1 +$i))]="${CSbd[$(($y*4 +1 +$i))]}${CSmini[$i]}"
			done
		done
	done
	cnt=${#CSbd[@]}
	for ((i = 0;  i < cnt;  i++)); do
		CSbd[i]="${CSbd[i]}${nbsp}"
	done
	CSbd+=("$(printf "%*s." 80 "")")

	for ((x = 40;  x >= 0;  x--)); do
		if [ $x -gt 0 ]; then
			echo -en "${atPFX}${fgWHT};${bgBLK};${atSFX}"
			for ((y = 1;  y <= 25;  y++)); do
				GOTO $y $x
				echo -en "│"
				GOTO $y $((81 -$x))
				echo -en "│"
			done
		fi
		if [ $x -lt 40 ]; then
			echo -en ${CSminiClr}
			for ((y = 1; y <= 25;  y++)); do
				GOTO $y $(($x +1))
				echo -en "${CSbd[$y]:$(($x +1 -1)):1}"
				GOTO $y $((80 -$x))
				echo -en "${CSbd[$y]:$((80 -$x -1)):1}"
			done
		fi
		[[ -z $1 ]] && sleep 0.01
	done
}

#+============================================================================= ========================================
Help() {
	CTRLbuild

	for ((y = 1;  y <= 26;  y++)); do
		if [ $y -le 25 ]; then
			GOTO $y 1
			echo -en "${atOFF}────────────────────────────────────────────────────────────────────────────────"
		fi
		((yy = $y -1))
		if [ $yy -ge 1 ]; then
			for ((x = 1;  x <= 80;  x++)); do
				CTRLplot $yy $x "${CTRL[$yy]:$x:1}"
			done
		fi
		sleep 0.01
	done

	# anykey
	keyFlush
	local anykey=1
	local i=0
	while (($anykey)); do
		[ $i -eq  0 ] && echo -en "\033[19;43H${atPFX}${atBLD};${fgYEL};${bgBLU}${atSFX}P"  # ■"
		[ $i -eq 10 ] && echo -en "\033[19;43H${atPFX}${atBLD};${fgYEL};${bgBLU}${atSFX}${nbsp}"
		sleep 0.05
		((i++))
		[ $i -ge 14 ] && i=0
		keyGet 
		case $KEY in
			[pP] )  break ;;
			BKSP )  Quit 0 ;;
		esac
	done
}

#+============================================================================= ========================================
required() {
	echo "Required terminal settings:"
	echo "  # Terminal size: {80 x 25} (24 + 1 status line)"
	echo ""
	echo "Play with PuTTY over SSH:"
	echo "  # Font         : Courier New"
	echo "    PuTTY -> Settings -> Window -> Appearance -> Font -> Change = Courier New"
	echo "  # Character Set: UTF-8"
	echo "    PuTTY -> Settings -> Window -> Translation -> Remote Charset = UTF-8"
	echo ""
	echo "Kali terminal window looks good with: [File->Preferences]"
	echo "  # Font         : Bitstream Vera Sans Mono"
	echo "  # Colour Scheme: Linux"
	echo ""
	echo "Windows Subsytem Linux (WSL)"
	echo "  # Font        : Courier New"
	echo "  # Command line: $0 -k1"
	echo ""
}

#+============================================================================= ========================================
checkSys() {
	local sz=($(stty size))
	SCRH=${sz[0]}
	SCRW=${sz[1]}
	
	local missing=()
	! which which >/dev/null 2>&1 && missing+=("which") || {
		! which stty >/dev/null 2>&1 && missing+=("stty")  # keyboard driver
		! which tput >/dev/null 2>&1 && missing+=("tput")  # keyboard driver
		! which grep >/dev/null 2>&1 && missing+=("grep")  # sprites/hi-score/rigging
		! which sed  >/dev/null 2>&1 && missing+=("sed")   # sprites/hi-score/rigging/timing
		! which date >/dev/null 2>&1 && missing+=("date")  # Timing
	}
	
	if [[ ${#missing[@]} -gt 0 ]]; then
		echo "You need to install the following utils to play $NAME"
		for (( i = 0;  i < ${#missing[@]};  i++)); do
			echo "  # ${missing[$i]}"
		done
		exit 91
	fi

	CMD=$(which $0)

	if [[ $SCRW -lt 80 || $SCRH -lt 25 ]]; then
		echo "! Terminal too small: {$SCRW x $SCRH}"
		echo ""
		required
		exit 92
		
	elif [[ $SCRW -gt 80 || $SCRH -gt 25 ]]; then
		echo "? Oversized window: {$SCRW x $SCRH}"
		echo ""
		required
		echo ""
		echo "$NAME will run in the top-left of this window,"
		echo "Do NOT report bugs found in this mode!"
		echo 'Press ` to redraw the playfield during play'
		echo ""
		echo "Press <return> to play or ^C to abort"
		
		read
	fi
}

#+============================================================================= ========================================
Intro() {
	CLS

	CSdraw

	Help

	# wipe to game backdrop
	for ((x = 1;  x <= 40;  x++)); do
		echo -en "${atPFX}${fgWHT};${bgBLK};${atSFX}"
		for ((y = 1;  y <= 25;  y++)); do
			GOTO $y $x
			echo -en "│"
			GOTO $y $((81 -$x))
			echo -en "│"
		done
		if [ $x -gt 0 ]; then
			echo -en ${CSminiClr}
			for ((y = 1; y <= 25;  y++)); do
				GOTO $y $(($x -1))
				echo -en " "
				GOTO $y $((81 -$x))
				echo -en " "
			done
		fi
		sleep 0.01
	done

#	CSdrawBackdropReveal
}

#****************************************************************************** ****************************************
#                            ,------------------.
#                           (  SYSTEM FUNCTIONS  )
#                            `------------------'
#****************************************************************************** ****************************************

#+============================================================================= ========================================
# Move cursor to specified coords
#
# These are SCREEN (not graph) coords, so they index from the top-left = {1,1}
# ...and therefore coords a given as {line, column}, ie. {y, x}
#
GOTO() {  # (y, x)
	echo -en "\033[$1;$2H"
}

#+=============================================================================
# Move cursor home
#
HOME() {
	GOTO 1 1
}

#+=============================================================================
# CLS
#
CLS() {
	echo -en "\033[2J"
	HOME
}

#+============================================================================= ========================================
# strstr - return true or false
#
strstr() {  # (haystack, needle) -> t/f
	[ "${1#*$2*}" == "$1" ] && return 1
	return 0
}

#****************************************************************************** ****************************************
#                             ,--------------.
#                            (  GAME COLOURS  )
#                             `--------------'
#****************************************************************************** ****************************************

clrGRIDv="${atPFX}${fgWHT};${bgBLU}${atSFX}"             # main grid box (vert)
clrGRIDh="${atPFX}${fgBLU};${bgBLK}${atSFX}"             # main grid box (horz)
clrGRIDb="${atPFX}${fgBLK};${bgBLK}${atSFX}"             # main grid box (body)

clrSH="${atPFX}${atBLD};${fgBLU};${bgBLK}${atSFX}"       # shoulder box
clrSHjoin="${atPFX}${atBLD};${fgBLU};${bgBLK}${atSFX}"   # join shoulder to grid

clrBS="${atPFX}${atBLD};${fgBLU};${bgBLK}${atSFX}"       # basket box
clrBSjoin="${atPFX}${atBLD};${fgBLU};${bgBLK}${atSFX}"   # join basket to grid

clrMT="${atPFX}${fgWHT};${bgBLK}${atSFX}"                # mini-tet box
clrMTscore="${atPFX}${atBLD};${fgWHT};${bgBLK}${atSFX}"  # ...

clrFgX="${fgBLK}"                                      # primary colour
clrFgO="${fgWHT}"
clrFgI="${fgCYN}"
clrFgT="${fgYEL}"
clrFgL="${fgMAG}"
clrFgJ="${fgRED}"
clrFgS="${fgGRN}"
clrFgZ="${fgBLU}"

clrX="${atPFX};${clrFgX};${bgBLK}${atSFX}"                # tet: none
clrI="${atPFX}${atBLD};${clrFgI};${bgBLK}${atSFX}"        # tet: I
clrO="${atPFX}${atBLD};${clrFgO};${bgBLK}${atSFX}"        # tet: O
clrT="${atPFX}${atBLD};${clrFgT};${bgBLK}${atSFX}"        # tet: T
clrL="${atPFX}${atBLD};${clrFgL};${bgBLK}${atSFX}"        # tet: L
clrJ="${atPFX}${atBLD};${clrFgJ};${bgBLK}${atSFX}"        # tet: J
clrS="${atPFX}${atBLD};${clrFgS};${bgBLK}${atSFX}"        # tet: S
clrZ="${atPFX}${atBLD};${clrFgZ};${bgBLK}${atSFX}"        # tet: Z

clrBm="${atPFX}${clrFgX};${bgBLK}${atSFX}"                # mini-tet: Blank
clrIm="${atPFX}${clrFgI};${bgBLK}${atSFX}"                # mini-tet: I
clrOm="${atPFX}${clrFgO};${bgBLK}${atSFX}"                # mini-tet: O
clrTm="${atPFX}${clrFgT};${bgBLK}${atSFX}"                # mini-tet: T
clrLm="${atPFX}${clrFgL};${bgBLK}${atSFX}"                # mini-tet: L
clrJm="${atPFX}${clrFgJ};${bgBLK}${atSFX}"                # mini-tet: J
clrSm="${atPFX}${clrFgS};${bgBLK}${atSFX}"                # mini-tet: S
clrZm="${atPFX}${clrFgZ};${bgBLK}${atSFX}"                # mini-tet: Z

clrFgV="${fgWHT}"
clrFgG="${fgYEL}"

clrCBsilv="${atPFX}${atBLD};${clrFgV};${bgBLK}${atSFX}"           # ..silver
clrCBgold="${atPFX}${atBLD};${clrFgG};${bgBLK}${atSFX}"           # ..gold

clrCBbox="${atPFX}${fgBLU};${bgBLK}${atSFX}"                      # combo box
clrCBsep="${atPFX}${fgBLU};${bgWHT}${atSFX}"                      # ..separator
clrCBv="${atPFX}${fgBLK};${bgWHT}${atSFX}"                        # ..value


clrSCbox="${atPFX}${fgWHT};${bgBLK}${atSFX}"             # score box

clrSCOREbg=${bgBLU}                                               # Score
clrSCOREh="${atPFX}${atBLD};${fgWHT};${clrSCOREbg}${atSFX}"       # ..heading
clrSCOREv="${atPFX}${fgBLK};${bgWHT}${atSFX}"                     # ..value

clrMULTbg=${bgMAG}                                                # Multiplier
clrMULTh="${atPFX}${atBLD};${fgWHT};${clrMULTbg}${atSFX}"         # ..heading
clrMULTv="${clrSCOREv}"                                           # ..value

clrLINESbg=${bgRED}                                               # Lines
clrLINESh="${atPFX}${atBLD};${fgWHT};${clrLINESbg}${atSFX}"       # ..heading
clrLINESv="${clrSCOREv}"                                          # ..value

clrTIME="${atPFX}${atBLD};${fgGRN};${bgBLK}${atSFX}"              # Time
clrTIMEs="${atPFX}${fgBLU};${bgBLK}${atSFX}"                      # ..sidebars

clrLVLbg=${bgMAG}                                                 # Level
clrLVLh="${atPFX}${atBLD};${fgWHT};${clrLVLbg}${atSFX}"           # ..heading
clrLVLv="${clrSCOREv}"                                            # ..value

clrLASTbg=${bgRED}                                                # Last tet
clrLASTh="${atPFX}${atBLD};${fgWHT};${clrLASTbg}${atSFX}"         # ..heading
clrLASTv="${clrSCOREv}"                                           # ..value

clrBESTbg=${bgGRN}                                                # best tet
clrBESTh="${atPFX}${atBLD};${fgWHT};${clrBESTbg}${atSFX}"         # ..heading
clrBESTv="${clrSCOREv}"                                           # ..value

clrScoreMult="${atPFX}${clrSCOREbg};$(($clrMULTbg -10))${atSFX}"  # div: score-mult
clrMultLast="${atPFX}${clrMULTbg};$(($clrLASTbg -10))${atSFX}"    # div: mult-last
clrLastBest="${atPFX}${clrLASTbg};$(($clrBESTbg -10))${atSFX}"    # div: last-best
clrBestEnd="${atPFX}${clrBESTbg};${fgBLK}${atSFX}"                # div: best-none

clrEndLines="${atPFX}${bgBLK};$(($clrLINESbg -10))${atSFX}"       # div: start-lines
clrLinesLvl="${atPFX}${clrLINESbg};$(($clrLVLbg -10))${atSFX}"    # div: lines-level
clrLvlEnd="${atPFX}${clrLVLbg};${fgBLK}${atSFX}"                  # div: level-none

clrSTATUS="${atPFX}${fgCYN};${bgBLK}${atSFX}"

clrNAME="${atPFX}${fgBLK};${bgWHT}${atSFX}"
clrNAMEc="${atPFX}${atREV};${fgBLK};${bgWHT}${atSFX}"

keyLR="${atPFX}${fgBLU};${bgBLK}${atSFX}"
keyL="${keyLR}▐${atPFX}${atBLD};${fgYEL};${bgBLU}${atSFX}"
keyR="${keyLR}▌${clrSTATUS}"


#****************************************************************************** ****************************************
#                         ,-----------------.
#                        (  KEYBOARD DRIVER  )
#                         `-----------------'
#****************************************************************************** ****************************************

#+=============================================================================
keyStop() {
#	echo "Stop keyboard driver"
#	stty sane            # Set terminal to "sane" settings
	stty ${KeyStty}      # Restore original terminal settings (may fail)
#	tput cnorm           # Make the cursor visible
	KEY=
	KeyQ=
	KeyRun=0
}

#+=============================================================================
keyStart() {  # (ctrlC_Handler)
	KeyEOK=[a-zA-NP-Z~^\$@\e]  # why no O ???  <- answer: Kali!
	
	KEY=
	KeyQ=

	trap $1 INT          # We need to tidy up as we exit

	KeyStty=$(stty -g)   # Save our current terminal settings

#	tput civis           # Hide the cursor

	# change terminal settings
	# -echo  : do not echo typed characters to the screen
	# -icanon: do not wait for a CR
	# min    : minimum number of characters per 'read'
	# time   : time-out if no new characters received within N/10 seconds

	if [[ "$KEYDRV" == "v2" ]] ; then
		stty -echo -icanon min 0 time 0  # Change our terminal settings
		# ...you may want to disassociate ^Q, ^S, ^C, ^Z, etc. - see `stty -a`
		#	stty intr  ^-  quit  ^-  erase  ^-  kill  ^-  eof     ^- \
		#	     eol   ^-  eol2  ^-  swtch  ^-  start ^-  stop    ^- \
		#		 susp  ^-  rprnt ^-  werase ^-  lnext ^-  discard ^- 
		# ...good luck killing the program ;)
	else # v1
		stty -echo
	fi
	
	KeyRun=1
}

#+=============================================================================
keyXlat() {
	printf -v x "%02X" "'$KEY"
	case $x in
		# we never see either of these values‽ :(
		0A )  KEY=LF ;;
		0D )  KEY=CR ;;
		# couple of special cases
		7F )  KEY=BKSP ;;
		1B )  KEY=ESC ;;
		09 )  KEY=TAB ;;
		*  )
			printf -v x "%d" "'$KEY"
			if [[ ($x -ge 0) && ($x -le 31) ]]; then
				# If you need {^Q, ^S, ^C, ^Z, ^D, etc.},
				#   you will need to unbind them with stty [see keyStart()]
				printf -v x "%02X" $((x|=64))
				KEY=$(echo -en "^\x${x}")
				[[ "$KEY" == "^H" ]] && KEY=BKSP  # Kali
			fi ;;
	esac
}

#+=============================================================================
keyXlatEsc() {
#GOTO 1 1 		
#printf "%c%c%c  " "${KEY:1:1}" "${KEY:2:1}" "${KEY:3:1}"

	case $KEY in
		$'\033'[A   )  KEY=UP    ;;
		$'\033'[B   )  KEY=DOWN  ;;
		$'\033'[C   )  KEY=RIGHT ;;
		$'\033'[D   )  KEY=LEFT  ;;

		$'\033'[11~ )  KEY=F1    ;;
		$'\033'[12~ )  KEY=F2    ;;
		$'\033'[13~ )  KEY=F3    ;;
		$'\033'[14~ )  KEY=F4    ;;

		$'\033'[OP )  KEY=F1    ;;  # kali
		$'\033'[OQ )  KEY=F2    ;;  # kali
		$'\033'[OR )  KEY=F3    ;;  # kali
		$'\033'[OS )  KEY=F4    ;;  # kali

		$'\033'[15~ )  KEY=F5    ;;
		$'\033'[17~ )  KEY=F6    ;;
		$'\033'[18~ )  KEY=F7    ;;
		$'\033'[19~ )  KEY=F8    ;;
		$'\033'[20~ )  KEY=F9    ;;
		$'\033'[21~ )  KEY=F10   ;;
		$'\033'[23~ )  KEY=F11   ;;
		$'\033'[24~ )  KEY=F12   ;;
		 
		$'\033'[1~  )  KEY=HOME  ;;
		$'\033'[H   )  KEY=HOME  ;;  # kali
		
		$'\033'[4~  )  KEY=END   ;;
		$'\033'[F   )  KEY=END   ;;  # kali
		
		$'\033'[5~  )  KEY=PGUP  ;;
		$'\033'[6~  )  KEY=PGDN  ;;
		$'\033'[2~  )  KEY=INS   ;;

		$'\033'[3~  )  KEY=DEL   ;;
		$'\033'[3   )  KEY=DEL   ;; # i have no idea why this has started happening!?

		## Add more keys here

		*) ;;
	esac
#	[ -n "$1" ] && eval "$2=\$KEY"  # store the result in the specified variable
}

#+=============================================================================
keyFlush() {
	if [[ "$KEYDRV" == "v2" ]] ; then
		IFS= read -r
	else # v1
		IFS= read -r -d '' -t0.01
	fi

	KEY=
	KeyQ=
}

#+=============================================================================
keyGet() {
	KEY=

	if [[ "$KEYDRV" == "v2" ]] ; then
		IFS= read -r
		KeyQ="${KeyQ}${REPLY}"
	else # v1
		local esc=0
		while true ; do
			IFS= read -r -s -n1 -d '' -t0.05  # -s doesn't seem to work - stackoverflow suggests this is common
			[ $? -ne 0 ] && break
			KeyQ="${KeyQ}${REPLY}"
			if [[ $esc -eq 0 ]]; then
				[[ ${REPLY} == $'\033' ]] && esc=1 || break
			else  # esc=1
				case ${REPLY} in
					${KeyEOK} )  break  ;;  # the for loop	
				esac
			fi
		done
	fi

	local buflen=${#KeyQ}
	
	case ${buflen} in
		0)	return 1  ;;  # error 1 - no keys found
		1)	KEY="${KeyQ}"
			KeyQ=
			keyXlat
			return 0  ;;  # error=0K
	esac

	if [[ ${KeyQ:0:1} == $'\033' ]]; then
		local i=
		for (( i = 1;  i < ${buflen};  i++ )); do
			case ${KeyQ:$i:1} in
				${KeyEOK} )  break  ;;  # the for loop
			esac
		done
		[[ $i == ${buflen} ]] && return 2  # error 2 - unterminated escape sequence
		
		KEY=${KeyQ:0:$((++i))}
		KeyQ=${KeyQ:$i}
		keyXlatEsc
	else
		KEY="${KeyQ:0:1}"
		KeyQ="${KeyQ:1}"
		keyXlat
	fi

	return 0
}

#****************************************************************************** ****************************************
#                             ,----------------.
#                            (  CTRL-C HANDLER  )
#                             `----------------'
#****************************************************************************** ****************************************

#+============================================================================= ========================================
# Force the user to exit cleanly so we can restore the TTY settings
#
ctrlC_init() {
	[[ ! -z $1 ]] && trap $1 INT
}

#+============================================================================= ========================================
ctrlC_quit() {
	STATUS="Press ◄▬▬ to quit"
	return
}

#+============================================================================= ========================================
ctrlC_pipe() {
	rm $DBGpipe
	echo -e "\nExiting cleanly"
	return
}

#****************************************************************************** ****************************************
#                            ,---------------.
#                           (  GAME GRAPHICS  )
#                            `---------------'
#****************************************************************************** ****************************************

# box (shoulder) ===
shTL="╔"
shT="═"
shTR="╗"
shL="║"
shR="║"
shBL="╚"
shB="═"
shBR="╝"

# joints (shoulder) [outward]
shJR="╠"
shJH="═"
shJB="╤"

# sign jl
snST="⌡"
snSB="⌠"

# box (score) ---
scTL="┌"
scT="─"
scTR="┐"
scL="│"
scR="│"
scBL="└"
scB="─"
scBR="┘"

scDIV="▀"

# joints (score)
scJT="┴" #[outward]
scJL="├" #[inward]
scJR="┤" #[inward]

# box (mini tet) ---
mtTL=${scTL}
mtT=${scT}
mtTR=${scTR}
mtL=${scL}
mtR=${scR}
mtBL=${scBL}
mtB=${scB}
mtBR=${scBR}

mtDIV1="-"
mtDIV2="="
mtJL="├" #[inward]
mtJR="┤" #[inward]

# joints (mtet)
mtJL=${mtJL} #[inward]
mtJR=${mtJR} #[inward]

# box (grid) ###
grL="∙"
grR="∙"
grB="▀"
grBL="▀"
grBR="▀"

# box (basket) ###
bsL="█"
bsR="█"
bsB="▀"
bsBL="▀"
bsBR="▀"

# joints (basket)
bsJH="═"
bsJT="╤"
bsJTR="╕"

# tetromino
tetGR="▒▒"   # normal block
tetGRc="▓▓"  # combo block
tetGRs="░░"  # shadow block

# combo blocks
cmGR="▓▓"
cmGOLD='*'
cmSILV='+'

#****************************************************************************** ****************************************
#                           ,-----------------.
#                          (  PLAYFIELD SETUP  )
#                           `-----------------'
#****************************************************************************** ****************************************

#+============================================================================= ========================================
# Initialise most/all of the game logic
#
PFinit() {
	PFy=4
	PFx=20

	PFd=$((4*4 +2))          # depth of game grid (number of playable lines)
	PFw=$((0    +10   +0 ))  #             left, grid, right
	PFh=$((1 +1 +$PFd +1 ))  # invisible, empty, grid, base

	PSy=5  # offset from PFy
	PSx=3  # offset from PFx
	PSw=15
	PSh=3

	SHh=6
	SHw=12
	SHy=$(($PFy -1))
	SHx=$(($PFx -$SHw -3))

	SCh=9
	SCw=14
	SCy=$(($SHy +$SHh +2))
	SCx=$(($SHx -1))

#	TMy=$(($SCy +$SCh +2))
#	TMx=$(($SCx +2))
	TMy=25
	TMx=71

	BSh=13
	BSw=12
	BSy=$(($PFy))
	BSx=$(($PFx + $PFw*2 +2 +3))

	LVLy=$(($BSy +BSh))
	LVLx=$(($BSx -1))
	LVLh=4
	LVLw=$(($SCw))

	MTh=17
	MTw=12
	MTy=$(($BSy -1))
	MTx=$(($BSx + $BSw +5))

	CBy=$(($MTy +$MTh))
	CBx=$(($MTx -1))

 	PF=()

	EMPTY=
	printf -v EMPTY "%02X" "${gridPl}"
	for ((i = 0;  i < $PFw;  i++)); do
		printf -v EMPTY "%s%02X" "$EMPTY" "$tetiB"
	done
	printf -v EMPTY  "%s%02X" "$EMPTY" "${gridPr}"
	for ((i = 1; i < $PFh; i++)); do  # not base
		PF+=("$EMPTY")
	done

	local s=
	printf -v s "%02X" "${gridPbl}"
	for ((i = 0;  i < $PFw;  i++)); do
		printf -v s "%s%02X" "$s" "$gridPb"
	done
	printf -v s  "%s%02X" "$s" "${gridPbr}"
	PF+=("$s")

	# clear all the tetrominoes
	tet0=("${tetB[@]}")
	tet1=("${tetB[@]}")
	tet2=("${tetB[@]}")
	tet3=("${tetB[@]}")
	tet4=("${tetB[@]}")

	# Start position
	tetSty=0
	tetStx=3
	tetStr=0

	# Prime the basket
#	TETadd 0  # 0 = do NOT update stats
#	TETadd 0
#	TETadd 0

	# pick a starting shoulder piece
	RND
	[[ $(($RNDn &1)) -eq 0 ]] && tet4=(${tetT[@]}) || tet4=(${tetI[@]})

	# zero the piece counters
	for i in L J S Z T O I ; do
		eval tet$i[8]=0
	done

	# Initialise score
	score=0
	scoreMul=1  # multiplier
	scoreMulMax=1  # maximum multiplier achieved
	scoreLvl=$LEVEL  # level
	scoreLin=0  # lines
	scoreLast=0 # last line
	scoreBest=0 # best line

	# combo counters
	tetGold=0
	tetSilv=0

	# status bar
	STATUS=   # input here
	STATUSd=  # currently displayed
	statNow=0
	statClear=0
}

#+============================================================================= ========================================
# Draw the main grid
# This WILL also draw all the right colours and graphics for placed tets
#
PFdrawGrid() {  # (slp)
	grb=${grB}${grB}
	for ((y = $((${#PF[@]} -1));  y >= 1;  y--)); do
		(($DEBUG)) && grL=$(($y %10))
		GOTO $(($PFy +$y -1))  $PFx
		echo -en ${clrGRID}
		for ((x = 0;  x < $(($PFw +2));  x++)); do
			(($DEBUG)) && grb=$(($x %10))${grB}
			local ch=$((0x${PF[$y]:$(($x *2)):2}))
			case $ch in
				"${gridPl}"  )  echo -en ${clrGRIDv}${grL}  ; continue ;;
				"${gridPr}"  )  echo -en ${clrGRIDv}${grR}  ; continue ;;
				"${gridPb}"  )  echo -en ${clrGRIDh}${grb}  ; continue ;;
				"${gridPbl}" )  echo -en ${clrGRIDh}${grBL} ; continue ;;
				"${gridPbr}" )  echo -en ${clrGRIDh}${grBR} ; continue ;;
			esac

			gr="${tetGR}"

			printf -v cc "%d" $(($ch & $maskT))
			case $cc in
				"${tetiB}"  )  clr="${tetB[4]}" ; bgc="$((${clrFgB}+10))"  ;;
				"${tetiO}"  )  clr="${tetO[4]}" ; bgc="$((${clrFgO}+10))"  ;;
				"${tetiI}"  )  clr="${tetI[4]}" ; bgc="$((${clrFgI}+10))"  ;;
				"${tetiT}"  )  clr="${tetT[4]}" ; bgc="$((${clrFgT}+10))"  ;;
				"${tetiL}"  )  clr="${tetL[4]}" ; bgc="$((${clrFgL}+10))"  ;;
				"${tetiJ}"  )  clr="${tetJ[4]}" ; bgc="$((${clrFgJ}+10))"  ;;
				"${tetiS}"  )  clr="${tetS[4]}" ; bgc="$((${clrFgS}+10))"  ;;
				"${tetiZ}"  )  clr="${tetZ[4]}" ; bgc="$((${clrFgZ}+10))"  ;;
				
				"${tetiV}"  )  clr="${clrCBsilv}" ; bgc="$((${clrFgV}+10))"  ; gr="${tetGRc}";;
				"${tetiG}"  )  clr="${clrCBgold}" ; bgc="$((${clrFgG}+10))"  ; gr="${tetGRc}";;
				
#				"${tetiVV}" )  clr="${cmSILV}${cmSILV}"  ;;  #!! super-combos!?
#				"${tetiGG}" )  clr="${cmGOLD}${cmGOLD}"  ;;
			esac
			
			if (($DEBUG)); then
				printf -v cc "%d" $(($ch & $maskC))
				case $cc in
					"$maskB"    )  clr="${atPFX};${atBLD};${fgBLK};${bgc}${atSFX}" ; gr="∙∙"  ;;
					"$maskL"    )  clr="${atPFX};${fgBLK};${bgc}${atSFX}" ; gr="═-"  ;;
					"$maskD"    )  clr="${atPFX};${fgBLK};${bgc}${atSFX}" ; gr="╓╖"  ;; 
					"$maskU"    )  clr="${atPFX};${fgBLK};${bgc}${atSFX}" ; gr="╙╜"  ;; 
					"$maskR"    )  clr="${atPFX};${fgBLK};${bgc}${atSFX}" ; gr="-═"  ;; 
					"$maskLD"   )  clr="${atPFX};${fgBLK};${bgc}${atSFX}" ; gr="╦╗"  ;; 
					"$maskLU"   )  clr="${atPFX};${fgBLK};${bgc}${atSFX}" ; gr="╩╝"  ;;
					"$maskLR"   )  clr="${atPFX};${fgBLK};${bgc}${atSFX}" ; gr="══"  ;;
					"$maskDU"   )  clr="${atPFX};${fgBLK};${bgc}${atSFX}" ; gr="║║"  ;;
					"$maskDR"   )  clr="${atPFX};${fgBLK};${bgc}${atSFX}" ; gr="╔╦"  ;;
					"$maskUR"   )  clr="${atPFX};${fgBLK};${bgc}${atSFX}" ; gr="╚╩"  ;;
					"$maskLRU"  )  clr="${atPFX};${fgBLK};${bgc}${atSFX}" ; gr="╩╩"  ;;
					"$maskLRD"  )  clr="${atPFX};${fgBLK};${bgc}${atSFX}" ; gr="╦╦"  ;;
					"$maskUDL"  )  clr="${atPFX};${fgBLK};${bgc}${atSFX}" ; gr="╬╣"  ;;
					"$maskUDR"  )  clr="${atPFX};${fgBLK};${bgc}${atSFX}" ; gr="╠╬"  ;;
					"$maskLDUR" )  clr="${atPFX};${fgBLK};${bgc}${atSFX}" ; gr="╬╬"  ;;
					*) gr=$cc ;;
				esac
			fi
		
			echo -en "${clr}${gr}"
		done
		[ ! -z $1 ] && sleep $1
	done

	(($DEBUG)) && {
		for ((i = 0;  i < $PFh;  i++)); do
			DBGF "PF[%2d]=\"%s\"\n" $i ${PF[$i]}
		done
	}
}

#+============================================================================= ========================================
# Draw shoulder - intro animation
#
PFdrawFromShoulder() {  # (slp, hslp)
	PFdrawShoulder $1 $2
	PFdrawScore $1
}

#+============================================================================= ========================================
# Draw shoulder
#
PFdrawShoulder() {  # (slp, hslp, [joints])
	local hslp=
	[[ ! -z $2 ]] && [[ "$1" != "0" ]] && hslp=$2 #$(echo "scale=6; ${1} / 2" | bc)

	# join shoulder to grid
	for ((x = $(($PFx -1));  x >= $(($PFx -3)); x--)); do
		goto="\033[${PFy};${x}H"
		echo -en "${goto}${clrSH}${shJH}\b\033[2B${shJH}"
		[ ! -z $hslp ] && sleep $1
	done
	goto="\033[${PFy};${x}H"
	echo -en "${goto}${clrSH}${shJR}\b\033[2B${shJR}"

	# right
	goto="\033[$(($SHy +2));$((SHx +SHw -1))H"
	echo -en "${goto}${clrSH}${shR}\b\033[2B${shR}"
	[ ! -z $hslp ] && sleep $1

	goto="\033[${SHy};$((SHx +SHw -1))H"
	echo -en "${goto}${clrSH}${shTR}\b\033[$(($SHh -1))B${shBR}"
	[ ! -z $hslp ] && sleep $1

	# top & bottom
	for ((x = $(($SHx +$SHw -2));  x >= $(($SHx +1)); x--)); do
		goto="\033[${SHy};${x}H"
		echo -en "${goto}${clrSH}${shT}\b\033[$(($SHh -1))B${shB}"
		for ((y = $(($SHy +1));  y < $(($SHy +$SHh -1)); y++)); do
			goto="\033[${y};${x}H"
			echo -en "${goto}${atOFF} "
		done
		[ ! -z $hslp ] && sleep $hslp
	done
	goto="\033[${SHy};${x}H"
	echo -en "${goto}${clrSH}${shTL}\b\033[$(($SHh -1))B${shBL}"

	[[ ! -z $3 ]] && {
		goto1="\033[$(($SHy +$SHh -1));$(($SHx +2))H"
		goto2="\033[$(($SHy +$SHh -1));$(($SHx +$SHw -2))H"
		echo -en "${clrSH}${goto1}${shJB}${goto2}${shJB}"
	}

	# left
	max=$((x = $SHh -1, x /2))
	for ((i = 1;  i <= max;  i++)); do
		goto1="\033[$(($SHy +$i));${SHx}H"
		goto2="\033[$(($SHy +SHh -1 -$i));${SHx}H"
		echo -en "${goto1}${clrSH}${shL}${goto2}${shL}"
		[ ! -z $hslp ] && sleep $1
	done
}

#+============================================================================= ========================================
# Draw main scoreboard
#
PFdrawScore() {  # (slp)
	# shoulder to score
	goto1="\033[$(($SHy +$SHh -1));$(($SHx +2))H"
	goto2="\033[$(($SHy +$SHh -1));$(($SHx +$SHw -2))H"
	echo -en ${clrSH}${goto1}${shJB}${goto2}${shJB}
	[ ! -z $1 ] && sleep $1

	goto1="\033[$(($SHy +$SHh));$(($SHx +2))H"
	goto2="\033[$(($SHy +$SHh));$(($SHx +$SHw -2))H"
	echo -en ${clrSH}${goto1}${snST}${goto2}${snST}
	[ ! -z $1 ] && sleep $1

	goto1="\033[$(($SCy -1));$(($SCx +2))H"
	goto2="\033[$(($SCy -1));$(($SCx +$SCw -4))H"
	echo -en ${clrSCbox}${goto1}${snSB}${goto2}${snSB}
	[ ! -z $1 ] && sleep $1

	goto1="\033[${SCy};$(($SCx +2))H"
	goto2="\033[${SCy};$(($SCx +$SCw -4))H"
	echo -en ${clrSCbox}${goto1}${scJT}${goto2}${scJT}
	[ ! -z $1 ] && sleep $1

	# score top
	max=$((x = $SCw -6, x /2))
	for ((i = 0;  i < $max;  i++)); do
		goto1="\033[${SCy};$(($SCx +3 +$i))H"
		goto2="\033[${SCy};$(($SCx +$SCw -5 -$i))H"
		echo -en "${goto1}${clrSCbox}${scT}${goto2}${scT}"
		[ ! -z $1 ] && sleep $1
	done

	goto="\033[${SCy};$(($SCx +$SCw -3))H"
	echo -en "${goto}${clrSCbox}${scT}"
	[ ! -z $1 ] && sleep $1

	goto1="\033[${SCy};$(($SCx +1))H"
	goto2="\033[${SCy};$(($SCx +$SCw -2))H"
	echo -en "${goto1}${clrSCbox}${scT}${goto2}${scT}"
	[ ! -z $1 ] && sleep $1

	goto1="\033[${SCy};$(($SCx))H"
	goto2="\033[${SCy};$(($SCx +$SCw -1))H"
	echo -en "${goto1}${clrSCbox}${scTL}${goto2}${scTR}"
	[ ! -z $1 ] && sleep $1

	# sides
	local space=$(printf "%*s" $(($SCw -2)) "")
	for ((y = 1;  y <= 7;  y++)); do
		goto="\033[$(($SCy +$y));${SCx}H"
		if [ $(($y & 1)) -eq 1 ]; then
			echo -en "${goto}${clrSCbox}${scL}${space}${scR}"
		else
			echo -en "${goto}${clrSCbox}${scJL}${space}${scJR}"
		fi
		[ ! -z $1 ] && sleep $1
	done
	goto="\033[$(($SCy +$y));${SCx}H"
	echo -en "${goto}${clrSCbox}${scBL}${space}${scBR}"

	# Score banners
	local bar=
	for ((i = 1;  i < $(($SCw -1));  i++)) ; do bar="${bar}▄" ; done

	goto="\033[$(($SCy +1));$(($SCx +1))H"
	echo -en ${goto}${clrSCOREh}" SCORE:     "
	[ ! -z $1 ] && sleep $1

	goto="\033[$(($SCy +2));$(($SCx +1))H"
	echo -en ${goto}${clrSCOREh}" "${clrSCOREv}"          "${clrSCOREh}" "
	[ ! -z $1 ] && sleep $1

	goto="\033[$(($SCy +3));$(($SCx +1))H"
	echo -en ${goto}${clrScoreMult}${bar}
	[ ! -z $1 ] && sleep $1

	goto="\033[$(($SCy +4));$(($SCx +1))H"
	echo -en ${goto}${clrMULTh}" Mult. "${clrMULTv}"    "${clrMULTh}" "
	[ ! -z $1 ] && sleep $1

	goto="\033[$(($SCy +5));$(($SCx +1))H"
	echo -en ${goto}${clrMultLast}${bar}
	[ ! -z $1 ] && sleep $1

	goto="\033[$(($SCy +6));$(($SCx +1))H"
	echo -en ${goto}${clrLASTh}" Last  "${clrLASTv}"    "${clrLASTh}" "
	[ ! -z $1 ] && sleep $1

	goto="\033[$(($SCy +7));$(($SCx +1))H"
	echo -en ${goto}${clrLastBest}${bar}
	[ ! -z $1 ] && sleep $1

	goto="\033[$(($SCy +8));$(($SCx +1))H"
	echo -en ${goto}${clrBESTh}" Best  "${clrBESTv}"    "${clrBESTh}" "
	echo -en ${goto}${clrBESTh}" Best  "${clrBESTv}"    "${clrBESTh}" "
	[ ! -z $1 ] && sleep $1

	goto="\033[$(($SCy +9));$(($SCx +1))H"
	echo -en ${goto}${clrBestEnd}${bar}
	[ ! -z $1 ] && sleep $1

}

#+============================================================================= ========================================
# Draw tet basket - intro anim
#
PFdrawFromBasket() {  # (slp, hslp)
	PFdrawBasket $1
	PFdrawLevel $1
	PFdrawCombo $1 $2
	PFdrawMtets $1
}

#+============================================================================= ========================================
# Draw tet basket
#
PFdrawBasket() {  # (slp)
	# join shoulder to grid
	for ((i = 0;  i < 3;  i++)); do
		x=$(($PFx + $PFw*2 +2 +$i))
		local goto1="\033[${PFy};${x}H"
		local goto2="\033[$(($PFy +5));${x}H"
		local goto3="\033[$(($PFy +11));${x}H"
		echo -en "${clrBSjoin}${goto1}${shJH}${goto2}${shJH}${goto3}${shJH}"
		[ ! -z $1 ] && sleep $1
	done
	echo -en "\033[$(($BSy +$BSh -2));$(($BSx -1))H${clrBSjoin}${bsJT}"

	local space=$(printf "%*s" $(($BSw -2)) "")
	for ((y = $BSy;  y <= $((BSy +BSh -2));  y++)); do
		local goto="\033[${y};${BSx}H"
		echo -en "${goto}${clrBS}${bsL}${atOFF}${space}${clrBS}${bsR}"
		[ ! -z $1 ] && sleep $1
	done

	local bar=${bsBL}
	for ((i = 1;  i < $(($BSw -1));  i++)) ; do bar="${bar}${bsB}" ; done
	bar="${bar}${bsBR}"

	goto="\033[$((BSy +BSh -1));${BSx}H"
	echo -en ${goto}${clrBS}${bar}
	[ ! -z $1 ] && sleep $1
}

#+============================================================================= ========================================
# Draw lines/level box
#
PFdrawLevel() {  # (slp)
	# joinery
	goto="\033[$(($BSy +$BSh -2));$(($BSx -1))H"
	echo -en ${goto}${clrBSjoin}${bsJT}
	goto="\033[$(($BSy +$BSh -2));$(($BSx +$BSw))H"
	echo -en ${goto}${clrBSjoin}${bsJTR}
	[ ! -z $1 ] && sleep $1

	goto="\033[$(($BSy +$BSh -1));$(($BSx -1))H"
	echo -en ${goto}${clrSCbox}${scL}
	goto="\033[$(($BSy +$BSh -1));$(($BSx +$BSw))H"
	echo -en ${goto}${clrSCbox}${scR}
	[ ! -z $1 ] && sleep $1

	# sides
	local space=$(printf "%*s" $(($LVLw -2)) "")
	echo -en "\033[$(($LVLy));${LVLx}H${clrSCbox}${scL}${space}${scR}"
	[ ! -z $1 ] && sleep $1
	echo -en "\033[$(($LVLy +1));${LVLx}H${clrSCbox}${scJL}${space}${scJR}"
	[ ! -z $1 ] && sleep $1
	echo -en "\033[$(($LVLy +2));${LVLx}H${clrSCbox}${scL}${space}${scR}"
	[ ! -z $1 ] && sleep $1
	echo -en "\033[$(($LVLy +3));${LVLx}H${clrSCbox}${scBL}${space}${scBR}"
	[ ! -z $1 ] && sleep $1

	# titles
	local bar=
	for ((i = 1;  i < $(($LVLw -1));  i++)) ; do bar="${bar}▄" ; done

	goto="\033[$(($LVLy));$(($LVLx +1))H"
	echo -en ${goto}${clrEndLines}${bar}
	[ ! -z $1 ] && sleep $1

	goto="\033[$(($LVLy +1));$(($LVLx +1))H"
	echo -en ${goto}${clrLINESh}" Lines "${clrLINESv}"    "${clrLINESh}" "
	[ ! -z $1 ] && sleep $1

	goto="\033[$(($LVLy +2));$(($LVLx +1))H"
	echo -en ${goto}${clrLinesLvl}${bar}
	[ ! -z $1 ] && sleep $1

	goto="\033[$(($LVLy +3));$(($LVLx +1))H"
	echo -en ${goto}${clrLVLh}" Level "${clrLVLv}"    "${clrLVLh}" "
	[ ! -z $1 ] && sleep $1

	goto="\033[$(($LVLy +4));$(($LVLx +1))H"
	echo -en ${goto}${clrLvlEnd}${bar}
}

#+============================================================================= ========================================
# Draw mini-tet stats box
#
PFdrawMtets() {  # (slp)
	goto="\033[$(($MTy +$MTh -1));${MTx}H"
	echo -en "${goto}${clrSCbox}└─┬──────┬─┘"
	for ((y = 2;  y < $MTh;  y++)); do
		goto="\033[$(($MTy +$MTh -$y));${MTx}H"
		if [ $y -eq 3 ]; then
			echo -en "${goto}${clrSCbox}╞==========╡"
		elif (($y & 1)); then
			echo -en "${goto}${clrSCbox}├----------┤"
		else
			order="BIOTZSJL"
			i=${order:$(($y/2 -1)):1}
			eval tet=('$'{tet$i[@]})
			local mtet="${tet[7]//./ }"
			echo -en "${goto}${clrSCbox}│${tet[9]}${mtet}${clrSCbox}      │"
		fi
		[ ! -z $1 ] && sleep $1
	done
	goto="\033[${MTy};${MTx}H"
	echo -en "${goto}${clrSCbox}┌──────────┐"
}

#+============================================================================= ========================================
# Draw combo stats box
#
PFdrawCombo() {  # (slp, hslp)
	COMBO=()
	COMBO+=("▄▄▄█▄▄▄▄▄▄█▄▄▄▄█")
	COMBO+=("█SS▌xxx▐GG▌xxx▐I")
	COMBO+=("▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█")

	[ ! -z $1 ] && hslp=$2 #$(echo "scale=6; ${1} / 2" | bc)

	for ((x = 0;  x < ${#COMBO[1]};  x++)); do
		for ((y = 0;  y < ${#COMBO[@]};  y++)); do
			chr=${COMBO[$y]:$x:1}
			case $chr in
				[█▄▀] ) echo -en "\033[$(($CBy +$y));$(($CBx +$x))H${clrCBbox}$chr"  ;;
				[▌▐]  ) echo -en "\033[$(($CBy +$y));$(($CBx +$x))H${clrCBsep}$chr"  ;;
				S     ) echo -en "\033[$(($CBy +$y));$(($CBx +$x))H${clrCBsilv}▓"    ;;
				G     ) echo -en "\033[$(($CBy +$y));$(($CBx +$x))H${clrCBgold}▓"    ;;
				x     ) echo -en "\033[$(($CBy +$y));$(($CBx +$x))H${clrCBv} "       ;;
				I     ) echo -en "\033[$(($CBy +$y));$(($CBx +$x))H${clrCBbox}▌"     ;;
			esac
		done
		[ ! -z $1 ] && sleep $hslp
	done
}

#****************************************************************************** ****************************************
#                          ,-----------------------.
#                         (  TETROMINO DEFINITIONS  )
#                          `-----------------------'
#****************************************************************************** ****************************************

tetCnt=7
tetW=4
tetH=4
tetName="BOITLJSZ"  # for the random selector

tetB=("80808080808080808080808080808080"  # 0    : rot_0
      "80808080808080808080808080808080"  # 1    : rot_1
      "80808080808080808080808080808080"  # 2    : rot_2
      "80808080808080808080808080808080"  # 3    : rot_3
      ${clrX} 0 0                         # 4,5,6: colour, Xoffs, Yoffs
      "...." 0 ${clrBm}                   # 7,8,9: MTet, cnt, colour
      "B")                                # 10   : Name
										
tetO=("808080808080808080151c8080131a80"  # 0    : rot_0
      "808080808080808080151c8080131a80"  # 1    : rot_1
      "808080808080808080151c8080131a80"  # 2    : rot_2
      "808080808080808080151c8080131a80"  # 3    : rot_3
      ${clrO} -1 0                        # 4,5,6: colour, Xoffs, Yoffs
      "..██" 0 ${clrOm}                   # 7,8,9: MTet, cnt, colour
      "O")                                # 10   : Name
										
tetI=("80808080808080802129292880808080"  # 0    : rot_0
      "80248080802680808026808080228080"  # 1    : rot_1
      "80808080808080802129292880808080"  # 2    : rot_2
      "80248080802680808026808080228080"  # 3    : rot_3
      ${clrI} -1 1                        # 4,5,6: colour, Xoffs, Yoffs
      "▄▄▄▄" 0 ${clrIm}                   # 7,8,9: MTet, cnt, colour
      "I")                                # 10   : Name
										
tetT=("8080808080808080313D388080328080"  # 0    : rot_0
      "8080808080348080313E808080328080"  # 1    : rot_1
      "8080808080348080313B388080808080"  # 2    : rot_2
      "80808080803480808037388080328080"  # 3    : rot_3
      ${clrT} 0 0                         # 4,5,6: colour, Xoffs, Yoffs
      ".▀█▀" 0 ${clrTm}                   # 7,8,9: MTet, cnt, colour
      "T")                                # 10   : Name
										
tetL=("80808080808080804549488042808080"  # 0    : rot_0
      "80808080414c80808046808080428080"  # 1    : rot_1
      "808080808080448041494a8080808080"  # 2    : rot_2
      "80808080804480808046808080434880"  # 3    : rot_3
      ${clrL} 0 0                         # 4,5,6: colour, Xoffs, Yoffs
      ".█▀▀" 0 ${clrLm}                   # 7,8,9: MTet, cnt, colour
      "L")                                # 10   : Name

tetJ=("808080808080808051595c8080805280"  # 0    : rot_0
      "808080808054808080568080515a8080"  # 1    : rot_1
      "80808080548080805359588080808080"  # 2    : rot_2
      "80808080805558808056808080528080"  # 3    : rot_3
      ${clrJ} 0 0                         # 4,5,6: colour, Xoffs, Yoffs
      ".▀▀█" 0 ${clrJm}                   # 7,8,9: MTet, cnt, colour
      "J")                                # 10   : Name

tetS=("808080808080808080656880616a8080"  # 0    : rot_0
      "8080808064808080636c808080628080"  # 1    : rot_1
      "808080808080808080656880616a8080"  # 2    : rot_2
      "8080808064808080636c808080628080"  # 3    : rot_3
      ${clrS} 0 0                         # 4,5,6: colour, Xoffs, Yoffs
      ".▄█▀" 0 ${clrSm}                   # 7,8,9: MTet, cnt, colour
      "S")                                # 10   : Name

tetZ=("8080808080808080717c808080737880"  # 0    : rot_0
      "808080808080748080757a8080728080"  # 1    : rot_1
      "8080808080808080717c808080737880"  # 2    : rot_2
      "808080808080748080757a8080728080"  # 3    : rot_3
      ${clrZ} 0 0                         # 4,5,6: colour, Xoffs, Yoffs
      ".▀█▄" 0 ${clrZm}                   # 7,8,9: MTet, cnt, colour
      "Z")                                # 10   : Name
										 

#+=============================================================================
# Grab tet #1 from the basket (to the grid tet #0)
# Generate a new tet for the bottom of the basket
#
TETadd() {  # (show)
	local i=

	# Start new piece at the top
	tetY=$tetSty
	tetX=$tetStx
	rot=$tetStr

	# shuffle everything up one
	tet0=(${tet1[@]})
	tet1=(${tet2[@]})
	tet2=(${tet3[@]})

	# create a new tet
#	i=$(($RNDn %$tetCnt +1))  # well, didn't this cause some horrors?!
	while true ; do
		RND
		((RNDn &= 7))
		[[ $RNDn -eq 0 ]] && continue
		
		i=${tetName:$RNDn:1}
		eval tet3=('$'{tet$i[@]})

		[[ ("${tet3[10]}" != "${tet0[10]}") && ("${tet3[10]}" != "${tet1[10]}") ]] && break
	done
#	i=${tetName:$RNDn:1}
#	eval tet3='$'{tet$i[@]}

	# Add new/grid tet to the stats
	i=${tet0[10]}
	eval tmp='$'{tet$i[8]}
	((tmp += 1))
	eval tet$i[8]='$'{tmp}
	[ "$1" == 1 ] && TETshowMtet

#	# take a quick stab at emptying the keyboard buffer
#	if [[ $1 -eq 1 ]]; then
#		for ((i = 0;  i < 20;  i++)); do 
#			keyGet
#			[[ "$KEY" == "" ]] && break
#		done
#	fi
	keyFlush

	# Clear piece settings
	tetVal=1
	tetSwap=0

	# check game-over
	TETcollide  $tetY $tetX ${tet0[$rot]}
	[ $? -ne 0 ] && RUN=2

	keyFlush

}

#+=============================================================================
# Put the piece in the playfield
#
TETplace() {
	local cnt=0
	for ((h = 0;  h < $tetH;  h++)); do
		local y=$(($tetY + $h))
		for ((w = 0;  w < tetW;  w++)); do
			local x=$(($tetX +$w +1))
			local z=$(($tetW*$h + $w))
			local ch=${tet0[$rot]:$(($z*2)):2}
			local chv=$((0x$ch))
			if [[ $chv != $tetiB ]] ; then
				PF[$y]="${PF[$y]:0:$(($x*2))}"$ch"${PF[$y]:$(($x*2+2))}"
				((cnt++))
				[ $cnt -eq 4 ] && break 2  # may cause a variation in game speed
			fi
		done
	done

	TETcheckComboAll
	TETcheckLin
}

#+============================================================================= ========================================
# Swap active-tet with shoulder-tet
#
TETswap() {
	# undraw both
	TETundraw
	TETundrawSh

	# swap them over
	local tmp=("${tet4[@]}")
	tet4=("${tet0[@]}")
	tet0=("${tmp[@]}")

	# position the new piece at the top
	tetY=$tetSty
	tetX=$tetStx
	rot=$tetStr

	# draw them back in
	TETdraw
	TETdrawSh

	tetVal=1   # reset tet-value (score)
	tetSwap=1  # can only do this once per drop (except debug mode)
}

#+=============================================================================
# Draw a Shoulder or Basket tetromino
# This does off-byte alignment for "pretty"
#
TETdrawTet() {  # ([un]draw, y, x, rot, tet)
	local gr=$1
	shift

	local by=$1
	shift

	local bx=$1
	shift

	local br=$1
	shift

	local tet=("$@")

	echo -en ${tet[4]} # colour

	local h=
	local w=

	local x=$(($bx +${tet[5]})) #bidmas
	for ((h = 0;  h < $tetH;  h++)); do
		local y=$(($by +$h +${tet[6]}))  # adjust x coord as per table
		GOTO $y $x
		for ((w = 0;  w < $tetW;  w++)); do
			local z=$(($h*$tetW +$w))
			local ch=$((0x${tet[$br]:$(($z*2)):2}))
			if [[ $ch != $tetiB ]] ; then
				echo -en $gr
			else
				echo -en "\033[2C" # cursor right 2
			fi
		done
	done
}

#+============================================================================= ========================================
# Update mini-tet stats board
#
TETshowMtet() {
	local tot=0
	local y=0
	for i in L J S Z T O I ; do
		eval tet=('$'{tet$i[@]})
		GOTO $(($MTy +1 + $y*2))  $(($MTx +7))
		echo -en ${tet[4]} # colour (main, not mtet - for text)
		printf "%3d" ${tet[8]}
		((tot += ${tet[8]}))
		((y += 1))
	done

	GOTO $(($MTy +1 + $y*2))  $(($MTx +5))
	echo -en ${clrMTscore}
	printf "%5d" $tot

	# silver counter
	GOTO $(($CBy +1))  $(($CBx +4))
	echo -en "${atPFX}${fgBLK};${bgWHT}${atSFX}" # number
	printf "%3d" $tetSilv

	# gold counter
	GOTO $(($CBy +1))  $(($CBx +11))
	echo -en "${atPFX}${fgBLK};${bgWHT}${atSFX}" # number
	printf "%3d" $tetGold
}

#+=========================================================
# Redraw the basket - after adding a new piece
#
#!! a nice little scrolling up animation wouldn't go amiss here!
#
TETdrawBs() {
	local i=

	# undraw the old ones
	for ((i = 0;  i <= 2;  i++)); do
		eval tet='$'{tet$i[@]}
		TETdrawTet "${nbsp}${nbsp}" $(($BSy -1 +$i*4)) $(($BSx +3)) 0 ${tet[@]}
	done

	# draw the new ones
	for ((i = 1;  i <= 3;  i++)); do
		eval tet='$'{tet$i[@]}
		TETdrawTet ${tetGR} $(($BSy -5 +$i*4)) $(($BSx +3)) 0 ${tet[@]}
	done
}

#+=========================================================
# Draw the shoulder tet
#
TETdrawSh() {
	TETdrawTet ${tetGR} $(($SHy)) $(($SHx +3)) 0 ${tet4[@]}
}

#+=========================================================
# UN-Draw the shoulder tet
#
TETundrawSh() {
	TETdrawTet "${nbsp}${nbsp}" $(($SHy)) $(($SHx +3)) 0 ${tet4[@]}
}

#+=============================================================================
# Used by TETdraw and TETundraw
#
TETdrawShadowNow() {  # (graphic)
	echo -en ${tet0[9]} # colour
	local x=$(($PFx +1 + $shadX*2)) #bidmas
	for ((h = 0;  h < $tetH;  h++)); do
		[ $(($shadY + $h)) -eq 0 ] && continue
		local y=$(($PFy +$shadY +$h -1))
		GOTO $y $x
		for ((w = 0;  w < $tetW;  w++)); do
			local z=$(($h*$tetW +$w))
			local ch=$((0x${tet0[$rot]:$(($z*2)):2}))
			if [[ $ch != $tetiB ]] ; then
				echo -en $1
			else
				echo -en "\033[2C" # cursor right 2
			fi
		done
	done
}

#+=========================================================
# Work out where the shadow should be and draw it
#
TETdrawShadow() {
	shadY=$tetY
	while TETcollide $shadY $tetX ${tet0[$rot]} ; do ((shadY++)) ; done
	[ $((--shadY)) -le $tetY ] && return

	shadX=$tetX

	TETdrawShadowNow ${tetGRs}
}

#+=========================================================
# UN-DRAW the shadow
#
TETundrawShadow() {
	[ $shadY -le $tetY ] && return
	TETdrawShadowNow "${nbsp}${nbsp}"
}

#+=============================================================================
# Used by TETdraw and TETundraw
#
TETdrawNow() {  # (graphic)
	echo -en ${tet0[4]} # colour
	local x=$(($PFx +1 + $tetX*2)) #bidmas
	for ((h = 0;  h < $tetH;  h++)); do
		[ $(($tetY + $h)) -eq 0 ] && continue
		local y=$(($PFy +$tetY +$h -1))
		GOTO $y $x
		for ((w = 0;  w < $tetW;  w++)); do
			local z=$(($h*$tetW +$w))
			local ch=$((0x${tet0[$rot]:$(($z*2)):2}))
			if [[ $ch != $tetiB ]] ; then
				echo -en $1
			else
				echo -en "\033[2C" # cursor right 2
			fi
		done
	done
}

#+=============================================================================
# DRAW a tet on the GRID
#
TETdraw() {
	TETdrawShadow
	TETdrawNow ${tetGR}
}

#+=============================================================================
# UN-DRAW a tet on the GRID
#
TETundraw() {
	[ "$KEY" != "DOWN" ] && TETundrawShadow
	TETdrawNow "${nbsp}${nbsp}"
}

#+=============================================================================
# Update the scoreboard
#
TETscoreShow() {
	local goto=
	local ch=
	
	goto="\033[$(($SCy +2));$(($SCx +2))H"
	printf -v ch "%'10d" $score
	echo -en "${goto}${clrSCOREv}${ch}"

	goto="\033[$(($SCy +4));$(($SCx +8))H"
	printf -v ch "%3d" $scoreMul
	echo -en "${goto}${clrMULTv}x${ch}"

	goto="\033[$(($SCy +6));$(($SCx +8))H"
	printf -v ch "%4d" $scoreLast
	echo -en "${goto}${clrLASTv}${ch}"

	goto="\033[$(($SCy +8));$(($SCx +8))H"
	printf -v ch "%4d" $scoreBest
	echo -en "${goto}${clrBESTv}${ch}"

	goto="\033[$(($LVLy +1));$(($LVLx +8))H"
	printf -v ch "%4d" $scoreLin
	echo -en "${goto}${clrLINESv}${ch}"

	goto="\033[$(($LVLy +3));$(($LVLx +8))H"
	printf -v ch "%4d" $scoreLvl
	echo -en "${goto}${clrLVLv}${ch}"
}

#+============================================================================= ========================================
# Special bonus if the board is cleared
#
TETperfect100() {
	local c=(37 33 36 32 35 31 34)  # W,Y,C,G,M,R,B - what an interesting pattern!?

	for ((i = 0;  i < 7;  i++)); do
		local goto="\033[$(($PFy +$PFh -3 -$i/2));$(($PFx +9))H"
		local clr="${atPFX}${c[$i]}${atSFX}"
		echo -en "${goto}${clr}+100"
		sleep 0.06
		echo -en "${goto}    "
	done
}

#+=============================================================================
TETperfect() {
	# Check if board is cleared
	local j=1
	for ((i = 0; i < $(($PFh -1)); i++)); do  # -1 to avoid the grid floor
		[[ ${PF[$i]} == $EMPTY ]] && ((j += 1))
	done
	[ $j -ne $PFh ] && return

	# +100
	TETperfect100 &

	[[ $SOUND == BEL ]] && echo -en "\a"

	# baloon - threads need to do things atomically
	local clr="${atPFX}${atBLD};${fgYEL}${atSFX}"
	echo -en "\033[$(($PFy +6));$(($PFx +4))H${clr} ,---------."
	echo -en "\033[$(($PFy +7));$(($PFx +4))H${clr}(  PERFECT  )"
	echo -en "\033[$(($PFy +8));$(($PFx +4))H${clr} \`---------'"

	# flashing "PERFECT"
	s="PERFECT"
	sl=${#s}
	fg=31  # 31--> R,G,Y,B,M,C,W <--37
	for ((i = 0;  i < 6;  i++)); do
		for ((j = 0;  j < $sl;  j++)); do
			echo -en "\033[$(($PFy +7));$(($PFx +7 +$j))H"${atPFX}$fg${atSFX}${s:$j:1}
			[ $((++fg)) -eq 37 ] && fg=31
			sleep 0.02
		done
	done

	# clean up
	local clr="${atOFF}"
	echo -en "\033[$(($PFy +6));$(($PFx +4))H${clr}            "
	echo -en "\033[$(($PFy +7));$(($PFx +4))H${clr}             "
	echo -en "\033[$(($PFy +8));$(($PFx +4))H${clr}            "

	# an extra 100 points (pre-multiplier) for clearing :)
	STATUS="Perfect: +100"
	((tetVal += 100))
}

#+============================================================================= ========================================
# Update the score & score stats
#
TETscoreAdd() {
	((scoreLast = $tetVal * $scoreMul))
	[ $scoreLast -gt $scoreBest ] && scoreBest=$scoreLast
	((score += $scoreLast))
}

#+============================================================================= ========================================
# Score this tetromino
#
TETscore() {  # (cnt, silver, gold)
	local cnt=$1
	local silv=$2 
	local gold=$3

	# Basic score
	if [ $cnt -eq 0 ]; then
		TETscoreAdd
		scoreMul=1
		TETscoreShow
		return
	fi

	((scoreLin += $cnt))  # tally lines

	# score ... lines*10; or lines*20 for a tetris
	[ $cnt -ne 4 ] && ((tetVal += $cnt *10)) || ((tetVal += $cnt *20))
	TETperfect   # check if board is cleared
	TETscoreAdd  # update score

	((scoreMul += 1))  # enhance multiplier for next piece
	[[ ${scoreMul} -gt ${scoreMulMax} ]] && scoreMulMax=${scoreMul}

	if [ $scoreLvl -ne 20 ] ; then    # already at full speed
		local tmp=$(($scoreLvl))
		((scoreLvl = $scoreLin /10 +$LEVEL))  # calculate level
		[ $tmp -ne $scoreLvl ] && STATUS="Level Up!"
		SPEEDset
	fi

	TETscoreShow  # update scoreboard

	# all the animations may result in buffered keystrokes...
#	while keyGet ; do : ; done  # flush keyboard buffer
	keyFlush
}

#+============================================================================= ========================================
fragDoit() { 
	local y=$1
	local x=
	for (( x = 0;  x < $PFw;  x++)); do
		local o=$((0x${PF[$y]:$(($x*2+2)):2}))  # old piece
		
		printf -v n "%02X" $(($o | $maskLDUR))  # new piece (fragment)
		PF[$y]="${PF[$y]:0:$(($x*2+2))}"$n"${PF[$y]:$(($x*2+4))}"
		
		[[ $(($o & $maskC)) -eq $maskLDUR ]] && continue
		[[ $(($o & $maskU)) -eq $maskU    ]] && fragFrom $((y -1))  $x  down
		[[ $(($o & $maskD)) -eq $maskD    ]] && fragFrom $((y +1))  $x  up
	done
}


#+============================================================================= ========================================
fragFrom() {
	local y=$1
	local x=$2
	local d=$3  # direction to parent

	local o=$((0x${PF[$y]:$(($x*2+2)):2}))

	[[ $(($o & $maskT)) -eq $tetiW    ]] && return  # wall
	[[ $(($o & $maskC)) -eq $maskLDUR ]] && return  # fragment
	[[ $(($o & $maskC)) -eq $maskB    ]] && return  # blank

	printf -v n "%02X" $(($o | $maskLDUR))  # new piece (fragment)
	PF[$y]="${PF[$y]:0:$(($x*2+2))}"$n"${PF[$y]:$(($x*2+4))}"

	[[ ("$d" != "up"   ) && ($(($o & $maskU)) -eq $maskU) ]] && fragFrom $((y -1))  $x         down
	[[ ("$d" != "down" ) && ($(($o & $maskD)) -eq $maskD) ]] && fragFrom $((y +1))  $x         up
	[[ ("$d" != "left" ) && ($(($o & $maskL)) -eq $maskL) ]] && fragFrom $y         $(($x -1)) right
	[[ ("$d" != "right") && ($(($o & $maskR)) -eq $maskR) ]] && fragFrom $y         $(($x +1)) left
}

#+============================================================================= ========================================
# Clear lines (with animation)
#
TETlines() {
	local cnt=$1
	shift
	local list=("$@")
	
	local y=
	local l=
	local i=

	if [[ $cnt -eq 4 ]]; then
		[[ $SOUND == BEL ]] && echo -en "\a"
	fi

	# fancy animation goes here!
	for (( i=0;  i<3; i++ )); do
		for l in ${list[@]} ; do
			GOTO $(($PFy +$l -1)) $(($PFx +1))
			for ((x =0;  x < $PFw; x++)); do  echo -en ${tetGRc} ;  done
		done
		sleep 0.2
		for l in ${list[@]} ; do
			GOTO $(($PFy +$l -1)) $(($PFx +1))
			for ((x = 0;  x < $PFw; x++)); do  echo -en ${tetGRs} ;  done
		done
		sleep 0.1
	done

	# Edit the grid
	for ((i = 0;  i < $cnt;  i++)); do
		local l=$((${list[$i]} +$i))  # +$i as lines will be disappearing
		fragDoit $l
		for ((y = $l;  y > 0;  y--)); do
			PF[$y]=${PF[$(($y -1))]}
		done
	done
	PFdrawGrid
	
	TETcheckComboAll
}

#+============================================================================= ========================================
# Check for combo blocks
#
TETcheckCombo() {
	local y=$1
	local x=$2

	local v=
	local t=
	local c=
	local g=

	v=$((0x${PF[$y]:$(($x*2 +2)):2}))
	((g = v &$maskT))
	for ((h = 0;  h < 4;  h++)); do
		for ((w = 0;  w < 4;  w++)); do
			v=$((0x${PF[$(($y +$h))]:$(($(($x+$w))*2 +2)):2}))  # I'm getting good at this :)
			((t = v &$maskT))
			[[ $t -ge ${tetiB} ]] && return 0
			[[ $t -ne $g ]] && g=0
			((c = v &$maskC))
			[[ $c -eq 0 || $c -eq 15 ]] && return 0
			[[ $h -eq 0 && $(($c & $maskU)) -gt 0 ]] && return 0
			[[ $w -eq 0 && $(($c & $maskL)) -gt 0 ]] && return 0
			[[ $w -eq 3 && $(($c & $maskR)) -gt 0 ]] && return 0
			[[ $h -eq 3 && $(($c & $maskD)) -gt 0 ]] && return 0
		done
	done
	[[ $g -eq 0 ]] && return 1 || return 2  # 1=silver, 2=gold
}

#+============================================================================= 
flashCombo() {
	local y=$1
	local x=$2
	local c=$3

	local i
	local h
	local w
	for ((i = 0;  i < 4;  i++)); do
		for ((h = 0;  h < 4;  h++)); do
			for ((w = 0;  w < 4;  w++)); do
				local goto="\033[$(($PFy +$y +$h -1));$(($PFx +$(($x +$w))*2 +1))H"
				local v=$((0x${PF[$(($y +$h))]:$(($(($x+$w))*2 +2)):2}))  # I'm getting good at this :)
				local t=$((v &$maskT))
				local clr=${tetI[4]}
				(($i & 1))  &&  ch=${tetGR}  ||  ch=${tetGRc}
				case $t in 
					"${tetiO}"  )  echo -en "${goto}${tetO[4]}${ch}"  ;;
					"${tetiI}"  )  echo -en "${goto}${tetI[4]}${ch}"  ;;
					"${tetiT}"  )  echo -en "${goto}${tetT[4]}${ch}"  ;;
					"${tetiL}"  )  echo -en "${goto}${tetL[4]}${ch}"  ;;
					"${tetiJ}"  )  echo -en "${goto}${tetJ[4]}${ch}"  ;;
					"${tetiS}"  )  echo -en "${goto}${tetS[4]}${ch}"  ;;
					"${tetiZ}"  )  echo -en "${goto}${tetZ[4]}${ch}"  ;;
				esac
			done
		done
		sleep 0.16
	done
}

#+============================================================================= 
makeCombo() {
	local cblk=()
		cblk+=("0109090C") # >--.
		cblk+=("0509090A") # ,--'
		cblk+=("0309090C") # '--.
		cblk+=("0109090A") # >--'

	local y=$1
	local x=$2
	local t=$3

	local h=
	local w=
	for (( h = 0;  h < 4;  h++)); do
		for (( w = 0;  w < 4;  w++)); do
			local yy=$(($y +$h))
			local xx=$(($(($x+$w))*2 +2))
			local cv=$(($((0x${cblk[$h]:$(($w*2)):2})) |$t)) 
			printf -v ch "%02X" $cv
			PF[$yy]="${PF[$yy]:0:$xx}"$ch"${PF[$yy]:$(($xx+2))}"
		done
	done
}

#+============================================================================= 
TETcheckComboAll() {
	local x=
	local y=
	local cntV=0
	local cntG=0
	for ((y = 2;  y < $(($PFh -4)); y++)); do
		for ((x = 0;  x < $(($PFw -3)); x++)); do
			TETcheckCombo $y $x
			rv=$?
			case $rv in
				1)	[[ $SOUND == BEL ]] && echo -en "\a"
					STATUS="${BWHT}SILVER${atOFF} COMBO!"
					flashCombo $y $x &
					makeCombo $y $x "${tetiV}"
					((tetSilv++))
					((cntV++))
					;;
				2)	[[ $SOUND == BEL ]] && echo -en "\a"
					STATUS="${YEL}*GOLD*${atOFF} COMBO!"
					flashCombo $y $x &
					makeCombo $y $x "${tetiG}"
					((tetGold++))
					((cntG++))
					;;
			esac
		done
	done
	
	if [[ $(($cntV +$cntG)) -gt 1 ]]; then
		STATUS="${YEL}**${BWHT}D${MAG}O${GRN}U${YEL}B${MAG}L${BWHT}E${YEL}**${atOFF} COMBO!"
	fi
	wait
	PFdrawGrid
	TETshowMtet
	
}

#+============================================================================= ========================================
# Check for complete lines
#
TETcheckLin() {
	local lines=()
	local silver=0
	local gold=0
	local SILVER=0
	local GOLD=0
	for ((h = $tetH;  h > 0;  h--)); do
		local y=$(($tetY +$h -1))
		[ $y -ge $(($PFh -1)) ] && continue  # off the grid

#		strstr ${PF[$y]} "-" && continue     # Still has gaps
		for ((x = 1;  x <= $PFw;  x++)); do
			[[ $((0x${PF[$y]:$(($x*2)):2})) == $tetiB ]] && continue 2
		done

		lines+=("$y")                        # array of complete lines

#!		local tmp="${PF[$y]//[^${cmSILV}]}"  # how many silver blocks
#!		((silver += ${#tmp} /2))

#!		local tmp="${PF[$y]//[^${cmGOLD}]}"   # how many gold blocks
#!		((gold += ${#tmp} /2))
	done
	local cnt=${#lines[@]}

	[ $cnt -ne 0 ] && TETlines $cnt ${lines[@]}  # Clear lines (animation)

	TETscore $cnt $silver $gold  # ALWAYS called (for multiplier calculation)
}

#+=============================================================================
#         Auto-drop time
# Factor  Lvl-0 .. Lvl-20
#   45  : 1.000    0.100
#   46  : 1.000    0.080
#   47  : 1.000    0.060
#
SPEEDset() {
	((speed = 1000 - $scoreLvl*46))
}

#+=============================================================================
# Start stopwatch
#
TIMEstart() {
	timePause=0
	timeStart=$(date -u +%s)
}

#+=============================================================================
# Update stopwatch
#
TIMEshow() {
	timeNow=$(date -u +%s)
	timeTotal=$((timeNow -timeStart -timePause))
	GOTO $TMy $(($TMx +1))
	echo -en "${clrTIME}$(date -u -d @${timeTotal} +"%T")"
}

#+=============================================================================
# Timestamp last drop, and next drop
#
SPEEDstamp() {
	speedLast=$(date +%s%N | sed -e 's/\(.*\)....../\1/')
	((speedNext = $speedLast + $speed))
}

#+=============================================================================
# return:  1=Collision. 0=Not-Collision
#
TETcollide() {  # (y, x, tet[rot])
	for ((h = 0;  h < $tetH;  h++)); do
		local y=$(($1 +$h))
		for ((w = 0;  w < tetW;  w++)); do
			local x=$(($2 +$w +1))
			local z=$(($h*$tetW +$w))
#			[ "${3:$z:1}" == "#" ] && [ "${PF[$y]:$x:1}" != "-" ] && return 1
			[[ ($((     0x${3:$(($z*2)):2})) != $tetiB) && 
			   ($((0x${PF[$y]:$(($x*2)):2})) != $tetiB) ]] && return 1
		done
	done
	return 0
}

#+=============================================================================
statFast=4200  # most messages
statSlow=6000  # long messages

STATUSupdate() {  # (spd)
	statNow=$(date +%s%N | sed -e 's/\(.*\)....../\1/')

	[[ -z $statNow || -z $statClear ]] && return

	[ "$STATUSd" != "" ] && [ $statNow -gt $statClear ] && STATUS=

	[ "$STATUSd" == "$STATUS" ] && return

	STATUSd="$STATUS"

	GOTO 25 1
	echo -en ${atOFF}
	printf "%*s" 71 ""

	GOTO 25 3
	echo -en ${clrSTATUS}$STATUSd
	[[ ! -z $STATUSd ]] && DBG "STATUS=\"$STATUSd\""

	((statClear = $statNow +$statSpeed))  # clear messages after 3200mS
}

#+=============================================================================
# Exit cleanly
#
Quit() {  # (errorlevel)

#        0         1         2         3         4         5        6          7         8
#        012345678901234567890123456789012345678901234567890123456789012345678901234567890
QMSG=()
 QMSG+=(" │○¦ Thanks for playing Башотрис                                              ¦○│") # 0
 QMSG+=(" │ ¦                                                                          ¦ │") # 1
 QMSG+=(" │○¦ All feedback welcome at: www.github.com/csBlueChip/BAShTris/issues       ¦○│") # 2
 QMSG+=(" │ ¦                                                                          ¦ │") # 3
 QMSG+=(" │○¦        ╓────╖╥ ╥╓─╖╓─╖╓─╖╓─╖             ▄▄▄▄▄▄▄   ▄ ▄▄▄▄ ▄▄▄▄ ▄▄▄▄▄▄▄   ¦○│") # 4
 QMSG+=(" │ ¦        ║     ╙╥╜║─╢║ ║║╓╜║ ╖             █ ▄▄▄ █ ▀ ▀ ▄█▀█▀ █▄▀ █ ▄▄▄ █   ¦ │") # 5
 QMSG+=(" │○¦        ║      ╨ ╙─╜╙─╜╨╙ ╙─╜             █ ███ █ ▀█▀ ▀ ▀█▄█▄ ▄ █ ███ █   ¦○│") # 6
 QMSG+=(" │ ¦        ║  ╓─╖╥ ╥╓─╖─╥─╓─╖╓╥╖╓─╖          █▄▄▄▄▄█ █▀▄▀█ ▄ ▄ █ █ █▄▄▄▄▄█   ¦ │") # 7
 QMSG+=(" │○¦        ║  ╙─╖╙╥╜╙─╖ ║ ╟─ ║║║╙─╖          ▄▄▄▄▄ ▄▄▄█▀█  ▀ ▀▄  ▀▄ ▄ ▄ ▄    ¦○│") # 8
 QMSG+=(" │ ¦        ╙─┘╙─╜ ╨ ╙─╜ ╨ ╙─╜╨ ╨╙─╜          ▄▀█ ██▄█  █ ▀███▄ ▄▀█▀██▀▀██▀   ¦ │") # 9
 QMSG+=(" │○¦    ┌──────────────────────────────┐      █▄▄  ▀▄▀ ▄▄ █▀▄▄▄▄█ █ ▀ ▀▀▄ ▀   ¦○│") #10
 QMSG+=(" │ ¦    │° Greetz to:                 °│      ▀█▄▀  ▄  █ ▄▄  ▄██▀▀▀▀█▀▀█▄ ▀   ¦ │") #11
 QMSG+=(" │○¦    │   • Cyborg666     • RIMSy    │       ▀▀▀ ▀▄ ▄ ██  ▀▀   ▄▀▄ ▀ ▀▄ ▀   ¦○│") #12
 QMSG+=(" │ ¦    │   • Lord Grumble  • PajaCo   │      █ █▄▀▄▄▄██▀ ▀██▄▀▄█▀▀▀█ ▀▄▀ ▀   ¦ │") #13
 QMSG+=(" │○¦    │.  • jgs/spunk     • sbot    .│      █ █▄█▄▄  ▀▄ █▀▄▄▄ ▀▀▄▄█▄██▄ ▀   ¦○│") #14
 QMSG+=(" │ ¦    └──────────────────────────────┘      ▄▄▄▄▄▄▄ ██▄▄▄  ▄▀ █ █ ▄ █▀  ▀   ¦ │") #15
 QMSG+=(" │○¦                                          █ ▄▄▄ █ ▄▀██  ▀██  ▀█▄▄▄█▀▄█▀   ¦○│") #16
 QMSG+=(" │ ¦ KThxBye,                                 █ ███ █ █▀▄ ▀███▀▄▄▀▀▄▄▄▄ ▀█▀   ¦ │") #17
 QMSG+=(" │○¦   csßlúèÇhîp                             █▄▄▄▄▄█ █▀  █▀▄▀ ▄ █▀▀▄███▄▀    ¦○│") #18
 QMSG+=(" │ ¦                                         ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ¦/ ") #19
 QMSG+=(" │○¦,-'\"-._,-'\"'--'\"'-.,-'\"'-._-\"-._,-\"'-.__,-^-._,-'\"'-._,-''-._,-\"--._-\"-._/   ") #20
 QMSG+=("                                                                                 ") #21
 QMSG+=(" If your cursor is not visible: stty sane ; tput cnorm                           ") #22
#        0         1         2         3         4         5        6          7         8
#        012345678901234567890123456789012345678901234567890123456789012345678901234567890

local cTHX="${atPFX}${atBLD};${fgYEL};${bgBLK}${atSFX}"
local cWWW="${atPFX}${atBLD};${atUSC};${fgBLU};${bgBLK}${atSFX}"
local cCSYS="${atPFX}${atBLD};${fgCYN};${bgBLK}${atSFX}"
local cBOX="${atPFX}${fgYEL};${bgBLK}${atSFX}"
local cQR="${atPFX}${fgBLK};${bgWHT}${atSFX}"
local cSTTY="${atPFX}${atBLD};${fgGRN};${bgBLK}${atSFX}"

local cCS="${atPFX}${atBLD};${fgBLK};${bgBLK}${atSFX}"
local cBLUE="${atPFX}${atBLD};${fgGRN};${bgBLK}${atSFX}"
local cCHIP="${atPFX}${atBLD};${fgBLU};${bgBLK}${atSFX}"

local cRIP="${atPFX}${atBLD};${fgBLK};${bgBLK}${atSFX}"

local cCUT="${atPFX}${atBLD};${fgBLK};${bgBLK}${atSFX}"
local cCUT21L="${atPFX}${atBLD};${atUSC};${fgBLK};${bgBLK}${atSFX}"

	STATUS="KThxBye"
	STATUSupdate
	sleep 0.3

	[ "$2" != "q" ] && {
		local slp=0.03

		GOTO 25 1
		for ((y = 0;  y <= 23;  y++)); do
			echo ""
			for ((x = 1;  x <= 80;  x++)); do
				if false; then :
				elif [[  ($y -eq 19) &&                 ($x -eq 78)  ]] ; then echo -en ${cCUT21L}
				elif [[  ($y -eq 19) &&                 ($x -eq 79)  ]] ; then echo -en ${cRIP}

				elif [[ (($y -eq 10) || ($y -eq 15)) &&  ($x -eq  8)                 ]] ; then echo -en ${cBOX}
				elif [[ (($y -ge 11) && ($y -le 14)) && (($x -eq  8) || ($x -eq 38)) ]] ; then echo -en ${cBOX}
				elif [[ (($y -ge 11) && ($y -le 14)) &&  ($x -eq 10)                 ]] ; then echo -en ${atOFF}

				elif [[  ($y -eq 20) && (($x -eq  2) || ($x -eq  3)) ]] ; then echo -en ${cCUT21L}
				elif [[  ($y -eq 20) &&                 ($x -eq  1)  ]] ; then echo -en ${atOFF}
				elif [[  ($y -eq 20)                                 ]] ; then echo -en ${cCUT}

				elif [[  ($y -eq 22)                 && ($x -eq  2)  ]] ; then echo -en ${atOFF} # cursor:
				elif [[  ($y -eq 22)                 && ($x -eq 32)  ]] ; then echo -en ${cSTTY} # stty

				elif [[                  ($x -eq  1) || ($x -eq 80)  ]] ; then echo -en ${atOFF}  # tractor
				elif [[                  ($x -eq  2) || ($x -eq 78)  ]] ; then echo -en ${cCUT}
				elif [[                  ($x -eq  4)                 ]] ; then echo -en ${atOFF}

				elif [[  ($y -eq  0)                 && ($x -eq  5)  ]] ; then echo -en ${cTHX}

				elif [[  ($y -eq  2)                 && ($x -eq 30)  ]] ; then echo -en ${cWWW}
				elif [[  ($y -eq  2)                 && ($x -eq 71)  ]] ; then echo -en ${atOFF}

				elif [[ (($y -ge  4) && ($y -le  9)) && ($x -eq 12)  ]] ; then echo -en ${cCSYS}
				elif [[ (($y -ge  4) && ($y -le  9)) && ($x -eq 37)  ]] ; then echo -en ${atOFF}

				elif [[ (($y -ge  4) && ($y -le 19)) && ($x -eq 45)  ]] ; then echo -en ${cQR}
				elif [[ (($y -ge  4) && ($y -le 19)) && ($x -eq 76)  ]] ; then echo -en ${atOFF}

				elif [[  ($y -eq 18)                 && ($x -eq  7)  ]] ; then echo -en ${cCS}
				elif [[  ($y -eq 18)                 && ($x -eq  9)  ]] ; then echo -en ${cBLUE}
				elif [[  ($y -eq 18)                 && ($x -eq 13)  ]] ; then echo -en ${cCHIP}

				elif [[  ($y -eq 20)                 && ($x -eq 78)  ]] ; then echo -en ${cRIP}
				elif [[  ($y -eq 20)                 && ($x -eq 79)  ]] ; then echo -en ${atOFF}
				fi
				echo -en "${QMSG[$y]:$x:1}"
			done
			sleep $slp
		done

		echo ""
		GOTO 24 1
	}

	((KeyRun)) && keyStop # stty reset
	tput cnorm

	exit $1
}

#+=============================================================================
Redraw() {  # (slow)
	if ! (($1)); then
		slp=0.025 
		hslp=0.0125 
	else
		slp=
		hslp=
	fi

	if [[ -z $slp ]]; then
		if [[ $1 -ne 2 ]]; then
			echo -en ${atOFF}
			CLS
			CSdrawBackdrop
		fi
	else
		CSdrawBackdropReveal
	fi

	PFdrawGrid $slp

	PFdrawFromShoulder $slp $hslp &
	#	PFdrawScore $slp

	PFdrawFromBasket $slp $hslp &
	#	PFdrawLevel $slp
	#	PFdrawCombo $slp
	#	PFdrawMtets $slp

	wait

	TETscoreShow
	TETshowMtet
	((! $1)) && TETdrawSh
}

#+=============================================================================

STRRU=()
  # PFx+  12345678901234567890
 STRRU+=(".╔═╕.....╒═╤═╕......")  # PFy +  1            
 STRRU+=(".║─╖┌┐┬.┬┌┐│┌┐┬.┬┌┐.")  # PFy +  2
 STRRU+=(".║.║┌┤││││││├┘│/││..")  # PFy +  3
 STRRU+=(".╙─╨└┘└┴┘└┘┴┴.┴.┴└┘.")  # PFy +  4
RUMAP=()
 RUMAP+=(".ttt.....ttttt......")  # PFy +  1            
 RUMAP+=(".tttlji.iootjji.iss.")  # PFy +  2
 RUMAP+=(".t.tjtitiootojiiis..")  # PFy +  3
 RUMAP+=(".tttjjtttootj.i.iss.")  # PFy +  4

STREN=()
  #                1         2
  # PFx+  12345678901234567890
 STREN+=("..╔═╕....╒═╤═╕.♦....")  # PFy +  1            
 STREN+=("..║─┤╒╕╒╕┬.│┌─┐┬┌┐..")  # PFy +  2
 STREN+=("..║.││╡╘╕├┐││┌┘│└┐..")  # PFy +  3
 STREN+=("..╙─┘┴┴└┘┴┴┴┴└.┴└┘..")  # PFy +  4
ENMAP=()
 ENMAP+=("..ttt....ttttt.o....")  # PFy +  1            
 ENMAP+=("..tttllsso.tjjjiss..")  # PFy +  2
 ENMAP+=("..t.tlissoitijjiss..")  # PFy +  3
 ENMAP+=("..tttllssoitjj.iss..")  # PFy +  4

STRT=()
  #                1         2
  # PFx+  12345678901234567890
  STRT+=("....................")  # PFy +  1
  STRT+=("....................")  # PFy +  2
  STRT+=("....................")  # PFy +  3
  STRT+=("....................")  # PFy +  4
  STRT+=("....................")  # PFy +  5
  STRT+=("..Style:▐====▌......")  # PFy +  6  NORM/CHAL/NVIS
  STRT+=("....................")  # PFy +  7
  STRT+=("..Level:▐^^▌........")  # PFy +  8  00..20
  STRT+=("....................")  # PFy +  9
  STRT+=("..Sound:▐<<<▌.......")  # PFy + 10  OFF/BEL
  STRT+=("....................")  # PFy + 11
  STRT+=("▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄")  # PFy + 12   
  STRT+=("▐_~-▐High:Score▌-~_▌")  # PFy + 13   
  STRT+=("▐..................▌")  # PFy + 14   
  STRT+=("▐..................▌")  # PFy + 15   
  STRT+=("▐..................▌")  # PFy + 16   
  STRT+=("▐..................▌")  # PFy + 17   
  STRT+=("▐▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▌")  # PFy + 18   
  #                1         2
  # PFx+  12345678901234567890
   
#       ("▐ AAA - 12,456,890 ▌")
   #        |     |1         2
   # PFx+ 12345678901234567890
#                  |      |   ")
#       ("..Style:▐NORM▌  <-- ")

clrHi=()
clrHi+=("${atPFX}${atUSC};${atBLD};${fgYEL};${bgGRN}${atSFX}")
clrHi+=("${atPFX}${atUSC};${atBLD};${fgGRN};${bgBLK}${atSFX}")
clrHi+=("${atPFX}${fgGRN};${bgBLK}${atSFX}")

SOUND=BEL   # < OFF/BEL
LEVEL=00    # ^ 00..20
STYLE=NORM  # = NORM/CHAL/NVIS
LANG=EN
AZ=$AZRU

#+=============================================================================
showLang() {
	[[ $LANG == EN ]] && {
		STRT[0]="${STREN[0]}"
		STRT[1]="${STREN[1]}"
		STRT[2]="${STREN[2]}"
		STRT[3]="${STREN[3]}"
		MAP=("${ENMAP[@]}")
	} || {
		STRT[0]="${STRRU[0]}"
		STRT[1]="${STRRU[1]}"
		STRT[2]="${STRRU[2]}"
		STRT[3]="${STRRU[3]}"
		MAP=("${RUMAP[@]}")
	}

	local goto=
	local clr=
	local str=
	local ch=
	local x=
	local y=
	
	goto="\033[$(($SHy +2));$((SHx +1))H"
	clr="${atPFX}${fgBLK};${bgCYN}${atSFX}"
	[[ $LANG == RU ]] && str="▌Рyсский▐" || str="▌English▐"
	echo -en "$goto$clr$str"

	goto="\033[$(($SHy +3));$((SHx +2))H"
	clr="${atPFX}${atBLD};${fgBLK};${bgBLK}${atSFX}"
	[[ $LANG != RU ]] && str=" Русский " || str=" English "
	echo -en "$goto$clr$str"

	(($1)) && {
		for ((y = 0;  y < 4;  y++)); do
			for ((x = 0;  x < 20;  x++)); do
				goto="\033[$(($PFy +$y +1));$(($PFx +$x +1))H"
				ch="${STRT[$y]:$x:1}"
				[[ $ch == . ]] && ch=" "
				local clr="${MAP[$y]:$x:1}"
				case $clr in
					l )  clr="$clrL"   ;;
					j )  clr="$clrJ"   ;;
					t )  clr="$clrT"   ;;
					o )  clr="$clrO"   ;;
					i )  clr="$clrI"   ;;
					s )  clr="$clrS"   ;;
					* )  clr="$atOFF"  ;;
				esac
				echo -en "${goto}${clr}${ch}"
			done
		done
	}

}

#+=============================================================================
ctrlC_none(){
	return 0
}

pressStart() {
	trap ctrlC_none INT

	local press="PRESS"
	local start="START"
	
	[[ $LANG == RU ]] && {
		press="НАЖМИТЕ"
	    start="СТАРТ"
	}
	
	local goto=
	local ch=
	local fg=31
	local frst=1
	local x=
	while true; do
		for ((x = 0;  x < ${#press};  x++)); do
			goto="\033[$(($BSy +4));$(($BSx +3 +$x))H"
			clr="${atPFX}${atBLD};${fg};${bgBLK}${atSFX}"
			ch=${press:$x:1}
			echo -en "${goto}${clr}${ch}"
			((++fg))
			[[ $fg -eq 38 ]] && fg=31
			[[ $frst -eq 0 ]] && sleep 0.005
		done
			
		for ((x = 0;  x < ${#start};  x++)); do
			goto="\033[$(($BSy +5));$(($BSx +4 +$x))H"
			clr="${atPFX}${atBLD};${fg};${bgBLK}${atSFX}"
			ch=${start:$x:1}
			echo -en "${goto}${clr}${ch}"
			((++fg))
			[[ $fg -eq 38 ]] && fg=31
			[[ $frst -eq 0 ]] && sleep 0.005
		done
		frst=0
	done
}

#+=============================================================================
killStart() {
	kill -13 $1
	
	GOTO $(($BSy +4)) $(($BSx +3))
	echo -en "${atOFF}"
	echo -en "       "
	GOTO $(($BSy +5)) $(($BSx +4))
	echo -en "     "
}

#+=============================================================================
scrollPut() {
	local clr=
	local goto=
	local l=
	local ch=
	local x=

	l=$(($sy +$ss -18))
	for ((x = 0;  x < ${#STRT[$l]};  x++)); do
		goto="\033[$(($PFy +$sy));$(($PFx +$x +1))H"
		ch="${STRT[$l]:$x:1}"
		[[ "$ch" == "." ]] && ch=" "
		if [[ $l -lt 4 ]]; then
			clr="${MAP[$l]:$x:1}"
			case $clr in
				"l" )  clr="$clrL"   ;;
				"j" )  clr="$clrJ"   ;;
				"t" )  clr="$clrT"   ;;
				"o" )  clr="$clrO"   ;;
				"i" )  clr="$clrI"   ;;
				"s" )  clr="$clrS"   ;;
				*   )  clr="$atOFF"  ;;
			esac

		elif [[ $l -lt 11 ]]; then 
			case $ch in
				"▐" | "▌" )  clr=${WHT}   ;;
				"="  )     
					ch=${STYLE}
					clr="${atPFX}${fgBLK};${bgWHT}${atSFX}"
					((x+=3))
					;;
				"^"  )
					printf -v ch "%02d" $LEVEL
					clr="${atPFX}${fgBLK};${bgWHT}${atSFX}"
					((x+=1))
					;;
				"<"  )
					ch=${SOUND}
					clr="${atPFX}${fgBLK};${bgWHT}${atSFX}"
					((x+=2))
					;;
				*   )  clr="$GRN"  ;;
			esac

		elif [[ ($l -eq 11) || ($l -eq 17) ]]; then # box top bottom
			clr="${atPFX}${fgYEL};${bgBLK}${atSFX}"

		elif [[ $l -eq 12 ]]; then  # title
			if [[ ($x -eq 0) || ($x -eq 19) ]]; then
				clr="${atPFX}${fgYEL};${bgBLK}${atSFX}"
			else
				case $ch in
					"," | "_" | "-" )  clr="${atPFX}${atBLD};${fgGRN};${bgBLK}${atSFX}"  ;;
					"~")  clr="${atPFX}${atBLD};${fgGRN};${bgBLK}${atSFX}"   
					      ch="."
					      ;;
					"▐" | "▌" )  clr="${atPFX}${fgGRN};${bgBLK}${atSFX}"   ;;
					":"       )  clr="${atPFX}${atBLD};${fgWHT};${bgGRN}${atSFX}"
					             ch=" " 
					             ;;
					[^\ ]     )  clr="${atPFX}${atBLD};${fgWHT};${bgGRN}${atSFX}"   ;;
					*         )  clr="${atOFF}"  ;;
				esac
			fi

		elif [[ ($l -eq 13) ]]; then  # pre 1st place
			if [[ $ch == " " ]]; then
				clr="${atPFX}${atUSC};${atBLD};${fgYEL};${bgBLK}${atSFX}"
			else
				clr="${atPFX}${fgYEL};${bgBLK}${atSFX}"
			fi

		elif [[ ($l -eq 14) ]]; then  # 1st place
			clr="${clrHi[0]}"
			if [[ ($x -eq 0) || ($x -eq 19) ]]; then     # box
				clr="${atPFX}${fgYEL};${bgBLK}${atSFX}"
			elif [[ $x -eq 2 ]]; then                   # name$
				ch="${HI0[2]:0:3}"
				((x+=2))
			elif [[ $x -eq 8 ]]; then                   # score$
				printf -v ch "%'10d" ${HI0[3]}
				((x+=9))
			fi
		
		elif [[ ($l -eq 15) ]]; then  # 2nd place
			clr="${clrHi[1]}"
			if [[ ($x -eq 0) || ($x -eq 19) ]]; then     # box
				clr="${atPFX}${fgYEL};${bgBLK}${atSFX}"
			elif [[ $x -eq 2 ]]; then                   # name$
				ch="${HI1[2]:0:3}"
				((x+=2))
			elif [[ $x -eq 8 ]]; then                   # score$
				printf -v ch "%'10d" ${HI1[3]}
				((x+=9))
			fi

		elif [[ ($l -eq 16) ]]; then  # 3rd place
			clr="${clrHi[2]}"
			if [[ ($x -eq 0) || ($x -eq 19) ]]; then     # box
				clr="${atPFX}${fgYEL};${bgBLK}${atSFX}"
			elif [[ $x -eq 2 ]]; then                   # name$
				ch="${HI2[2]:0:3}"
				((x+=2))
			elif [[ $x -eq 8 ]]; then                   # score$
				printf -v ch "%'10d" ${HI2[3]}
				((x+=9))
			fi

		fi
		echo -en "${goto}${clr}${ch}"
	done
}

#+=============================================================================
scrollIn() {
	for ((ss = 0;  ss < ${#STRT[@]};  ss++)); do
		for ((sy = $((18 -$ss));  sy <= 18;  sy++)); do
			scrollPut
		done
		sleep 0.01
	done
	echo -en "\033[$PFy;$(($PFx +1))H${atOFF}                    "
#	showHi
}

#+=============================================================================
scrollOut() {
	for ((ss = ((${#STRT[@]} -1));  ss >= 0;  ss--)); do
		for ((sy = 18;  sy >= $((18 -$ss));  sy--)); do
			scrollPut
		done
		for ((x = 0;  x < ${#STRT[$l]};  x++)); do
			goto="\033[$(($PFy +$sy));$(($PFx +$x +1))H"
			clr="$atOFF"
			echo -en "${goto}${clr} "
		done
		sleep 0.01
	done
}

#+=============================================================================
drawSEL() {
	local goto="\033[$(($PFy +$2*2 +6 +$3));$(($PFx +16))H"
	local clr="${atPFX}${atBLD};${fgGRN};${bgBLK}${atSFX}"
	local ch="◄▬▬" #«"
	[[ $1 -eq 0 ]] && ch="    "
	echo -en "${goto}${clr}${ch}"
}

#+=============================================================================
optScroll() {  # (y, x, clr, L|R, old, new)
	local x=
	local ch=
	local old=
	local new=
	
	local goto="\033[$1;$2H"
	local l=$((${#5} +1))

	if [[ $4 == L ]]; then  # left
		for (( x = 1;  x <= $l;  x++)); do
			[[ $x -eq 1          ]] && new="" || new="${6:$(($l -$x))}"
			[[ $x -eq $l         ]] && ch=""  || ch="║"
			[[ $x -ge $(($l -1)) ]] && old="" || old="${5:0:$(($l -$x -1))}"
			echo -en "${goto}${3}${new}${ch}${old}"
			sleep 0.05
		done
	else
		for (( x = 1;  x <= $l;  x++)); do
			[[ $x -eq $(($l -1)) ]] && old="" || old="${5:$x}"
			[[ $x -eq $l         ]] && ch=""  || ch="║"
			[[ $x -eq 1          ]] && new="" || new="${6:0:$(($x -1))}"
			echo -en "${goto}${3}${old}${ch}${new}"
			sleep 0.05
		done
	fi

}

#+=============================================================================
showHi() {
	local ch=
	local goto=

	local hi=($(grep "^~hs:$LEVEL," ${CMD}))	# get the three score for this level
	IFS=',' read -r -a HI0 <<< "${hi[0]}"   # stick them in global arrays
	IFS=',' read -r -a HI1 <<< "${hi[1]}"
	IFS=',' read -r -a HI2 <<< "${hi[2]}"
	
	[[ $1 -eq 0 ]] && return # engineering menu only wants the values loaded

	# no scrolling requested (initial display)
	if [[ -z $2 ]]; then
		for (( i = 0;  i < 3;  i++ )); do
			IFS=',' read -r -a itm <<< "${hi[$i]}"
			
			clr=${clrHi[$i]}
	
			goto="\033[$(($PFy +15 +$i));$(($PFx +2))H"
			echo -en "${goto}${clr}                  "
	
			goto="\033[$(($PFy +15 +$i));$(($PFx +3))H"
			printf -v ch "%3s" "${itm[2]}"
			echo -en "${goto}${clr}${ch} -"
			
			goto="\033[$(($PFy +15 +$i));$(($PFx +9))H"
			printf -v ch "%'10d" "${itm[3]}"
			echo -en "${goto}${clr}${ch}"
			
		done
		
	else
		local pre=($(grep "^~hs:${3}," ${CMD}))
		IFS=',' read -r -a PRE0 <<< "${pre[0]}"
		IFS=',' read -r -a PRE1 <<< "${pre[1]}"
		IFS=',' read -r -a PRE2 <<< "${pre[2]}"
		
		# Macs can't printf in to an array
		local tmp
		local old=()
		printf -v tmp " %3s - %'10d " "${PRE0[2]}" "${PRE0[3]}" 
		old+=("$tmp")
		printf -v tmp " %3s - %'10d " "${PRE1[2]}" "${PRE1[3]}"
		old+=("$tmp")
		printf -v tmp " %3s - %'10d " "${PRE2[2]}" "${PRE2[3]}"
		old+=("$tmp")
		
		local new=()
		printf -v tmp " %3s - %'10d " "${HI0[2]}" "${HI0[3]}"
		new+=("$tmp")
		printf -v tmp " %3s - %'10d " "${HI1[2]}" "${HI1[3]}"
		new+=("$tmp")
		printf -v tmp " %3s - %'10d " "${HI2[2]}" "${HI2[3]}"
		new+=("$tmp")
		
		local l=${#old[0]}
		
		if [[ "$2" == "left" ]]; then  # coming from the left
			for ((x = 1;  x < $l;  x++)); do
				for ((y =0;  y < 3;  y++)); do
					clr=${clrHi[$y]}
					goto="\033[$(($PFy +15 +$y));$(($PFx +2))H"
					echo -en "${goto}${clr}${new[$y]:$(($l -$x))}│${old[$y]:0:$((0-$x-1))}"
				done
				sleep 0.02
			done		
			
		else  # right
			for ((x = 1;  x <= $l;  x++)); do
				for ((y =0;  y < 3;  y++)); do
					clr=${clrHi[$y]}
					goto="\033[$(($PFy +15 +$y));$(($PFx +2))H"
					echo -en "${goto}${clr}${old[$y]:$x}│${new[$y]:0:$(($x -1))}"
				done
				sleep 0.02
			done		
		fi
		
		for ((y =0;  y < 3;  y++)); do
			clr=${clrHi[$y]}
			goto="\033[$(($PFy +15 +$y));$(($PFx +2))H"
			echo -en "${goto}${clr}${new[$y]}"
		done
		
	fi
}

#+=============================================================================
startDispNow() {
	ss=$((${#STRT[@]} -1))
	for ((sy = $((18 -$ss));  sy <= 18;  sy++)); do
		scrollPut
	done
	showHi 1
}

#+=============================================================================
start() {
	SEL=0

	showLang 0

	showHi 0
	(($FAST)) && startDispNow || scrollIn

	local pid=
	pressStart &
	pid=$!
	
	STATUS=("Press${keyL}F10${keyR}to view game statistics.")

	keyFlush
	drawSEL 1 $SEL 0
	while true; do
		STATUSupdate
		sleep 0.05
		keyGet
		case $KEY in
			[pP] )
				STATUS=
				STATUSupdate
				(($pid)) && killStart $pid
				scrollOut
				PFdrawShoulder 0 0 j
				PFdrawGrid
				PFdrawBasket 

				return 
				;;
			"BKSP" )  
				killStart $pid
				Quit 0 
				;;
			[qQ] | DEL )  
				if [[ $LANG == RU ]]; then
					LANG=EN
					AZ=$AZEN
				else
					LANG=RU 
					AZ=$AZRU
				fi
				showLang 1
				(($pid)) && killStart $pid
				pressStart &
				local pid=$!
				;;
			DOWN | [sS] )
				drawSEL 0 $SEL 0
				if [[ $SEL -ne 2 ]]; then
					drawSEL 1 $SEL 1
					sleep 0.02
					drawSEL 0 $SEL 1
				fi
				SEL=$((i=$SEL +1, i % 3))
				drawSEL 1 $SEL 0
				;;

			[wW] | UP ) 
				drawSEL 0 $SEL 0
				if [[ $SEL -ne 0 ]]; then
					drawSEL 1 $SEL -1
					sleep 0.02
					drawSEL 0 $SEL -1
				fi
				SEL=$((i=$SEL +2, i % 3))
				drawSEL 1 $SEL 0
				;;
			LEFT  | [aA] )
				goto="\033[$(($PFy +$SEL*2 +6));$(($PFx +10))H"
				clr="${atPFX}${fgBLK};${bgWHT}${atSFX}"
				case $SEL in
					0 ) local old=$STYLE
						case $STYLE in
							NVIS )  STYLE=CHAL ;;
							CHAL )  STYLE=NORM ;;
						esac 
						[[ $old != $STYLE ]] && optScroll $(($PFy +$SEL*2 +6)) $(($PFx +10)) ${clr} "L" $old $STYLE
						;;
					1 ) if [[ $LEVEL -gt 0 ]]; then
							local old=$LEVEL
							((LEVEL--))
							printf -v ch "%02d" $LEVEL
							echo -en "${goto}${clr}${ch}"
							scoreLvl=$LEVEL
							TETscoreShow
							showHi 1 left $old $LEVEL &
#							keyFlush
						fi ;;
					2 ) local old=$SOUND
						SOUND=OFF
						[[ $old != $SOUND ]] && optScroll $(($PFy +$SEL*2 +6)) $(($PFx +10)) ${clr} "L" $old $SOUND
						;;
				esac
				;;
			RIGHT | [dD] )
				goto="\033[$(($PFy +$SEL*2 +6));$(($PFx +10))H"
				clr="${atPFX}${fgBLK};${bgWHT}${atSFX}"
				case $SEL in
					0 ) local old=$STYLE
						case $STYLE in
							NORM )  STYLE=CHAL ;;
							CHAL )  STYLE=NVIS ;;
						esac 
						[[ $old != $STYLE ]] && optScroll $(($PFy +$SEL*2 +6)) $(($PFx +10)) ${clr} "R" $old $STYLE
						;;
					1 ) if [[ $LEVEL -lt 20 ]]; then
							local old=$LEVEL
							((LEVEL++))
							printf -v ch "%02d" $LEVEL
							echo -en "${goto}${clr}${ch}"
							scoreLvl=$LEVEL
							TETscoreShow
							showHi 1 right $old $LEVEL &
#							keyFlush
						fi ;;
					2 ) local old=$SOUND
						SOUND=BEL
						[[ $old != $SOUND ]] && optScroll $(($PFy +$SEL*2 +6)) $(($PFx +10)) ${clr} "R" $old $SOUND
						;;
				esac
				;;

			F10 )
				(($pid)) && killStart $pid
				dumpHi
				CSdrawBackdropReveal 0
				Redraw 2 # 1=fast, 2=don't redraw backdrop
				showLang 0
				startDispNow
				drawSEL 1 $SEL 0
				pressStart &
				local pid=$!
				;;
			
			F1 | "?" )
				(($pid)) && killStart $pid
				Help
				CSdrawBackdropReveal 0
				Redraw 2 # 1=fast, 2=don't redraw backdrop
				showLang 0
				startDispNow
				drawSEL 1 $SEL 0
				pressStart &
				local pid=$!
				;;
			
		esac
		
		STATUSupdate
	
	done
}

#+=============================================================================
PauseTwinkle() {
	local i
	goto="\033[$1;$2H"
	fg=("$atBLD;$fgBLK" "$fgBLU" "$atBLD;$fgBLU" "$fgCYN" "$atBLD;$fgCYN" "$fgWHT" "$atBLD;$fgWHT")
	for ((i = 1;  i < ${#fg[@]};  i++)); do
		echo -en "${goto}${atPFX}${fg[i]};${bgBLK}${atSFX}◘"
		sleep .01
	done
	for ((i = ${#fg[@]} -2;  i >= 0;  i--)); do
		echo -en "${goto}${atPFX}${fg[i]};${bgBLK}${atSFX}◘"
		sleep .01
	done
}

#+=============================================================================
hideGame()
{
	local y=
	local x=

	# grid
	for ((y = 0;  y <= $PFd;  y++)); do
		if [ $(($y & 1)) -eq 1 ]; then
			for ((x = 0;  x < $(($PFw*2 -1));  x += 2)); do
				GOTO $(($PFy +$y)) $(($PFx +$x +1))
				echo -en "${atPFX}${atBLD};${fgBLK};${bgBLK}${atSFX} ◘" # ; ■ "
			done
		else
			for ((x = 0;  x < $(($PFw*2 -1));  x += 2)); do
				GOTO $(($PFy +$y)) $(($PFx +$x +1))
				echo -en "${atPFX}${atBLD};${fgBLK};${bgBLK}${atSFX}◘ " # ; ■ "
			done
		fi
	done

	# basket
	for ((y = 0;  y < $(($BSh -1));  y++)); do
		if [ $(($y & 1)) -eq 1 ]; then
			for ((x = 0;  x < $(($BSw -3));  x += 2)); do
				GOTO $(($BSy +$y)) $(($BSx +$x +1))
				echo -en "${atPFX}${atBLD};${fgBLK};${bgBLK}${atSFX}◘ " # ; ■ "
			done
		else
			for ((x = 0;  x < $(($BSw -3));  x += 2)); do
				GOTO $(($BSy +$y)) $(($BSx +$x +1))
				echo -en "${atPFX}${atBLD};${fgBLK};${bgBLK}${atSFX} ◘" # ; ■ "
			done
		fi
	done

	# shoulder
	for ((y = 1;  y < $(($SHh -1));  y++)); do
		if [ $(($y & 1)) -eq 1 ]; then
			for ((x = 0;  x < $(($SHw -3));  x += 2)); do
				GOTO $(($SHy +$y)) $(($SHx +$x +1))
				echo -en "${atPFX}${atBLD};${fgBLK};${bgBLK}${atSFX} ◘" # ; ■ "
			done
		else
			for ((x = 0;  x < $(($SHw -3));  x += 2)); do
				GOTO $(($SHy +$y)) $(($SHx +$x +1))
				echo -en "${atPFX}${atBLD};${fgBLK};${bgBLK}${atSFX}◘ " # ; ■ "
			done
		fi
	done
}

#+=============================================================================
rigGame() {
	local tly=
	local tlx=
	
	local n=
	local t=
	
	# get titles
	local list=($(
		grep '^tc~[0-9]*~titl=' ${CMD} | \
		sed -e 's/tc~\([0-9]*\)~titl="\([^"]*\).*/\1:\2/' \
			-e 's/ /_/g' \
	))
	
	local w=
	for (( i = 0;  i < ${#list[@]};  i++)); do
		t="${list[$i]//*:/}"
		n=${#t}
		[[ $n -gt $w ]] && w=$n
	done
	((w += 8))
	tly=$(($((24 -${#list[@]})) /2))
	tlx=$(($PFx +$PFw -$w/2 +1))
	[[ $tlx -lt 1 ]] && tlx=1

	# Display menu
	GOTO $tly $tlx
	echo -en "${RED}╔"
	for (( i = 0;  i < $(($w -2)) ;  i++ )); do
		echo -en "═"
	done
	echo -en "╗"

	# show titles
	local valid=
	for (( i = 0;  i < ${#list[@]};  i++)); do
		n=${list[$i]//:*/}
		t=${list[$i]//*:/}
		GOTO $(($tly +$i +1))  $(($tlx))
		printf "${RED}║ ${GRN}%c ${BBLK}- ${BWHT}%-*s ${RED}║" $n $(($w -8)) "${t//_/ }"
		echo -en "${BBLK}▒"
		valid="${valid}${n}"
	done

	GOTO $(($tly +$i +1))  $(($tlx))
	echo -en "${RED}╚"
	for (( i = 0;  i < $(($w -2)) ;  i++ )); do
		echo -en "═"
	done
	echo -en "╝${BBLK}▒"

	GOTO $(($tly +${#list[@]} +2))  $(($tlx +1))
	echo -en "${BBLK}"
	for (( i = 0;  i < $w;  i++ )); do
		echo -en "▒"
	done

	# get selection
	while : ; do
		keyGet
		if strstr $valid $KEY ; then
			# load selection
			local item=($(
				grep -E "^tc~$KEY~(rot|tet|PF)" ${CMD} | \
				sed -e 's/tc~[0-9]*~//' \
					-e 's/\[ /\[/' \
					-e 's/ /_/g' \
			))
			
			for (( i = 0;  i < ${#item[@]};  i++)); do
				eval ${item[$i]}
			done
			return
		fi
		
		# abort
		if [[ "$KEY" == "BKSP" || "$KEY" == "ESC" ]]; then
			return
		fi
		sleep 0.05
	done
}

#+=============================================================================
Pause() {
	local y=
	local x=
	local i=
	local timeSt=$(date -u +%s)

	hideGame

	local PAUSE=()
	PAUSE+=("TTLTLLXJXJXJXIXXXIXTTTXTZLZZXZ")
	PAUSE+=("TJXJLXIIXLJLIIXXIIJJXJXJLLXLXX")
	PAUSE+=("JJXXXXIIXXLLITTTITXLXLLLJJXJXJ")

	for ((y = 0;  y < $PSh;  y++)); do
		for ((x = 0;  x < $PSw;  x++)); do
			ct=${PAUSE[$y]:$((x*2   )):1}
			cb=${PAUSE[$y]:$((x*2 +1)):1}
			eval clrt='$'{clrFg$ct}
			eval clrb='$'{clrFg$cb}
			((clrb += 10))
			GOTO $(($PFy +$PSy +$y)) $(($PFx +$PSx +$x +1))
			echo -en "${atPFX}${clrt};${clrb}${atSFX}▀"
		done
	done

	# be bored until we restart
	local timeBored=0
	local boredDelay=18 # seconds

	local csuits="♠♣♥♦"
	local csuit=${csuits:$(($RANDOM %4)):1}
	local cvalues="A23456789JQK"
	local cvalue=${cvalues:$(($RANDOM %12)):1}

	local boredMsg=()
	boredMsg+=("Press${keyL}P${keyR}to un-pause.")
	boredMsg+=("You can redraw the screen at any time by pressing${keyL}\`${keyR}")
	boredMsg+=("Алексей Пажитнов wrote Тетрис the year ${GROUP}${clrSTATUS} was formed.")
	boredMsg+=("Two sugars please...")
	boredMsg+=("E != mc²  ...  E² = m²(c^4) + p²c²")
	boredMsg+=("Tell them you're busy!")
	boredMsg+=("\"Bored Now\"")
	boredMsg+=("one-two ... one-two ... Is this thing on?")
	boredMsg+=("The array you're looking for is boredMsg[]")
	boredMsg+=("The QBit was named by Benjamin Schumacher.")
	boredMsg+=("\"You'll go blind doing that!\" [Conker T Squirrel]")
	boredMsg+=("Come back, or I'll start ticking your score down!")
	boredMsg+=("Were you thinking of the${keyL}${cvalue}${csuit}${keyR}?")
	boredMsg+=("That's it, you're only getting Z-tets from now on >:-(")
	boredMsg+=("Seriously: \`grep boredMsg ${NAME}\`")
	boredMsg+=("WW91IGp1c3QgbG9zdCBUaGUgR2FtZQ==")
	boredMsg+=("Did you know you can cheat by running \`${NAME} -d\` ?")
	boredMsg+=("··· ·~ ~~ ··~ · ·~·· / ~~ ~~~ ·~· ··· · / ~·· ·· ~·· ·· ~ ~·~·~~")
	boredMsg+=("My dad told me that last one ☺")
	boredMsg+=("OK, I'm bored of being bored now...")
	statSpeed=$statSlow

#	x=0
#	y=0

	keyFlush
	while true; do
		keyGet
		sleep 0.05
		[ "$KEY" == "BKSP" ] && {
			RUN=0
			return
		}
		[ "$KEY" == "P" ] || [ "$KEY" == "p" ] && break

		local timeNow=$(date -u +%s)
		if [ $timeNow -gt $(($timeBored +$boredDelay)) ]; then
			STATUS=${boredMsg[$boredCnt]}
			# I really don't want to pull values out of the PRNG
			# as it will effect the game!
			[ $((++boredCnt)) -ge ${#boredMsg[@]} ] && boredCnt=0
			timeBored=$(date -u +%s)
		fi
		STATUSupdate

		y=$(($RANDOM % $PFh +$PFy))
		i=$(($BSx +$BSw -2))
		x=$(($RANDOM % $i +1))

#		((x++))
#		[[ $x -gt 80 ]] && x=0
#		[[ $x -eq  0 ]] && ((y++))
#		[[ $y -gt 24 ]] && y=24
#		GOTO 1 1
#		echo $y,$x

		if [[ \
			( ( ($(($y & 1)) -eq 0) && ($(($x & 1)) -eq 1) ) || \
			  ( ($(($y & 1)) -eq 1) && ($(($x & 1)) -eq 0) ) \
			) && \
			( \
				( ( ($y -ge $(($SHy +1)) ) && ($y -le $(($SHy +$SHh -2)) ) ) && \
				  ( ($x -ge $(($SHx +1)) ) && ($x -le $(($SHx +$SHw -2)) ) ) \
				) || \
				( ( ($y -ge    $PFy      ) && ($y -le $(($PFy +$PSy -1)) ) ) && \
				  ( ($x -ge $(($PFx +1)) ) && ($x -le $(($PFx + $PFw*2)) ) ) \
				) || \
				( ( ($y -ge $(($PFy +PSy)) ) && ($y -le $(($PFy +$PSy +$PSh -1)) ) ) && \
				  ( ( ($x -ge $(($PFx +1            )) ) && ($x -le $(($PFx +$PSx   )) ) ) || \
					( ($x -ge $(($PFx +$PSx +$PSw +1)) ) && ($x -le $(($PFx + $PFw*2)) ) ) \
				  ) \
				) || \
				( ( ($y -ge $(($PFy +PSy +$PSh)) ) && ($y -le $(($PFy +$PFd   )) ) ) && \
				  ( ($x -ge $(($PFx +1        )) ) && ($x -le $(($PFx + $PFw*2)) ) ) \
				) || \
				( ($y -ge    $BSy      ) && ($y -le $(($BSy +$BSh -2)) ) && \
				  ($x -ge $(($BSx +1)) ) && ($x -le $(($BSx +$BSw -2)) ) \
				) \
			) \
		]]; then
			#GOTO $y $x
			#echo -en "*"
			PauseTwinkle $y $x &
		fi

	done
	statSpeed=$statFast
	wait

	PFdrawGrid # not thread-safe!
	PFdrawBasket &
	PFdrawShoulder 0 0 j &
	wait
	TETdrawBs
	TETdrawSh
	TETdraw

	local timeNd=$(date -u +%s)
	((timePause += timeNd - timeSt))
}

#+=============================================================================
drawRkt() {
	local aty=$1
	local atx=$2
	local clr=  # 99: exhaust
	[[ "$3" == "99" ]] && clr=99 || clr="${atPFX}${3};${bgBLK}${atSFX}"
	shift
	shift
	shift

	local exc=("${fgRED}" "${atBLD};${fgRED}" "${fgYEL}") # exhaust colours
	local y=0
	while [[ ! -z $1 ]]; do 
		if [[ $(($aty +$y)) -ge 1 ]]; then
			local x
			for ((x = 0;  x < ${#1};  x++)); do
				local ch=${1:$x:1}
				local goto="\033[$(($aty+$y));$(($atx+$x))H"
				if [[ "$clr" != "99" ]]; then
					local ink=$clr
				else 
					local n=$RANDOM
					local r=$(($n % ${#exc[@]}))
					local ink="${atPFX}${exc[$r]};${bgBLK}${atSFX}"
				fi
				case "$ch" in
					"¬" )  continue ;;
					"X" )  echo -en "${goto}${atOFF} " ;;
					*   )  echo -en "${goto}${ink}${ch}" ;;
				esac
			done
		fi
		((y++))
		shift
	done

}

#+=============================================================================
getInitials() {
	local sc=
	
	GOTO $(($PFy + 10)) $(($PFx + 2))
	echo -en "${BBLK}-${WHT}-${YEL}- HIGH SCORE ${YEL}-${WHT}-${BBLK}-"

	GOTO $(($PFy + 12)) $(($PFx + 5))
	printf -v sc "%'10d" $score
	echo -en "${WHT}▐${clrSCOREv}${sc}${WHT}▌"

	GOTO $(($PFy + 14)) $(($PFx + 4))
	echo -en "${MAG}INITIALS: ${clrNAME}▌   ▐"

	local AZ=
	[[ $LANG == RU ]] && AZ=$AZRU || AZ=$AZEN

	local cur=0
	local chr=$((${#AZ}-1))
	local name=("${nbsp}" "${nbsp}" "${nbsp}")
	name[$cur]=${AZ:$chr:1}

	STATUS="Identify yourself, human."
	STATUSupdate

	local clr=${clrNAME}
	local next=$(($(date +%s%N | sed -e 's/\(.*\)....../\1/') +300))
	keyFlush
	while : ; do
		local now=$(date +%s%N | sed -e 's/\(.*\)....../\1/')
		if [[ $now -gt $next ]]; then
			next=$(($(date +%s%N | sed -e 's/\(.*\)....../\1/') +300))
			[[ "$clr" == "${clrNAME}" ]] && clr=${clrNAMEc} || clr=${clrNAME}
		fi
		GOTO $(($PFy + 14)) $(($PFx + 15 + $cur))
		echo -en "${clr}${name[$cur]}"
		keyGet
		case $KEY in
			[Qq] ) 
				if   [[ ${AZ:1:1} == "B" ]]; then 
					AZ=$AZRU
				elif [[ ${AZ:1:1} == "Б" ]]; then 
					AZ="≡ßÇ"
				else
					AZ=$AZEN
				fi 
				name[$cur]=${AZ:$chr:1} 
				;;

			RIGHT | [dD] | [xX.] )  
				if [[ $cur -lt 2 ]]; then
					GOTO $(($PFy + 14)) $(($PFx + 15 + $cur))
					echo -en "${clrNAME}${name[$cur]}"
					((cur++)) 
					[[ ${name[$cur]} == "${nbsp}" ]] && name[$cur]="${AZ:$chr:1}"
				fi ;;
						 
			LEFT  | [aA] )  
				if [[ $cur -gt 0 ]]; then
					GOTO $(($PFy + 14)) $(($PFx + 15 + $cur))
					echo -en "${clrNAME}${name[$cur]}"
					((cur--)) 
				fi ;;
			
			[zZ,] )  
				name[$cur]=" "
				if [[ $cur -gt 0 ]]; then
					GOTO $(($PFy + 14)) $(($PFx + 15 + $cur))
					echo -en "${clrNAME}${name[$cur]}"
					((cur--)) 
				fi ;;

			DOWN | [sS]  )
				chr=$((z = $chr +${#AZ} -1, z % ${#AZ}))
				name[$cur]=${AZ:$chr:1} 
				;;
			
			[wW] | UP    ) 
				chr=$((z = $chr +1, z % ${#AZ}))
				name[$cur]=${AZ:$chr:1}
				;;
			
			[pP]         ) break ;;
		esac
		sleep 0.05
		STATUSupdate
	done
	STATUS=
	STATUSupdate
	
	if [[ $1 -le 2 ]]; then # move 2nd -> 3rd
		local old=$(grep "^~hs:${LEVEL},2," ${CMD} | sed "s/\([^,],\).\(.*\)/\13\2/")
		#                       -v-    -^-                                -^-
		sed -ie "s/^~hs:${LEVEL},3,.*/${old}/" ${CMD}
	fi
	if [[ $1 -eq 1 ]]; then # move 1st -> 2nd
		local old=$(grep "^~hs:${LEVEL},1," ${CMD} | sed "s/\([^,],\).\(.*\)/\12\2/")
		sed -ie "s/^~hs:${LEVEL},2,.*/${old}/" ${CMD}
	fi
	# add new entry
	local hsl="${name[0]}${name[1]}${name[2]},${score}"
	hsl="${hsl},${scoreLin},${scoreMulMax},${scoreBest},${timeTotal},${SEED}"
	local tot=0
	for i in L J S Z T O I ; do
		eval tet=('$'{tet$i[@]})
		hsl="${hsl},${tet[8]}"
		((tot += ${tet[8]}))
	done
	hsl="${hsl},${tot}"
	hsl="${hsl},${tetSilv},${tetGold}"
	sed -ie "s/^\(~hs:${LEVEL},${hs},\).*/\1${hsl}/" ${CMD}

}

#+=============================================================================
rktLoadSprites() {
	# load rocket sprites
	RKT=() ; while read -r l ; do RKT+=("${l:7:-1}") ; done <<< $(grep "^rocket:" ${CMD})
	X1A=() ; while read -r l ; do X1A+=("${l:7:-1}") ; done <<< $(grep "^rx1a_.:" ${CMD})
	X1B=() ; while read -r l ; do X1B+=("${l:7:-1}") ; done <<< $(grep "^rx1b_.:" ${CMD})
	X2A=() ; while read -r l ; do X2A+=("${l:7:-1}") ; done <<< $(grep "^rx2a_.:" ${CMD})
	X2B=() ; while read -r l ; do X2B+=("${l:7:-1}") ; done <<< $(grep "^rx2b_.:" ${CMD})
	X3A=() ; while read -r l ; do X3A+=("${l:7:-1}") ; done <<< $(grep "^rx3a_.:" ${CMD})
	X3B=() ; while read -r l ; do X3B+=("${l:7:-1}") ; done <<< $(grep "^rx3b_.:" ${CMD})
	X4A=() ; while read -r l ; do X4A+=("${l:7:-1}") ; done <<< $(grep "^rx4a_.:" ${CMD})
	X4B=() ; while read -r l ; do X4B+=("${l:7:-1}") ; done <<< $(grep "^rx4b_.:" ${CMD})
	GND=() ; while read -r l ; do GND+=("${l:7:-1}") ; done <<< $(grep "^rktgnd:" ${CMD})
	STAR=() ; while read -r l ; do STAR+=("${l:8:-1}") ; done <<< $(grep "^rktstar:" ${CMD})
	MOON=() ; while read -r l ; do MOON+=("${l:8:-1}") ; done <<< $(grep "^rktmoon:" ${CMD})
	RKTLOADED=1
}

#+=============================================================================
rktReveal() {  # (draw_rocket)
	[[ "$RKTLOADED" != "1" ]] && rktLoadSprites
	
	local y=
	for (( y = 0;  y < 19;  y++)); do
		if [[ $y -lt 5 ]]; then
			drawRkt $(($PFy+$y)) $(($PFx+1)) "${fgCYN}" "${STAR[$y]}"
			drawRkt $(($PFy+$y)) $(($PFx+1)) "${atBLD};${fgWHT}" "${MOON[$y]}"
		elif [[ $y -lt 7 ]]; then
			drawRkt $(($PFy+$y)) $(($PFx+1)) "${fgCYN}" "${STAR[$y]}"
		elif [[ $y -le 8 ]]; then
			drawRkt $(($PFy+$y)) $(($PFx+1)) "${atBLD};${fgMAG}" "                    "
			drawRkt $(($PFy+$y)) $(($PFx+1)) "${fgCYN}" "${STAR[$y]}"
			[[ ! -z $1 ]] && drawRkt $(($PFy+$y)) $(($PFx+3)) "${atBLD};${fgMAG}" "${RKT[$(($y-7))]}"
		elif [[ $y -lt 18 ]]; then
			drawRkt $(($PFy+$y)) $(($PFx+1)) "${atBLD};${fgMAG}" "                    "
			[[ ! -z $1 ]] && drawRkt $(($PFy+$y)) $(($PFx+3)) "${atBLD};${fgMAG}" "${RKT[$(($y-7))]}"
		else
			drawRkt $(($PFy+$y)) $(($PFx+1)) "${fgGRN}" "${GND[@]}"
		fi
		[[ $(($y%3)) -ne 2 ]] && sleep 0.12
	done
}

#+=============================================================================
cleanup() {
	local cs=("")
		cs+=("──╖╓────╖╓────╖╓")
		cs+=("╓─╖║ °╓─╖║ °╓─╖║")
		cs+=("╙─╖║  ╙─╖║  ╙─╖║")

	local y=
	for ((y = 1;  y <= 3;  y++)); do
		echo -en "\033[${y};$(($PFx +3))H${CSminiClr}${cs[$y]}"
	done

	for (( y = 0;  y <= 11;  y++)); do
		local l=$(($y % 3))
		
		echo -en "\033[$(($BSy+$y));$(($BSx+1))H${atOFF}          " 

		if [[ $y -le 4  && $y -gt 0 ]]; then
			echo -en "\033[$(($SHy+$y));$(($SHx+1))H${atOFF}          " 
		fi
		[[ $l -ne 2 ]] && sleep 0.12
	done

}

#+=============================================================================
teleport() {
	local y=
	local x=
	local MASK=("${RKT[@]}")
	local d=$((${#MASK[@]} -1))

	for ((y = 0;  y < $d;  y++)); do
		MASK[$y]=$(echo "${MASK[$y]}" | sed 's/ /S/g')
		MASK[$y]=$(echo "${MASK[$y]}" | sed 's/X/¬/g')
		MASK[$y]=$(echo "${MASK[$y]}" | sed 's/[^¬S]/G/g')
	done

	local hit=1
	while [[ $hit -eq 1 ]] ; do
		hit=0
		for ((y = 0;  y < $d;  y++)); do
			local w=${#MASK[$y]}
			for ((x = 0;  x < $w;  x++)); do
				local mch="${MASK[$y]:$x:1}"
				case "$mch" in
					"¬" ) continue ;;
					"S" ) 
						local s=" \`\'.,;:"  
						local n=$RANDOM
						((n %= ${#s}))
						if [[ $n -eq 0 ]]; then
							clr="${atBLD};${fgMAG}"
							ch=" "
							MASK[$y]="${MASK[$y]:0:$x}${ch}${MASK[$y]:$(($x+1))}"
						else
							local c=$RANDOM
							((c %= 3))
							case "$c" in
								0 ) clr="${atBLD};${fgBLK}"  ;;
								1 ) clr="${fgWHT}"           ;;
								2 ) clr="${fgBLU}"           ;;
							esac
							ch="${s:$n:1}"
							hit=1
						fi ;;
					"G" )
						local s=" \\/{}[]()"
						local n=$RANDOM
						((n %= ${#s}))
						if [[ $n -eq 0 ]]; then
							clr="${atBLD};${fgMAG}"
							ch="${RKT[$y]:$x:1}"
							MASK[$y]="${MASK[$y]:0:$x}${ch}${MASK[$y]:$(($x+1))}"
						else
							local c=$RANDOM
							((c %= 3))
							case "$c" in
								0 ) clr="${atBLD};${fgBLK}"  ;;
								1 ) clr="${fgWHT}"           ;;
								2 ) clr="${fgBLU}"           ;;
							esac
							ch="${s:$n:1}"
							hit=1
						fi ;;
					*)
						clr="${atBLD};${fgMAG}"
						ch=${mch}
						;;
				esac
				GOTO $(($PFy +$y +7)) $(($PFx +$x +3))
				echo -en "${atPFX}${clr};${bgBLK}${atSFX}${ch}"
			done
			sleep 0.007
		done
	done
}

#+=============================================================================
takeoff() {
	local tly=$PFy
	local tlx=$PFx

	local ry=$(($tly+7))
	local rx=$(($tlx+3))
	local tx=$(($rx-2))
	local spd=100
	local step=2

	# picture
#	drawRkt $(($tly)) $(($tlx+1)) "${fgCYN}" "${STAR[@]}"
#	drawRkt $(($tly)) $(($tlx+1)) "${atBLD};${fgWHT}" "${MOON[@]}"
#	drawRkt $(($ry)) $(($rx)) "${atBLD};${fgMAG}" "${RKT[@]}"
#	drawRkt $(($tly+18)) $(($tx)) "${fgGRN}" "${GND[@]}"
	sleep 1

	# start engines
	local i=
	local n=19
	for (( i = 0 ;  i < $n;  i++)); do
		if (($i & 1)); then drawRkt $(($ry+${#RKT[@]}-2)) $(($rx+2)) 99 "${X1A[@]}"
		else                drawRkt $(($ry+${#RKT[@]}-2)) $(($rx+2)) 99 "${X1B[@]}" ; fi
		sleep 0.$spd
	done

	# lift off
	((ry--))
	drawRkt $(($tly)) $(($tlx+1)) "${fgCYN}" "${STAR[@]}"
	drawRkt $(($tly)) $(($tlx+1)) "${atBLD};${fgWHT}" "${MOON[@]}"
	drawRkt $(($ry)) $(($rx)) "${atBLD};${fgMAG}" "${RKT[@]}"
	
	for (( n += $step;  i < $n;  i++)); do
		if (($i & 1)); then drawRkt $(($ry+${#RKT[@]}-2)) $(($rx+2)) 99 "${X2A[@]}"
		else                drawRkt $(($ry+${#RKT[@]}-2)) $(($rx+2)) 99 "${X2B[@]}" ; fi
		sleep 0.$spd
	done
	
	# 3
	((ry--))
	drawRkt $(($tly)) $(($tlx+1)) "${fgCYN}" "${STAR[@]}"
	drawRkt $(($tly)) $(($tlx+1)) "${atBLD};${fgWHT}" "${MOON[@]}"
	drawRkt $(($ry)) $(($rx)) "${atBLD};${fgMAG}" "${RKT[@]}"
	
	for (( n += $step;  i < $n;  i++)); do
		if (($i & 1)); then drawRkt $(($ry+${#RKT[@]}-2)) $(($rx+2)) 99 "${X3A[@]}"
		else                drawRkt $(($ry+${#RKT[@]}-2)) $(($rx+2)) 99 "${X3B[@]}" ; fi
		sleep 0.$spd
	done
	
	# fly away
	local z=
	for (( z = 1;  z < 25;  z++)); do
		((ry--))
		drawRkt $(($tly)) $(($tlx+1)) "${fgCYN}" "${STAR[@]}"
		drawRkt $(($tly)) $(($tlx+1)) "${atBLD};${fgWHT}" "${MOON[@]}"
		drawRkt $(($ry)) $(($rx)) "${atBLD};${fgMAG}" "${RKT[@]}"
		
		for (( n += $step;  i < $n;  i++)); do
			if (($i & 1)); then drawRkt $(($ry+${#RKT[@]}-2)) $(($rx+2)) 99 "${X4A[@]}"
			else                drawRkt $(($ry+${#RKT[@]}-2)) $(($rx+2)) 99 "${X4B[@]}" ; fi
			[[ $z -eq 1 ]] && drawRkt $(($tly+18)) $(($tx)) "${fgGRN}" "${GND[@]}"
			sleep 0.$spd
		done
		# accelerate
		spd=$((1$spd -1003))
		printf -v spd "%03d" $spd
		#DBG $spd
	done

}

#+=============================================================================
brickout() {
	local x=
	local y=
	local l=

	echo -en "${atPFX}${atBLD};${fgBLK};${bgBLK}${atSFX}"
#	echo -en "${atPFX}${fgRED};${bgBLK}${atSFX}"
	for (( y = 18;  y >= 0;  y--)); do
		local l=$(($y % 3))
		case $l in
			"0" )  echo -en "\033[$(($PFy+$y));$(($PFx+1))H█ ████ ████ ████ ███" ;;
			"1" )  echo -en "\033[$(($PFy+$y));$(($PFx+1))H▄▄▄ ▄▄▄▄ ▄▄▄▄ ▄▄▄▄ ▄" ;;
			"2" )  echo -en "\033[$(($PFy+$y));$(($PFx+1))H▀▀▀ ▀▀▀▀ ▀▀▀▀ ▀▀▀▀ ▀" ;;
		esac
		
		if [[ $y -le 11 ]]; then
			case $l in
				"0" )  echo -en "\033[$(($BSy+$y));$(($BSx+1))H█ ████ ███" ;;
				"1" )  echo -en "\033[$(($BSy+$y));$(($BSx+1))H▄▄▄ ▄▄▄▄ ▄" ;;
				"2" )  echo -en "\033[$(($BSy+$y));$(($BSx+1))H▀▀▀ ▀▀▀▀ ▀" ;;
			esac
		fi
		
		if [[ $y -le 4  && $y -gt 0 ]]; then
			case $l in
				"0" )  echo -en "\033[$(($SHy+$y));$(($SHx+1))H▀▀▀ ▀▀▀▀ ▀" ;;
				"1" )  echo -en "\033[$(($SHy+$y));$(($SHx+1))H█ ████ ███" ;;
				"2" )  echo -en "\033[$(($SHy+$y));$(($SHx+1))H▄▄▄ ▄▄▄▄ ▄" ;;
			esac
		fi
		[[ $l -ne 2 ]] && sleep 0.12
	done
}

#+=============================================================================
DBG() {
	[[ ($DEBUG -eq 1) && -p $DBGpipe ]] && echo $@  >$DBGpipe
}

#+=============================================================================
# You cannot have any spaces in your format string
# How to fix?
#
DBGF() {
	[[ ($DEBUG -eq 1) && -p $DBGpipe ]] && printf $@  >$DBGpipe
}

#+=============================================================================
DBGmonitor() {
	[[ ! -e $DBGpipe ]] && mknod $DBGpipe p
	if [[ -p $DBGpipe ]]; then
		local d=$(date +%Y/%m/%d_%T)
		echo -e "${GRN}$NAME debug monitor ${atOFF}... ${YEL}$d ${atOFF}... ${RED}^C to exit.${atOFF}"
		ctrlC_init ctrlC_pipe  # trap ^C
		tail -f $DBGpipe
	else
		echo "! Error: $DBGpipe exists, and is not a named pipe"
	fi
	exit 0
}

#+=============================================================================
introduce() {
	local slp=0.2
	local i=
	
	TETdrawSh
	sleep $slp
	TETundrawSh
	sleep $slp
	TETdrawSh
	sleep $slp
	
	for ((i = 1;  i <= 3;  i++)); do
		TETadd 0  # 0 = do NOT update stats
		TETdrawBs  # redraw basket tets
		sleep $slp
		TETdrawTet "${nbsp}${nbsp}" $(($BSy -1 +2*4)) $(($BSx +3)) 0 ${tet3[@]}
		sleep $slp
		TETdrawTet "${tetGR}"     $(($BSy -1 +2*4)) $(($BSx +3)) 0 ${tet3[@]}
		sleep $slp
	done

	TETadd 1  # 0 = do NOT update stats
	TETdrawBs  # redraw basket tets
	TETdraw
	sleep $slp
	TETundraw
	sleep $slp
	TETdraw
}

#+=============================================================================
segment() {
	local cnt=()
	cnt+=("1101111") #  1    _
	cnt+=("0001001") # 234  |_|
	cnt+=("1011110") # 567  |_|
	cnt+=("1011011")
	cnt+=("0111001")
	cnt+=("1110011")
	cnt+=("1110111")
	cnt+=("1001001")
	cnt+=("1111111")
	cnt+=("1111001")
	
	local clr=("${BBLK}" "${GRN}")
	
	echo -en "\033[1C"
	echo -en "${clr[${cnt[$1]:0:1}]}__\033[3D\033[1B"
	echo -en "${clr[${cnt[$1]:1:1}]}|"
	echo -en "${clr[${cnt[$1]:2:1}]}__"
	echo -en "${clr[${cnt[$1]:3:1}]}|\033[4D\033[1B"
	echo -en "${clr[${cnt[$1]:4:1}]}|"
	echo -en "${clr[${cnt[$1]:5:1}]}__"
	echo -en "${clr[${cnt[$1]:6:1}]}|\033[4D\033[1B"
}

#+=============================================================================
dumpHi() {
	CSdrawBackdropReveal 0

	local mode=0
	echo -en "$GRN"
	
	STATUS=
	STATUSupdate

	GOTO 1 1
	
	local off=7

	echo -e  "\033[${off}C${BLU}╔════════════╦"
    echo -e  "\033[${off}C║${CYN} Ranking    ${BLU}║"
    echo -e  "\033[${off}C║${CYN} Initials   ${BLU}║"
    echo -e  "\033[${off}C║${CYN} Score      ${BLU}║"
    echo -e  "\033[${off}C╟─----------─╫"
    echo -e  "\033[${off}C║${CYN} Lines      ${BLU}║"
    echo -e  "\033[${off}C║${CYN} Best Mult. ${BLU}║"
    echo -e  "\033[${off}C║${CYN} Best Piece ${BLU}║"
    echo -e  "\033[${off}C║${CYN} Play Time  ${BLU}║"
    echo -e  "\033[${off}C╟─----------─╫"
    echo -e  "\033[${off}C║${BWHT} Silver     ${BLU}║"
    echo -e  "\033[${off}C║${YEL} Gold       ${BLU}║"
    echo -e  "\033[${off}C╟─----------─╫"
    echo -e  "\033[${off}C║${tetL[4]}     L-tets ${BLU}║"
    echo -e  "\033[${off}C║${tetJ[4]}     J-tets ${BLU}║"
    echo -e  "\033[${off}C║${tetS[4]}     S-tets ${BLU}║"
    echo -e  "\033[${off}C║${tetZ[4]}     Z-tets ${BLU}║"
    echo -e  "\033[${off}C║${tetT[4]}     T-tets ${BLU}║"
    echo -e  "\033[${off}C║${tetO[4]}     O-tets ${BLU}║"
    echo -e  "\033[${off}C║${tetI[4]}     I-tets ${BLU}║"
    echo -e  "\033[${off}C╟─----------─╫"
    echo -e  "\033[${off}C║${CYN} Total Tets ${BLU}║"
    echo -e  "\033[${off}C║${CYN} PRNG Seed  ${BLU}║"
    echo -e  "\033[${off}C╚════════════╩"
#    echo -en "\033[${off}C ${BBLK}▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀"

	local ly=2
	local lx=63                                                                            
										   
    echo -e  "\033[$(($ly+0));${lx}H${MAG}┌──────────┐"
    echo -e  "\033[$(($ly+1));${lx}H${MAG}│          │" #${BBLK}█"
    echo -e  "\033[$(($ly+2));${lx}H${MAG}│          │" #${BBLK}█"
    echo -e  "\033[$(($ly+3));${lx}H${MAG}│          │" #${BBLK}█"
    echo -e  "\033[$(($ly+4));${lx}H${MAG}│          │" #${BBLK}█"                 
    echo -e  "\033[$(($ly+5));${lx}H${MAG}├──────────┤" #${BBLK}█"              
	
    echo -en "\033[$(($ly+6));${lx}H${MAG}│ "
    echo -en "${atPFX}${fgBLU};${bgBLK}${atSFX}▐${atPFX}${atBLD};${fgYEL};${bgBLU}${atSFX}←${atPFX}${fgBLU};${bgBLK}${atSFX}▌"
    echo -en "  " #\033[4C"
    echo -en "${atPFX}${fgBLU};${bgBLK}${atSFX}▐${atPFX}${atBLD};${fgYEL};${bgBLU}${atSFX}→${atPFX}${fgBLU};${bgBLK}${atSFX}▌"
	echo -en "${MAG} │" #${BBLK}█"

    echo -e  "\033[$(($ly+7));${lx}H${MAG}└──────────┘" #${BBLK}█"
#    echo -en "\033[$(($ly+8));$(($lx+1))H${BBLK}°╓─╖║ °╓─╖║ "

	local pos=("1st" "2nd" "3rd")  
	local tr=("${BLU}╤" "${BLU}╤" "${BLU}╗")            
	local jr=("${BLU}┼" "${BLU}┼" "${BLU}╢") #${BBLK}█")            
	local rt=("${BLU}│" "${BLU}│" "${BLU}║") #${BBLK}█")            
	local br=("${BLU}╧" "${BLU}╧" "${BLU}╝") #${BBLK}█")            
	
	LEVEL=0                        
	while true ; do
		showHi 0
		GOTO $(($ly+1)) $(($lx+2))
		segment $(($LEVEL/10))
		GOTO $(($ly+1)) $(($lx+6))
		segment $(($LEVEL%10))                                 
		for ((y = 1;  y <= 24;  y++)); do                      
			for ((h = 0;  h <= 2;  h++)); do
				GOTO $y $((${off} +15 + $h*13))
				local hi=
				eval hi=('$'{HI${h}[@]})
				case $y in
					 1 )  printf  "${BLU}════════════${tr[$h]}"                ;;
					 2 )  printf  "${WHT}    %3s     ${rt[$h]}" "${pos[${h}]}" ;;
					 3 )  printf  "${WHT}    %3s     ${rt[$h]}" "${hi[2]}"     ;;
					 4 )  printf       "${WHT} %'10d ${rt[$h]}" "${hi[3]}"     ;;
					 5 )  printf  "${BLU}─----------─${jr[$h]}"                ;;
					 6 )  printf   "${WHT} [%4d]     ${rt[$h]}" "${hi[4]}"     ;;
					 7 )  printf  "${WHT} [x%3d]     ${rt[$h]}" "${hi[5]}"     ;; 
					 8 )  printf   "${WHT} [%4d]     ${rt[$h]}" "${hi[6]}"     ;;
					 9 )  local t="$(date -u -d @${hi[7]} +"%T")"
					      printf       "${WHT}   %8s ${rt[$h]}" "${t}"         ;;
					10 )  printf  "${BLU}─----------─${jr[$h]}"                ;;
					11 )  printf  "${WHT} [%3d]      ${rt[$h]}" "${hi[17]}"    ;;
					12 )  printf  "${WHT} [%3d]      ${rt[$h]}" "${hi[18]}"    ;;
					13 )  printf  "${BLU}─----------─${jr[$h]}"                ;;
					14 )  printf  "${WHT}     %3d    ${rt[$h]}" "${hi[9]}"     ;;
					15 )  printf  "${WHT}     %3d    ${rt[$h]}" "${hi[10]}"    ;;
					16 )  printf  "${WHT}     %3d    ${rt[$h]}" "${hi[11]}"    ;;
					17 )  printf  "${WHT}     %3d    ${rt[$h]}" "${hi[12]}"    ;;
					18 )  printf  "${WHT}     %3d    ${rt[$h]}" "${hi[13]}"    ;;
					19 )  printf  "${WHT}     %3d    ${rt[$h]}" "${hi[14]}"    ;;
					20 )  printf  "${WHT}     %3d    ${rt[$h]}" "${hi[15]}"    ;;
					21 )  printf  "${BLU}─----------─${jr[$h]}"                ;;
					22 )  printf    "${WHT}   %5d    ${rt[$h]}" "${hi[16]}"    ;;
					23 )  printf    "${WHT}   %5d    ${rt[$h]}" "${hi[8]}"     ;;
					24 )  printf  "${BLU}════════════${br[$h]}"                ;;
				esac      
			done
		done
		
		while ! keyGet ; do sleep 0.1 ; done
		case $KEY in
			LEFT  | [aA]   )  [[ $LEVEL -gt  0 ]] && ((LEVEL--)) ;;
			RIGHT | [dD]   )  [[ $LEVEL -lt 20 ]] && ((LEVEL++)) ;;
		    BKSP  | [pPqQ] )  break ;;
		esac
	done
}

#+=============================================================================
BAShTris() {
	start
	
	if [[ ($LEVEL -lt 3) && ($DEBUG -eq 0) && ($STYLE == NORM) ]]; then
		introduce
	else
		TETdrawSh  # draw shoulder piece
		TETadd 0  # 0 = do NOT update stats
		TETadd 0  # 0 = do NOT update stats
		TETadd 0  # 0 = do NOT update stats
		TETadd 1  # 0 = do NOT update stats
		TETdrawBs  # redraw basket tets
		TETdraw
	fi
		
	SPEEDset
	SPEEDstamp
	
	[ "$USEED" == "X" ] && SEED=$RANDOM || SEED=$USEED
	RND seed $SEED
	STATUS="Round $RNDs: Fight!"
	
	TIMEstart
	
#----------------------------------------------------------
# Main game loop
#
	RUN=1
	while [[ $RUN -eq 1 ]]; do
		TIMEshow
		speedNow=$(date +%s%N | sed -e 's/\(.*\)....../\1/')
		if [ $speedNow -ge $speedNext ]; then
			(($FREEZE)) || {
				# auto drop
				KEY=DOWN
				auto=1
			}
			SPEEDstamp
		else
			# get keystroke
			keyGet
			auto=0
		fi
		
		act=0
		if [ ! -z "$KEY" ] ; then
			tety=$tetY
			tetx=$tetX
			trot=$rot
		
			#------------------------------
			# DEBUG KEYS
			#
			(($DEBUG)) && case $KEY in
				[qQ] | DEL )  TETswap ;;  # shoulder swap
		
				6 | ^ ) # move piece UP!!
					act=1
					tety=$(($tetY -1))
					SPEEDstamp
					;;
		
				0 ) # (un)Freeze auto-drop
					(($FREEZE)) && FREEZE=0 || FREEZE=1
					;;
		
				INS ) # place the piece where it is
					TETplace
					PFdrawGrid
					TETadd 1 ; TETdrawBs ; TETdraw
					SPEEDstamp
					;;
		
				END ) # discard tetromino
					TETundraw
					TETadd 1 ; TETdrawBs ; TETdraw
					SPEEDstamp
					;;
		
				PGUP ) # advance 1 level (score 10 lines)
					TETscore 10
					TETundraw
					TETadd 1 ; TETdrawBs ; TETdraw
					SPEEDstamp
					;;
		
				* )  # unknown keystroke
					;;
			esac
		
			case $KEY in
				LEFT  | [aA] )  act=1 ; ((tetx--)) ;;
				RIGHT | [dD] )  act=1 ; ((tetx++)) ;;
		
				[zZ,]        )  act=1 ; trot=$((x = $rot +3,  x %4)) ;; # rot left
				[xX.]        )  act=1 ; trot=$((x = $rot +1,  x %4)) ;; # rot right
		
				[qQ] | DEL   ) [ $tetSwap -eq 0 ] && TETswap ;;  # shoulder swap
		
				[pP]         )
					Pause
					;;
		
				F1 | "?" )
					hideGame
					Help
					CSdrawBackdropReveal 0
					Redraw 2 # 1=fast, 2=don't redraw backdrop
					Pause
					;;
				
				F12 )
					hideGame
					rigGame
					CSdrawBackdropReveal 0
					Redraw 2 # 1=fast, 2=don't redraw backdrop
					TETdrawSh
					TETdrawBs
					;;
				
				DOWN | [sS] )
					act=1
					((tety++))
#					SPEEDstamp  # restart timer
					[ $auto -eq 0 ] && ((tetVal += 1))  # speed bonus
					KEY=DOWN # known name
					;;
		
				[wW] | UP )  # drop
					KEY=DOWN  # stop shadow redraw
					for ((y = $tetY;  y < $shadY;  y++)); do
						TETundraw
						((tetY++))
						((tetVal++))
						TETdraw
					done
					((tetVal += 10))
					TETplace
					# next please
					TETadd 1 ; TETdrawBs ; TETdraw
					SPEEDstamp
					;;
		
				"\`" )
					Redraw 1
					TETdraw
					TETdrawSh
					TETdrawBs
					;;
		
				BKSP )
					hideGame
					STATUS="> CONFIRM SHUT-DOWN?  ${keyL}Y${keyR}/${keyL}N${keyR}"
					STATUSupdate
					local timeSt=$(date -u +%s)
					while true ; do
						keyGet
						case $KEY in
							[yY]   ) 
								RUN=0  
								break ;;
							[nNpP] ) 
								Redraw 2 # 1=fast, 2=don't redraw backdrop
								break ;;
						esac
						sleep .05
					done
					STATUS=""
					STATUSupdate
					local timeNd=$(date -u +%s)
					((timePause += timeNd - timeSt))
					;;

				* ) ;;
			esac
		fi
		
		# Collision detection
		(($act)) && {
			TETcollide  $tety $tetx ${tet0[$trot]}
			if ((!$?)); then  # No collision
				TETundraw
				tetX=$tetx
				tetY=$tety
				rot=$trot
				TETdraw
			else  # collision
#				if                    [ "$KEY" == "DOWN" ]; then  # user can place
				if [ $auto -eq 1 ] || [ "$KEY" == "DOWN" ]; then  # place only on auto-drop
					TETplace
					TETadd 1 ; TETdrawBs ; TETdraw
					SPEEDstamp
				fi
			fi
		}
		
		STATUSupdate

	done  # while(run)
}

#==============================================================================
checkHi() {
	showHi 0
	[[ $score -gt ${HI0[3]} ]] && return 1
	[[ $score -gt ${HI1[3]} ]] && return 2
	[[ $score -gt ${HI2[3]} ]] && return 3
	return 0
}

#==============================================================================
# MAIN
#==============================================================================
#----------------------------------------------------------
# Parse CLI
#
DEBUG=0
SKIP=0
FAST=0
MSG=
SEED=
USEED=X
ADROP=1
FREEZE=0
MONITOR=0
KEYDRV=v2

for i in $@ ; do
	[ "${i:0:1}" == "+" ] && {
		USEED=${i:1}
		continue
	}
	case $i in
		"-d"  | "--debug"   )  DEBUG=1     ;;
		"-m"  | "--monitor" )  MONITOR=1   ;;
		"-s"  | "--skip"    )  SKIP=1      ;;
		"-f"  | "--fast"    )  SKIP=1      
		                       FAST=1      ;;
		"-r"  | "--records" )  MSG=RECORDS ;;
		"-h"  | "--help"    )  MSG=HELP    ;;
		"-v"  | "--version" )  MSG=VER     ;;
		"-k1" | "--kdbv1"   )  KEYDRV=v1   ;;
		* )  ;;
	esac
done

if [ "$MSG" == "HELP" ] ; then
	echo -e "${NAME} v${VER}"
#	echo "  -d  --debug   : debug mode (extra keys)"
#	echo "  -m  --monitor : monitor debug messages"
	echo "  -r  --records : dump hi score records"
	echo "  -s  --skip    : skip intro sequence"
	echo "  -f  --fast    : fast startup"
	echo "  -h  --help    : this info"
	echo "  -v  --version : show version number"
	echo "  -k1 --kbdv1   : use v1 keyboard driver (supports WSL)"
	echo "  +N            : seed(N)"
	echo ""
	required
	echo ""
	Quit 0 q
fi

[ "$MSG" == "VER" ] && {
	echo -e "${NAME} v${VER}"
	Quit 0 q
}

[ "$MSG" == "RECORDS" ] && {
	checkSys
	keyStart
	tput civis
	dumpHi
	keyStop
#	tput cnorm
	echo ""
	Quit 0 
}

(($MONITOR)) && DBGmonitor  # will not return!

#----------------------------------------------------------
# Set up the system
#
checkSys

ctrlC_init ctrlC_quit  # trap ^C
keyStart ctrlC_quit    # init key scanner (incl. `stty -echo`)
tput civis             # cursor invisible

#----------------------------------------------------------
# Intro screens
#
!(($SKIP)) && Intro

#----------------------------------------------------------
# Initialise the playfield
#
PFinit
Redraw $FAST
statSpeed=$statFast
LEVEL=0
boredCnt=0

# Run the game
RUN=1
while (($RUN)); do
	BAShTris
	
	# Game over?
	if [[ $RUN -eq 2 ]]; then
		STATUS="All your base are belong to us!"
		STATUSupdate
		brickout
		sleep 1
		
		checkHi
		hs=$?
		if [[ $hs -gt 0 ]]; then
			rktReveal 
			if [[ ($hs -eq 1) && (${LEVEL} -ge 10) ]]; then
				teleport
				takeoff
			fi
			getInitials $hs
		fi
		FAST=1
		cleanup &
		scrollIn
		PFinit
		TETscoreShow
	fi
done

Quit 0

# People craving social approval may edit the hi-score table by hand
cat <<EOT
0  : ~hs:${LEVEL},                     level
1  : ${hs}                             position
2  : ${name[0]}${name[1]}${name[2]},   initials
3  : ${score},                         final score
4  : ${scoreLin},                      lines made
5  : ${scoreMulMax},                   maximum multiplier
6  : ${scoreBest},                     best piece score
7  : ${timeTotal},                     game time (excluding pauses)
8  : ${SEED}                           game seed
9  : ${tetL[8]}                        L-tet count
10 : ${tetJ[8]}                        J-tet count
11 : ${tetS[8]}                        S-tet count
12 : ${tetZ[8]}                        Z-tet count
13 : ${tetT[8]}                        T-tet count
14 : ${tetO[8]}                        O-tet count
15 : ${tetI[8]}                        I-tet count
16 : ${tot}                            total tet's
17 : ${tetSilv}                        silver combos
18 : ${tetGold}                        gold combos
~hs:0,1,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:0,2,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:0,3,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:1,1,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:1,2,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:1,3,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:2,1,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:2,2,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:2,3,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:3,1,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:3,2,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:3,3,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:4,1,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:4,2,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:4,3,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:5,1,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:5,2,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:5,3,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:6,1,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:6,2,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:6,3,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:7,1,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:7,2,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:7,3,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:8,1,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:8,2,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:8,3,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:9,1,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:9,2,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:9,3,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:10,1,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:10,2,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:10,3,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:11,1,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:11,2,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:11,3,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:12,1,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:12,2,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:12,3,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:13,1,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:13,2,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:13,3,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:14,1,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:14,2,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:14,3,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:15,1,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:15,2,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:15,3,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:16,1,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:16,2,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:16,3,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:17,1,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:17,2,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:17,3,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:18,1,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:18,2,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:18,3,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:19,1,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:19,2,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:19,3,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:20,1,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:20,2,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
~hs:20,3,---,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

# debug test arenas

tc~0~titl="Clear grid"
tc~0~tetY=$tetSty
tc~0~tetX=$tetStx
tc~0~rot=0
tc~0~tet0=("${tetI[@]}")
tc~0~tet1=("${tetI[@]}")
tc~0~tet2=("${tetI[@]}")
tc~0~tet3=("${tetI[@]}")
tc~0~tet4=("${tetI[@]}")
tc~0~PF[ 0]="F880808080808080808080F1"
tc~0~PF[ 1]="F880808080808080808080F1"
tc~0~PF[ 2]="F880808080808080808080F1"
tc~0~PF[ 3]="F880808080808080808080F1"
tc~0~PF[ 4]="F880808080808080808080F1"
tc~0~PF[ 5]="F880808080808080808080F1"
tc~0~PF[ 6]="F880808080808080808080F1"
tc~0~PF[ 7]="F880808080808080808080F1"
tc~0~PF[ 8]="F880808080808080808080F1"
tc~0~PF[ 9]="F880808080808080808080F1"
tc~0~PF[10]="F880808080808080808080F1"
tc~0~PF[11]="F880808080808080808080F1"
tc~0~PF[12]="F880808080808080808080F1"
tc~0~PF[13]="F880808080808080808080F1"
tc~0~PF[14]="F880808080808080808080F1"
tc~0~PF[15]="F880808080808080808080F1"
tc~0~PF[16]="F880808080808080808080F1"
tc~0~PF[17]="F880808080808080808080F1"
tc~0~PF[18]="F880808080808080808080F1"
tc~0~PF[19]="F880808080808080808080F1"
tc~0~PF[20]="FCF4F4F4F4F4F4F4F4F4F4F5"

tc~1~titl="Add O for Perfect"
tc~1~tetY=$(($tetSty+7))
tc~1~tetX=$tetStx
tc~1~rot=1
tc~1~tet0=("${tetO[@]}")
tc~1~tet1=("${tetO[@]}")
tc~1~tet2=("${tetO[@]}")
tc~1~tet3=("${tetO[@]}")
tc~1~tet4=("${tetO[@]}")
tc~1~PF[ 0]="F880808080808080808080F1"
tc~1~PF[ 1]="F880808080808080808080F1"
tc~1~PF[ 2]="F880808080808080808080F1"
tc~1~PF[ 3]="F880808080808080808080F1"
tc~1~PF[ 4]="F880808080808080808080F1"
tc~1~PF[ 5]="F880808080808080808080F1"
tc~1~PF[ 6]="F880808080808080808080F1"
tc~1~PF[ 7]="F880808080808080808080F1"
tc~1~PF[ 8]="F880808080808080808080F1"
tc~1~PF[ 9]="F880808080808080808080F1"
tc~1~PF[10]="F880808080808080808080F1"
tc~1~PF[11]="F880808080808080808080F1"
tc~1~PF[12]="F880808080808080808080F1"
tc~1~PF[13]="F880808080808080808080F1"
tc~1~PF[14]="F880808080808080808080F1"
tc~1~PF[15]="F880808080808080808080F1"
tc~1~PF[16]="F880808080808080808080F1"
tc~1~PF[17]="F880808080808080808080F1"
tc~1~PF[18]="F821292928808021292928F1"
tc~1~PF[19]="F821292928808021292928F1"
tc~1~PF[20]="FCF4F4F4F4F4F4F4F4F4F4F5"

tc~2~titl="Add I for Perfect Tetris"
tc~2~tetY=$(($tetSty+5))
tc~2~tetX=$tetStx
tc~2~rot=1
tc~2~tet0=("${tetI[@]}")
tc~2~tet1=("${tetI[@]}")
tc~2~tet2=("${tetI[@]}")
tc~2~tet3=("${tetI[@]}")
tc~2~tet4=("${tetI[@]}")
tc~2~PF[ 0]="F880808080808080808080F1"
tc~2~PF[ 1]="F880808080808080808080F1"
tc~2~PF[ 2]="F880808080808080808080F1"
tc~2~PF[ 3]="F880808080808080808080F1"
tc~2~PF[ 4]="F880808080808080808080F1"
tc~2~PF[ 5]="F880808080808080808080F1"
tc~2~PF[ 6]="F880808080808080808080F1"
tc~2~PF[ 7]="F880808080808080808080F1"
tc~2~PF[ 8]="F880808080808080808080F1"
tc~2~PF[ 9]="F880808080808080808080F1"
tc~2~PF[10]="F880808080808080808080F1"
tc~2~PF[11]="F880808080808080808080F1"
tc~2~PF[12]="F880808080808080808080F1"
tc~2~PF[13]="F880808080808080808080F1"
tc~2~PF[14]="F880808080808080808080F1"
tc~2~PF[15]="F880808080808080808080F1"
tc~2~PF[16]="F89199999C8024A1A9A9ACF1"
tc~2~PF[17]="F89599999A8026A5A9A9AAF1"
tc~2~PF[18]="F89399999C8026A3A9A9ACF1"
tc~2~PF[19]="F89199999A8022A1A9A9AAF1"
tc~2~PF[20]="FCF4F4F4F4F4F4F4F4F4F4F5"

tc~3~titl="Test Frag+Combo"
tc~3~tetY=$(($tetSty+8))
tc~3~tetX=$(($tetStx+5))
tc~3~rot=1
tc~3~tet0=("${tetT[@]}")
tc~3~tet1=("${tetI[@]}")
tc~3~tet2=("${tetI[@]}")
tc~3~tet3=("${tetI[@]}")
tc~3~tet4=("${tetI[@]}")
tc~3~PF[ 0]="F880808080808080808080F1"
tc~3~PF[ 1]="F880808080808080808080F1"
tc~3~PF[ 2]="F880808080808080808080F1"
tc~3~PF[ 3]="F880808080808080808080F1"
tc~3~PF[ 4]="F880808080808080808080F1"
tc~3~PF[ 5]="F880808080808080808080F1"
tc~3~PF[ 6]="F880808080808080808080F1"
tc~3~PF[ 7]="F880808080808080808080F1"
tc~3~PF[ 8]="F880808080808080808080F1"
tc~3~PF[ 9]="F880808080808080808080F1"
tc~3~PF[10]="F880808080808080808080F1"
tc~3~PF[11]="F880808080808080808080F1"
tc~3~PF[12]="F880808080808080808080F1"
tc~3~PF[13]="F880808080808080808080F1"
tc~3~PF[14]="F880808080808080808080F1"
tc~3~PF[15]="F880808080808080808080F1"
tc~3~PF[16]="F834808080808080808080F1"
tc~3~PF[17]="F837388080808080808080F1"
tc~3~PF[18]="F8326568151c151c717c80F1"
tc~3~PF[19]="F8616a80131a131a807378F1"
tc~3~PF[20]="FCF4F4F4F4F4F4F4F4F4F4F5"

tc~4~titl="Add J for DOUBLE Combo"
tc~4~tetY=$(($tetSty+3))
tc~4~tetX=$tetStx
tc~4~rot=3
tc~4~tet0=("${tetJ[@]}")
tc~4~tet1=("${tetJ[@]}")
tc~4~tet2=("${tetI[@]}")
tc~4~tet3=("${tetI[@]}")
tc~4~tet4=("${tetI[@]}")
tc~4~PF[ 0]="F880808080808080808080F1"
tc~4~PF[ 1]="F880808080808080808080F1"
tc~4~PF[ 2]="F880808080808080808080F1"
tc~4~PF[ 3]="F880808080808080808080F1"
tc~4~PF[ 4]="F880808080808080808080F1"
tc~4~PF[ 5]="F880808080808080808080F1"
tc~4~PF[ 6]="F880808080808080808080F1"
tc~4~PF[ 7]="F880808080808080808080F1"
tc~4~PF[ 8]="F880808080808080808080F1"
tc~4~PF[ 9]="F880808080808080808080F1"
tc~4~PF[10]="F880808080808080808080F1"
tc~4~PF[11]="F880808080808080808080F1"
tc~4~PF[12]="F880808080808080808080F1"
tc~4~PF[13]="F8151c151c8080151c151cF1"
tc~4~PF[14]="F8131a131a8080131a131aF1"
tc~4~PF[15]="F84451595c808045494854F1"
tc~4~PF[16]="F846717c52802442656856F1"
tc~4~PF[17]="F8434873788026616a515aF1"
tc~4~PF[18]="F8151c151c8026151c151cF1"
tc~4~PF[19]="F8131a131a8022131a131aF1"
tc~4~PF[20]="FCF4F4F4F4F4F4F4F4F4F4F5"

tc~5~titl="Add 2x4 for Super Combo"
tc~5~tetY=$tetSty
tc~5~tetX=$tetStx
tc~5~rot=0
tc~5~tet0=("${tetO[@]}")
tc~5~tet1=("${tetO[@]}")
tc~5~tet2=("${tetI[@]}")
tc~5~tet3=("${tetI[@]}")
tc~5~tet4=("${tetO[@]}")
tc~5~PF[ 0]="F880808080808080808080F1"
tc~5~PF[ 1]="F880808080808080808080F1"
tc~5~PF[ 2]="F880808080808080808080F1"
tc~5~PF[ 3]="F880808080808080808080F1"
tc~5~PF[ 4]="F880808080808080808080F1"
tc~5~PF[ 5]="F880808080808080808080F1"
tc~5~PF[ 6]="F880808080808080808080F1"
tc~5~PF[ 7]="F880808080808080808080F1"
tc~5~PF[ 8]="F880808080808080808080F1"
tc~5~PF[ 9]="F880808080808080808080F1"
tc~5~PF[10]="F880808080808080808080F1"
tc~5~PF[11]="F880808080808080808080F1"
tc~5~PF[12]="F8A1A9A9AC151c80808080F1"
tc~5~PF[13]="F8A5A9A9AA131a80808080F1"
tc~5~PF[14]="F8A3A9A9AC151c80808080F1"
tc~5~PF[15]="F8A1A9A9AA131a80808080F1"
tc~5~PF[16]="F8A1A9A9ACA1A9A9AC8080F1"
tc~5~PF[17]="F8A5A9A9AAA5A9A9AA8080F1"
tc~5~PF[18]="F8A3A9A9ACA3A9A9AC8080F1"
tc~5~PF[19]="F8A1A9A9AAA1A9A9AA8080F1"
tc~5~PF[20]="FCF4F4F4F4F4F4F4F4F4F4F5"

tc~6~titl="Add T for T Spin"
tc~6~tetY=$tetSty
tc~6~tetX=$(($tetStx-1))
tc~6~rot=3
tc~6~tet0=("${tetT[@]}")
tc~6~tet1=("${tetT[@]}")
tc~6~tet2=("${tetT[@]}")
tc~6~tet3=("${tetT[@]}")
tc~6~tet4=("${tetT[@]}")
tc~6~PF[ 0]="F880808080808080808080F1"
tc~6~PF[ 1]="F880808080808080808080F1"
tc~6~PF[ 2]="F880808080808080808080F1"
tc~6~PF[ 3]="F880808080808080808080F1"
tc~6~PF[ 4]="F880808080808080808080F1"
tc~6~PF[ 5]="F880808080808080808080F1"
tc~6~PF[ 6]="F880808080808080808080F1"
tc~6~PF[ 7]="F880808080808080808080F1"
tc~6~PF[ 8]="F880808080808080808080F1"
tc~6~PF[ 9]="F880808080808080808080F1"
tc~6~PF[10]="F880808080808080808080F1"
tc~6~PF[11]="F880808080808080808080F1"
tc~6~PF[12]="F880808080808080808080F1"
tc~6~PF[13]="F845494880808080808080F1"
tc~6~PF[14]="F842656880808080808080F1"
tc~6~PF[15]="F8616a3480808080808080F1"
tc~6~PF[16]="F864313E80808080808080F1"
tc~6~PF[17]="F8636c328080151c51595cF1"
tc~6~PF[18]="F85462808080131a717c52F1"
tc~6~PF[19]="F853595880212929287378F1"
tc~6~PF[20]="FCF4F4F4F4F4F4F4F4F4F4F5"

# rocket sprite (by jgs/spunk)

#
#  ,~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~.
#  |H,===================================.h|
#  |H|                                   |h|
#  |H|                 *     .--.        |h|
#  |H|                      / /  `       |h|
#  |H|     +               | |           |h|
#  |H|            '         \ \__,       |h|
#  |H|        *          +   '--'  *     |h|
#  |H|            +   /\                 |h|
#  |H|              .'  '.   *           |h|
#  |H|      *      /======\      +       |h|
#  |H|            ;:.  _   ;             |h|
#  |H|            |:. (_)  |             |h|
#  |H|            |:.  _   |             |h|
#  |H|  +         |:. (_)  |          *  |h|
#  |H|            ;:.      ;             |h|
#  |H|          .' \:.    / `.           |h|
#  |H|         / .-'':._.'`-. \          |h|
#  |H|         |/    /||\    \|          |h|
#  |H|   jgs _..--"""````"""--.._        |h|
#  |H| _.-'``                    ``'-._  |h|
#  |H|'                                '-|h|
#  |H`==================================='h|
#  |H To The End of The Universe And Back h|
#  `~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
# 
# ...A framed copy of the original artwork :)
#

rocket:¬¬¬¬¬¬¬/\¬¬¬¬¬¬¬$
rocket:¬¬¬¬¬.'  '.¬¬¬¬¬$
rocket:¬¬¬¬/======\¬¬¬¬$
rocket:¬¬¬;:.  _   ;¬¬¬$
rocket:¬¬¬|:. (_)  |¬¬¬$
rocket:¬¬¬|:.  _   |¬¬¬$
rocket:¬¬¬|:. (_)  |¬¬¬$
rocket:¬¬¬;:.      ;¬¬¬$
rocket:¬.' \:.    / `.¬$
rocket:/ .-'':._.'`-. \$
rocket:|/XXXXXXXXXXXX\|$
rocket:XX¬¬¬¬¬¬¬¬¬¬¬¬XX$

rx1a_1:¬¬¬¬/||\¬¬¬¬$
rx1b_1:¬¬¬¬dHHb¬¬¬¬$

rx2a_1:¬¬¬¬/II\_¬¬¬$
rx2a_2:¬¬)//||\\(¬¬$

rx2b_1:¬¬¬./db\,¬¬¬$
rx2b_2:¬¬#/\**/\@¬¬$

rx3a_1:¬¬¬¬/II\¬¬¬¬$
rx3a_2:¬¬od|MM|bo¬¬$
rx3a_3:¬' =,#@'~ )¬$

rx3b_1:¬¬¬¬/db\¬¬¬¬$
rx3b_2:¬¬do-ww-ob¬¬$
rx3b_3:';¬=,()'¬-}'$

rx4a_1:¬¬¬¬/II\¬¬¬¬$
rx4a_2:¬¬¬;jHHl;¬¬¬$
rx4a_3:¬¬:;/::@,;¬¬$
rx4a_4:X^,XX''XX.~X$
rx4a_4:¬XX¬¬XX¬¬XX¬$

rx4b_1:¬¬¬¬/HH\¬¬¬¬$
rx4b_2:¬¬¬;dIIb:¬¬¬$
rx4b_3:¬¬',#||#.`¬¬$
rx4b_4:X};'X!!X`;}X$
rx4b_4:¬XXX¬XX¬XXX¬$

rktgnd:_..--"""````"""--.._$

rktstar:XXXXXXXXXXXX$
rktstar:XX☼XXXXX.XXX$
rktstar:XXXXXXXXXXXX$
rktstar:XXXXX.∞XXXXX$
rktstar:XXXX'XXXXXXX$
rktstar:XXXXXXXXXXXXXXXXXXXX$
rktstar:XXX.XXXX∙XXXXXXXXXXX$
rktstar:XXXXXXXXXXXXXXXX+XXX$

rktmoon:¬¬¬¬¬¬¬¬¬¬¬¬XX.--.XX$
rktmoon:¬¬¬¬¬¬¬¬¬¬¬¬X/X/XX`X$
rktmoon:¬¬¬¬¬¬¬¬¬¬¬¬|X|XXXXX$
rktmoon:¬¬¬¬¬¬¬¬¬¬¬¬X\X\__,X$
rktmoon:¬¬¬¬¬¬¬¬¬¬¬¬XX'--'XX$

gold          Золото
silver        Серебро
Developed by  Разработано 
GAME OVER!    КОНЕЦ ИГРЫ! Конец игры! 
Score         Счёт
Level         Уровень
Pause         Пауза
Sound         Звук 
High score    Рекорд

EOT
