#!/bin/bash
# =MAKE:npp_workspace - : notepad++ project file
# =MAKE:README        - : readme
# =MAKE:MAKE.sh       - : build system
# =MAKE:BREAK.s       - UNbuild system
# =MAKE:ID.sh         - machine ID command
# =MAKE:ansi.s        - ansi sequences (colour, etc)
# =MAKE:prng.s        - PRNG (for piece selection)
# =MAKE:kbd.s         - keyboard driver
# =MAKE:time.s        - timer system
# =MAKE:status.s      - status line
# =MAKE:sys.s         - system functions
# =MAKE:debug.s       - debug API & debug monitor
# =MAKE:cs.s          - cyborg systems fancy shit
# =MAKE:quit.s        - quit screen
# =MAKE:cli.s         - cli parser
# =MAKE:lang.s        - translation file
# =MAKE:help.s        - help screens
# =MAKE:gameover.dat  - gameover sprites
# =MAKE:gameover.s    - gameover process
# =MAKE:hiscore.s     - high score system
# =MAKE:start.s       - start menu
# =MAKE:pause.s       - pause screen
# =MAKE:rig.dat       - rig-game setups
# =MAKE:rig.s         - rig-game menu & system
# =MAKE:sound.s       - event sounds
# =MAKE:g_gfx.s       - game graphics
# =MAKE:g_logic.s     - game logic
# =MAKE:pf.s          - playfield maintenance
# =MAKE:main.s        - start here
# =MAKE:tris.sh       - : makefile
# =MAKE:hiscore.dat   - hiscores - last (for consistency)
: << 'EOF-npp_workspace'
# +MAKE:npp_workspace - : notepad++ project file
<NotepadPlus>
    <Project name="BAShTris_v1">
        <File name="README" />
        <Folder name="Tools">
            <File name="ID.sh" />
        </Folder>
        <Folder name="Build">
            <File name="MAKE.sh" />
            <File name="BREAK.s" />
            <File name="tris.sh" />
        </Folder>
        <Folder name="Core">
            <File name="ansi.s" />
            <File name="debug.s" />
            <File name="kbd.s" />
            <File name="prng.s" />
            <File name="status.s" />
            <File name="time.s" />
        </Folder>
        <Folder name="Main">
            <File name="sys.s" />
            <File name="cli.s" />
            <File name="lang.s" />
            <File name="main.s" />
        </Folder>
        <Folder name="Screens">
            <File name="cs.s" />
            <File name="help.s" />
            <File name="hiscore.dat" />
            <File name="hiscore.s" />
            <File name="gameover.dat" />
            <File name="gameover.s" />
            <File name="rig.dat" />
            <File name="rig.s" />
            <File name="pause.s" />
            <File name="quit.s" />
        </Folder>
        <Folder name="Game">
            <File name="sound.s" />
            <File name="g_gfx.s" />
            <File name="g_logic.s" />
            <File name="pf.s" />
            <File name="start.s" />
        </Folder>
    </Project>
</NotepadPlus>
# -MAKE:npp_workspace
EOF-npp_workspace
: << 'EOF-README'
# +MAKE:README - : readme
#!/bin/bash

: << 'EOT'
~~README-BEGIN
   ,-------.
==(  Index  )==================================================================
   `-------'
	# BAShTris
	# LICENCE
	# BIBLIOGRAPHY
	# ROADMAP
	# COMMAND LINE OPTIONS
		# Standard
		# Debug
	# CONSOLE SETTINGS
		# Required terminal settings    <----- 0_o
		# Play with PuTTY over SSH
		# Kali terminal window
		# Windows Subsytem Linux (WSL)
	# GAME MODES
		# Drop Rate
		# Normal (aka Marathon or A-Type)
		# Invisible [Marathon]
		# Challenge (aka B-Type)
	# STUFF TO TRY
		# CS Logo
		# Controller Screen
		# Start Screen
		# During Gameplay    <---------------- 0_o
		# End of Game
		# Repeating a Game    <--------------- 0_o
	# HIGH SCORES
		# Review
		# Export
		# Import
		# Merge   
		# Upgrading     <--------------------- 0_o
	# DEBUG MODE
		# Command line options
		# Debug Console
		# Extra keys during play
	# DEVELOPER MODE

   ,----------.
==(  BAShTris  )===============================================================
   `----------'

Autumn 2020. Boredom has set in. Never written a Tetris clone before. BASh
skillz could do with a work-out. Enjoy!

   ,---------.
==(  LICENCE  )================================================================
   `---------'

MIT License

Copyright (c) 2020 BlueChip

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

   ,--------------.
==(  BIBLIOGRAPHY  )===========================================================
   `--------------'

This probably isn't complete, but it's a list of handy references:
  * https://en.wikipedia.org/wiki/Code_page_437
  * http://ascii-table.com/ansi-escape-sequences.php
  * https://www.linuxquestions.org/questions/programming-9/bash-case-with-arrow-keys-and-del-backspace-etc-523441/
  * http://asciiqr.com/
  * https://www.utf8-chartable.de/unicode-utf8-table.pl?start=00&utf8=oct
  * https://www.artificialworlds.net/blog/2012/10/17/bash-associative-array-examples/
  * https://docs.google.com/spreadsheets/d/17f0dQawb-s_Fd7DHgmVvJoEGDMH_yoSd8EYigrb0zmM/edit#gid=296134756

   ,---------.
==(  ROADMAP  )================================================================
   `---------'

	# Wall kick (option)

	# Network play

	# OSX support (BASh v3 - no sub-second timer!)

   ,----------------------.
==(  COMMAND LINE OPTIONS  )===================================================
   `----------------------'

Standard Options
================
	-h  --help    : this info
	-H  --man     : full documentation
	-v  --version : show version number

	-k1 --kbdv1   : force v1 keyboard driver (supports WSL)
	-k2 --kbdv2   : force v2 keyboard driver (improved driver)
		--id      : generate id.out for this linux install [debug/porting]

	-r  --records : show hi score records
	-x  --rexport : eXport hi score records  [filename]  <-- optional
	-i  --rimport : Import hi score records  <filename>  <-- required
	-m  --rmerge  : merGe hi score records   <filename>  <-- required
	+N            : seed(N) - repeat a specific game

Debug Options
=============
	-d  --debug   : debug mode (extra keys - see controller help screen)
	-s  --skip    : skip intro sequence
	-f  --fast    : fast startup
	-c  --ctrlc   : Enable [do not disable] ^C
	-n  --monitor : monitor debug messages
	-b  --break   : break code in to components - use MAKE.sh to rebuild
	-B  --brkovr  : break code in to components - overwrite existing files

   ,------------------.
==(  CONSOLE SETTINGS  )=======================================================
   `------------------'

Required terminal settings
==========================
	# Terminal size: {80 x 25} (24 + 1 status line)

	Choice of Font & Colour Scheme are outside my control, and can be the 
	difference between "nice job" and "pass the bucket".

	If the graphics are misaligned, try a slightly bigger or smaller font size.

	Make sure you have UTF8 support enabled!

Play with PuTTY over SSH
========================
	# Font         : Courier New
	  PuTTY -> Settings -> Window -> Appearance -> Font -> Change = Courier New

	# Character Set: UTF-8
	  PuTTY -> Settings -> Window -> Translation -> Remote Charset = UTF-8

Kali terminal window looks good with
====================================
	[File->Preferences]
	# Font         : Bitstream Vera Sans Mono
	# Colour Scheme: Linux

Windows Subsytem Linux (WSL)
============================
	# Font         : Courier New
	# Command line : $0 -k1          <-- this should auto-detect now!

   ,------------.
==(  GAME MODES  )=============================================================
   `------------'

Drop Rate
=========
In all modes, the drop rate is:
	Drop Rate = (1000 - (Level *46)) milliseconds
		,--------------------------.
		| Level | Rate | drops/sec |
		|=======|======|===========|
		|    0  | 1000 |    1      |  Yawn
		|   ..  |  ... |           |  ...
		|    5  |  770 |    1.3    |  Playable
		|   ..  |  ... |           |  ...
		|   10  |  540 |    1.85   |  Game on
		|   11  |  496 |    2      |  ..
		|   ..  |  ... |           |  ...
		|   15  |  310 |    3.2    |  Stay focussed
		|   ..  |  ... |           |  ...
		|   20  |   80 |   12.5    |  Faster than I can play!
		`--------------------------'

By comparison, these are the speeds for the Gameboy:
	https://harddrop.com/wiki/Tetris_(Game_Boy)
		,-----------------------------------------.
		|       | ___BAShTris___ | ___Gameboy____ |
		| Level | Rate | drops/S | Rate | drops/S |
		|=======|======|=========|======|=========|
		|    0  | 1000 |   1.00  |  887 |   1.13  |  
		|    1  |  954 |   1.05  |  820 |   1.22  |  
		|    2  |  908 |   1.10  |  753 |   1.33  |  
		|    3  |  862 |   1.16  |  686 |   1.46  |  
		|    4  |  816 |   1.23  |  619 |   1.62  |  
		|       |      |         |      |         |  
		|    5  |  770 |   1.30  |  552 |   1.81  |  
		|    6  |  724 |   1.38  |  469 |   2.13  |  
		|    7  |  678 |   1.47  |  368 |   2.72  |  
		|    8  |  632 |   1.58  |  285 |   3.51  |  
		|    9  |  586 |   1.71  |  184 |   5.43  |  
		|       |      |         |      |         |  
		|   10  |  540 |   1.85  |  167 |   5.99  |  
		|   11  |  494 |   2.02  |  151 |   6.62  |  
		|   12  |  448 |   2.23  |  134 |   7.46  |  
		|   13  |  402 |   2.49  |  117 |   8.55  |  
		|   14  |  356 |   2.81  |  100 |  10.00  |  
		|       |      |         |      |         |  
		|   15  |  310 |   3.23  |  100 |  10.00  |  
		|   16  |  264 |   3.79  |   84 |  11.90  |  
		|   17  |  218 |   4.59  |   84 |  11.90  |  
		|   18  |  172 |   5.81  |   67 |  14.93  |  
		|   19  |  126 |   7.94  |   67 |  14.93  |  
		|       |      |         |      |         |  
		|   20  |   80 |  12.50  |   50 |  20.00  |  
		`-----------------------------------------'

NORM : Normal (aka Marathon or A-Type)
======================================
	It's tetris with "N64: New Tetris" combo blocks
	You start on the selected Level.
	The start speed is the same as the Level
	The speed will 'Level Up' every 10 lines (~25 pieces)

NVIS : Invisible [Marathon]
===========================
	As per normal gameplay, but pieces become invisible when they are placed.
	Additionally, on higher levels, Basket Pieces are hidden:
		 0.. 9 -> 0 hidden
		10..14 -> 1 hidden
		15..20 -> 2 hidden

CHAL : Challenge (aka B-Type)
=============================
	You will start with some "junk" (aka "garbage") in the "pit"
	You must survive until all the pieces have been placed.
	Any pieces left at the end of the game will be deducted from your score.
		...with a nice animation

	Based on the user-selected [Game] 'Level'
		SpeedLevel = ((Level /5) +3) +(Level % 5) +((Level /20) *3)
		JunkLines  = ((Level /5) *2) +4
		DropPieces = 100 +JunkLines +SpeedLevel +Level +((Level /5) *10)

	The start speed is defined as SpeedLevel (above)
	The speed will 'Level Up' every 6 lines (~15 pieces)

	This table shows all game parameters
		The "max" values are theoretical, and may/will vary during gameplay.
		EG. At Level=20, you will need to survive ABOUT 32 pieces at speed 20
		,-------------------------------------------.
		|       |      | ___Speed___ | ___Pieces___ |
		| Level | Junk | Start | Max | Total | @Max |
		|=======|======|=======|=====|=======|======|
		|    0  |   4  |    3  |  10 |  107  |   2  |
		|    1  |   4  |    4  |  11 |  109  |   4  |
		|    2  |   4  |    5  |  12 |  111  |   6  |
		|    3  |   4  |    6  |  13 |  113  |   8  |
		|    4  |   4  |    7  |  14 |  115  |  10  |
		|       |      |       |     |       |      |
		|    5  |   6  |    4  |  12 |  125  |   5  |
		|    6  |   6  |    5  |  13 |  127  |   7  |
		|    7  |   6  |    6  |  14 |  129  |   9  |
		|    8  |   6  |    7  |  15 |  131  |  11  |
		|    9  |   6  |    8  |  16 |  133  |  13  |
		|       |      |       |     |       |      |
		|   10  |   8  |    5  |  14 |  143  |   8  |
		|   11  |   8  |    6  |  15 |  145  |  10  |
		|   12  |   8  |    7  |  16 |  147  |  12  |
		|   13  |   8  |    8  |  17 |  149  |  14  |
		|   14  |   8  |    9  |  19 |  151  |   1  |
		|       |      |       |     |       |      |
		|   15  |  10  |    6  |  16 |  161  |  11  |
		|   16  |  10  |    7  |  17 |  163  |  13  |
		|   17  |  10  |    8  |  19 |  165  |   0  |
		|   18  |  10  |    9  |  20 |  167  |   2  |
		|   19  |  10  |   10  |  20 |  169  |  19  |
		|       |      |       |     |       |      |
		|   20  |  12  |   10  |  20 |  182  |  32  |
		`-------------------------------------------'

   ,--------------.
==(  STUFF TO TRY  )===========================================================
   `--------------'

CS Logo
=======
	Animations that run in threads, so can be concurrent

Controller Screen
=================
	No easter eggs here (or are there?)

Start Screen
============
	F1  - Review controller keys
	F2  - Show combo block table
	F4  - System details (multiple 'pages')
	F10 - Review high-score statistics

	Select "Sound" and press Rotate-Left: Audio test

	Select Russian [qv lang.s]

During Gameplay
===============
	If the screen becomes corrupt:
		1. Press "`" / "backtick" / "grave accent" to redraw the screen
		2. If it's a bug - report it!

	Play on level 0, 1, or 2 to see the piece 'introduction' animation

	F1 or F2 for the help screens

	P to Pause the game
		...with random animations & 'easter egg' messages
	Random graphical events do NOT effect the piece distribution!

	Complete a challenge for an animation run

	Clear the pit for a "PERFECT" bonus and +100 points

	Work out a strategy for maximising the score multiplier

	Try and create all 11 GOLD and 106 SILVER combinations
		...I hope to add "Achievements" to a future version

End of Game
===========
	Watch out for easter-egg messages

	Get your name/initials on the High Score Table

	Use <shoulder> to change the input language

	In any game mode, on any Level 10-or-above:
		Play three games and enter your initials for all three wins
		On the fouth play, get position #1 on the table
			...for a surprise

Repeating a Game
================
	Use `bashtris +N` to force the seed to N, where 0 <= N <= 65535
		...This will be the same for every game until BAShTris is restarted

	This allows you to challenge a friend on a specific game :)
		...Work out how to get the same pieces on a different level!

   ,-------------.
==(  HIGH SCORES  )============================================================
   `-------------'

Review
======
	You can view the in-game hjigh score records table
		by pressing F10 on the in-game menu page. Or...

	Review any set of high score records with:
		`bashtris -r [filename]`
	...A filename of a [friend's] exported table MAY be specified
	...If NO filename is given, the internal records will be shown

	**************************************************************
	**  The following features do NOT work in 'developer' mode  **
	**************************************************************
	  In 'developer' mode, the high score table is:  hiscore.dat
	   and it does NOT contain the markers required for sharing

Export
======
	Export your high scores with:
		`bashtris -x [filename]`
	...will use stdout if no filename is supplied

	Save your scores before upgrading
	Or send them to a friend for challenges

Import
======
	Import a complete set of high scores with:
		`bashtris -i <filename>`

	You can run `bashtris -r` to confirm the records have imported 

Merge
=====
	Merge a [friend's] high score table in to your game with:
		`bashtris -m <filename>`
	...Basic statistics will be given about what was imported

	You can run `bashtris -r` to view the newly merged records

Upgrade
=======
	If you upgrade to a new version of BAShTris, you will (probably) want
	to keep your high score records.

	I was going to automate this, but "automatically download and install 
	unsigned scripts off github" just seems like an unreasonable security risk.
	...Maybe I will consider signed updates at some point in the future :/

	1.	Run `bashtris -x records.dat` to save your records as 'records.dat'
	2.	Download the new version
	wget https://raw.githubusercontent.com/csBlueChip/BAShTris/main/bashtris.sh
	3. 	Move the current 'bashtris.sh' to your trashcan
	4.	Replace it with the new 'bashtris.sh' file you just downloaded
	5.	Run `bashtris -i records.dat` to re-import your exported records

   ,------------.
==(  DEBUG MODE  )=============================================================
   `------------'

Command line options
====================
	-d to enable debug mode
	-s to skip the intros
	-f to skip the board draw
	-c allow ^C to exit the program

Debug Console
=============
	Open another session and run `bashtris -n` for a debug monitor console

	The main code can use DBG and DBGF to send debug console messages.

Extra keys during play
======================
	0 : Disable auto-drop - aka Realtime Pause
		Pressing UP in this mode will cause a piece to lock immediately

	F5 : Toggle invisible mode on/off
		Useful for debugging invivisble mode!

	F6 : Draw tetrominoes normally
		Debug mode usually show the piece geometry during play
		Enabling "NormalDRAW" has an easter-egg side-effect!

	F12 : Rig the game
		A number of test pits exist for exercising certain features
		To create another: See the instructions in rig.dat

	PgUp : Level up
		Add enough lines to push you up 1 level

	6 ^ : Move up!
		Piece dropped too far? ...Move it back up the screen!

	Ins : Place piece
		Lock the active tetromino in to place where it is now

	End : Ditch piece
		Discard the active tetromino
		...and get the next one out of the basket, as normal

   ,----------------.
==(  DEVELOPER MODE  )=========================================================
   `----------------'

	Run `bashtris -b` to break the code in to manageable components
		...including a notepad++ workspace
	You can use `bashtris -B` [capital B] to force file-overwrite

	Run `MAKE.sh` to re-"compile" it in to a single file

	Once "broken" the game may be run with `tris.sh`

	Run `bashtris --id` to create an `id.out` file to identify this distro
	When broken out, `ID.sh` is the standalone version of `bashtris --id`

	Some of this information can be seen by pressing F4 on the start menu
	The various outputs will rotate with each press of F4

                                   ==[EOF]==
~~README-END
EOT
# -MAKE:README
EOF-README
: << 'EOF-MAKE.sh'
# +MAKE:MAKE.sh - : build system
#!/bin/bash

out=bashtris.sh
in=tris.sh
lin=()

echo "# Processing..."
# load input file
while IFS= read -r  l || [ -n "$l" ] ; do
	lin+=("$l")
#	lin+=("${l#"${l%%[![:space:]]*}"}")         # ltrim
done < $in

file=()
cmnt=()
hs=
hsc=
err=0
for l in "${lin[@]}" ; do
	a=($l)
	if [[ "${a[0]}" == "." ]]; then
		if [[ -f "${a[1]}" ]]; then
			c="${l#*#}"                           # grab comment
			if [[ "${a[1]}" == "hiscore.dat" ]]; then  # put scores at the end
				hs="${a[1]}"
				hsc=("${c#"${c%%[![:space:]]*}"}")  # ltrim
			else
#				echo "+ |${a[1]}| - |${c#"${c%%[![:space:]]*}"}|"
				file+=("${a[1]}")                     # grab filename
				cmnt+=("${c#"${c%%[![:space:]]*}"}")  # ltrim
			fi
		else
			>&2  echo "! File not found: |${a[1]}|"
			((err++))
		fi
	fi
done

((err))  &&  exit $((100 +err))

# append the "makefile"
inc=": makefile"
#echo "+ |$in| - |$inc|"
file+=("$in")
cmnt+=("$inc")

# hiscores come last
[[ ! -z "$hs" ]] && {
#	echo "+ |$hs| - |$hsc|"
	file+=("$hs")
	cmnt+=("$hsc")
}

echo "#   Header"
>$out  echo "#!/bin/bash"

echo "#   List"
len=0
for ((i = 0;  i < ${#file[@]};  i++)); do
	((${#file[$i]} > len)) && len=${#file[$i]}
done
for ((i = 0;  i < ${#file[@]};  i++)); do
	printf -v c "# =MAKE:%s%*s - %s" "${file[$i]}" $((len -${#file[$i]})) "" "${cmnt[$i]}"
	>>$out  echo "$c"
done

echo "#   Includes"
for ((i = 0;  i < ${#file[@]};  i++)); do
	printf "#     %s%*s - %s\n" "${file[$i]}" $((len -${#file[$i]})) "" "${cmnt[$i]}"
	[[ "${cmnt[$i]:0:1}" == ":" ]]  &&  >>$out  echo ": << 'EOF-${file[$i]}'"
	>>$out  echo "# +MAKE:${file[$i]} - ${cmnt[$i]}"
	>>$out  cat ${file[$i]}
	>>$out  echo "# -MAKE:${file[$i]}"
	[[ "${cmnt[$i]:0:1}" == ":" ]]  &&  >>$out  echo "EOF-${file[$i]}"
done

echo "# Privs"
chmod +x $out

echo "* Success |$out|"
# -MAKE:MAKE.sh
EOF-MAKE.sh
# +MAKE:BREAK.s - UNbuild system
#!/bin/bash

# MAKE-COOKIE  <--- This let's the system know if it is running in Make or Break mode

#+============================================================================= ========================================
unmake() {
	local re  l  fn
	local arr=()

	IFS=$'\n' read -r -d '' -a arr < <(grep '^# =MAKE' ${CMD} && printf "\0")
	for ((i = 0;  i < ${#arr[@]};  i++)); do
		l="$(echo "${arr[$i]}" | sed 's/[^:]*:\(.*\)/\1/')"
		fn="$(echo "$l" | sed 's/\([^[:space:]]*\).*/\1/')"

		if [[ -e $fn ]]; then
			if [[ "$1" != "force" ]]; then
				echo "! File already exists: |$fn|"
				continue
			else
				echo "# Overwrite: |$fn|"
			fi
		else
			echo "# Create: $l"
		fi

		re='/^# +MAKE:'$fn'/,/^# -MAKE:'$fn'/'
		sed -n "${re}p" ${CMD}  |  sed -e '1d' -e '$d' >$fn
	done

	echo "# Set privs"
	chmod +x  MAKE.sh  ID.sh  tris.sh

	echo "* Success"
}
# -MAKE:BREAK.s
# +MAKE:ID.sh - machine ID command
#!/bin/bash

#+=============================================================================
idDoit () {
	echo \$ $@
	eval $@
	echo ""
}

#+=============================================================================
idMake() {
	{
		2>&1 idDoit uname -a
		2>&1 idDoit uname -s
		2>&1 idDoit uname -n
		2>&1 idDoit uname -r
		2>&1 idDoit uname -v
		2>&1 idDoit uname -m
		2>&1 idDoit uname -p
		2>&1 idDoit uname -i
		2>&1 idDoit uname -o
		2>&1 idDoit uname -z # test error redirect
		2>&1 idDoit uname --version
		2>&1 idDoit bash --version
	} >$1
	echo '* Created: |id.out|'

	echo "* Feel free to redact your machine name [$(uname -n)] in the file before sharing"
}

[[ "${0##*/}" == "ID.sh" ]]  &&  idMake id.out
# -MAKE:ID.sh
# +MAKE:ansi.s - ansi sequences (colour, etc)
#!/bin/bash

#------------------------------------------------------------------------------ ----------------------------------------
# ANSI Colour definitions
#
# use : ${atPFX}  {at};{fg};{bg}  ${atSFX}
# EG. : ${atPFX}${atBLD};{$fgYEL};${bgRED}${atSFX}
#       ${atPFX}{$fgBLU};${bgBLK}${atSFX}
#
atPFX="\033[0;"  # OSX comes with BASh v3, so no "\e" or "\x1b"
atSFX=m

# Foreground attributes
atOFF=0  # attibutes off
atBLD=1  # bold/bright
atUSC=4  # underscore
atBLN=5  # blink
atREV=7  # reverse
atCON=8  # conceal

fgBLK="0;30"
fgGRY="1;30"

fgRED="0;31"
fgBRED="1;31"

fgGRN="0;32"
fgBGRN="1;32"

fgBRN="0;33"
fgYEL="1;33"

fgBLU="0;34"
fgBBLU="1;34"

fgMAG="0;35"
fgBMAG="1;35"

fgCYN="0;36"
fgBCYN="1;36"

fgWHT="0;37"
fgBWHT="1;37"

bgBLK=40
bgRED=41
bgGRN=42
bgYEL=43
bgBLU=44
bgMAG=45
bgCYN=46
bgWHT=47


#------------------------------------------------------------------------------ ----------------------------------------
# Text colours
#
clrTxtFg="${fgGRN}"
clrTxtBg="${bgBLK}"

atOFF="${atPFX}${clrTxtFg};${clrTxtBg}${atSFX}"  # override terminal skin

BLK="${atPFX}${fgBLK};${clrTxtBg}${atSFX}"
RED="${atPFX}${fgRED};${clrTxtBg}${atSFX}"
GRN="${atPFX}${fgGRN};${clrTxtBg}${atSFX}"
BRN="${atPFX}${fgBRN};${clrTxtBg}${atSFX}"
BLU="${atPFX}${fgBLU};${clrTxtBg}${atSFX}"
MAG="${atPFX}${fgMAG};${clrTxtBg}${atSFX}"
CYN="${atPFX}${fgCYN};${clrTxtBg}${atSFX}"
WHT="${atPFX}${fgWHT};${clrTxtBg}${atSFX}"

GRY="${atPFX}${fgGRY};${clrTxtBg}${atSFX}"
BRED="${atPFX}${fgBRED};${clrTxtBg}${atSFX}"
BGRN="${atPFX}${fgBGRN};${clrTxtBg}${atSFX}"
YEL="${atPFX}${fgYEL};${clrTxtBg}${atSFX}"
BBLU="${atPFX}${fgBBLU};${clrTxtBg}${atSFX}"
BMAG="${atPFX}${fgBMAG};${clrTxtBg}${atSFX}"
BCYN="${atPFX}${fgBCYN};${clrTxtBg}${atSFX}"
BWHT="${atPFX}${fgBWHT};${clrTxtBg}${atSFX}"

#+============================================================================= ========================================
# PrintAT(y, x, s) - TL={1,1}
#
PAT() {  # (y, x, $s)
	echo -en "\033[$1;$2H$3"
}

#+=============================================================================
# CLS
#
CLS() {
	echo -en "\033[2J\033[1;1;H"  # cls ; tab(1,1)
}
# -MAKE:ansi.s
# +MAKE:prng.s - PRNG (for piece selection)
#!/bin/bash

#****************************************************************************** ****************************************
#                                 ,------.
#                                (  PRNG  )
#                                 `------'
#****************************************************************************** ****************************************

#****************************************************************************** ****************************************
# "Linear Congruency" Pseudo Random Number Generator [PRNG]
# Full docs here: https://github.com/csBlueChip/simplePRNG
#

#------------------------------------------------------------------------------ ----------------------------------------
# Constansts
#
RNDm=$((0x100000000 -1))               # m: >2^30, precise ^2 allows for boolean optimisation
RNDa=$((0x5D635DBA & 0xFFFFFFF0 | 5))  # a: no binary pattern ... as M is a ^2, A%8==5
RNDc=1                                 # c: no factor in common with m

# The wider (in bits) your result is, the less entropy will appear in the LSb's
RNDw=3                                 # w= width of result
RNDb=$(((1 <<$RNDw) -1))               # b= bitmask
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
	[[ "$1" == "seed" ]] && {
		RNDs=$2
		RNDx=$RNDs
		return
	}

#	RNDx=$((($RNDa*$RNDx +$RNDc) %$RNDm))  # x <- (ax+c)%m
	RNDx=$((($RNDa*$RNDx +$RNDc) &$RNDm))  # x <- (ax+c)%m
	RNDn=$(($RNDx >>$RNDr))                # upper bits have greater entropy

	return $RNDn  # this return method, limits us to 8-bit values
}

#+============================================================================= ========================================
#  RNDtest 1000000  # I suggest *at least* 1,000,000
#
#>	RNDtest() {
#>		RND seed $RANDOM
#>
#>		sz=$1  # size of sample set
#>
#>		W=()       # weighting array
#>		for ((i = $sz;  i > 0;  i--)); do
#>			RND  # get a fresh random number to $RNDn
#>
#>	#		echo $RNDn  # echo to the tty
#>
#>			# tally the weight
#>			if [[ ${W[$RNDn]} == "" ]]; then
#>				W[$RNDn]=1
#>			else
#>				W[$RNDn]=$((${W[$RNDn]} +1))
#>			fi
#>
#>			# countdown timer
#>			[[ $(($i % 10000)) -eq 0 ]] && echo -en "\r$i " >&2
#>		done
#>		echo -e "\rdone    " >&2
#>
#>		echo "RNDm=$RNDm"
#>		echo "RNDa=$RNDa"
#>		echo "RNDc=$RNDc"
#>	#	echo ""
#>		echo "RNDw=$RNDw"
#>		echo "RNDb=$RNDb"
#>		echo "RNDr=$RNDr"
#>	#	echo ""
#>		echo "RNDs=$RNDs"
#>	#	echo "RNDx=$RNDx"
#>	#	echo ""
#>	#	echo "RNDn=$RNDn"
#>	#	echo ""
#>
#>		echo -e "\nStats\n-----"
#>		tot=0               # total numbers counted
#>		hi=$((1 << $RNDw))  # max number of values available
#>		mt=0                # number of empty values
#>		avg=$(($sz /$hi))   # average expected count
#>		for ((i = 0;  i < $hi;  i++)); do
#>			# only consider values which were generated at least once
#>			if [[ ${W[$i]} != "" ]]; then
#>				echo $i: ${W[$i]}   $((${W[$i]} -$avg))  # value, count, deviation from average
#>				((tot+=${W[$i]}))                        # tally the count
#>			# otherwise just count is as an "empty" value
#>			else
#>				((mt++))
#>			fi
#>		done
#>		echo "tot:$tot"
#>		echo "empty: $mt"
#>
#>		min=$sz  # smallest count
#>		max=0    # biggest count
#>		for ((i = 0;  i < $hi;  i++)); do
#>			[[ ${W[$i]} -lt $min ]] && min=${W[$i]}
#>			[[ ${W[$i]} -gt $max ]] && max=${W[$i]}
#>		done
#>
#>		dn=$(($avg -$min))  # biggest deviation down
#>		up=$(($max -$avg))  # biggest deviation up
#>		pk=$up              # peak deviation
#>		[[ $dn -gt $pk ]] && pk=$dn
#>		pc=$(echo "($pk / $hi) / 100.0" | bc -l | head -c 6)  # worst % deviation
#>		echo "range: $min <= $avg <= $max .. peak-dev: $pk = $pc%"
#>	}
# -MAKE:prng.s
# +MAKE:kbd.s - keyboard driver
#!/bin/bash

#******************************************************************************
#                         ,-----------------.
#                        (  KEYBOARD DRIVER  )
#                         `-----------------'
#******************************************************************************

#+=============================================================================
# returns:
#   0 - OK
#   1 - driver not running
#
keyStop() {
	[[ (! -z $KeyRun) && ($KeyRun -ne 1) ]]  &&  return 1

	# Restore terminal settings - known to fail sometimes !?
#	stty sane            # Set terminal to "sane" settings
	[[ ! -z "$KeyStty" ]]  &&  stty ${KeyStty}

	tput cnorm           # Make the cursor visible

	KEY=
	KeyQ=
	KeyEOK=
	KeyStty=

	KeyRun=0

	return 0
}

#+=============================================================================
# optional:
#   KEYDRV=v2  -  use keyboard driver v2 (preferred, not supported by WSL)
#
keyStart() {
	# weirdly, this "\e" seems to work with OSX
	# why no O ???  <- answer: see Kali!
	KeyEOK=[a-zA-NP-Z~^\$@\e]

	KEY=
	KeyQ=

	KeyStty=$(stty -g)   # Save our current terminal settings

	ATEXIT+=("keyStop")

	tput civis           # Hide the cursor

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
# private function
#
keyXlat() {
	local k
	printf -v k "%02X" "'$KEY"
	case $k in
		# we never see either of these values‽ :(
		0A )  KEY=LF ;;
		0D )  KEY=CR ;;
		# couple of special cases
		7F )  KEY=BKSP ;;
		1B )  KEY=ESC ;;
		09 )  KEY=TAB ;;
		*  )
			printf -v k "%d" "'$KEY"                   # get ASCII value
			if [[ ($k -ge 0) && ($k -le 31) ]]; then   # ctrl key?
				# If you need {^Q, ^S, ^C, ^Z, ^D, etc.},
				#   you will need to unbind them with stty [see keyStart()]

				printf -v k "%02X" $((k|=64))          # set bit6 for printable
				KEY=$(echo -en "^\x${k}")              # create "^C" style KEY

				[[ "$KEY" == "^H" ]]  &&  KEY=BKSP     # Kali
			fi ;;
	esac
}

#+=============================================================================
# private function
#
keyXlatEsc() {
	case $KEY in
		$'\033'[A   )  KEY=UP    ;;
		$'\033'[B   )  KEY=DOWN  ;;
		$'\033'[C   )  KEY=RIGHT ;;
		$'\033'[D   )  KEY=LEFT  ;;

		$'\033'[11~ )  KEY=F1    ;;
		$'\033'[12~ )  KEY=F2    ;;
		$'\033'[13~ )  KEY=F3    ;;
		$'\033'[14~ )  KEY=F4    ;;

		$'\033'[OP  )  KEY=F1    ;;  # kali
		$'\033'[OQ  )  KEY=F2    ;;  # kali
		$'\033'[OR  )  KEY=F3    ;;  # kali
		$'\033'[OS  )  KEY=F4    ;;  # kali

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
		$'\033'[3   )  KEY=DEL   ;; # NO idea why this has started happening!?

		## Add more keys here

		*) ;;
	esac
}

#+=============================================================================
# optional:
#   KEYDRV=v2  -  use keyboard driver v2 (preferred, not supported by WSL)
#
# returns:
#   0 - OK
#   1 - driver not running
#
keyFlush() {
	[[ -z $KeyRun  ||  $KeyRun -eq 0 ]]  &&  return 1

	if [[ "$KEYDRV" == "v2" ]] ; then
		IFS= read -r
	else # v1
		IFS= read -r -d '' -t0.01
	fi

	KEY=
	KeyQ=

	return 0
}

#+=============================================================================
# optional:
#   KEYDRV=v2  -  use keyboard driver v2 (preferred, not supported by WSL)
#
# returns:
#   0 - OK, keystroke in $KEY
#   1 - driver not running
#   2 - no keys ready
#   3 - partial escape code ready
#
keyGet() {
	[[ (-z $KeyRun) || ($KeyRun -eq 0) ]]  &&  return 1

	KEY=

	if [[ "$KEYDRV" == "v2" ]] ; then
		IFS= read -r
		KeyQ="${KeyQ}${REPLY}"
	else # v1
		local esc=0
		while true ; do
			# -s doesn't seem to work - stackoverflow suggests this is common
			IFS= read -r -s -n1 -d '' -t0.05
			[[ $? -ne 0 ]]  &&  break
			KeyQ="${KeyQ}${REPLY}"
			if [[ $esc -eq 0 ]]; then
				[[ ${REPLY} == $'\033' ]]  &&  esc=1  ||  break
			else  # esc=1
				case ${REPLY} in
					${KeyEOK} )  break  ;;  # the while loop
				esac
			fi
		done
	fi

	local buflen=${#KeyQ}

	case ${buflen} in
		0)	return 2  ;;  # error: no keys found
		1)	KEY="${KeyQ}"
			KeyQ=
			keyXlat
			return 0  ;;  # error: 0K
	esac

	if [[ ${KeyQ:0:1} == $'\033' ]]; then
		local i
		for ((i = 1;  i < ${buflen};  i++)); do
			case ${KeyQ:$i:1} in
				${KeyEOK} )  break  ;;  # break 'for' loop
			esac
		done
		[[ $i == ${buflen} ]]  &&  return 3  # error: unterminated escape sequence

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
# -MAKE:kbd.s
# +MAKE:time.s - timer system
#!/bin/bash

#------------------------------------------------------------------------------ ----------------------------------------
clrTIME="${BGRN}"              # Time

#+============================================================================= ========================================
timeGet() {  # (resultvar)
	case "$BASHVER" in
		"bash5" )  eval printf -v $1 "%s" "\$((\${EPOCHREALTIME/.} / 1000))"  ;;
		"bash4" )  eval $1=$(date +%s%3N)  ;;  # external - slow
		"bash3" )
			echo "BASh v3 (MacOS) lacks sub-second timing precision"
			exit -1
	esac
}

#+=============================================================================
# Start stopwatch
#
timeStart() {
	timePause=0
	timeGet timeStart
}

#+=============================================================================
# Update stopwatch
#
timeShow() {
	local now
	timeGet now
	timeTotal=$((now -timeStart -timePause))
	PAT $TMy $((TMx +1)) "${clrTIME}$(date -u -d @$((timeTotal /1000)) +"%T")"
}
# -MAKE:time.s
# +MAKE:status.s - status line
#!/bin/bash

#------------------------------------------------------------------------------ ----------------------------------------
clrStatus="${GRN}"                           # status text

statNorm=4200  # most messages
statSlow=6000  # long messages
statLen=71     # max length of status message

#+=============================================================================
statusClear() {  # (msg)
	printf "\033[25;1H${atOFF}%*s" $statLen  # clear
	StatMsg=0
}

#+=============================================================================
statusStart() {  # (delay)
	StatTime=$1  # How long to display a message in mS
	statusClear
}

#+=============================================================================
statusSet() {  # (msg)
	local s  now

	statusClear
	s="$@"
#	PAT 25 3 "${clrStatus}${s::$statLen}" # embedded colours will break this :(
	PAT 25 3 "${clrStatus}${s}" # embedded colours will break this :(
	StatMsg=1

	timeGet now
	((StatClear = now +StatTime))
}

#+=============================================================================
statusUpdate() {
	if (($StatMsg)); then
		local now
		timeGet now
		[[ $now -gt $StatClear ]]  &&  statusClear
	fi
}
# -MAKE:status.s
# +MAKE:sys.s - system functions
#!/bin/bash

#****************************************************************************** ****************************************
#                              ,--------------.
#                             (  PROGRAM INFO  )
#                              `--------------'
#****************************************************************************** ****************************************
NAME="BAShTris"
VER=1.0

AUTHOR="${BBLK}cs${BGRN}ßlúè${BBLU}Çhîp${atOFF}"
GROUP="${BCYN}Çybôrg Sÿstem$"

DBGpipe=$NAME.debug

ERR_OK=0
ERR_NODEP=1
ERR_TOOBIG=2

# https://www.utf8-chartable.de/unicode-utf8-table.pl?start=00&number=256&utf8=oct
#nbsp="$(echo -e '\u00a0')"     # Nope - Mac's come with BASh v3
#nbsp="$(echo -e '\xc2\xa0')"   # Nope - Mac's come with BASh v3
nbsp="$(echo -e '\0302\0240')"

clrCsMini="${RED}"                                     # backdrop logo
clrCsSlogan="${atPFX}${fgYEL};${bgRED}${atSFX}"        # CS slogans

clrKeyDbg="${atPFX}${fgYEL};${bgMAG}${atSFX}"          # keycap debug
clrKeycap="${atPFX}${fgYEL};${bgBLU}${atSFX}"          # keycap normal
keyL="${atPFX}${fgBLU};${bgBLK}${atSFX}▐${clrKeycap}"  # left of normal keycap
keyR="${atPFX}${fgBLU};${bgBLK}${atSFX}▌${atOFF}"      # right of normal keycap

clrVal="${atPFX}${fgBLK};${bgWHT}${atSFX}"             # values and inputs
clrLang1="${atPFX}${fgBLK};${bgCYN}${atSFX}"           # active language
clrLang2="${GRY}"                                      # next language

#+============================================================================= ========================================
sysChkUtil() {
	local err reqd r

	err=$ERR_OK

	reqd=(which sed grep date tput stty wc chmod uname less)         # <--- 0_o
	for r in ${reqd[@]} ; do
		$(which $r >/dev/null 2>&1)  ||  {
			>&2 echo "! Missing dependency: $r"
			err=$ERR_NODEP
		}
	done

	((err != ERR_OK))  &&  exit $err
	return $err
}

#+============================================================================= ========================================
sysChkTerm() {
	local sz=($(stty size))
	SCRH=${sz[0]}
	SCRW=${sz[1]}

	if [[ $SCRW -lt 80 || $SCRH -lt 25 ]]; then
		echo "! Terminal too small: {$SCRW x $SCRH}"
		echo ""
		helpRequired
		exit 92

	elif [[ $SCRW -gt 80 || $SCRH -gt 25 ]]; then
		echo "? Oversized window: {$SCRW x $SCRH}"
		echo ""
		helpRequired
		echo ""
		echo "$NAME will run in the top-left of this window,"
		echo "Do NOT report bugs found in this mode!"
		echo 'Press ` to redraw the playfield during play'
		echo ""
		echo "Press <return> to play or ^C to abort"

		read
		return $ERR_TOOBIG
	fi

	return $ERR_OK
}

#+============================================================================= ========================================
sysGetArch() {
	local tmp=$(uname -v)

	if   [[ "$tmp" =~ "Darwin"    ]]; then  DISTRO="OSX"
	elif [[ "$tmp" =~ "Microsoft" ]]; then  DISTRO="WSL"
	elif [[ "$tmp" =~ "kali"      ]]; then  DISTRO="Kali"  # before "Debian"
	elif [[ "$tmp" =~ "Debian"    ]]; then  DISTRO="Debian"
	else                                    DISTRO="???"
	fi

	BASHVER=$(bash --version | grep bash | sed 's/[^0-9]*\(.\).*/bash\1/')
}

#+============================================================================= ========================================
sysSetup() {
	ATEXIT=()

	# Get our own truename, for {high scores, sprites, etc.}
	CMD=$(which $0)
	if grep '^# MAKE-COOKIE' ${CMD} 2>&1 >/dev/null ; then
		CMDhs="${CMD}"
		CMDrig="${CMD}"
		CMDgo="${CMD}"
	else
		CMDhs="${CMD%/*}/hiscore.dat"
		CMDrig="${CMD%/*}/rig.dat"
		CMDgo="${CMD%/*}/gameover.dat"
	fi

	# Check we have all the required utils {sed, grep, etc.}
	sysChkUtil  ||  return $?

	# System Architecture
	sysGetArch

	[[ "$1" == "quick" ]]  &&  return

	# Check as much as we can about the terminal
	sysChkTerm

	# Make sure we clean up on the way out
	trap sysAtexit EXIT

	# Unsupported OS will error & `exit -1` here
	local x
	timeGet x

	# Start the keyboard driver (requires cleanup to be configured)
	if [[ -z "$KEYDRV" ]]; then
		case "{$DISTRO^^}" in
			"OSX" | "KALI" | "DEBIAN" )  KEYDRV="v2" ;;
			"WSL"                     )  KEYDRV="v1" ;;
			*                         )  KEYDRV="v2" ;;  # might as well try!
		esac
	fi
	keyStart

	# trap ^C ...unnecessary now we're trapping EXIT, but still pretty :)
	((CTRLC))  &&  trap ctrlC_pressBksp INT

	# trap ^Z

	statusStart $statNorm

	langInit EN

	(($DEBUG))  &&  dbgStart "${NAME}"

	boredCnt=0
}

#+============================================================================= ========================================
sysAtexit() {
	for c in ${ATEXIT[@]} ; do
		DBG "ATEXIT: $c"
		$c
	done

	# don't leave zombies
	local list="$(jobs -p)"
	if [[ ! -z "$list" ]]; then
		local pipe="/dev/null"
		[[ $DEBUG -eq 1  &&  -p $DbgPipe ]]  &&  pipe="$DbgPipe"
		DBG "ATEXIT: kill -13 {$list}"
		kill -13  $list 1>$pipe 2>&1
	fi

	((DEBUG))  &&  PAT 24 1 ""
}

#+============================================================================= ========================================
ctrlC_pressBksp() {
	statusSet "Press${keyL}◄▬▬${keyR}to quit"
	return
}

#+============================================================================= ========================================
WipeOut() {
	local  y  x

	# wipe-out
	for ((x = 1;  x <= 40;  x++)); do
		for ((y = 1;  y <= 25;  y++)); do
			PAT $y $x "${WHT}│"
			PAT $y $((81 -x)) "${WHT}│"
		done
		if [[ $x -gt 0 ]]; then
			for ((y = 1; y <= 25;  y++)); do
				PAT $y $((x  -1)) " "
				PAT $y $((81 -x)) " "
			done
		fi
		sleep 0.01
	done
}

#+============================================================================= ========================================
Intro() {
	((CTRLC))  &&  trap "" INT
	CLS
	csDraw
	helpCtrl
	WipeOut
	((CTRLC))  &&  trap ctrlC_pressBksp INT
}

#+============================================================================= ========================================
countdown() {
	local sz  s  cnt  st  now  next  clr
	local cset=("${YEL}" "${BRN}" "${RED}")
	local bps=12

	((sz = $1 *bps))
	printf -v s "%*s" $sz
	s="${s// /•}"

	cnt=0
	timeGet st
	((now = st))
	while ((cnt <= sz)); do
		clr=$((RANDOM %3))
		clr=${cset[$clr]}
		statusSet "${GRN}${s::-$cnt}${clr}☼"
		((next = st +((cnt *1000) /$bps) ))
		while ((now < next)); do timeGet now ; done
		keyGet
		[[ "${KEY^^}" == "P" ]]  &&  break
		((cnt++))
	done
	statusSet ""
}
# -MAKE:sys.s
# +MAKE:debug.s - debug API & debug monitor
#!/bin/bash

#+=============================================================================
dbgStart() {  # (pipename)
	DbgPipe="~$1.debug"
}

#+=============================================================================
DBG() {
	[[ $DEBUG -eq 1 && -p $DbgPipe ]]  &&  echo "$@" >$DbgPipe
}

#+=============================================================================
DBGF() {
	[[ $DEBUG -eq 1 && -p $DbgPipe ]]  &&  printf $@  >$DbgPipe
}

#+=============================================================================
dbgEnd() {
	echo -e "\nExiting cleanly"
	rm -f ${DbgPipe}
	exit 0
}

#+=============================================================================
dbgMonitor() {
	dbgStart "${NAME}"

	[[ ! -e $DbgPipe ]]  &&  mknod $DbgPipe p

	if [[ -p $DbgPipe ]]; then
		local d=$(date +%Y/%m/%d_%T)
		echo -en "${GRN}$NAME debug monitor ${atOFF}... ${MAG}$DbgPipe ${atOFF}... "
		echo -e "${YEL}$d ${atOFF}... ${RED}^C to exit.${atOFF}"
		((CTRLC))  &&  trap dbgEnd  INT  # trap ^C
		tail -f $DbgPipe
	else
		echo "! Error: $DbgPipe exists, and is not a named pipe"
		exit 1
	fi
	exit 2  # should never reach here
}
# -MAKE:debug.s
# +MAKE:cs.s - cyborg systems fancy shit
#!/bin/bash

#****************************************************************************** ****************************************
#                          ,-------------------------.
#                         (  CYBORG SYSTEMS BRANDING  )
#                          `-------------------------'
#****************************************************************************** ****************************************

CSmini=()
	CSmini+=("╓────╖")
	CSmini+=("║ °╓─╖")
	CSmini+=("║  ╙─╖")
	CSmini+=("╙─╜╙─╜")
CSminiW=${#CSmini[0]}
CSminiH=${#CSmini[@]}

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
CSlogoW=${#CS[0]}
CSlogoH=${#CS[@]}

#+============================================================================= ========================================
# Fill the main screen with the CSmini logo
#
csDrawBackdrop() {
	local  y  h  yy  x

	for ((y = 1;  y <= 25; y += $CSminiH)); do
		for ((h = 0;  h < ${CSminiH};  h++)); do
			((yy = $y +$h))
			[[ $yy -gt 24 ]]  &&  break
			for ((x = 2;  x < 80; x += ${CSminiW})); do
				PAT $yy $x "${clrCsMini}${CSmini[$h]}"
			done
		done
	done

	pfDrawDebug
}

#+============================================================================= ========================================
csDrawBackdropReveal() {
	local x  s

	local CSbd=()
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

	local cnt=${#CSbd[@]}
	for ((i = 0;  i < cnt;  i++)); do
		CSbd[i]="${CSbd[i]}${nbsp}"
	done
	CSbd+=("$(printf "%*s" 80 "")")
#	printf -v s "%*s" 80 ""
#	Csbd+=("$s")

	for ((x = 40;  x >= 0;  x--)); do
		if [[ $x -gt 0 ]]; then
			for ((y = 1;  y <= 25;  y++)); do
				PAT $y $x "${WHT}│"
				PAT $y $((81 -$x)) "${WHT}│"
			done
		fi
		if [[ $x -lt 40 ]]; then
			for ((y = 1; y <= 25;  y++)); do
				PAT $y $((x +1)) "${clrCsMini}${CSbd[$y]:$(($x +1 -1)):1}"
				PAT $y $((80 -$x)) "${clrCsMini}${CSbd[$y]:$((80 -$x -1)):1}"
			done
		fi
		[[ -z $1 ]] && sleep 0.01
	done

	pfDrawDebug
}

#+============================================================================= ========================================
# Plot a single character on the screen
# Colour according to position & character type
#
csDrawPlot() {  # (y, x, chr)
	local clrCsBc="${atPFX}${fgBLU};${clrTxtBg}${atSFX}"
	local clrCsBcLegs="${atPFX}${atUSC};${fgYEL};${clrTxtBg}${atSFX}"

	if [[ ($1 -ge 5) && ($1 -le 8) && ($2 -ge 73) && ($2 -le 78) ]]; then  # bluechip
		case $3 in
			"_" )  PAT $1 $2 "${clrCsBcLegs} "   ;;
			"―" )  PAT $1 $2 "${clrCsBcLegs}$3"  ;;  # chip legs are \u2015 'cos Kali
			*   )  PAT $1 $2 "${clrCsBc}$3"      ;;
		esac

	else  # CS
		case $3 in
			"▀"     )  PAT $1 $2 "${CYN}$3"   ;;  # up
			"█"     )  PAT $1 $2 "${CYN}$3"   ;;  # full
			"▄"     )  PAT $1 $2 "${BCYN}$3"  ;;  # down

			"░"     )  PAT $1 $2 "${CYN}$3"  ;;  # dark
			"▒"     )  PAT $1 $2 "${CYN}$3"  ;;  # med
			"▓"     )  PAT $1 $2 "${CYN}$3"  ;;  # light
			[▲▼]    )  PAT $1 $2 "${CYN}$3"  ;;

			[0-9]   )  PAT $1 $2 "${BLU}$3"  ;;  # year

			[A-Z\-] )  PAT $1 $2 "${clrCsSlogan}$3"  ;;  # Slogan
			[#]     )  PAT $1 $2 "${clrCsSlogan} "   ;;  # ...

			" "     )  PAT $1 $2 "${atOFF}$3" ;;
			*       )  PAT $1 $2 "${atOFF}" ;;
		esac
	fi
}

#+============================================================================= ========================================
# Draw a full ANSI letter
#
csDrawChar() {  # (y, x, speed)
	((CTRLC))  &&  trap "" INT  # disable ^C

	local tly=$1
	local tlx=$2

	local bry=$(($1 +11))
	local brx=$(($2 + 8))
	local spd=$3

	for ((y = $tly;  y <= $bry;  y++)); do
		for ((x = $tlx;  x <= $brx;  x++)); do
			csDrawPlot $y $x "${CS[$y]:$x:1}"
			sleep $spd
		done
	done
}

#+============================================================================= ========================================
# Draw the big C, downwards
#
csDrawCdown() {  # (spd)
	((CTRLC))  &&  trap "" INT  # disable ^C

	local  y  x

	local spd=$1

	for ((y = 5;  y >=  2;  y--)); do
		for ((x = 17;  x <= 19;  x++)); do     csDrawPlot $y $x "${CS[$y]:$x:1}" ; done ; sleep $spd
	done
	y=1   ; for ((x = 18;  x >= 2;  x--)); do  csDrawPlot $y $x "${CS[$y]:$x:1}" ; sleep $spd ; done
	for ((y = 2;  y <=  23;  y++)); do
		for ((x = 1;  x <=  3;  x++)); do      csDrawPlot $y $x "${CS[$y]:$x:1}" ; done ; sleep $spd
	done
	y=24 ; for ((x =  1;  x <=  8;  x++)); do  csDrawPlot $y $x "${CS[$y]:$x:1}" ; sleep $spd ; done
	x=9  ; for ((y = 24;  y >= 21;  y--)); do  csDrawPlot $y $x "${CS[$y]:$x:1}" ; sleep $spd ; done
}

#+=============================================================================
# Draw the big C, upwards
#
#>	csDrawCup() {  # (spd)
#>		local  y  x
#>
#>		local spd=$1
#>
#>		x=9  ; for ((y = 21;  y <= 24;  y++)); do  csDrawPlot $y $x "${CS[$y]:$x:1}" ; sleep $spd ; done
#>		y=24 ; for ((x =  8;  x >=  1;  x--)); do  csDrawPlot $y $x "${CS[$y]:$x:1}" ; sleep $spd ; done
#>		for ((y = 23;  y >=  2;  y--)); do
#>			for ((x = 1;  x <=  3;  x++)); do      csDrawPlot $y $x "${CS[$y]:$x:1}" ; done ; sleep $spd
#>		done
#>		y=1  ; for ((x =  2;  x <= 18;  x++)); do  csDrawPlot $y $x "${CS[$y]:$x:1}" ; sleep $spd ; done
#>		for ((y = 2;  y <=  5;  y++)); do
#>			for ((x = 17;  x <= 19;  x++)); do     csDrawPlot $y $x "${CS[$y]:$x:1}" ; done ; sleep $spd
#>		done
#>	}

#+============================================================================= ========================================
# Draw the first S, downwards
#
csDrawSdown() {  # (spd)
	((CTRLC))  &&  trap "" INT  # disable ^C

	local  y  x

	local spd=$1

	for ((y = 17;  y >= 14;  y--)); do
		for ((x = 17;  x <= 19;  x++)); do      csDrawPlot $y $x "${CS[$y]:$x:1}" ; done ; sleep $spd
	done
	y=13 ; for ((x = 18;  x >=  12;  x--)); do  csDrawPlot $y $x "${CS[$y]:$x:1}" ; sleep $spd ; done
	for ((y = 14;  y <= 18;  y++)); do
		for ((x = 11;  x <= 13;  x++)); do      csDrawPlot $y $x "${CS[$y]:$x:1}" ; done ; sleep $spd
	done
	for ((x = 13;  x <= 19;  x++)); do
		for ((y = 18;  y <= 19;  y++)); do      csDrawPlot $y $x "${CS[$y]:$x:1}" ; done ; sleep $spd
	done
	for ((y = 19;  y <= 23;  y++)); do
		for ((x = 17;  x <= 19;  x++)); do      csDrawPlot $y $x "${CS[$y]:$x:1}" ; done ; sleep $spd
	done
	y=24 ; for ((x = 18;  x >=  12;  x--)); do  csDrawPlot $y $x "${CS[$y]:$x:1}" ; sleep $spd ; done
	for ((y = 23;  y >= 20;  y--)); do
		for ((x = 11;  x <= 13;  x++)); do      csDrawPlot $y $x "${CS[$y]:$x:1}" ; done ; sleep $spd
	done
}

#+=============================================================================
# Draw the first S, upwards
#
#>	csDrawSup() {  # (spd)
#>		local  y  x
#>
#>		local spd=$1
#>
#>		for ((y = 20;  y <= 23;  y++)); do
#>			for ((x = 11;  x <= 13;  x++)); do      csDrawPlot $y $x "${CS[$y]:$x:1}" ; done ; sleep $spd
#>		done
#>		y=24 ; for ((x = 12;  x <=  18;  x++)); do  csDrawPlot $y $x "${CS[$y]:$x:1}" ; sleep $spd ; done
#>		for ((y = 23;  y >= 19;  y--)); do
#>			for ((x = 17;  x <= 19;  x++)); do      csDrawPlot $y $x "${CS[$y]:$x:1}" ; done ; sleep $spd
#>		done
#>		for ((x = 19;  x >= 13;  x--)); do
#>			for ((y = 19;  y >= 18;  y--)); do      csDrawPlot $y $x "${CS[$y]:$x:1}" ; done ; sleep $spd
#>		done
#>		for ((y = 18;  y >= 14;  y--)); do
#>			for ((x = 11;  x <= 13;  x++)); do      csDrawPlot $y $x "${CS[$y]:$x:1}" ; done ; sleep $spd
#>		done
#>		y=13 ; for ((x = 12;  x <=  18;  x++)); do  csDrawPlot $y $x "${CS[$y]:$x:1}" ; sleep $spd ; done
#>		for ((y = 14;  y <= 17;  y++)); do
#>			for ((x = 17;  x <= 19;  x++)); do      csDrawPlot $y $x "${CS[$y]:$x:1}" ; done ; sleep $spd
#>		done
#>	}

#+============================================================================= ========================================
# EFFECT: Lightning effect on the shading characters
#
csFxFlash() {
	((CTRLC))  &&  trap "" INT  # disable ^C

	local  i  y  x

	for ((i = 1;  i <= 6;  i++)); do
		(($i & 1))  &&  fg="${fgBCYN}" || fg="${fgBBLU}"
		(($i & 1))  &&  fgn="${fgWHT}" || fgn="${fgBBLU}"

		for ((y = 2;  y <= 22;  y++)); do
			for ((x = 2;  x <= 78;  x++)); do
				local chr="${CS[$y]:$x:1}"
				case $chr in
					"░"|"▒"|"▓"|"▲"|"▼" )
						PAT $y $x "${atPFX}${fg};${bgBLK}${atSFX}$chr"
						;;
					[0-9] )
						PAT $y $x "${atPFX}${fgn};${bgBLK}${atSFX}$chr"
						;;
				esac;
			done
		done
		[[ $i -eq  2 ]]  &&  sleep 0.5
	done
}

#+============================================================================= ========================================
# EFFECT: Interlace effect on the whole logo
#
csFxIlace() {
	((CTRLC))  &&  trap "" INT  # disable ^C

	local  i  y  yy  x

	for ((i = 1;  i <= 3;  i++)); do
		for ((y = 1;  y <= $((24 -$i));  y += 3)); do
			yy=$(($y +$i -1))
			for ((x = 1;  x <= 80;  x++)); do  csDrawPlot $yy $x "${CS[$yy]:$x:1}" ; done

			yy=$(($y +$i))
			PAT $yy 1 "${atOFF} "
			for ((x = 1;  x <= 79;  x++)); do  csDrawPlot $yy $(($x +1)) "${CS[$yy]:$x:1}" ; done
		done
	done

	for ((yy = $i;  yy <= 23;  yy += 3)); do
		for ((x = 1;  x <= 80;  x++)); do      csDrawPlot $yy $x "${CS[$yy]:$x:1}" ; done
	done
	for ((x = 1;  x <= 80;  x++)); do          csDrawPlot 24 $x "${CS[24]:$x:1}" ; done
}

#+============================================================================= ========================================
# EFFECT: WIPE - erase
#
csWipeUnplot() {  # (y, x)
	[[ $1 -lt  1 || $1 -gt 25 || $2 -lt  1 || $2 -gt 80 ]]  &&  return
	[[ $2 -lt 79 ]]  &&  ch="   "  ||  ch="  "
	PAT $1 $2 "${atOFF}${ch}"
}

#+=============================================================================
# EFFECT: WIPE - redraw
#
csWipeReplot() {  # (y, x)
	local  i

	[[ $1 -lt  1 || $1 -gt 25 || $2 -lt  1 || $2 -gt 80 ]]  &&  return
	[[ $2 -lt 79 ]]  &&  c=3  ||  c=2
	for ((i = 0;  i < $c;  i++)); do
		local x=$(($2 +$i))
		csDrawPlot $1 $x "${CS[$1]:$x:1}"
	done
}

#+=============================================================================
# EFFECT: WIPE - redraw with CONTROLLER screen
#
#>	CTRLwipeReplot() {  # (y, x)
#>		local  i
#>
#>		[[ $1 -lt  1 || $1 -gt 25 || $2 -lt  1 || $2 -gt 80 ]]  &&  return
#>		[[ $2 -lt 79 ]]  &&  c=3 || c=2
#>		for ((i = 0;  i < $c;  i++)); do
#>			local x=$(($2 +$i))
#>			CTRLplot $1 $x "${CTRL[$1]:$x:1}"
#>		done
#>	}

#+=============================================================================
# EFFECT: WIPE - expanding box
#
csFxWipe() {  # (unplot|replot, spd)
	((CTRLC))  &&  trap "" INT  # disable ^C

	local  l  d  u  r

	local w=3
	local y=13  # start seed point
	local x=37  # (N *w) +1
	local sz=1
	while [[ $sz -le $((80/$w + 1)) ]]; do
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
# This is it!!
#
csDraw() {
	local  y  x

	CLS

	# CS
	csDrawCdown 0.02 &
	csDrawSdown 0.03 &
	wait

	# YBORG
	for ((x = 21;  x < 62;  x += 10)); do
		csDrawChar 1 $x 0.0001 &
		sleep 0.1
	done
	wait

	# YSTEMS
	for ((x = 21;  x < 72;  x += 10)); do
		csDrawChar 13 $x 0.0001 &
		sleep 0.1
	done
	wait

	# Chip
	for ((y = 5;  y <= 8;  y++)); do
		for ((x = 73;  x <= 77;  x++)); do
			csDrawPlot $y $x "${CS[$y]:$x:1}"
		done
	done
	sleep 0.2

	# slogan
	PAT 25 29 "${clrCsSlogan}                      "
	for ((x = 29;  x <= 50;  x++)); do
		csDrawPlot 25 $x "${CS[25]:$x:1}"
		sleep 0.02
	done

	# anykey
	keyFlush
	local i=0
	while true ; do
		[[ $i -eq  0 ]]  &&  PAT 24 80 "${WHT}■"
		[[ $i -eq 10 ]]  &&  PAT 24 80 "${WHT} "  #${nbsp}"
		sleep 0.05

		[[ $((++i)) -ge 14 ]]  &&  i=0

		keyGet  &&  break

		# maybe do an animation
		if [[ $(($RANDOM % 70)) -eq 0 ]]; then
			case $(($RANDOM %4)) in
				[0]  )  csFxIlace &  ;;
				[12] )  csFxFlash &  ;;
				[3]  )  csFxWipe csWipeUnplot 0.01 &
				        sleep 0.03
				        csFxWipe csWipeReplot 0.01 &  ;;
			esac
		fi
	done
	PAT 24 80 "${WHT}√"
	wait
	PAT 24 80 "${WHT} "

	[[ "$KEY" == "BKSP" ]]  &&  quit 0
}

#+============================================================================= ========================================
# Draw a tetromino at the given coords (full screen)
#
#>	csDrawTet() {  # (y, x, tet$, colour)
#>		local ty=$1
#>		local tx=$2
#>		local tet=$3
#>		local clr=$4
#>
#>		for ((h = 0;  h < $tetH;  h++)); do
#>			local y=$(($ty +$h))
#>			for ((w = 0;  w < $tetW;  w++)); do
#>				local x=$(($tx + $w*2))
#>				local z=$(($h*$tetW +$w))
#>				[ ${tet:$z:1} == "#" ]  &&  echo -en ${clr}"\033[${y};${x}H"${tetGR}
#>			done
#>		done
#>	}

#+============================================================================= ========================================
# Un-Draw a tetromino at the given coords (restore logo)
#
#>	csUndrawTet() {  # (y, x, tet$)
#>		for ((h = 0;  h < $tetH;  h++)); do
#>			local y=$(($1 +$h))
#>			for ((w = 0;  w < $tetW;  w++)); do
#>				local z=$(($h*$tetW +$w))
#>				local tet=$3
#>				[ ${tet:$z:1} == "#" ]  &&  {
#>					((x = $2 + $w*2))
#>					csDrawPlot $y $x "${CS[$y]:$x:1}"  # undraw
#>					((x++))
#>					csDrawPlot $y $x "${CS[$y]:$x:1}"  # undraw
#>				}
#>			done
#>		done
#>	}

#+============================================================================= ========================================
# test harness
#
#>	csDrawTEST() {
#>		# draw logo
#>		CLS
#>		for ((y = 1;  y <= 25;  y++)); do
#>			PAT $y 1 "${CS[$y]:1}"
#>		done
#>
#>		# overlay tetromino - demo
#>		for ((i=1; i<=5; i++)); do
#>			csDrawTet 6 43 ${tetL[0]} ${tetL[4]}
#>			sleep 0.5
#>			csUndrawTet 6 43 ${tetL[0]}
#>			sleep 0.5
#>		done
#>
#>		# wait key
#>		while ! keyGet ; do : ; done
#>		[ "$KEY" == "BKSP" ] && Quit 0
#>	}

# -MAKE:cs.s
# +MAKE:quit.s - quit screen
#!/bin/bash

#+============================================================================= ========================================
# Exit cleanly
#
quit() {  # (errorlevel)

#        0         1         2         3         4         5        6          7         8
#        012345678901234567890123456789012345678901234567890123456789012345678901234567890
QMSG=()
 QMSG+=(" │○¦ Thanks for playing BAShTrish                  Спасибо за игру в Башотрис ¦○│") # 0
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
 QMSG+=(" │ ¦ KThxBye,                                 █ ███ █ █▀▄ ▀███▀▄▄▀▀▄▄▄▄ ▀█▀  /\ │") #17
 QMSG+=(" │○¦   csßlúèÇhîp                             █▄▄▄▄▄█ █▀  █▀▄▀ ▄ █▀▀▄███▄▀   \○\│") #18
 QMSG+=(" │ ¦                                         ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄  \/ ") #19
 QMSG+=(" │○¦,-'\"-._,-'\"'--'\"'-.,-'\"'-._-\"-._,-\"'-.__,-^-._,-'\"'-._,-''-._,-\"--._-\"-.._/  ") #20
 QMSG+=("                                                                                 ") #21
#QMSG+=(" If your cursor is not visible: stty sane ; tput cnorm                           ") #22
#        0         1         2         3         4         5        6          7         8
#        012345678901234567890123456789012345678901234567890123456789012345678901234567890

	local clr

	local cWWW="${atPFX}${atUSC};${fgBBLU};${bgBLK}${atSFX}"
	local cQR="${atPFX}${fgBLK};${bgWHT}${atSFX}"
	local cRIP="${atPFX}${atUSC};${fgGRY};${bgBLK}${atSFX}"

	[ "$2" != "q" ] && {
		statusSet "KThxBye"

		PAT 25 1
		for ((y = 0;  y < 24;  y++)); do
			echo ""
			for ((x = 1;  x <= 80;  x++)); do
				if false; then :
				elif [[  $y -eq 19 &&                $x -eq 79                ]] ; then clr=${GRY}   # holes
				elif [[  $y -eq 18 &&                $x -eq 79                ]] ; then clr=${WHT}   # holes
				elif [[  $y -eq 17 &&                $x -eq 78                ]] ; then clr=${WHT}   # holes

				elif [[ ($y -eq 10 || $y -eq 15) &&  $x -eq  8                ]] ; then clr=${BRN}   # greet box
				elif [[ ($y -ge 11 && $y -le 14) && ($x -eq  8  || $x -eq 38) ]] ; then clr=${BRN}   # greet box
				elif [[ ($y -ge 11 && $y -le 14) &&  $x -eq 10                ]] ; then clr=${WHT}   # greet txt

				elif [[  $y -eq 20               && ($x -eq  2 ||  $x -eq  3) ]] ; then clr=${cRIP}
				elif [[  $y -eq 20               &&  $x -eq  1                ]] ; then clr=${WHT}
				elif [[  $y -eq 20                                            ]] ; then clr=${GRY}   # tear

				elif [[  $y -eq 22               &&  $x -eq  2                ]] ; then clr=${WHT}   # cursor:
				elif [[  $y -eq 22               &&  $x -eq 32                ]] ; then clr=${BGRN}  # stty

				elif [[                              $x -eq  1 ||  $x -eq 80  ]] ; then clr=${WHT}   # tractor
				elif [[                              $x -eq  2 ||  $x -ge 77  ]] ; then clr=${GRY}   # cut
				elif [[                              $x -eq  4                ]] ; then clr=${WHT}

				elif [[  $y -eq  0               &&  $x -eq  5                ]] ; then clr=${YEL}   # thx

				elif [[  $y -eq  2               &&  $x -eq 30                ]] ; then clr=${cWWW}
				elif [[  $y -eq  2               &&  $x -eq 71                ]] ; then clr=${WHT}

				elif [[ ($y -ge  4 && $y -le  9) &&  $x -eq 12                ]] ; then clr=${BCYN}   # csys logo
				elif [[ ($y -ge  4 && $y -le  9) &&  $x -eq 37                ]] ; then clr=${WHT}

				elif [[ ($y -ge  4 && $y -le 19) &&  $x -eq 45                ]] ; then clr=${cQR}
				elif [[ ($y -ge  4 && $y -le 19) &&  $x -eq 76                ]] ; then clr=${WHT}

				elif [[  $y -eq 18                 &&  $x -eq  7              ]] ; then clr=${GRY}   # cs
				elif [[  $y -eq 18                 &&  $x -eq  9              ]] ; then clr=${BGRN}  # Blue <sic>
				elif [[  $y -eq 18                 &&  $x -eq 13              ]] ; then clr=${BBLU}  # Chip

				elif [[  $y -eq 20                 &&  $x -eq 79              ]] ; then clr=${WHT}
				fi
				echo -en "${clr}${QMSG[$y]:$x:1}"
			done
			sleep 0.03
		done

		PAT $((SCRH -1)) 1 "\n\n"
		PAT $((SCRH -2)) 1
	}

	exit $1
}
# -MAKE:quit.s
# +MAKE:cli.s - cli parser
#!/bin/bash

#+============================================================================= ========================================
parseCLI() {  # (...)
	DEBUG=0     # debug mode
	NDRAW=0     # piece: normal draw (default is grid draw) [debug mode only]
	SKIP=0      # skip intros
	FAST=0      # fast draw

	MONITOR=0   # monitor mode

	DOIT=       # perform action
	FILE=       # records file
	MSG=        # message request {help, etc.}
	SEED=       # PRNG seed
	USEED=X     # user defined PRNG seed
	KEYDRV=v2   # keyboard driver (v2 for everything except WSL, so far)
	CTRLC=1     # trap ^C

	while [[ ! -z "$1" ]]; do
		local arg="$1"

		[[ "${arg:0:1}" == "+" ]] && {
			USEED="${arg:1}"
			if [[ ! "$USEED" =~ ^[0-9]+$ ]] || ((USEED > 65535)); then
				echo "! Invalid seed"
				quit 53 q
			fi
			shift
			continue
		}

		case "$arg" in
			"-d"  | "--debug"   )  DEBUG=1        ;;
			"-n"  | "--monitor" )  MONITOR=1      ;;
			"-s"  | "--skip"    )  SKIP=1         ;;
			"-f"  | "--fast"    )  SKIP=1
			                       FAST=1         ;;

			"-k1" | "--kdbv1"   )  KEYDRV=v1      ;;
			"-k2" | "--kdbv2"   )  KEYDRV=v2      ;;

			"-h"  | "--help"    )  MSG=HELP       ;;

			"-H"  | "--man"     )  MSG=README     ;;

			"-v"  | "--version" )  MSG=VER        ;;

			"-c"  | "--ctrlc"   )  CTRLC=0        ;;

			"-r"  | "--records" )  MSG=RECORDS
			                       FILE="$2"
			                       shift
			                       ;;
			"-x"  | "--rexport" )  DOIT=hisExport
			                       FILE="$2"
			                       shift
			                       ;;
			"-i"  | "--rimport" )  DOIT=hisImport
			                       FILE="$2"
			                       shift
			                       ;;
			"-m"  | "--rmerge"  )  DOIT=hisMerge
			                       FILE="$2"
			                       shift
			                       ;;
			"-b"  | "--break"   )  DOIT=unmake
			                       FILE=""
			                       ;;
			"-B"  | "--brkovr"  )  DOIT=unmake
			                       FILE=force
			                       ;;
			        "--id"      )  DOIT=idMake
			                       FILE="id.out"
			                       ;;
			* )  echo "! Unknown command line switch: |$1|"
			     MSG=HELP
			     ;;
		esac
		shift
	done

	((! DEBUG)) && ((SKIP = FAST = 0))  # fast startup in debug mode only

	if [[ "$MSG" == "HELP" ]] ; then
		cat << EOF
${NAME} v${VER}
  -h  --help    : this info
  -H  --man     : full documentation
  -v  --version : show version number

  -k1 --kbdv1   : force v1 keyboard driver (supports WSL)
  -k2 --kbdv2   : force v2 keyboard driver (improved driver)
      --id      : generate id.out for this linux install [debug/porting]

  -r  --records : show hi score records
  -x  --rexport : eXport hi score records  [filename]  <-- optional
  -i  --rimport : Import hi score records  <filename>  <-- required
  -m  --rmerge  : merGe hi score records   <filename>  <-- required
  +N            : seed(N) - repeat a specific game

EOF

		((DEBUG))  &&  cat << EOF
  -d  --debug   : debug mode (extra keys - see controller help screen)
  -s  --skip    : skip intro sequence
  -f  --fast    : fast startup
  -c  --ctrlc   : Enable [do not disable] ^C
  -n  --monitor : monitor debug messages
  -b  --break   : break code in to components - use MAKE.sh to rebuild
  -B  --brkovr  : break code in to components - overwrite existing files

EOF

		helpRequired
		echo ""
		quit 0 q
	fi

	case "$MSG" in
		"README" )
			local re=/^~~README-BEGIN/,/^~~README-END/
			less -x4 <<< $(sed -n "${re}p" $(which $0) | sed -e '1d' -e '$d')
			quit 0 q
			;;

		"VER" )
			echo -e "${NAME} v${VER}"
			quit 0 q
			;;

		"RECORDS" )
			sysSetup
	
			if [[ ! -z "$FILE" ]]; then
				if [[ ! -f "$FILE" ]]; then
					echo "! Cannot read file: |$FILE|"
					exit 130
				fi
				if grep hs_NORM~0,1, $FILE ; then
					echo "! Not a high score file: |$FILE|"
					exit 131
				fi
				CMDhs="$FILE"
			fi
	
			hisStats
			quit 0
			;;
	esac

	[[ ! -z "$DOIT" ]] && {
		sysSetup quick
		$DOIT $FILE
		rv=$?
		quit $rv q
	}

	# Will not return ...yeah, it's dirty - but it's a debug monitor!
	(($MONITOR))  &&  dbgMonitor
}
# -MAKE:cli.s
# +MAKE:lang.s - translation file
#!/bin/bash

#+============================================================================= ========================================
langSetEN() {
	LANG=EN
	AZ="$AZEN"

	txtDebugMode="DEBUG MODE"   # [variable length]

	txtStatsHelp="${keyL}F1${keyR} Keys .. ${keyL}F2${keyR} Combinations .. ${keyL}F10${keyR} Records"

	txtKeyYes="Y"
	txtKeyNo="N"
	txtQuitChk="> CONFIRM SHUT-DOWN? ${keyL}${txtKeyYes}${keyR}/${keyL}${txtKeyNo}${keyR}"

	# PLAYFIELD
	txtScore="SCORE:     "      # [11] score
	txtMult="Mult "             # [ 5] points multiplier
	txtLast="Last "             # [ 5] score for last landed piece
	txtBest="Best "             # [ 5] best piece score (this game)
	txtLines="Lines"            # [ 5] Lines cleared
	txtLevel="Level"            # [ 5] Level (speed of play)
	txtJunk="Junk "             # [ 5] Lines of junk (challenge mode)
	txtPieces="Drops"           # [ 5] Pieces remaining (challenge mode)
	txtSpeed="Speed"            # [ 5] Speed of play (challenge mode)

	# START SCREEN
	txtStyle="Style"            # [5] Gaming Style
	declare -g -A txtOptStyle
	txtOptStyle[NORM]="NORM"    # [4] Normal
	txtOptStyle[CHAL]="CHAL"    # [4] Challenge
	txtOptStyle[NVIS]="NVIS"    # [4] Invisible

	txtSound="Sound"            # [5] Sound mode
	declare -g -A txtOptSound
	txtOptSound[OFF]="OFF"      # [3] Sound off
	txtOptSound[BEL]="BEL"      # [3] "BEL" (ASCII #7)

	txtHighScore="High Score"   # [10]

	# "PRESS START"
	txtPress="PRESS"            # [5] length {5..8}
	txtStart="START"            # [5] length {5..8}

	# HIGH SCORE TABLE [variable length, but all the same]
	txtHsRank="Ranking   "      # [10] 1st/2nd/3rd
	txtHsInit="Initials  "      # [10]
	txtHsScor="Score     "      # [10]
	txtHsLine="Lines     "      # [10]
	txtHsMult="Best Mult."      # [10]
	txtHsPiec="Best Piece"      # [10]
	txtHsTime="Play Time "      # [10]
	txtHsSilv="Silver    "      # [10] Combo blocks
	txtHsGold="Gold      "      # [10] Combo blocks
	txtHsLtet="    L-tets"      # [10] tetrominoes
	txtHsJtet="    J-tets"      # [10]
	txtHsStet="    S-tets"      # [10]
	txtHsZtet="    Z-tets"      # [10]
	txtHsTtet="    T-tets"      # [10]
	txtHsOtet="    O-tets"      # [10]
	txtHsItet="    I-tets"      # [10]
	txtHsTotl="Total Tets"      # [10]
	txtHsSeed="PRNG Seed "      # [10]

	# GET INITAILS
	txtIdentify="Identify yourself, human."  # [variable length]
	txtHIGHSCORE="HIGH SCORE"   # [10]
	txtINITIALS="INITIALS"      # [8]

	# BONUS
	txtPerfect=" PERFECT "      # [9] Clear all pieces from pit

	# COMBOS HELP SCREEN - |F2|
	txtCombinations="Combinations"  # [variable length]
	txtMirror="MIRROR   "      # [9]
	txtRotation="ROTATION "    # [9]
	txtPair="Pair    "         # [8]
	txtPairP="p"               # [1]
	txtSplit="Split   "        # [8]
	txtSplitS="s"              # [1]
	txtUnique="Unique"         # [6]
	txtRotate="Rotate"         # [6] "rotation"
	txtSilv="SILV"             # [4] "silver"
	txtGold="GOLD"             # [4] "gold"

	# Splash strips : "Cyborg Systems is..."
	txtSplashEnt="ENTERTAINING YOU"         # [variable length]
	txtSplashCtrl="PUTTING YOU IN CONTROL"  # [variable length]
}

#+============================================================================= ========================================
#
#
#
#               Thanks for playing BAShTrish
#               Спасибо за игру в Башотрис      <--- did I(/google) get this right?
#
#
#

langSetRU() {
	LANG=RU
	AZ="$AZRU"

	txtDebugMode="РЕЖИМ ОТЛАДКИ"   # [variable length]

	txtStatsHelp="${keyL}F1${keyR} Подсказка .. ${keyL}F2${keyR} Комбинации .. ${keyL}F10${keyR} Результаты"

	txtKeyYes="Д"
	txtKeyNo="Н"
	txtQuitChk="> ПОДТВЕРДИТЬ ВЫХОД? ${keyL}${txtKeyYes}${keyR}/${keyL}${txtKeyNo}${keyR}"

	# PLAYFIELD
	txtScore="Очки:      "      # [11] score
	txtMult="Бонус"             # [ 5] points multiplier
	txtLast="Посл "             # [ 5] score for last landed piece
	txtBest="Лучш "             # [ 5] best piece score (this game)
	txtLines="Линии"            # [ 5] Lines cleared
	txtLevel="Уров "            # [ 5] Level (speed of play)  +START
	txtJunk="Мусор"             # [ 5] Lines of junk (challenge mode)
	txtPieces="Шт   "           # [ 5] Pieces remaining (challenge mode)
	txtSpeed="Темп "            # [ 5] Speed of play (challenge mode)

	# START SCREEN
	txtStyle="Стиль"            # [5] Gaming Style
	declare -g -A txtOptStyle
	txtOptStyle[NORM]="НОРМ"    # [4] Normal
	txtOptStyle[CHAL]="ТЯЖЛ"    # [4] Challenge
	txtOptStyle[NVIS]="ОЧЕН"    # [4] Invisible

	txtSound="Звук "            # [5] Sound mode
	declare -g -A txtOptSound
	txtOptSound[OFF]="БЕЗ"      # [3] Sound off
#	txtOptSound[BEL]="ЗВУ"      # [3] "BEL" (ASCII #7)
	txtOptSound[BEL]="BEL"      # [3] "BEL" (ASCII #7)

	txtHighScore="РЕЗУЛЬТАТЫ"   # [10] Banner for High Scores table

	# "PRESS START"
	txtPress="НАЖМИТЕ"         # [7] length {5..8}
	txtStart="СТАРТ"           # [5] length {5..8}

	# HIGH SCORE TABLE [variable length, but all the same]
	txtHsRank="Рейтинг   "      # [10] 1st/2nd/3rd
	txtHsInit="Инициалы  "      # [10] Initials
	txtHsScor="Очки      "      # [10] Score
	txtHsLine="Линии     "      # [10] Number of lines
	txtHsMult="Лучш Множ."      # [10] Best/highest multiplier
	txtHsPiec="Лучш Очки "      # [10] Best/highest scoring single piece
	txtHsTime="Время Игры"      # [10] Total game time
	txtHsSilv="Серебро   "      # [10] Combo blocks
	txtHsGold="Золото    "      # [10] Combo blocks
	txtHsLtet="    L-tets"      # [10] tetrominoes
	txtHsJtet="    J-tets"      # [10]
	txtHsStet="    S-tets"      # [10]
	txtHsZtet="    Z-tets"      # [10]
	txtHsTtet="    T-tets"      # [10]
	txtHsOtet="    O-tets"      # [10]
	txtHsItet="    I-tets"      # [10]
	txtHsTotl="Всего     "      # [10] total tetrominos
	txtHsSeed="Случайное "      # [10] PRNG Seed

	# GET INITAILS
	txtIdentify="Назови себя, человек."  # [variable length]
	txtHIGHSCORE="  РЕКОРД  "   # [10] [you just got a] "HIGH SCORE"
	txtINITIALS="ИНИЦИАЛЫ"      # [8]  Enter your name

	# BONUS
	txtPerfect=" ИДЕАЛЬНО "      # [9] Clear all pieces from pit

	# COMBOS HELP SCREEN - |F2|
	txtCombinations="Комбинации"  # [variable length]
	txtMirror="ЗЕРКАЛО  "      # [9]
	txtRotation="ВРАЩЕНИЕ "    # [9]
	txtPair="Пара    "         # [8]
	txtPairP="п"               # [1]
	txtSplit="Трещина "        # [8]
	txtSplitS="т"              # [1]
	txtUnique="Уникал"         # [6]
	txtRotate="Вращен"         # [6] "rotation"
	txtSilv="СЕРБ"             # [4] "silver"
	txtGold="ЗОЛТ"             # [4] "gold"

	# Splash strips : "Cyborg Systems is..."
	txtSplashEnt="РАЗВЛЕКАЕТ ВАС"            # [variable length]
	txtSplashCtrl="ПЕРЕДАЮ ВАМ КОНТРОЛЬ"  # [variable length]
}

#+============================================================================= ========================================
langSet() {  # (lang)
	case "$1" in
		RU )  langSetRU ;;
		*  )  langSetEN ;;
	esac

	stPitLang $LANG  # Start screen (incl. logo)
}

#+============================================================================= ========================================
langInit() {  # (lang)
	langEN="English"
	AZEN=" ABCDEFGHIJKLMNOPQRSTUVWXYZ☺☻♣♦♥♠♂♀♪☼0123456789-."

	langRU="Рyсский"
	AZRU=" АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ☺☻♣♦♥♠♂♀♪☼0123456789-."

	langSet "$1"
}

# -MAKE:lang.s
# +MAKE:help.s - help screens
#!/bin/bash

#****************************************************************************** ****************************************
#                               ,---------------.
#                              (  SPLASH SCREEN  )
#                               `---------------'
#****************************************************************************** ****************************************
ctrlBuild() {

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

if [[ $DEBUG -eq 1 ]]; then
 CTRL+=(" ▐Ins▌  █▄▄▄▄▄▄▄▄▄███████████████████▄▄▄▄▄████████████████████████████████  ▐0▌  ")   #13
 CTRL+=(" Place  ██         ▐W▌ ▐↑▌             Θ                                ██ NoDrop")   #14
 CTRL+=("        ██        __//▲||__                                   ▐X▌ ▐.▌   ██       ")   #15
 CTRL+=(" ▐End▌  ██       /    ║    \                                   ,--.     ██  ▐F5▌ ")   #16
 CTRL+=(" Ditch  ██ ▐A▌  /  °  ║  °  \  ▐→▌        ___                 ( @► )    ██  NVIS ")   #17
 CTRL+=("        ██     <◄═════╬═════►>           ( ☼ )          ,--.   ¬--'     ██       ")   #18
 CTRL+=(" ▐6▌▐^▌ ██ ▐←▌  \  .  ║  .  /  ▐D▌        ▐P▌          ( ◄@ )           ██  ▐F6▌ ")   #19
 CTRL+=(" Move↑  ██       \__  ║  __/                            ¬--'            ██  Line ")   #20
 CTRL+=("        ██          ||▼//                             ▐Z▌ ▐,▌           ██       ")   #21
 CTRL+=(" ▐PgUp▌ ██         ▐S▌ ▐↓▌                                              ██ ▐F12▌ ")   #22
 CTRL+=(" Lvl-Up ██████████████████████████████████████████████████████████████████  Rig  ")   #23

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
 CTRL+=("                           #-#PUTTING#YOU#IN#CONTROL#-#                          ")   #25
#        012345678901234567890123456789012345678901234567890123456789012345678901234567890
#        0         1         2         3         4         5        6          7         8
}

#+============================================================================= ========================================
# Plot a single character on the screen
# Colour according to position & character
#
ctrlPlot() {  # (x, y, chr)
	local ch=$3

	# translate escaped psuedonyms
	[[ "$ch" == "¬" ]]  &&  ch="\`"
	[[ "$ch" == "|" ]]  &&  ch="\\"

	if [[ $1 -le 11 ]]; then  # Башотрис Logo
		case $ch in
			"L"      )  PAT $1 $2 "${tetL[4]}▒"  ;;
			"J"      )  PAT $1 $2 "${tetJ[4]}▒"  ;;
			"T"      )  PAT $1 $2 "${tetT[4]}▒"  ;;
			"O"      )  PAT $1 $2 "${tetO[4]}▒"  ;;
			"I"      )  PAT $1 $2 "${tetI[4]}▒"  ;;
			"S"      )  PAT $1 $2 "${tetS[4]}▒"  ;;
			"Z"      )  PAT $1 $2 "${tetZ[4]}▒"  ;;

			"∙"      )  PAT $1 $2 "${clrPitV}$ch"      ;;
			"▀"      )  PAT $1 $2 "${clrPitH}$ch"      ;;
			" "      )  PAT $1 $2 "${clrPitB}$ch"      ;;

			[▐▌]     )  PAT $1 $2 "${BLU}$ch"           ;;  # key sides
			[QDel◄─] )  PAT $1 $2 "${clrKeycap}$ch"     ;;  # keys

			*        )  PAT $1 $2 "${atOFF}$ch"         ;;
		esac

	elif [ $1 -eq 25 ]; then  # slogan
		case $ch in
			[A-Z\-] )  PAT $1 $2 "${clrCsSlogan}$ch"  ;;
			[#]     )  PAT $1 $2 "${clrCsSlogan} "   ;;
			" "     )  PAT $1 $2 "${atOFF}$ch" ;;
		esac

	else  # controller
		if [[ $DEBUG -eq 1 && ($2 -le 6  || $2 -ge 75) ]]; then  # DEBUG
			case $ch in
				[▐▌]    )  PAT $1 $2 "${MAG}$ch"  ;;  # key sides
				" "     )  PAT $1 $2 "${atOFF}$ch" ;;
				*       )
					if [[ $(($1 %3)) -eq 1 ]]; then
						PAT $1 $2 "${clrKeyDbg}$ch"  # keys
					else
						PAT $1 $2 "${BMAG}$ch"  # text
					fi  ;;
			esac
			return

		elif [[ $1 -eq 15 || $1 -eq 21 ]]; then  # keys
			case $ch in
				"."|",")  PAT $1 $2 "${clrKeycap}$ch"
				          return  ;;
			esac

		elif [[ $2 -ge 56 ]]; then  # outlines
			case $ch in
				"."|",")  PAT $1 $2 "${YEL}$ch"
				          return  ;;
			esac

		else  # detail
			case $ch in
				"."|",")  PAT $1 $2 "${RED}$ch"
				          return  ;;
			esac
		fi

		case $ch in
			[▐▌]     )  PAT $1 $2 "${BLU}$ch"   ;;  # key sides
			[▄█]     )  PAT $1 $2 "${BRN}$ch"   ;;  # border
			[┌┴┐]    )  PAT $1 $2 "${WHT}$ch"   ;;  # switch
			[☼◄▼▲►@] )  PAT $1 $2 "${BCYN}$ch"  ;;  # caps
			[°]      )  PAT $1 $2 "${RED}$ch"   ;;  # detail
			[ΦΘ]     )  PAT $1 $2 "${BRED}$ch"  ;;  # LED
			[═╬║]    )  PAT $1 $2 "${WHT}$ch"   ;;  # cross
			[QDelWASDZXP◄─←↓↑→] )
				PAT $1 $2 "${clrKeycap}$ch"     ;;  # keys
			"<"|">"|"-"|"_"|"("|")"|"/"|"\`"|"'"|"\\" )
				PAT $1 $2 "${YEL}$ch"           ;;  # outlines

			" "     )  PAT $1 $2 "${atOFF}$ch"  ;;
		esac
	fi
}

#+============================================================================= ========================================
ctrlReveal() {
	local  y  yy  x

	for ((y = 1;  y <= 26;  y++)); do
		if [ $y -le 25 ]; then
			PAT $y 1 "${WHT}────────────────────────────────────────────────────────────────────────────────"
		fi
		((yy = $y -1))
		if [ $yy -ge 1 ]; then
			for ((x = 1;  x <= 80;  x++)); do
				ctrlPlot $yy $x "${CTRL[$yy]:$x:1}"
			done
		fi
		sleep 0.01
	done
}

#+============================================================================= ========================================
helpCtrl() {
	ctrlBuild
	ctrlReveal

	# anykey
	keyFlush
	local i=0
	while : ; do
		[[ $i -eq  0 ]]  &&  PAT 19 43 "${clrKeycap}P"
		[[ $i -eq 10 ]]  &&  PAT 19 43 "${clrKeycap}${nbsp}"
		sleep 0.05
		[[ $((++i)) -ge 14 ]]  &&  i=0
		keyGet
		case ${KEY^^} in
			[P]    )  break ;;
			"BKSP" )  quit 0 ;;
		esac
	done
}

#+============================================================================= ========================================
helpRequired() {
	cat << EOT
Required terminal settings:
  # Terminal size: {80 x 25} (24 + 1 status line)

Play with PuTTY over SSH:
  # Font         : Courier New
    PuTTY -> Settings -> Window -> Appearance -> Font -> Change = Courier New
  # Character Set: UTF-8
    PuTTY -> Settings -> Window -> Translation -> Remote Charset = UTF-8

Kali terminal window looks good with: [File->Preferences]
  # Font         : Bitstream Vera Sans Mono
  # Colour Scheme: Linux

Windows Subsytem Linux (WSL)
  # Font        : Courier New
  # Command line: $0 -k1 <-- this should auto-detect now!

EOT
}

#------------------------------------------------------------------------------ ----------------------------------------
CTXT=()
 CTXT+=('                                                                                ') #  0 <--
 CTXT+=('   ╔═══╗            ╥                                                           ') #  1
 CTXT+=('   ║                ║    ♦           ╥   ♦                                      ') #  2
 CTXT+=('   ║     ╓──╖ ╓─╥─╖ ║──╖ ╥ ╓──╖ ┌──╖ ╟─  ╥ ╓──╖ ╓──╖ ╓──╖                       ') #  3
 CTXT+=('   ║     ║  ║ ║ ║ ║ ║  ║ ║ ║  ║ ╓──║ ║   ║ ║  ║ ║  ║ ╙──╖                       ') #  4
 CTXT+=('   ╚═══╝ ╙──╜ ╨   ╨ ╙──╜ ╨ ╨  ╨ ╙──╜ ╙─╜ ╨ ╙──╜ ╨  ╨ ╙──╜                       ') #  5
 CTXT+=('                                                                                ') #  6
 CTXT+=('  ,----[4 x 4]----.   ,---[4 x 3]----.   ,----[4 x 2]----.                      ') #  7 <--
 CTXT+=(' /                 \ /                \ /                 \                     ') #  8
 CTXT+=(' |                  |                  |                  |                     ') #  9
 CTXT+=(' :   ┌───────┐┌─┐   :   ┌────┐┌────┐   :   ┌─┐┌───────┐   :     MIRROR TETS     ') # 10
 CTXT+=(' :   └──┐T┌──┘│ │   :   │J┌──┘└──┐L│   :   │ │└─────┐J│   :                     ') # 11
 CTXT+=(' :   ┌─┐│ │┌──┘ │   :   │ │┌────┐│ │   :   │J└─────┐│ │   :       L <–> J       ') # 12
 CTXT+=(' :   │ │└─┘└──┐T│   :   │ ││    ││ │   :   └───────┘└─┘   :       S <–> Z       ') # 13
 CTXT+=(' :   │T└──┐┌─┐│ │   :   │ ││  O ││ │   :                  :                     ') # 14
 CTXT+=(' :   │ ┌──┘│ │└─┘   :   └─┘└────┘└─┘   :   ┌───────┐┌─┐   :                     ') # 15
 CTXT+=(' :   │ │┌──┘T└──┐   :   +2 I–TET       :   │L┌─────┘│ │   :                     ') # 16
 CTXT+=(' :   └─┘└───────┘   :   @4 ROTATION    :   │ │┌─────┘L│   :                     ') # 17
 CTXT+=(' :   *2 MIRROR      :   =8    %%%%%%%% :   └─┘└───────┘   :                     ') # 18
 CTXT+=(' :   =2          $$ :                  :                  :                     ') # 19
 CTXT+=(' :                  :                  :   ┌────┐┌────┐   :                     ') # 20
 CTXT+=(' :   ┌─┐┌───────┐   :   ┌─┐┌─┐┌────┐   :   │    ││    │   :                     ') # 21
 CTXT+=(' :   │ ││L┌─────┘   :   │ ││ │└──┐L│   :   │  O ││ O  │   :                     ') # 22
 CTXT+=(' :   │ ││ │┌────┐   :   │ ││S└──┐│ │   :   └────┘└────┘   :                     ') # 23
 CTXT+=(' :   │ │└─┘└──┐L│   :   │ │└──┐ ││ │   :                  :                     ') # 24
 CTXT+=(' :   │L└──┐┌─┐│ │   :   │L└──┐│ ││ │   :    I–pair        :                     ') # 25
 CTXT+=(' :   └────┘│ ││ │   :   └────┘└─┘└─┘   :   ┌──────────┐   :                     ') # 26
 CTXT+=(' :   ┌─────┘L││ │   :   +2 I–TET       :   └──────────┘   :                     ') # 27
 CTXT+=(' :   └───────┘└─┘   :   *2 MIRROR      :   ┌──────────┐   :                     ') # 28
 CTXT+=(' :   *2 MIRROR      :   @2 ROTATION    :   └──────────┘   :                     ') # 29
 CTXT+=(' :   =2          $$ :   =8    %%%%%%%% :                  :                     ') # 30
 CTXT+=(' :                  :                  :                  :                     ') # 31
 CTXT+=(' :                  :                  :                  :                     ') # 32 <--
 CTXT+=(' :   ┌────┐┌────┐   :   ┌─┐┌───────┐   :    I–split       :                     ') # 33
 CTXT+=(' :   └──┐ │└──┐L│   :   │ ││L┌─────┘   :   ┌──────────┐   :                     ') # 34
 CTXT+=(' :   ┌─┐│Z└──┐│ │   :   │ ││ │┌────┐   :   └──────────┘   :                     ') # 35
 CTXT+=(' :   │ │└────┘│ │   :   │ │└─┘│    │   :   ¦          ¦   :                     ') # 36
 CTXT+=(' :   │ │┌────┐│ │   :   │L└──┐│ O  │   :   ┌──────────┐   :                     ') # 37
 CTXT+=(' :   │ │└──┐Z│└─┘   :   └────┘└────┘   :   └──────────┘   :                     ') # 38
 CTXT+=(' :   │L└──┐│ └──┐   :   +2 I–TET       :                  :                     ') # 39
 CTXT+=(' :   └────┘└────┘   :   *2 MIRROR      :  J+J  @2 =2   $$ :                     ') # 40
 CTXT+=(' :   *2 MIRROR      :   @4 ROTATION    :  J+L  @4 =4 %%%% :                     ') # 41
 CTXT+=(' :   @2 ROTATION    :   =16   %%%%%%%% :  J+O  @4 =4 %%%% :                     ') # 42
 CTXT+=(' :   =4        %%%% :         %%%%%%%% :  J+Ip @4 =4 %%%% :                     ') # 43
 CTXT+=(' :                  :                  :  J+Is @2 =2   %% :                     ') # 44
 CTXT+=(' :   ┌────┐┌────┐   :   ┌────┐┌────┐   :                  :                     ') # 45
 CTXT+=(' :   └──┐Z│└──┐L│   :   └──┐Z│└──┐L│   :  L+L  @2 =2   $$ :                     ') # 46
 CTXT+=(' :   ┌─┐│ └──┐│ │   :   ┌─┐│ └──┐│ │   :  L+O  @4 =4 %%%% :                     ') # 47
 CTXT+=(' :   │ │└────┘│ │   :   │ │└────┘│ │   :  L+Ip @4 =4 %%%% :                     ') # 48
 CTXT+=(' :   │T└──┐┌─┐│ │   :   │J└─────┐│ │   :  L+Is @2 =2   %% :                     ') # 49
 CTXT+=(' :   │ ┌──┘│ │└─┘   :   └───────┘└─┘   :                  :                     ') # 50
 CTXT+=(' :   │ │┌──┘T└──┐   :   +2 I–TET       :  O+O  @1 =1    $ :                     ') # 51
 CTXT+=(' :   └─┘└───────┘   :   *2 MIRROR      :  O+Ip @4 =4 %%%% :                     ') # 52
 CTXT+=(' :   *2 MIRROR      :   @4 ROTATION    :  O+Is @2 =2   %% :                     ') # 53
 CTXT+=(' :   @4 ROTATION    :   =16   %%%%%%%% :                  :                     ') # 54
 CTXT+=(' :   =8    %%%%%%%% :         %%%%%%%% :  I+I  @2 =2   $$ :                     ') # 55
 CTXT+=(' :                  :                  :                  :                     ') # 56 <--
 CTXT+=(' :                  :   ┌───────┐┌─┐   :                  :                     ') # 57
 CTXT+=(' :                  :   └──┐T┌──┘│ │   :                  :                     ') # 58
 CTXT+=(' :                  :   ┌─┐│ │┌──┘ │   :                  :                     ') # 59
 CTXT+=(' :                  :   │ │└─┘└──┐T│   :                  :                     ') # 60
 CTXT+=(' :                  :   │J└─────┐│ │   :                  :                     ') # 61
 CTXT+=(' :                  :   └───────┘└─┘   :                  :                     ') # 62
 CTXT+=(' :                  :    +2 I–TET      :                  :                     ') # 63
 CTXT+=(' :                  :    *2 MIRROR     :                  :                     ') # 64
 CTXT+=(' :                  :    @4 ROTATION   :                  :                     ') # 65
 CTXT+=(' :                  :    =16  %%%%%%%% :                  :                     ') # 66
 CTXT+=(' :                  :         %%%%%%%% :                  : ,-----------------. ') # 67
 CTXT+=(' :                  :                  :                  : | Unique | Rotate | ') # 68
 CTXT+=(' !-================" !================" !================-" |--------|--------| ') # 69
 CTXT+=('     SILV:  4/12        SILV: 18/64        SILV:  9/30      |   31   |   106  | ') # 70
 CTXT+=('     GOLD:  4/ 4        GOLD:  0/ 0        GOLD:  4/ 7      |    8   |    11  | ') # 71
 CTXT+=('   ================   ================   ================   |========|========| ') # 72
 CTXT+=('            8/16              18/64              13/37      |   39   |   117  | ') # 73
 CTXT+=('                                                            !-----------------" ') # 74
 CTXT+=('                                                                                ') # 75
 CTXT+=('                                                                                ') # 76
 CTXT+=('                                                                                ') # 77
 CTXT+=('                                                                                ') # 78
 CTXT+=('                                                                                ') # 79
 CTXT+=('                                                                                ') # 80
COFF=(0 7 32 56)

CMAP=()
 CMAP+=('')
 CMAP+=('   ooooo            o                                                           ') #  1 <--
 CMAP+=('   o                o    o           o   o                                      ') #  2
 CMAP+=('   o     oooo ooooo oooo o oooo oooo oo  o oooo oooo oooo                       ') #  3
 CMAP+=('   o     o  o o o o o  o o o  o oooo o   o o  o o  o oooo                       ') #  4
 CMAP+=('   ooooo oooo o   o oooo o o  o oooo ooo o oooo o  o oooo                       ') #  5
 CMAP+=('                                                                                ') #  6
 CMAP+=('  ,----[4 x 4]----.   ,---[4 x 3]----.   ,----[4 x 2]----.                      ') #  7 <--
 CMAP+=(' /                 \ /                \ /         	       \                     ') #  8
 CMAP+=(' |                  |                  |                  |                     ') #  9
 CMAP+=(' :   tttttttttttt   :   jjjjjjllllll   :   jjjjjjjjjjjj   :                     ') # 10
 CMAP+=(' :   ttttTttttt t   :   jJjjjjllllLl   :   j jjjjjjjjJj   :                     ') # 11
 CMAP+=(' :   tttt ttttt t   :   j jooooool l   :   jJjjjjjjjj j   :                     ') # 12
 CMAP+=(' :   t ttttttttTt   :   j jo    ol l   :   jjjjjjjjjjjj   :                     ') # 13
 CMAP+=(' :   tTtttttttt t   :   j jo  O ol l   :                  :                     ') # 14
 CMAP+=(' :   t ttttt tttt   :   jjjoooooolll   :   llllllllllll   :                     ') # 15
 CMAP+=(' :   t tttttTtttt   :   +2 I–TET       :   lLllllllll l   :                     ') # 16
 CMAP+=(' :   tttttttttttt   :   @4 ROTATION    :   l llllllllLl   :                     ') # 17
 CMAP+=(' :   *2 MIRROR      :   =8    %%%%%%%% :   llllllllllll   :                     ') # 18
 CMAP+=(' :   =2          $$ :                  :                  :                     ') # 19
 CMAP+=(' :                  :                  :   oooooooooooo   :                     ') # 20
 CMAP+=(' :   llllllllllll   :   lllsssllllll   :   o    oo    o   :                     ') # 21
 CMAP+=(' :   l llLlllllll   :   l ls sllllLl   :   o  O oo O  o   :                     ') # 22
 CMAP+=(' :   l ll lllllll   :   l lsSssssl l   :   oooooooooooo   :                     ') # 23
 CMAP+=(' :   l llllllllLl   :   l lssss sl l   :                  :                     ') # 24
 CMAP+=(' :   lLllllllll l   :   lLlllls sl l   :    I–pair:       :                     ') # 25
 CMAP+=(' :   lllllll ll l   :   llllllssslll   :   iiiiiiiiiiii   :                     ') # 26
 CMAP+=(' :   lllllllLll l   :   +2 I–TET       :   iiiiiiiiiiii   :                     ') # 27
 CMAP+=(' :   llllllllllll   :   *2 MIRROR      :   iiiiiiiiiiii   :                     ') # 28
 CMAP+=(' :   *2 MIRROR      :   @2 ROTATION    :   iiiiiiiiiiii   :                     ') # 29
 CMAP+=(' :   =2          $$ :   =8    %%%%%%%% :                  :                     ') # 30
 CMAP+=(' :                  :                  :                  :                     ') # 31
 CMAP+=(' :                  :                  :                  :                     ') # 32 <--
 CMAP+=(' :   zzzzzzllllll   :   llllllllllll   :    I–split:      :                     ') # 33
 CMAP+=(' :   zzzz zllllLl   :   l llLlllllll   :   iiiiiiiiiiii   :                     ') # 34
 CMAP+=(' :   lllzZzzzzl l   :   l ll loooooo   :   iiiiiiiiiiii   :                     ') # 35
 CMAP+=(' :   l lzzzzzzl l   :   l llllo    o   :   i          i   :                     ') # 36
 CMAP+=(' :   l lzzzzzzl l   :   lLllllo O  o   :   iiiiiiiiiiii   :                     ') # 37
 CMAP+=(' :   l lzzzzZzlll   :   lllllloooooo   :   iiiiiiiiiiii   :                     ') # 38
 CMAP+=(' :   lLllllz zzzz   :   +2 I–TET       :                  :                     ') # 39
 CMAP+=(' :   llllllzzzzzz   :   *2 MIRROR      :  J+J  @2 =2   $$ :                     ') # 40
 CMAP+=(' :   *2 MIRROR      :   @4 ROTATION    :  J+L  @4 =4 %%%% :                     ') # 41
 CMAP+=(' :   @2 ROTATION    :   =16   %%%%%%%% :  J+O  @4 =4 %%%% :                     ') # 42
 CMAP+=(' :   =4        %%%% :         %%%%%%%% :  J+Ip @4 =4 %%%% :                     ') # 43
 CMAP+=(' :                  :                  :  J+Is @2 =2   %% :                     ') # 44
 CMAP+=(' :   zzzzzzllllll   :   zzzzzzllllll   :                  :                     ') # 45
 CMAP+=(' :   zzzzZzllllLl   :   zzzzZzllllLl   :  L+L  @2 =2   $$ :                     ') # 46
 CMAP+=(' :   tttz zzzzl l   :   jjjz zzzzl l   :  L+O  @4 =4 %%%% :                     ') # 47
 CMAP+=(' :   t tzzzzzzl l   :   j jzzzzzzl l   :  L+Ip @4 =4 %%%% :                     ') # 48
 CMAP+=(' :   tTtttttttl l   :   jJjjjjjjjl l   :  L+Is @2 =2   %% :                     ') # 49
 CMAP+=(' :   t ttttt tlll   :   jjjjjjjjjlll   :                  :                     ') # 50
 CMAP+=(' :   t tttttTtttt   :   +2 I–TET       :  O+O  @1 =1    $ :                     ') # 51
 CMAP+=(' :   tttttttttttt   :   *2 MIRROR      :  O+Ip @4 =4 %%%% :                     ') # 52
 CMAP+=(' :   *2 MIRROR      :   @4 ROTATION    :  O+Is @2 =2   %% :                     ') # 53
 CMAP+=(' :   @4 ROTATION    :   =16   %%%%%%%% :                  :                     ') # 54
 CMAP+=(' :   =8    %%%%%%%% :         %%%%%%%% :  I+I  @2 =2   $$ :                     ') # 55
 CMAP+=(' :                  :                  :                  :                     ') # 56 <--
 CMAP+=(' :                  :   tttttttttttt   :                  :                     ') # 57
 CMAP+=(' :                  :   ttttTttttt t   :                  :                     ') # 58
 CMAP+=(' :                  :   jjjt ttttt t   :                  :                     ') # 59
 CMAP+=(' :                  :   j jtttttttTt   :                  :                     ') # 60
 CMAP+=(' :                  :   jJjjjjjjjt t   :                  :                     ') # 61
 CMAP+=(' :                  :   jjjjjjjjjttt   :                  :                     ') # 62
 CMAP+=(' :                  :    +2 I–TET      :                  :                     ') # 63
 CMAP+=(' :                  :    *2 MIRROR     :                  :                     ') # 64
 CMAP+=(' :  MIRROR:         :    @4 ROTATION   :                  :                     ') # 65
 CMAP+=(' :     L <––> J     :    =16  %%%%%%%% :                  :                     ') # 66
 CMAP+=(' :     S <––> Z     :         %%%%%%%% :                  : ,-----------------. ') # 67
 CMAP+=(' :                  :                  :                  : | oooooo | llllll | ') # 68
 CMAP+=(' !-================" !================" !================-" |-----------------| ') # 69
 CMAP+=('     ooooo  oooo        ooooo ooooo        ooooo  oooo      |   oo   /   lll  | ') # 70
 CMAP+=('     ttttt  tttt        ttttt ttttt        ttttt  tttt      |   oo   /   lll  | ') # 71
 CMAP+=('   ================   ================   ================   |========|========| ') # 72
 CMAP+=('            iiii              iiiii              iiiii      |   oo   /   lll  | ') # 73
 CMAP+=('                                                            !-----------------" ') # 74
 CMAP+=('                                                                                ') # 75
 CMAP+=('                                                                                ') # 76
 CMAP+=('                                                                                ') # 77
 CMAP+=('                                                                                ') # 78
 CMAP+=('                                                                                ') # 79
 CMAP+=('                                                                                ') # 80

#+============================================================================= ========================================
CbLast=
CbClr=
CbCh=

helpCbGet() {  # (y, x, yoff)
	local clr  c
	local l=$(($1 +$3))

	CbCh=${CTXT[$l]:$2:1}

	if [[ "$CbCh" == " " ]]; then  # space
		if [[ $l -eq 10  &&  $2 -eq 75 ]]; then  # mirror text
			CbClr="${atOFF}"
		else
			CbClr=""
		fi
		return
	fi

	local x=0
	if [[ $l -le 5 ]]; then  # banner
		c=${CMAP[$l]:$2:1}
		eval clr='$'{tet${c^^}[4]}
		x=1

	elif [[ ($l -eq 25  ||  $l -eq 33)  &&  $2 -eq 44 ]]; then  # 2x4 I-names
		clr="${tetI[4]}"
		x=1

	elif [[ $l -ge 40  &&  $l -le 55 ]]; then  # 2x4 combos
		case "$2" in
			"42" | "44" )  eval clr='$'{tet${CbCh^^}[4]} ; x=1 ;;
			"43"        )  clr="${WHT}"                  ; x=1 ;;
		esac

	elif [[ $l -eq 10  &&  $2 -ge 64  &&  $2 -le 74 ]]; then  # mirror text
		#clr="${atPFX}${atUSC}${fgWHT:2};${bgBLK}${atSFX}"
		clr="\033[0;4;37;40m"
		x=1

	elif [[ $l -ge 12  &&  $l -le 13  &&  $2 -ge 66 ]]; then  # mirror tets
		case "$CbCh" in
			[JLSZTOI] )  eval clr='$'{tet${CbCh^^}[4]} ; x=1 ;;
			*         )  clr=${WHT}
		esac
		x=1
	fi

	if ((! $x)); then
		[[ "$CbCh" == "!" ]] && CbCh="\`"
		[[ "$CbCh" == '"' ]] && CbCh="'"

		case "$CbCh" in
			"+"                    )  clr=${CYN} ;;
			"*"                    )  clr=${BRN} ;;
			"@"                    )  clr=${MAG} ;;
			"="                    )  clr=${GRN} ;;
			[\:\|\'\`\-\,\.\/\+\]] )  clr=${BBLU} ;;
			"%"                    )  clr=${GRY} ;;
			"$"                    )  clr=${GRY} ;;
			"["                    )  CbCh="${CbCh}${BWHT}" ;;

			[┌─┐└┘│¦] )
				c=${CMAP[$l]:$2:1}
				if [[ "$c" != " " ]]; then
					eval clr='$'{tet${c^^}[4]}
				else
					clr="$CbLast"
				fi ;;

			* )
				if [[ $l -ge 68 ]]; then
					c=${CMAP[$l]:$2:1}
					if [[ "$c" != " " ]]; then
						eval clr='$'{tet${c^^}[4]}
					else
						clr="$CbLast"
					fi
				fi ;;
		esac
	fi

	if [[ "$clr" == "$CbLast" ]]; then
		CbClr=""
	else
		CbClr="$clr"
		CbLast="$clr"
	fi
}

#+============================================================================= ========================================
helpCombo() {
	local y  x  offi  off  s

	offi=0
	while : ; do
		CbLast=""
		off=$((${COFF[$offi]} -1))
		for ((y = 1;  y <= 25;  y++)); do
			s=""
			for ((x = 0;  x < 80;  x++)); do
				helpCbGet $y $x $off
				s="${s}${CbClr}${CbCh}"
			done
			PAT $y 1 "${s}"
			if [[ $y -eq  2  &&  $offi -ne 0 ]]; then
				PAT  2 77 "${keyL}↑${keyR}"
				CbLast="void"
			fi
			if [[ $y -eq 24  &&  $offi -ne $((${#COFF[@]} -1)) ]]; then
				PAT 24 77 "${keyL}↓${keyR}"
				CbLast="void"
			fi
		done


		keyFlush
		while : ; do
			sleep 0.05
			keyGet
			case ${KEY^^} in
				[pP]   )  break 2 ;;
				"BKSP" )  quit 0 ;;

				"DOWN" )
					if [[ $offi -lt $((${#COFF[@]} -1)) ]]; then
						((offi++))
						break
					fi ;;

				"UP" )
					if [[ $offi -gt 0 ]]; then
						((offi--))
						break
					fi ;;
			esac
		done
	done
}
# -MAKE:help.s
# +MAKE:gameover.dat - gameover sprites
#!/bin/bash

# we'll just wrap this in a heredoc for sanity
: << 'EOT'

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
# @jgs: Your ASCII art will forever be the best there ever was!
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
rktstar:XXXX°XXXXXXX$
rktstar:XXXXXXXXXXXXXXXXXXXX$
rktstar:XXX.XXXX∙XXXXXXXXXXX$
rktstar:XXXXXXXXXXXXXXXX+XXX$

rktmoon:¬¬¬¬¬¬¬¬¬¬¬¬XX.--.XX$
rktmoon:¬¬¬¬¬¬¬¬¬¬¬¬X/X/XX`X$
rktmoon:¬¬¬¬¬¬¬¬¬¬¬¬|X|XXXXX$
rktmoon:¬¬¬¬¬¬¬¬¬¬¬¬X\X\__,X$
rktmoon:¬¬¬¬¬¬¬¬¬¬¬¬XX'--'XX$

EOT
# -MAKE:gameover.dat
# +MAKE:gameover.s - gameover process
#!/bin/bash

#+=============================================================================
goLoadSprites() {
	# load rocket sprites
	RKT=()  ; while read -r l ; do RKT+=("${l:7:-1}")  ; done <<< $(grep "^rocket:"  ${CMDgo})
	X1A=()  ; while read -r l ; do X1A+=("${l:7:-1}")  ; done <<< $(grep "^rx1a_.:"  ${CMDgo})
	X1B=()  ; while read -r l ; do X1B+=("${l:7:-1}")  ; done <<< $(grep "^rx1b_.:"  ${CMDgo})
	X2A=()  ; while read -r l ; do X2A+=("${l:7:-1}")  ; done <<< $(grep "^rx2a_.:"  ${CMDgo})
	X2B=()  ; while read -r l ; do X2B+=("${l:7:-1}")  ; done <<< $(grep "^rx2b_.:"  ${CMDgo})
	X3A=()  ; while read -r l ; do X3A+=("${l:7:-1}")  ; done <<< $(grep "^rx3a_.:"  ${CMDgo})
	X3B=()  ; while read -r l ; do X3B+=("${l:7:-1}")  ; done <<< $(grep "^rx3b_.:"  ${CMDgo})
	X4A=()  ; while read -r l ; do X4A+=("${l:7:-1}")  ; done <<< $(grep "^rx4a_.:"  ${CMDgo})
	X4B=()  ; while read -r l ; do X4B+=("${l:7:-1}")  ; done <<< $(grep "^rx4b_.:"  ${CMDgo})
	GND=()  ; while read -r l ; do GND+=("${l:7:-1}")  ; done <<< $(grep "^rktgnd:"  ${CMDgo})
	STAR=() ; while read -r l ; do STAR+=("${l:8:-1}") ; done <<< $(grep "^rktstar:" ${CMDgo})
	MOON=() ; while read -r l ; do MOON+=("${l:8:-1}") ; done <<< $(grep "^rktmoon:" ${CMDgo})
	GOSPRITES=1
}

#+=============================================================================
goDrawSprite() {
	local y  x  exc  ch

	local aty=$1
	local atx=$2
	local clr=$3  # 99: exhaust
	shift
	shift
	shift
	local ink=$clr

	exc=("${RED}" "${BRED}" "${YEL}")  # exhaust colours
	y=0
	while [[ ! -z $1 ]]; do
		if [[ $((aty +y)) -ge 1 ]]; then
			for ((x = 0;  x < ${#1};  x++)); do
				[[ "$clr" == "99" ]]  &&  ink="${exc[$((RANDOM % ${#exc[@]}))]}"
				ch=${1:$x:1}
				case "$ch" in
					"¬" )  continue ;;
					"X" )  PAT $((aty +y)) $((atx +x)) "${atOFF} " ;;
					*   )  PAT $((aty +y)) $((atx +x)) "${ink}${ch}" ;;
				esac
			done
		fi
		((y++))
		shift
	done

}

#+=============================================================================
goDrawPit() {
	[[ "$GOSPRITES" != "1" ]]  &&  goLoadSprites

	local y
	for ((y = 0;  y <= 18;  y++)); do
		if [[ $y -lt 5 ]]; then
			goDrawSprite $((PITy +y)) $((PITx +1)) "${CYN}" "${STAR[$y]}"
			goDrawSprite $((PITy +y)) $((PITx +1)) "${BWHT}" "${MOON[$y]}"
		elif [[ $y -lt 7 ]]; then
			goDrawSprite $((PITy +y)) $((PITx +1)) "${CYN}" "${STAR[$y]}"
		elif [[ $y -le 8 ]]; then
			goDrawSprite $((PITy +y)) $((PITx +1)) "${BMAG}" "                    "
			goDrawSprite $((PITy +y)) $((PITx +1)) "${CYN}" "${STAR[$y]}"
#			[[ ! -z $1 ]] && goDrawSprite $((PITy +y)) $((PITx +3)) "${BMAG}" "${RKT[$(($y-7))]}"
		elif [[ $y -lt 18 ]]; then
			goDrawSprite $((PITy +y)) $((PITx +1)) "${BMAG}" "                    "
#			[[ ! -z $1 ]] && goDrawSprite $((PITy +y)) $((PITx +3)) "${BMAG}" "${RKT[$(($y-7))]}"
		else
			goDrawSprite $((PITy +y)) $((PITx +1)) "${GRN}" "${GND[@]}"
		fi
		[[ $((y %3)) -ne 1 ]]  &&  sleep 0.12
	done
}

#+=============================================================================
goRktTeleport() {
	local y  x  hit  w  s  n  mch  clr  ch

	local MASK=("${RKT[@]}")
	local d=$((${#MASK[@]} -1))

	for ((y = 0;  y < d;  y++)); do
		MASK[$y]=${MASK[$y]// /S}
		MASK[$y]=${MASK[$y]//X/¬}
		MASK[$y]=${MASK[$y]//[^¬S]/G}
	done

	while
		hit=0
		for ((y = 0;  y < d;  y++)); do
			 w=${#MASK[$y]}
			for ((x = 0;  x < $w;  x++)); do
				mch="${MASK[$y]:$x:1}"
				case "$mch" in
					"¬" ) continue ;;
					"S" )
						s=" \`\'.,;:"
						n=$((RANDOM % ${#s}))
						if [[ $n -eq 0 ]]; then
							clr="${atOFF}"
							ch=" "
							MASK[$y]="${MASK[$y]:0:$x}${ch}${MASK[$y]:$((x +1))}"
						else
							clr=("${GRY}" "${WHT}" "${BLU}")
							clr=${clr[$((RANDOM % 3))]}
							ch="${s:$n:1}"
							hit=1
						fi ;;
					"G" )
						s=" \\/{}[]()"
						n=$((RANDOM % ${#s}))
						if [[ $n -eq 0 ]]; then
							clr="${BMAG}"
							ch="${RKT[$y]:$x:1}"
							MASK[$y]="${MASK[$y]:0:$x}${ch}${MASK[$y]:$(($x+1))}"
						else
							clr=("${GRY}" "${WHT}" "${BLU}")
							clr=${clr[$((RANDOM % 3))]}
							ch="${s:$n:1}"
							hit=1
						fi ;;
					*)
						clr="${BMAG}"
						ch=${mch}
						;;
				esac
				PAT $((PITy +y +7)) $((PITx +x +3)) "${clr}${ch}"
			done
			sleep 0.007
		done
		((hit == 1))
	do : ; done
}

#+=============================================================================
goRktTakeoff() {
	local i  n  z

	local tly=$PITy
	local tlx=$PITx

	local ry=$((tly +7))
	local rx=$((tlx +3))
	local tx=$((rx  -2))
	local spd=100
	local step=2

#	# picture
#	goDrawSprite $(($tly)) $(($tlx+1)) "${fgCYN}" "${STAR[@]}"
#	goDrawSprite $(($tly)) $(($tlx+1)) "${atBLD};${fgWHT}" "${MOON[@]}"
#	goDrawSprite $(($ry)) $(($rx)) "${atBLD};${fgMAG}" "${RKT[@]}"
#	goDrawSprite $(($tly+18)) $(($tx)) "${fgGRN}" "${GND[@]}"
#	sleep 1

	# start engines
	n=19
	for ((i = 0 ;  i < n;  i++)); do
		if ((i & 1)); then goDrawSprite $((ry +${#RKT[@]} -2)) $((rx +2)) 99 "${X1A[@]}"
		else               goDrawSprite $((ry +${#RKT[@]} -2)) $((rx +2)) 99 "${X1B[@]}" ; fi
		sleep 0.$spd
	done

	# lift off
	((ry--))
	goDrawSprite $((tly)) $((tlx +1)) "${CYN}"  "${STAR[@]}"
	goDrawSprite $((tly)) $((tlx +1)) "${BWHT}" "${MOON[@]}"
	goDrawSprite $((ry))  $((rx    )) "${BMAG}" "${RKT[@]}"

	for ((n += step;  i < n;  i++)); do
		if ((i & 1)); then goDrawSprite $((ry +${#RKT[@]} -2)) $((rx +2)) 99 "${X2A[@]}"
		else               goDrawSprite $((ry +${#RKT[@]} -2)) $((rx +2)) 99 "${X2B[@]}" ; fi
		sleep 0.$spd
	done

	# 3
	((ry--))
#	goDrawSprite $((tly)) $((tlx +1)) "${CYN}"  "${STAR[@]}"
#	goDrawSprite $((tly)) $((tlx +1)) "${BWHT}" "${MOON[@]}"
	goDrawSprite $((ry))  $((rx    )) "${BMAG}" "${RKT[@]}"

	for ((n += step;  i < n;  i++)); do
		if ((i & 1)); then goDrawSprite $((ry +${#RKT[@]} -2)) $((rx +2)) 99 "${X3A[@]}"
		else               goDrawSprite $((ry +${#RKT[@]} -2)) $((rx +2)) 99 "${X3B[@]}" ; fi
		sleep 0.$spd
	done

	# fly away
	for ((z = 1;  z < 25;  z++)); do
		((ry--))
		goDrawSprite $((tly)) $((tlx +1)) "${CYN}"  "${STAR[@]}"
		goDrawSprite $((tly)) $((tlx +1)) "${BWHT}" "${MOON[@]}"
		goDrawSprite $((ry )) $((rx    )) "${BMAG}" "${RKT[@]}"

		for ((n += step;  i < n;  i++)); do
			if ((i & 1)); then goDrawSprite $((ry  +${#RKT[@]} -2)) $((rx +2)) 99 "${X4A[@]}"
			else               goDrawSprite $((ry  +${#RKT[@]} -2)) $((rx +2)) 99 "${X4B[@]}" ; fi
			[[ $z -eq 1 ]]  &&  goDrawSprite $((tly +18)) $((tx)) "${GRN}" "${GND[@]}"
			sleep 0.$spd
		done
		# accelerate
#		printf -v spd "%03d" $((1$spd -1003))
		#DBG $spd
	done
}

#+=============================================================================
# ooohhh, this is dirty!
#
goRktCleanup() {
	local y  l

	local cs=("")
		cs+=("──╖╓────╖╓────╖╓")
		cs+=("╓─╖║ °╓─╖║ °╓─╖║")
		cs+=("╙─╖║  ╙─╖║  ╙─╖║")

	for ((y = 1;  y <= 3;  y++)); do
		PAT $y $((PITx +3)) "${clrCsMini}${cs[$y]}"
	done
	pfDrawDebug

	# unbrick shoulder and basket
	for ((y = 0;  y <= 11;  y++)); do
		((l = y %3))

		PAT $((BSy +y)) $((BSx +1)) "${atOFF}          "

		[[ $y -ge 0  &&  $y -le 3 ]]  &&  PAT $((SHy +y +1)) $((SHx +1)) "${atOFF}          "

		[[ $l -ne 1 ]]  &&  sleep 0.12
	done

}

#+=============================================================================
goChalScore() {
	local clr  ch  i

	clrSCOREvI="${atPFX}${fgBWHT};${bgBLK};${atSFX}"  # inverse

	printf -v ch "%'10d" $score

	case "$1" in
		"blk" )  clr=(${clrSCOREvI} ${clrSCOREv}) ;;
		"wht" )  clr=(${clrSCOREv} ${clrSCOREvI}) ;;
		"num" )
			PAT $((SCy +2)) $((SCx +2)) "${clrSCOREvI}${ch}"
			return ;;
		* )  return ;;
	esac

	for ((i = 0;  i < 5;  i++)); do
		PAT $((SCy +2)) $((SCx +2)) "${clr[$((i &1))]}${ch}"
		sleep 0.2
	done
}

#+=============================================================================
goChalClrCube() {
	local i

	local y=$((PITy -1 +$1))
	local x=$((PITx +1 +$2 * 2))
	local t=$(($3 & maskT))

	for ((i = 1;  i <= 3;  i++)); do
		(($i & 1))  &&  ch="░░"  ||  ch="▒▒"
		case $t in
			"${tetiO}" )  PAT $y $x "${tetO[4]}${ch}" ;;
			"${tetiI}" )  PAT $y $x "${tetI[4]}${ch}" ;;
			"${tetiT}" )  PAT $y $x "${tetT[4]}${ch}" ;;
			"${tetiL}" )  PAT $y $x "${tetL[4]}${ch}" ;;
			"${tetiJ}" )  PAT $y $x "${tetJ[4]}${ch}" ;;
			"${tetiS}" )  PAT $y $x "${tetS[4]}${ch}" ;;
			"${tetiZ}" )  PAT $y $x "${tetZ[4]}${ch}" ;;
		esac
		sleep 0.025
	done

	((DEBUG && ! NDRAW))  &&  ch="${GRY}∙∙"  ||  ch="${atOFF}  "
	PAT $y $x "${ch}"
}

#+=============================================================================
goChalClrPit() {
	local y  x  t

	goChalScore blk
	for ((y = 0;  y < PITh -1;  y++)); do
		for ((x = 0;  x < PITw;  x++)); do
			t=$((0x${PIT[$y]:$((x*2 +2)):2}))
			if ((t != tetiB)); then
				goChalClrCube $y $x $t
				((score -= 1))
				goChalScore num
			fi
		done
	done
	goChalScore wht
}

#+=============================================================================
gameover() {
	local his

	case "$STYLE" in
		"NVIS" )
			STYLE="xxxx"
			tetDrawPit
			tetDraw
			STYLE="NVIS"

			HIDE=0
			pfDrawBasket
			tetDrawBs

			countdown 5
			;;

		"NORM" )
			countdown 2
			statusSet "All your base are belong to us!"
			;;

		"CHAL" )
			countdown 3
			if [[ $RUN -eq 2 ]]; then  # 2: died
				statusSet "Death to all treasure seekers!"
			else                       # 3: won
				statusSet "The cake was a lie!"
				goChalClrPit
			fi
			;;
	esac

	pfBrickout
	sleep 1

	hisCheck $score $LEVEL $STYLE
	his=$?
	if [[ $his -gt 0 ]]; then
		goDrawPit
		if (( (DEBUG && NDRAW) || \
		      (his == 1  &&  LEVEL >= 10  &&  ${HI2[3]}) )); then
			sleep 0.8
			goRktTeleport
			sleep 1.1
			goRktTakeoff
		fi
		hisGetInitials $his
	fi
	goRktCleanup &
	FAST=0
}
# -MAKE:gameover.s
# +MAKE:hiscore.s - high score system
#!/bin/bash

#+=============================================================================
#  1    _       _   _       _   _   _   _   _   _       _       _   _
# 234  | |   |  _|  _| |_| |_  |_    | |_| |_| |_| |_  |    _| |_  |_
# 567  |_|   | |_   _|   |  _| |_|   | |_|   | | | |_| |_  |_| |_  |
#      ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~
#
segment() {  # (y, x, val)
	local cnt=()
		#      1234567
		cnt+=("1101111")  # 0
		cnt+=("0001001")  # 1
		cnt+=("1011110")  # 2
		cnt+=("1011011")  # 3
		cnt+=("0111001")  # 4
		cnt+=("1110011")  # 5
		cnt+=("1110111")  # 6
		cnt+=("1001001")  # 7
		cnt+=("1111111")  # 8
		cnt+=("1111001")  # 9
#		cnt+=("1111101")  # 10/A
#		cnt+=("0110111")  # 11/b
#		cnt+=("1100110")  # 12/C
#		cnt+=("0011111")  # 13/d
#		cnt+=("1110110")  # 14/E
#		cnt+=("1110100")  # 15/F

	local clr=("${GRY}" "${BGRN}")  # off/on

	local ch="\033[1C"                                # skip
	ch="${ch}${clr[${cnt[$3]:0:1}]}__\033[3D\033[1B"  # 1 / newline
	ch="${ch}${clr[${cnt[$3]:1:1}]}|"                 # 2
	ch="${ch}${clr[${cnt[$3]:2:1}]}__"                # 3
	ch="${ch}${clr[${cnt[$3]:3:1}]}|\033[4D\033[1B"   # 4 / newline
	ch="${ch}${clr[${cnt[$3]:4:1}]}|"                 # 5
	ch="${ch}${clr[${cnt[$3]:5:1}]}__"                # 6
	ch="${ch}${clr[${cnt[$3]:6:1}]}|"                 # 7

	PAT $1 $2 "${ch}"
}

#+=============================================================================
hisStats() {
	local y  x  h  hi  ly  lx  sy  sx  style  si

	statusClear
	csDrawBackdropReveal 0

	y=1
	PAT $((y++)) 7 "${BLU}╔════════════╦"
	PAT $((y++)) 7 "║${CYN} ${txtHsRank} ${BLU}║"
	PAT $((y++)) 7 "║${CYN} ${txtHsInit} ${BLU}║"
	PAT $((y++)) 7 "║${CYN} ${txtHsScor} ${BLU}║"
	PAT $((y++)) 7 "╟─----------─╫"
	PAT $((y++)) 7 "║${CYN} ${txtHsLine} ${BLU}║"
	PAT $((y++)) 7 "║${CYN} ${txtHsMult} ${BLU}║"
	PAT $((y++)) 7 "║${CYN} ${txtHsPiec} ${BLU}║"
	PAT $((y++)) 7 "║${CYN} ${txtHsTime} ${BLU}║"
	PAT $((y++)) 7 "╟─----------─╫"
	PAT $((y++)) 7 "║${BWHT} ${txtHsSilv} ${BLU}║"
	PAT $((y++)) 7 "║${YEL} ${txtHsGold} ${BLU}║"
	PAT $((y++)) 7 "╟─----------─╫"
	PAT $((y++)) 7 "║${tetL[4]} ${txtHsLtet} ${BLU}║"
	PAT $((y++)) 7 "║${tetJ[4]} ${txtHsJtet} ${BLU}║"
	PAT $((y++)) 7 "║${tetS[4]} ${txtHsStet} ${BLU}║"
	PAT $((y++)) 7 "║${tetZ[4]} ${txtHsZtet} ${BLU}║"
	PAT $((y++)) 7 "║${tetT[4]} ${txtHsTtet} ${BLU}║"
	PAT $((y++)) 7 "║${tetO[4]} ${txtHsOtet} ${BLU}║"
	PAT $((y++)) 7 "║${tetI[4]} ${txtHsItet} ${BLU}║"
	PAT $((y++)) 7 "╟─----------─╫"
	PAT $((y++)) 7 "║${CYN} ${txtHsTotl} ${BLU}║"
	PAT $((y++)) 7 "║${CYN} ${txtHsSeed} ${BLU}║"
	PAT $((y++)) 7 "╚════════════╩"

	y=2
	ly=$y
	lx=63
	PAT $((y++)) $lx "${MAG}┌──────────┐"
	PAT $((y++)) $lx "${MAG}│          │"
	PAT $((y++)) $lx "${MAG}│          │"
	PAT $((y++)) $lx "${MAG}│          │"
	PAT $((y++)) $lx "${MAG}│          │"
	PAT $((y++)) $lx "${MAG}├──────────┤"
	PAT $((y++)) $lx "${MAG}│ ${keyL}←${keyR}  ${keyL}→${keyR}${MAG} │"
	PAT $((y++)) $lx "${MAG}└──────────┘"

	((y++))
	PAT $((y++)) $lx "${MAG}┌──────────┐"

	style=($(grep '^hs_....~0,1' ${CMDhs} | sed 's/...\(....\).*/\1/'))
	sy=$y
	sx=$lx
	si="${style[0]}"
	PAT $((y++)) $sx "${MAG}│ ${BGRN}${txtOptStyle[$si]}  ${keyL}↑${keyR}${MAG}│"
	for ((i = 1;  i < $((${#style[@]} -1));  i++)); do
		si="${style[$i]}"
		PAT $((y++)) $sx "${MAG}│ ${BGRN}${txtOptStyle[$si]}     ${MAG}│"
	done
	si="${style[$i]}"
	PAT $((y++)) $sx "${MAG}│ ${BGRN}${txtOptStyle[$si]}  ${keyL}↓${keyR}${MAG}│"
	PAT $((y++)) $sx "${MAG}└──────────┘"

	local pos=("1st" "2nd" "3rd")
	local tr=("${BLU}╤" "${BLU}╤" "${BLU}╗")
	local jr=("${BLU}┼" "${BLU}┼" "${BLU}╢")
	local rt=("${BLU}│" "${BLU}│" "${BLU}║")
	local br=("${BLU}╧" "${BLU}╧" "${BLU}╝")

	local lvl=0
	local sty=0
	while : ; do
		hisLoad $lvl ${style[$sty]}

		segment $((ly +1)) $((lx +2)) $((lvl /10))
		segment $((ly +1)) $((lx +6)) $((lvl %10))

		si="${style[$sty]}"
		PAT $((sy +sty)) $((sx +1)) "${GRN}▐${atPFX}${fgBLK};${bgGRN}${atSFX}${txtOptStyle[$si]}${GRN}▌"

		for ((y = 1;  y <= 24;  y++)); do
			for ((h = 0;  h <= 2;  h++)); do
				eval hi=('$'{HI${h}[@]})
				PAT $y $((7 +14 + h*13))
				case $y in
					1 )   printf "${BLU}════════════${tr[$h]}"                ;;
					2 )   printf "${YEL}    %3s     ${rt[$h]}" "${pos[${h}]}" ;;  # ranking
					3 )   printf "${BWHT}    %3s     ${rt[$h]}" "${hi[2]}"     ;;  # initials
					4 )   printf      "${BWHT} %'10d ${rt[$h]}" "${hi[3]}"     ;;  # score
					5 )   printf "${BLU}─----------─${jr[$h]}"                ;;
					6 )   printf  "${WHT}   [%4d]   ${rt[$h]}" "${hi[4]}"     ;;  # Lines
					7 )   printf "${WHT}   [x%3d]   ${rt[$h]}" "${hi[5]}"     ;;  # Best Mult.
					8 )   printf  "${WHT}   [%4d]   ${rt[$h]}" "${hi[6]}"     ;;  # Best Piece
					9 )   local t="--:--:--"
						  [[ ! -z ${hi[7]} ]]  &&  t="$(date -u -d @$((${hi[7]} /1000)) +"%T")"  # Play Time
						  printf      "${GRN}  %8s  ${rt[$h]}" "${t}"         ;;
					10 )  printf "${BLU}─----------─${jr[$h]}"                ;;
					11 )  printf "${BWHT}    [%3d]   ${rt[$h]}" "${hi[17]}"    ;;  # Silver
					12 )  printf "${YEL}    [%3d]   ${rt[$h]}" "${hi[18]}"    ;;  # Gold
					13 )  printf "${BLU}─----------─${jr[$h]}"                ;;
					14 )  printf "${tetL[4]}     %3d    ${rt[$h]}" "${hi[9]}"     ;;  # L-tets
					15 )  printf "${tetJ[4]}     %3d    ${rt[$h]}" "${hi[10]}"    ;;  # J-tets
					16 )  printf "${tetS[4]}     %3d    ${rt[$h]}" "${hi[11]}"    ;;  # S-tets
					17 )  printf "${tetZ[4]}     %3d    ${rt[$h]}" "${hi[12]}"    ;;  # Z-tets
					18 )  printf "${tetT[4]}     %3d    ${rt[$h]}" "${hi[13]}"    ;;  # T-tets
					19 )  printf "${tetO[4]}     %3d    ${rt[$h]}" "${hi[14]}"    ;;  # O-tets
					20 )  printf "${tetI[4]}     %3d    ${rt[$h]}" "${hi[15]}"    ;;  # I-tets
					21 )  printf "${BLU}─----------─${jr[$h]}"                ;;
					22 )  printf   "${BCYN}   %5d    ${rt[$h]}" "${hi[16]}"    ;;  # Total Tets
					23 )  printf   "${WHT}   %5d    ${rt[$h]}" "${hi[8]}"     ;;  # PRNG SEED
					24 )  printf "${BLU}════════════${br[$h]}"                ;;
				esac
			done
		done

		while : ; do
			while ! keyGet ; do sleep 0.1 ; done
			case ${KEY^^} in
				"BKSP" )  quit 0 ;;

				"DEL" | [PQ] )
					hisLoad $LEVEL $STYLE
					break 2
					;;

				"LEFT" | [A] )
					if [[ $lvl -gt 0 ]]; then
						((lvl--))
						break
					fi ;;

				"RIGHT" | [D] )
					if [[ $lvl -lt 20 ]]; then
						((lvl++))
						break
					fi ;;

				"UP" | [W] )
					if [[ $sty -gt  0 ]]; then
						si="${style[$sty]}"
						PAT $((sy +sty)) $((sx +1)) "${GRN} ${txtOptStyle[$si]} "
						((sty--))
						break
					fi ;;

				"DOWN" | [S] )
					if [[ $sty -lt  $((${#style[@]} -1)) ]]; then
						si="${style[$sty]}"
						PAT $((sy +sty)) $((sx +1)) "${GRN} ${txtOptStyle[$si]} "
						((sty++))
						break
					fi ;;
			esac
		done
	done
}


#+=============================================================================
hisShow() {  # (left|right, old-level, old-style, new-level, new-style
	local tmp  x  y  ch


	# no scrolling requested (initial display)
	if [[ -z $1 ]]; then
		hisLoad $LEVEL $STYLE
		for ((i = 0;  i < 3;  i++)); do
			eval tmp=(\${HI$i[@]})
			printf -v ch " %3s │ %'10d" "${tmp[2]}" "${tmp[3]}"
			PAT $((PITy +15 +i)) $((PITx +2)) "${clrHi[$i]}${ch}"
		done

	else
		hisLoad $4 $5

		local OLD0  OLD1  OLD2
		local old=($(grep "^hs_${2}~${3}" ${CMDhs}))
		IFS=',' read -r -a OLD0 <<< "${old[0]}"
		IFS=',' read -r -a OLD1 <<< "${old[1]}"
		IFS=',' read -r -a OLD2 <<< "${old[2]}"

		# Macs can't printf in to an array
		local old=()
		printf -v tmp " %3s │ %'10d " "${OLD0[2]}" "${OLD0[3]}"
		old+=("$tmp")
		printf -v tmp " %3s │ %'10d " "${OLD1[2]}" "${OLD1[3]}"
		old+=("$tmp")
		printf -v tmp " %3s │ %'10d " "${OLD2[2]}" "${OLD2[3]}"
		old+=("$tmp")

		local new=()
		printf -v tmp " %3s │ %'10d " "${HI0[2]}" "${HI0[3]}"
		new+=("$tmp")
		printf -v tmp " %3s │ %'10d " "${HI1[2]}" "${HI1[3]}"
		new+=("$tmp")
		printf -v tmp " %3s │ %'10d " "${HI2[2]}" "${HI2[3]}"
		new+=("$tmp")

		local l=${#old[0]}  # all elements are the same size

		if [[ "$1" == "left" ]]; then  # coming from the left
			for ((x = 1;  x < $l;  x++)); do
				for ((y = 0;  y < 3;  y++)); do
					ch="${new[$y]:$(($l -$x))}│${old[$y]:0:$((0-x-1))}"
					PAT $((PITy +15 +y)) $((PITx +2)) "${clrHi[$y]}${ch}"
				done
				sleep 0.02
			done

		else  # coming from the right
			for ((x = 1;  x <= $l;  x++)); do
				for ((y =0;  y < 3;  y++)); do
					ch=${old[$y]:$x}│${new[$y]:0:$(($x -1))}
					PAT $((PITy +15 +y)) $((PITx +2)) "${clrHi[$y]}${ch}"
				done
				sleep 0.02
			done
		fi

		for ((y =0;  y < 3;  y++)); do
			PAT $((PITy +15 +y)) $((PITx +2)) "${clrHi[$y]}${new[$y]}"
		done

	fi
}

#+=============================================================================
hisLoad() {  # (level, style)
	HIA=($(grep "^hs_$2~$1" ${CMDhs}))   # get the three score for this level
	IFS=',' read -r -d '' -a HI0 <<< "${HIA[0]}"  # stick them in global arrays
	IFS=',' read -r -d '' -a HI1 <<< "${HIA[1]}"
	IFS=',' read -r -d '' -a HI2 <<< "${HIA[2]}"
}

#==============================================================================
hisCheck() {  # (score, level, style)
	[[ "$4" != "noload" ]]  &&  hisLoad $2 $3
	[[ $1 -gt ${HI0[3]} ]]  &&  return 1
	[[ $1 -gt ${HI1[3]} ]]  &&  return 2
	[[ $1 -gt ${HI2[3]} ]]  &&  return 3
	return 0
}


#+=============================================================================
hisGetInitials() {
	local sc  cur  chr  name  nchr  clr  now  next  old  hsl  tot

	local clrNAME="${atPFX}${fgBLK};${bgWHT}${atSFX}"
	local clrNAMEc="${atPFX}${atREV};${fgBLK:2};${bgWHT}${atSFX}"

	PAT $((PITy + 10)) $((PITx + 2)) "${BBLK}-${WHT}-${YEL}- ${txtHIGHSCORE} ${YEL}-${WHT}-${BBLK}-"

	printf -v sc "%'10d" $score
	PAT $((PITy + 12)) $((PITx + 5)) "${WHT}▐${clrSCOREv}${sc}${WHT}▌"

	PAT $((PITy + 14)) $((PITx + 4)) "${MAG}${txtINITIALS}: ${clrNAME}▌   ▐"

	cur=0
	chr=0
	name=("${nbsp}" "${nbsp}" "${nbsp}")
	nchr=(0 0 0)
	name[$cur]="${AZ:$chr:1}"

	statusSet "${txtIdentify}"

	clr=${clrNAME}
	timeGet next
	keyFlush
	while : ; do
		timeGet now
		if [[ $now -gt $next ]]; then
			((next = now +300))
			[[ "$clr" == "${clrNAME}" ]]  &&  clr=${clrNAMEc}  ||  clr=${clrNAME}
		fi
		PAT $((PITy +14)) $((PITx +15 +cur)) "${clr}${name[$cur]}"
		keyGet
		case "${KEY^^}" in
			"DEL" | [Q] )  # change language
				if   [[ "${AZ:2:1}" == "B" ]]; then  AZ="$AZRU"
				elif [[ "${AZ:2:1}" == "Б" ]]; then  AZ="≡ßÇ" ; chr=0
				else                                 AZ="$AZEN"
				fi
				[[ $chr -ge ${#AZ} ]]  &&  chr=$((${#AZ} -1))
				name[$cur]="${AZ:$chr:1}"
				;;

			"RIGHT" | [dD] | [xX.] )
				if [[ $cur -lt 2 ]]; then
					nchr[$cur]=$chr
					PAT $((PITy +14)) $((PITx +15 +cur)) "${clrNAME}${name[$cur]}"
					((cur++))
					if [[ "${name[$cur]}" == "${nbsp}" ]]; then
						name[$cur]="${AZ:$chr:1}"
					else
						chr=${nchr[$cur]}
					fi
				fi ;;

			"LEFT"  | [aA] )
				if [[ $cur -gt 0 ]]; then
					nchr[$cur]=$chr
					PAT $((PITy +14)) $((PITx +15 +cur)) "${clrNAME}${name[$cur]}"
					((cur--))
					chr=${nchr[$cur]}
				fi ;;

			[Z,] )
				name[$cur]="${nbsp}"
				if [[ $cur -gt 0 ]]; then
					nchr[$cur]=0
					PAT $((PITy +14)) $((PITx +15 +cur)) "${clrNAME}${name[$cur]}"
					((cur--))
					chr=${nchr[$cur]}
				fi ;;

			"DOWN" | [S] )
				chr=$(((chr +${#AZ} -1) % ${#AZ}))
				name[$cur]="${AZ:$chr:1}"
				;;

			"UP" | [W] )
				chr=$(( (chr +1) % ${#AZ} ))
				name[$cur]="${AZ:$chr:1}"
				;;

			[pP] ) break ;;
		esac
		sleep 0.05
#		statusUpdate
	done
	langSet $LANG  # reset language
	statusClear

	# don't put spaces in the high score file!
	[[ "${name[0]}" == " " ]]  &&  name[0]="${nbsp}"
	[[ "${name[1]}" == " " ]]  &&  name[1]="${nbsp}"
	[[ "${name[2]}" == " " ]]  &&  name[2]="${nbsp}"
	
	# Running debug mode?
	((DEBUG)) && {
		# Empty name? ...Just don't add the score
		[[ "${name[0]}${name[1]}${name[2]}" == "${nbsp}${nbsp}${nbsp}" ]]  &&  return

		# otherwise, we will replace the name with a tet
		case $((RANDOM %5)) in
			0 ) chr="${tetT[7]}" ;;
			1 ) chr="${tetL[7]}" ;;
			2 ) chr="${tetJ[7]}" ;;
			3 ) chr="${tetS[7]}" ;;
			4 ) chr="${tetZ[7]}" ;;
		esac
		name[0]="${chr:1:1}"
		name[1]="${chr:2:1}"
		name[2]="${chr:3:1}"
	}

	if [[ $1 -le 2 ]]; then  # move 2nd -> 3rd
		old=$(grep "^hs_${STYLE}~${LEVEL},2," ${CMDhs} | sed "s/\([^,],\).\(.*\)/\13\2/")
		#                               -v^--------------------------------------^-
		sed -i "s/^hs_${STYLE}~${LEVEL},3,.*/${old}/" ${CMDhs}
	fi
	if [[ $1 -eq 1 ]]; then # move 1st -> 2nd
		old=$(grep "^hs_${STYLE}~${LEVEL},1," ${CMDhs} | sed "s/\([^,],\).\(.*\)/\12\2/")
		sed -i "s/^hs_${STYLE}~${LEVEL},2,.*/${old}/" ${CMDhs}
	fi

	hsl="${name[0]}${name[1]}${name[2]},${score}"
	hsl="${hsl},${scoreLin},${scoreMulMax},${scoreBest},${timeTotal},${SEED}"
	tot=0
	for i in L J S Z T O I ; do
		eval tet=('$'{tet$i[@]})
		hsl="${hsl},${tet[8]}"
		((tot += ${tet[8]}))
	done
	hsl="${hsl},${tot}"
	hsl="${hsl},${tetSilv},${tetGold}"
	sed -i "s/^\(hs_${STYLE}~${LEVEL},$1,\).*/\1${hsl}/" ${CMDhs}
}

#+=============================================================================
hisExport() {
	if ! grep '^# MAKE-COOKIE' ${CMD} 2>&1 >/dev/null ; then
		echo "! Export disabled in 'break' mode"
		return
	fi

	local re='/^# +MAKE:hiscore.dat/,/^# -MAKE:hiscore.dat/'

	if [[ ! -z "$1" ]]; then
		echo "# Export high scores..."
#		sed -n "${re}p" ${CMD}  |  sed -e '1d' -e '$d' >$1
		sed -n "${re}p" ${CMD} >$1
		echo "* Success: |$1|"
	else
#		sed -n "${re}p" ${CMD}  |  sed -e '1d' -e '$d'
		sed -n "${re}p" ${CMD}
	fi

	return 0
}

#+=============================================================================
hisImport() {
	if ! grep '^# MAKE-COOKIE' ${CMD} 2>&1 >/dev/null ; then
		echo "! Import disabled in 'break' mode"
		return
	fi

	local re='/^# +MAKE:hiscore.dat/,/^# -MAKE:hiscore.dat/'

	echo "# Import high scores..."

	# import file exists
	if [[ ! -f $1 ]]; then
		echo "! Import file not found: |$1|"
		exit 81
	fi

	# temp file available (input scores)
	local itmp="${CMD}.itmp"
	if [[ -e $itmp ]]; then
		echo "! Temporary filename in use: |$itmp|"
		exit 87
	fi

	# extract hiscores from input file
	sed -n "${re}p" $1 >$itmp

	# entry count match
	local cntNew=$(grep '^_hs' ${itmp} | wc -l)
	local cntCur=$(grep '^_hs' ${CMD}  | wc -l)
	if [[ $cntNew -ne $cntCur ]]; then
		echo "! Entry count mismatch ($cntNew != $cntCur) ...try merge"
		exit 82
	fi

	# styles match
	local styNew=($(grep '^hs_....~0,1' ${itmp} | sed 's/...\(....\).*/\1/'))
	local styCur=($(grep '^hs_....~0,1' ${CMD}  | sed 's/...\(....\).*/\1/'))
	for s in ${styNew[@]} ; do
		if [[ ! ${styCur[@]} =~ $s ]]; then
			echo "! Unmatched style: |$s| ...try merge"
			exit 83
		fi
	done

	# temp file available (new bashtris)
	local ftmp="${CMD}.new"
	if [[ -e $ftmp ]]; then
		echo "! Temporary filename in use: |$ftmp|"
		exit 84
	fi

	# temp file available (rename script)
	local xtmp="${CMD}.ren.sh"
	if [[ -e $xtmp ]]; then
		echo "! Temporary filename in use: |$xtmp|"
		exit 85
	fi

	# build file
	>$ftmp  sed "${re}d" ${CMD}
	[[ -f $ftmp ]] || {
		echo "! Creation failed: |$ftmp|"
		exit 86
	}
	>>$ftmp  cat $itmp
	rm "${itmp}"

	# rename the files
	>$xtmp  echo "#!/bin/bash"
	>>$xtmp  echo "sleep 1"
#	>>$xtmp  echo "mv ${CMD} ${CMD}.bak"
	>>$xtmp  echo "mv ${ftmp} ${CMD}"
	>>$xtmp  echo "rm ${xtmp}"
	>>$xtmp  echo "chmod +x ${CMD}"
	chmod +x $xtmp
	$xtmp &

	echo "* Success |$1|"

	return 0
}

#+=============================================================================
hisMerge() {
	local i  j

	if ! grep '^# MAKE-COOKIE' ${CMD} 2>&1 >/dev/null ; then
		echo "! Merge disabled in 'break' mode"
		return
	fi

	echo "# Merge high scores..."

	# import file exists
	if [[ ! -f $1 ]]; then
		echo "! Import file not found: |$1|"
		exit 91
	fi

	local new=()
	local ign=0
	local got=0
	local rej=0
	local imp=0
	IFS=$'\n' read -r -d '' -a new < <(grep '^hs_....~' $1 && printf "\0")
	for ((i = 0;  i < ${#new[@]};  i++)); do
		local re='^hs_(....)~([0-9]+),([1-3]),(...),([0-9]*),(.*)'
		if [[ ${new[$i]} =~ ${re} ]]; then
			local sty=${BASH_REMATCH[1]}
			local lvl=${BASH_REMATCH[2]}
			local pos=${BASH_REMATCH[3]}
			local int=${BASH_REMATCH[4]}
			local scr=${BASH_REMATCH[5]}
			local tet=${BASH_REMATCH[6]}

#			echo "--------"
#			echo "sty: |$sty|"
#			echo "lvl: |$lvl|"
#			echo "pos: |$pos|"
#			echo "int: |$int|"
#			echo "scr: |$scr|"
#			echo "tet: |$tet|"

			# ignore 0 scores
			((scr == 0))  &&  ((++ign))  &&  continue

			# load scores for this level
			hisLoad $lvl $sty

			# don't reimport matching games
			for ((j = 0;  j < ${#HIA[@]};  j++)); do
				[[ "${HIA[$j]#*,*,}" == "${new[$i]#*,*,}" ]]  &&  ((++got))  &&  continue 2
			done

			# Work out where to put it
			hisCheck $scr $lvl $sty noload
			local pos=$?

			# ignore 0 scores
			((pos == 0))  &&  ((++rej))  &&  continue

			# move existing entries
			if [[ $pos -le 2 ]]; then  # move 2nd -> 3rd
				old=$(grep "^hs_${sty}~${lvl},2," ${CMD} | sed "s/\([^,],\).\(.*\)/\13\2/")
				#                          -v-^----------------------------^---------^-
				sed -i "s/^hs_${sty}~${lvl},3,.*/${old}/" ${CMD}
			fi

			if [[ $pos -eq 1 ]]; then  # move 1st -> 2nd
				old=$(grep "^hs_${sty}~${lvl},1," ${CMD} | sed "s/\([^,],\).\(.*\)/\12\2/")
				#                          -v-^----------------------------^---------^-
				sed -i "s/^hs_${sty}~${lvl},2,.*/${old}/" ${CMD}
			fi

			# insert new entry
			sed -i "s/^\(hs_${sty}~${lvl},${pos},\).*/\1${int},${scr},${tet}/" ${CMD}
			printf "# Imported: %s/%-2d @%d  : %s = %d\n" "${sty}" "${lvl}" "${pos}" "${int}" "${scr}"
			((++imp))
		fi
	done

	echo "# IMPORTED: New Entries : $imp"
	echo "# eschewed: Score == 0  : $ign"
	echo "# eschewed: Game exists : $got"
	echo "# eschewed: Weak Score  : $rej"
	echo "#   Total records found : $((ign +got +rej +imp))"

	return 0
}
# -MAKE:hiscore.s
# +MAKE:start.s - start menu
#!/bin/bash

#------------------------------------------------------------------------------ ----------------------------------------
STYLE=NORM  # = NORM/CHAL/NVIS
LEVEL=00    # ^ 00..20
SOUND=BEL   # < OFF/BEL

clrHi=()
clrHi+=("${atPFX}${atUSC};${fgYEL};${bgGRN}${atSFX}")
clrHi+=("${atPFX}${atUSC};${fgBGRN};${bgBLK}${atSFX}")
clrHi+=("${GRN}")

#+=============================================================================
stPitLang() {  # (lang)
	STRT=()

	if [[ "$LANG" == "RU" ]]; then
		#                1         2
		#       12345678901234567890
		STRT+=(".╔═╕.....╒═╤═╕......")  #  1
		STRT+=(".║─╖┌┐┬.┬┌┐│┌┐┬.┬┌┐.")  #  2
		STRT+=(".║.║┌┤││││││├┘│/││..")  #  3
		STRT+=(".╙─╜└┘└┴┘└┘┴┴.┴.┴└┘.")  #  4

		STMAP=()
		STMAP+=(".ttt.....ttttt......")  #  1
		STMAP+=(".tttlji.iootjji.iss.")  #  2
		STMAP+=(".t.tjtitiootojiiis..")  #  3
		STMAP+=(".tttjjtttootj.i.iss.")  #  4

	else
		#                1         2
		#       12345678901234567890
		STRT+=("..╔═╕....╒═╤═╕.♦....")  #  1
		STRT+=("..║─┤╒╕╒╕┬.│┌─┐┬┌┐..")  #  2
		STRT+=("..║.││╡╘╕├┐││┌┘│└┐..")  #  3
		STRT+=("..╙─┘┴┴└┘┴┴┴┴└.┴└┘..")  #  4

		STMAP=()
		STMAP+=("..ttt....ttttt.o....")  #  1
		STMAP+=("..tttllsso.tjjjiss..")  #  2
		STMAP+=("..t.tlissoitijjiss..")  #  3
		STMAP+=("..tttllssoitjj.iss..")  #  4
	fi

	#                1         2
	#       12345678901234567890
	STRT+=("....................")  #  5
	STRT+=("..${txtStyle// /.}:▐====▌......")  #  6  NORM/CHAL/NVIS
	STRT+=("....................")  #  7
	STRT+=("..${txtLevel// /.}:▐^^▌........")  #  8  00..20
	STRT+=("....................")  #  9
	STRT+=("..${txtSound// /.}:▐<<<▌.......")  # 10  OFF/BEL
	STRT+=("....................")  # 11
	STRT+=("▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄")  # 12
	STRT+=("▐_~-▐${txtHighScore// /:}▌-~_▌")  # 13
	STRT+=("▐..................▌")  # 14
	STRT+=("▐..................▌")  # 15
	STRT+=("▐..................▌")  # 16
	STRT+=("▐..................▌")  # 17
	STRT+=("▐▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▌")  # 18
}

#+=============================================================================
stShowLang() {  # (0|1:updateLogo)
	local ch

	[[ "$LANG" == "RU" ]]  &&  ch="▌${langRU}▐"  ||  ch="▌${langEN}▐"
	PAT $((SHy +2)) $((SHx +1)) "${clrLang1}${ch}"

	[[ "$LANG" != "RU" ]]  &&  ch=" ${langRU} "  ||  ch=" ${langEN} "
	PAT $((SHy +3)) $((SHx +2)) "${clrLang2}${ch}"

	# redraw screen, if requested
	if (($1)); then
		stShow
		stDrawSel 1 $2 0

		FAST=1
		pfDrawLevel
		pfDrawScore
		pfShowScore

		pfDrawDebug

		statusSet "${txtStatsHelp}"
	fi
}

#+=============================================================================
stPressStart() {
	local press  start  x  fg

	((CTRLC))  &&  trap "" INT  # disable ^C

	local fgc=(37 33 36 32 35 31 34 30)  # W,Y,C,G,M,R,B,K [8]
	local fgi=0
	while : ; do
		[[ $((++fgi)) -eq 7 ]]  &&  fgi=0
		fg=${fgc[$fgi]}
		for ((x = 0;  x < ${#txtPress};  x++)); do
			PAT $((BSy +4)) $((BSx +3 +x)) "${atPFX}${atBLD};${fg};${bgBLK}${atSFX}${txtPress:$x:1}"
			[[ $((++fg)) -eq 38 ]]  &&  fg=31
			sleep 0.001
		done

		for ((x = 0;  x < ${#txtStart};  x++)); do
			PAT $((BSy +5)) $((BSx +4 +x)) "${atPFX}${atBLD};${fg};${bgBLK}${atSFX}${txtStart:$x:1}"
			[[ $((++fg)) -eq 38 ]]  &&  fg=31
			sleep 0.001
		done
	done
}

#+=============================================================================
stKillPressStart() {
	if [[ $StPid -ne 0 ]]; then
		kill -13 $StPid  # silent death!
		StPid=0
		PAT $((BSy +4)) $((BSx +3)) "${atOFF}       "
		PAT $((BSy +5)) $((BSx +4)) "${atOFF}     "
	fi
}

#+=============================================================================
stScrollPut() {  # (ss, sy))
	local  c  clr  l  ch  x  xx

	l=$((${2} +${1} -18))
	for ((x = 0;  x < ${#STRT[$l]};  x++)); do
		xx=$x
		ch="${STRT[$l]:$x:1}"
		[[ "$ch" == "." ]] && ch=" "

		if [[ $l -lt 4 ]]; then  # logo
			c="${STMAP[$l]:$x:1}"
			case $c in
				[ljsztoi] )  eval clr=\$clr${c^^}  ;;
				*         )  clr="$atOFF"          ;;
			esac

		elif [[ $l -lt 11 ]]; then  # options
			case "$ch" in
				"▐" | "▌" )  clr=${WHT}   ;;
				"="  )
					ch=${txtOptStyle[${STYLE}]}
					clr="${clrVal}"
					((x+=3))
					;;
				"^"  )
					printf -v ch "%02d" $LEVEL
					clr="${clrVal}"
					((x+=1))
					;;
				"<"  )
					ch=${txtOptSound[${SOUND}]}
					clr="${clrVal}"
					((x+=2))
					;;
				*   )  clr="${BGRN}"  ;;
			esac

		elif [[ $l -eq 11 || $l -eq 17 ]]; then  # box top & bottom
			clr="${YEL}"

		elif [[ $l -eq 12 ]]; then  # title
			if [[ $x -eq 0 || $x -eq 19 ]]; then
				clr="${YEL}"
			else
				case "$ch" in
					"," | "_" | "-" )  clr="${BGRN}"  ;;
					"~" )  clr="${BGRN}"
					       ch="."
					       ;;
					"▐" | "▌" )  clr="${GRN}"   ;;
					":"       )  clr="${atPFX}${fgBWHT};${bgGRN}${atSFX}"
					             ch=" "
					             ;;
					[^\ ]     )  clr="${atPFX}${fgBWHT};${bgGRN}${atSFX}"   ;;
					*         )  clr="${atOFF}"  ;;
				esac
			fi

		elif [[ $l -eq 13 ]]; then  # pre 1st place
			if [[ "$ch" == " " ]]; then
				clr="${atPFX}${atUSC};${fgYEL};${bgBLK}${atSFX}"
			else
				clr="${YEL}"
			fi

		elif [[ $l -ge 14 && $l -le 16 ]]; then                   # 1st place
			if [[ $x -eq 0 || $x -eq 19 ]]; then     # box
				clr="${YEL}"
			elif [[ $x -eq 1 ]]; then
				local tmp
				local i=$((l -14))
				eval tmp=(\${HI$i[@]})
				printf -v ch " %3s │ %'10d" "${tmp[2]}" "${tmp[3]}"
				clr="${clrHi[$i]}"
				((x += 16))
			fi
		fi

		PAT $((PITy +$2)) $((PITx +xx +1)) "${clr}${ch}"
	done
}

#+=============================================================================
stScrollIn() {
	local ss  sy  s

	for ((ss = 0;  ss < ${#STRT[@]};  ss++)); do
		for ((sy = $((18 -$ss));  sy <= 18;  sy++)); do
			stScrollPut $ss $sy
		done
		sleep 0.01
	done

	printf -v s "%*s" ${#STRT[$l]} ""
	PAT $PITy $((PITx +1)) "${atOFF}${s}"
}

#+=============================================================================
stScrollOut() {
	local ss  sy  s

	printf -v s "%*s" ${#STRT[$l]} ""
	for ((ss = ((${#STRT[@]} -1));  ss >= 0;  ss--)); do
		for ((sy = 18;  sy >= $((18 -$ss));  sy--)); do
			stScrollPut $ss $sy
		done
		PAT $((PITy +sy)) $((PITx +1)) "${atOFF}${s}"
		sleep 0.01
	done

	PAT $((PITy +sy +1)) $((PITx +1)) "${atOFF}${s}"
}

#+=============================================================================
stShow() {
	local ss  sy  s

	ss=$((${#STRT[@]} -1))
	for ((sy = $((18 -$ss));  sy <= 18;  sy++)); do
		stScrollPut $ss $sy
	done

	printf -v s "%*s" ${#STRT[$l]} ""
	PAT $PITy $((PITx +1)) "${atOFF}${s}"
}

#+=============================================================================
stDrawSel() {  # (0:clear/1:draw, sel{0..2}, offsetY)
	local ch
	(($1))  &&  ch="◄▬▬"  ||  ch="    "
	PAT $((PITy +${2}*2 +6 +${3})) $((PITx +16)) "${BGRN}${ch}"
}

#+=============================================================================
stOptPan() {  # (y, x, clr, L|R, old, new)
	local  l  x  ch  old  new

	l=$((${#5} +1))

	if [[ $4 == L ]]; then  # left
		for (( x = 1;  x <= $l;  x++)); do
			[[ $x -eq 1         ]]  &&  new=""  ||  new="${6:$((l -x))}"
			[[ $x -eq $l        ]]  &&  ch=""   ||  ch="║"
			[[ $x -ge $((l -1)) ]]  &&  old=""  ||  old="${5:0:$((l -x -1))}"
			PAT $1 $2 "${3}${new}${ch}${old}"
			sleep 0.05
		done

	else  # right
		for (( x = 1;  x <= $l;  x++)); do
			[[ $x -eq $((l -1)) ]]  &&  old=""  ||  old="${5:$x}"
			[[ $x -eq $l        ]]  &&  ch=""   ||  ch="║"
			[[ $x -eq 1         ]]  &&  new=""  ||  new="${6:0:$((x -1))}"
			PAT $1 $2 "${3}${old}${ch}${new}"
			sleep 0.05
		done
	fi
}

#+=============================================================================
# Handle the STYLE prams
#
startPrams() {
	pfDrawLevel start

	GARBAGE=0
	CLEVEL=
	scoreDrp=
	scoreLvl=$LEVEL
	scoreLin=0
	LPL=10  # lines per level
	if [[ "$STYLE" == "CHAL" ]]; then
		#  Lvl Spd Grb Pcs   Lvl Spd Grb Pcs   Lvl Spd Grb Pcs   Lvl Spd Grb Pcs
		#   0   3   4  107    5   4   6  125    10  5   8  143    15  6   10 161
		#   1   4   4  109    6   5   6  127    11  6   8  145    16  7   10 163
		#   2   5   4  111    7   6   6  129    12  7   8  147    17  8   10 165
		#   3   6   4  113    8   7   6  131    13  8   8  149    18  9   10 167
		#   4   7   4  115    9   8   6  133    14  9   8  151    19  10  10 169
		#                                                         20  10  12 182
		CLEVEL=$(( ((LEVEL /5) +3) +(LEVEL %5) +((LEVEL /20) *3) ))  # spd
		GARBAGE=$(( ((LEVEL /5) *2) +4))  # 4,6,8,10,12
		scoreDrp=$((100 +GARBAGE +CLEVEL +LEVEL +((LEVEL/5)*10)))
		LPL=6

		if ((DEBUG)); then
			#             10    cubes/line   [PITw]
			#              4    cubes/piece
			# (10/4)    =  2.5  pieces/line
			#              6    lines/level  [LPL]
			# (6*10)    = 60    cubes/level
			# (6*2.5)   = 15    pieces/level
			# ((6*5)/2) = 15    pieces/level (integer maths)
			local ppl=$(( (LPL *5) /2 ))                     # piece per level
			local top=$(( CLEVEL +(scoreDrp /ppl) ))         # theoretical top level
			local max=$top
			((max > 20))  &&  max=20                         # maxes out at 20 anyway
			local pcs=$(( scoreDrp -((max -CLEVEL) *ppl) ))  # pieces that will drop at max level
			DBG "LPL=$LPL ; Level=$LEVEL ; Speed=$CLEVEL ; Junk=$GARBAGE ; Pieces=$scoreDrp , @$max=$pcs"
		fi

		scoreLvl=$CLEVEL
		scoreLin=$GARBAGE
	fi

	score=0
	scoreMul=0
	scoreLast=0
	scoreBest=0
	pfShowScore start
}

#+=============================================================================
start() {
	local old  update

	local SEL=0

	hisLoad $LEVEL $STYLE
	((FAST))  &&  stShow  ||  stScrollIn

	wait  # wait for UNbrickout to complete

	stShowLang 0

	# animated "press start"
	stPressStart &
	StPid=$!

	statusSet "${txtStatsHelp}"

	keyFlush
	stDrawSel 1 $SEL 0
	vercnt=1
	while : ; do
		statusUpdate

		sleep 0.05  # 20 reads/sec
		keyGet

		case ${KEY^^} in
			[Z,] )
				[[ $SEL -eq 2 ]]  &&  sound test
				;;

			[P] )
				startPrams
				stScrollOut &
				pfDrawShoulder 0 0 j &

				HIDE=0  # hide basket pieces
				if [[ "$STYLE" == "NVIS" ]]; then
					if   [[ $LEVEL -ge 15 ]]; then HIDE=2
					elif [[ $LEVEL -ge 10 ]]; then HIDE=1
					fi
				fi
				stKillPressStart
				pfBsHide &

				statusClear

				wait
				return
				;;

			"BKSP" )
				stKillPressStart
				quit 0
				;;

			"DEL" | [Q] )
				[[ "$LANG" == "RU" ]]  &&  langSet EN  ||  langSet RU
				stShowLang 1 $SEL

				stKillPressStart
				stPressStart &
				StPid=$!
				;;

			"DOWN" | [S] )
				if [[ $SEL -ne 2 ]]; then
					stDrawSel 0 $SEL 0
					stDrawSel 1 $SEL 1
					sleep 0.02
					stDrawSel 0 $SEL 1
					((SEL = ++SEL %3))
					stDrawSel 1 $SEL 0
				fi
				;;

			"UP" | [W] )
				if [[ $SEL -ne 0 ]]; then
					stDrawSel 0 $SEL 0
					stDrawSel 1 $SEL -1
					sleep 0.02
					stDrawSel 0 $SEL -1
					((SEL = ($SEL +2) % 3))
					stDrawSel 1 $SEL 0
				fi
				;;

			"LEFT" | [A] )
				case $SEL in
					0 ) old=$STYLE
						case $STYLE in
							NVIS )  STYLE=CHAL ;;
							CHAL )  STYLE=NORM ;;
						esac
						if [[ $old != $STYLE ]]; then
							hisShow left $LEVEL $old $LEVEL $STYLE &
							stOptPan $((PITy +SEL*2 +6)) $((PITx +10)) ${clrVal} "L" \
							         "${txtOptStyle[$old]}" "${txtOptStyle[$STYLE]}" &
						fi
						startPrams
						;;

					1 ) if [[ $LEVEL -gt 0 ]]; then
							old=$LEVEL
							((LEVEL--))
							printf -v ch "%02d" $LEVEL
							PAT $((PITy +SEL*2 +6)) $((PITx +10)) "${clrVal}${ch}"
							hisShow left $old $STYLE $LEVEL $STYLE &
						fi
						startPrams
						;;

					2 ) old=$SOUND
						SOUND=OFF
						if [[ $old != $SOUND ]]; then
							stOptPan $((PITy +SEL*2 +6)) $((PITx +10)) ${clrVal} "L" \
							         "${txtOptSound[$old]}" "${txtOptSound[$SOUND]}" &
						fi ;;
				esac
				;;

			"RIGHT" | [D] )
				case $SEL in
					0 ) old=$STYLE
						case $STYLE in
							NORM )  STYLE=CHAL ;;
							CHAL )  STYLE=NVIS ;;
						esac
						if [[ $old != $STYLE ]]; then
							hisShow right $LEVEL $old $LEVEL $STYLE &
							stOptPan $((PITy +SEL*2 +6)) $((PITx +10)) ${clrVal} "R" \
							         "${txtOptStyle[$old]}" "${txtOptStyle[$STYLE]}" &
						fi
						startPrams
						;;

					1 ) if [[ $LEVEL -lt 20 ]]; then
							old=$LEVEL
							((LEVEL++))
							printf -v ch "%02d" $LEVEL
							PAT $((PITy +SEL*2 +6)) $((PITx +10)) "${clrVal}${ch}"
							hisShow right $old $STYLE $LEVEL $STYLE &
						fi
						startPrams
						;;

					2 ) old=$SOUND
						SOUND=BEL
						if [[ $old != $SOUND ]]; then
							stOptPan $((PITy +SEL*2 +6)) $((PITx +10)) ${clrVal} "R" \
							         "${txtOptSound[$old]}" "${txtOptSound[$SOUND]}" &
						fi ;;
				esac
				;;

			"F1" | "?" | "F2" | "F10" )
				stKillPressStart

				case "${KEY^^}" in
					"F1" | "?" )  helpCtrl ;;
					"F2"       )  helpCombo ;;
					"F10"      )  hisStats ;;
				esac

				csDrawBackdropReveal 0
				pfDrawAll 2 # 1=fast, 2=don't redraw backdrop
				stShowLang 0
				stShow
				stDrawSel 1 $SEL 0

				pfDrawLevel start
				pfShowScore start

				stPressStart &
				StPid=$!
				;;

			"F4" )
				case $vercnt in
					1 )  statusSet "${NAME} v${VER} |${DBGpipe}|" ;;
					2 )  statusSet "DbgPipe: |${DBGpipe}|" ;;
					3 )  statusSet "\`uname -v\`: |$(uname -v 2>/dev/null)|" ;;
					4 )  statusSet "Distro: |${DISTRO}|  Bash: |${BASHVER}|  KbdDrv: |${KEYDRV}|" ;;
					5 )  statusSet "CLI: |${CMD} ${ARGS}|" ;;
					6 )  statusSet "HS.dat: |${CMDhs}|" ;;
					7 )  statusSet "RIG.dat: |${CMDrig}|" ;;
					8 )  statusSet "GO.dat: |${CMDgo}|"
					     vercnt=0
					     ;;
				esac
				((vercnt++))
				;;
		esac

	done
}

# -MAKE:start.s
# +MAKE:pause.s - pause screen
#!/bin/bash

#+=============================================================================
PauseTwinkle() {
	local i
	local clr=("$GRY" "$BLU" "$BBLU" "$CYN" "$BCYN" "$WHT" "$BWHT")
	for ((i = 1;  i < ${#clr[@]};  i++)); do
		PAT $1 $2 "${clr[$i]}◘"
		sleep .01
	done
	for ((i = ${#clr[@]} -2;  i >= 0;  i--)); do
		PAT $1 $2 "${clr[$i]}◘"
		sleep .01
	done
}

#+=============================================================================
Pause() {
	local y  x  i  n  now  timeSt

	local timeBored=0
	local boredDelay=18000 # mS
	timeGet timeSt

	pfHideGame

	local PAUSE=()
		PAUSE+=("TTLTLLBJBJBJBIBBBIBTTTBTZLZZBZ")
		PAUSE+=("TJBJLBIIBLJLIIBBIIJJBJBJLLBLBB")
		PAUSE+=("JJBBBBIIBBLLITTTITBLBLLLJJBJBJ")

	for ((y = 0;  y < PSh;  y++)); do
		for ((x = 0;  x < PSw;  x++)); do
			local ct  cb  clrt  clrb
			ct=${PAUSE[$y]:$((x*2   )):1}
			cb=${PAUSE[$y]:$((x*2 +1)):1}
			eval clrt='$'{clrFg$ct:2}
			eval clrb='$'{clrFg$cb:2}
			((clrb += 10))
			PAT $((PITy +PSy +y)) $((PITx +PSx +x +1)) "${atPFX}${clrt};${clrb}${atSFX}▀"
		done
	done

	# be bored until we restart
	local csuits="♠♣♥♦"
	local csuit=${csuits:$(($RANDOM %4)):1}
	local cvalues="A23456789JQK"
	local cvalue=${cvalues:$(($RANDOM %12)):1}

	local boredMsg=()
		boredMsg+=("Press${keyL}P${keyR}to un-pause.")
		boredMsg+=("You can redraw the screen at any time by pressing${keyL}\`${keyR}")
		boredMsg+=("Алексей Пажитнов wrote Тетрис the year ${GROUP}${clrStatus} was formed.")
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
	StatTime=$statSlow

	keyFlush
	n=0
	while : ; do
		keyGet
		sleep 0.05
		if [[ "$KEY" == "BKSP" ]]; then
			RUN=0
			return
		fi
		[[ "${KEY^^}" == "P" ]]  &&  break

		timeGet now
		if [[ $now -gt $((timeBored +boredDelay)) ]]; then
			statusSet "${boredMsg[$boredCnt]}"
#			[[ $((++boredCnt)) -ge ${#boredMsg[@]} ]]  &&  boredCnt=0
			i=$boredCnt
			while [[ $i -eq $boredCnt ]]; do
				boredCnt=$((RANDOM %${#boredMsg[@]}))
			done
			timeGet timeBored
		fi
		statusUpdate

		y=$((RANDOM %PITh +PITy))
		i=$((BSx +BSw -2))
		x=$((RANDOM %i +1))

		if [[ \
			( ( $((y & 1)) -eq 0  &&  $((x & 1)) -eq 1 ) || \
			  ( $((y & 1)) -eq 1  &&  $((x & 1)) -eq 0 ) \
			) && \
			( \
				( ($y -ge $((SHy +1))  &&  $y -le $((SHy +SHh -2)) ) && \
				  ($x -ge $((SHx +1))  &&  $x -le $((SHx +SHw -2)) ) \
				) || \
				( ( ($y -ge   $PITy      ) && ($y -le $((PITy +PSy -1)) ) ) && \
				  ( ($x -ge $((PITx +1)) ) && ($x -le $((PITx + PITw*2)) ) ) \
				) || \
				( ( ($y -ge $((PITy +PSy)) ) && ($y -le $((PITy +PSy +PSh -1)) ) ) && \
				  ( ($x -ge $((PITx +1          ))  &&  $x -le $((PITx +PSx   )) ) || \
					($x -ge $((PITx +PSx +PSw +1))  &&  $x -le $((PITx + PITw*2)) ) \
				  ) \
				) || \
				( ($y -ge $((PITy +PSy +PSh))  &&  $y -le $((PITy +PITd   )) ) && \
				  ($x -ge $((PITx +1       ))  &&  $x -le $((PITx + PITw*2)) ) \
				) || \
				($y -ge   $BSy       &&  $y -le $((BSy +BSh -2)) && \
				 $x -ge $((BSx +1))  &&  $x -le $((BSx +BSw -2)) \
				) \
			) \
		]]; then
			((n++))
			((n %3))  ||  PauseTwinkle $y $x &
		fi

	done
	statusClear
	StatTime=$statNorm

	wait
	pfUnhideGame
	tetDraw

	timeGet mow
	((timePause += now -timeSt))
}

# -MAKE:pause.s
# +MAKE:rig.dat - rig-game setups
#!/bin/bash

# we'll just wrap this in a heredoc for sanity
: << 'EOT'

# Test rigs
# Each line is essentially a line of code which is eval'ed
# - Run the game in debug mode
# - Set up the pit you want to test
# - Capture the PlayField from the debug monitor
# - tet0 is the tet in play
# - tet1 is the next tet in play
# - tet4 is the shoulder tet
# - rot is the rotation {0..3} [moving clockwise]
# - tetY|X are the starting pit coords
# - tetStY|X are the default starting values {top, middle}
# The character between the ~'s is the selection key
# The box will auto-centre, but it will not scroll!
# ...So you're limited to ~23 test rigs [ironically, untested]

rig~0~titl="Clear Pit"
rig~0~tetY=$tetStY
rig~0~tetX=$tetStX
rig~0~rot=0
rig~0~tet0=("${tetI[@]}")
rig~0~tet1=("${tetI[@]}")
rig~0~tet2=("${tetI[@]}")
rig~0~tet3=("${tetI[@]}")
rig~0~tet4=("${tetI[@]}")
rig~0~PIT[ 0]="F880808080808080808080F1"
rig~0~PIT[ 1]="F880808080808080808080F1"
rig~0~PIT[ 2]="F880808080808080808080F1"
rig~0~PIT[ 3]="F880808080808080808080F1"
rig~0~PIT[ 4]="F880808080808080808080F1"
rig~0~PIT[ 5]="F880808080808080808080F1"
rig~0~PIT[ 6]="F880808080808080808080F1"
rig~0~PIT[ 7]="F880808080808080808080F1"
rig~0~PIT[ 8]="F880808080808080808080F1"
rig~0~PIT[ 9]="F880808080808080808080F1"
rig~0~PIT[10]="F880808080808080808080F1"
rig~0~PIT[11]="F880808080808080808080F1"
rig~0~PIT[12]="F880808080808080808080F1"
rig~0~PIT[13]="F880808080808080808080F1"
rig~0~PIT[14]="F880808080808080808080F1"
rig~0~PIT[15]="F880808080808080808080F1"
rig~0~PIT[16]="F880808080808080808080F1"
rig~0~PIT[17]="F880808080808080808080F1"
rig~0~PIT[18]="F880808080808080808080F1"
rig~0~PIT[19]="F880808080808080808080F1"
rig~0~PIT[20]="FCF4F4F4F4F4F4F4F4F4F4F5"

rig~1~titl="Add O for Perfect"
rig~1~tetY=$(($tetStY+7))
rig~1~tetX=$tetStX
rig~1~rot=1
rig~1~tet0=("${tetO[@]}")
rig~1~tet1=("${tetO[@]}")
rig~1~tet2=("${tetO[@]}")
rig~1~tet3=("${tetO[@]}")
rig~1~tet4=("${tetO[@]}")
rig~1~PIT[ 0]="F880808080808080808080F1"
rig~1~PIT[ 1]="F880808080808080808080F1"
rig~1~PIT[ 2]="F880808080808080808080F1"
rig~1~PIT[ 3]="F880808080808080808080F1"
rig~1~PIT[ 4]="F880808080808080808080F1"
rig~1~PIT[ 5]="F880808080808080808080F1"
rig~1~PIT[ 6]="F880808080808080808080F1"
rig~1~PIT[ 7]="F880808080808080808080F1"
rig~1~PIT[ 8]="F880808080808080808080F1"
rig~1~PIT[ 9]="F880808080808080808080F1"
rig~1~PIT[10]="F880808080808080808080F1"
rig~1~PIT[11]="F880808080808080808080F1"
rig~1~PIT[12]="F880808080808080808080F1"
rig~1~PIT[13]="F880808080808080808080F1"
rig~1~PIT[14]="F880808080808080808080F1"
rig~1~PIT[15]="F880808080808080808080F1"
rig~1~PIT[16]="F880808080808080808080F1"
rig~1~PIT[17]="F880808080808080808080F1"
rig~1~PIT[18]="F821292928808021292928F1"
rig~1~PIT[19]="F821292928808021292928F1"
rig~1~PIT[20]="FCF4F4F4F4F4F4F4F4F4F4F5"

rig~2~titl="Add I for Perfect Tetris"
rig~2~tetY=$(($tetStY+5))
rig~2~tetX=$tetStX
rig~2~rot=1
rig~2~tet0=("${tetI[@]}")
rig~2~tet1=("${tetI[@]}")
rig~2~tet2=("${tetI[@]}")
rig~2~tet3=("${tetI[@]}")
rig~2~tet4=("${tetI[@]}")
rig~2~PIT[ 0]="F880808080808080808080F1"
rig~2~PIT[ 1]="F880808080808080808080F1"
rig~2~PIT[ 2]="F880808080808080808080F1"
rig~2~PIT[ 3]="F880808080808080808080F1"
rig~2~PIT[ 4]="F880808080808080808080F1"
rig~2~PIT[ 5]="F880808080808080808080F1"
rig~2~PIT[ 6]="F880808080808080808080F1"
rig~2~PIT[ 7]="F880808080808080808080F1"
rig~2~PIT[ 8]="F880808080808080808080F1"
rig~2~PIT[ 9]="F880808080808080808080F1"
rig~2~PIT[10]="F880808080808080808080F1"
rig~2~PIT[11]="F880808080808080808080F1"
rig~2~PIT[12]="F880808080808080808080F1"
rig~2~PIT[13]="F880808080808080808080F1"
rig~2~PIT[14]="F880808080808080808080F1"
rig~2~PIT[15]="F880808080808080808080F1"
rig~2~PIT[16]="F89199999C8024A1A9A9ACF1"
rig~2~PIT[17]="F89599999A8026A5A9A9AAF1"
rig~2~PIT[18]="F89399999C8026A3A9A9ACF1"
rig~2~PIT[19]="F89199999A8022A1A9A9AAF1"
rig~2~PIT[20]="FCF4F4F4F4F4F4F4F4F4F4F5"

rig~3~titl="Test Frag+Combo"
rig~3~tetY=$(($tetStY+8))
rig~3~tetX=$(($tetStX+5))
rig~3~rot=1
rig~3~tet0=("${tetT[@]}")
rig~3~tet1=("${tetI[@]}")
rig~3~tet2=("${tetI[@]}")
rig~3~tet3=("${tetI[@]}")
rig~3~tet4=("${tetI[@]}")
rig~3~PIT[ 0]="F880808080808080808080F1"
rig~3~PIT[ 1]="F880808080808080808080F1"
rig~3~PIT[ 2]="F880808080808080808080F1"
rig~3~PIT[ 3]="F880808080808080808080F1"
rig~3~PIT[ 4]="F880808080808080808080F1"
rig~3~PIT[ 5]="F880808080808080808080F1"
rig~3~PIT[ 6]="F880808080808080808080F1"
rig~3~PIT[ 7]="F880808080808080808080F1"
rig~3~PIT[ 8]="F880808080808080808080F1"
rig~3~PIT[ 9]="F880808080808080808080F1"
rig~3~PIT[10]="F880808080808080808080F1"
rig~3~PIT[11]="F880808080808080808080F1"
rig~3~PIT[12]="F880808080808080808080F1"
rig~3~PIT[13]="F880808080808080808080F1"
rig~3~PIT[14]="F880808080808080808080F1"
rig~3~PIT[15]="F880808080808080808080F1"
rig~3~PIT[16]="F834808080808080808080F1"
rig~3~PIT[17]="F837388080808080808080F1"
rig~3~PIT[18]="F8326568151c151c717c80F1"
rig~3~PIT[19]="F8616a80131a131a807378F1"
rig~3~PIT[20]="FCF4F4F4F4F4F4F4F4F4F4F5"

rig~4~titl="Add J for DOUBLE Combo"
rig~4~tetY=$(($tetStY+3))
rig~4~tetX=$tetStX
rig~4~rot=3
rig~4~tet0=("${tetJ[@]}")
rig~4~tet1=("${tetJ[@]}")
rig~4~tet2=("${tetI[@]}")
rig~4~tet3=("${tetI[@]}")
rig~4~tet4=("${tetO[@]}")
rig~4~PIT[ 0]="F880808080808080808080F1"
rig~4~PIT[ 1]="F880808080808080808080F1"
rig~4~PIT[ 2]="F880808080808080808080F1"
rig~4~PIT[ 3]="F880808080808080808080F1"
rig~4~PIT[ 4]="F880808080808080808080F1"
rig~4~PIT[ 5]="F880808080808080808080F1"
rig~4~PIT[ 6]="F880808080808080808080F1"
rig~4~PIT[ 7]="F880808080808080808080F1"
rig~4~PIT[ 8]="F880808080808080808080F1"
rig~4~PIT[ 9]="F880808080808080808080F1"
rig~4~PIT[10]="F880808080808080808080F1"
rig~4~PIT[11]="F880808080808080808080F1"
rig~4~PIT[12]="F880808080808080808080F1"
rig~4~PIT[13]="F8151c151c8080151c151cF1"
rig~4~PIT[14]="F8131a131a8080131a131aF1"
rig~4~PIT[15]="F84451595c808045494854F1"
rig~4~PIT[16]="F846717c52802442656856F1"
rig~4~PIT[17]="F8434873788026616a515aF1"
rig~4~PIT[18]="F8151c151c8026151c151cF1"
rig~4~PIT[19]="F8131a131a8022131a131aF1"
rig~4~PIT[20]="FCF4F4F4F4F4F4F4F4F4F4F5"

rig~5~titl="Add 2x4 for Super Combo"
rig~5~tetY=$tetStY
rig~5~tetX=$tetStX
rig~5~rot=0
rig~5~tet0=("${tetO[@]}")
rig~5~tet1=("${tetO[@]}")
rig~5~tet2=("${tetI[@]}")
rig~5~tet3=("${tetI[@]}")
rig~5~tet4=("${tetO[@]}")
rig~5~PIT[ 0]="F880808080808080808080F1"
rig~5~PIT[ 1]="F880808080808080808080F1"
rig~5~PIT[ 2]="F880808080808080808080F1"
rig~5~PIT[ 3]="F880808080808080808080F1"
rig~5~PIT[ 4]="F880808080808080808080F1"
rig~5~PIT[ 5]="F880808080808080808080F1"
rig~5~PIT[ 6]="F880808080808080808080F1"
rig~5~PIT[ 7]="F880808080808080808080F1"
rig~5~PIT[ 8]="F880808080808080808080F1"
rig~5~PIT[ 9]="F880808080808080808080F1"
rig~5~PIT[10]="F880808080808080808080F1"
rig~5~PIT[11]="F880808080808080808080F1"
rig~5~PIT[12]="F8A1A9A9AC151c80808080F1"
rig~5~PIT[13]="F8A5A9A9AA131a80808080F1"
rig~5~PIT[14]="F8A3A9A9AC151c80808080F1"
rig~5~PIT[15]="F8A1A9A9AA131a80808080F1"
rig~5~PIT[16]="F8A1A9A9ACA1A9A9AC8080F1"
rig~5~PIT[17]="F8A5A9A9AAA5A9A9AA8080F1"
rig~5~PIT[18]="F8A3A9A9ACA3A9A9AC8080F1"
rig~5~PIT[19]="F8A1A9A9AAA1A9A9AA8080F1"
rig~5~PIT[20]="FCF4F4F4F4F4F4F4F4F4F4F5"

rig~6~titl="Add T for T Spin"
rig~6~tetY=$tetStY
rig~6~tetX=$(($tetStX-1))
rig~6~rot=3
rig~6~tet0=("${tetT[@]}")
rig~6~tet1=("${tetT[@]}")
rig~6~tet2=("${tetT[@]}")
rig~6~tet3=("${tetT[@]}")
rig~6~tet4=("${tetT[@]}")
rig~6~PIT[ 0]="F880808080808080808080F1"
rig~6~PIT[ 1]="F880808080808080808080F1"
rig~6~PIT[ 2]="F880808080808080808080F1"
rig~6~PIT[ 3]="F880808080808080808080F1"
rig~6~PIT[ 4]="F880808080808080808080F1"
rig~6~PIT[ 5]="F880808080808080808080F1"
rig~6~PIT[ 6]="F880808080808080808080F1"
rig~6~PIT[ 7]="F880808080808080808080F1"
rig~6~PIT[ 8]="F880808080808080808080F1"
rig~6~PIT[ 9]="F880808080808080808080F1"
rig~6~PIT[10]="F880808080808080808080F1"
rig~6~PIT[11]="F880808080808080808080F1"
rig~6~PIT[12]="F880808080808080808080F1"
rig~6~PIT[13]="F845494880808080808080F1"
rig~6~PIT[14]="F842656880808080808080F1"
rig~6~PIT[15]="F8616a3480808080808080F1"
rig~6~PIT[16]="F864313E80808080808080F1"
rig~6~PIT[17]="F8636c328080151c51595cF1"
rig~6~PIT[18]="F85462808080131a717c52F1"
rig~6~PIT[19]="F853595880212929287378F1"
rig~6~PIT[20]="FCF4F4F4F4F4F4F4F4F4F4F5"

EOT
# -MAKE:rig.dat
# +MAKE:rig.s - rig-game menu & system
#!/bin/bash

#+=============================================================================
rigGame() {
	local tlx  tly  x  y  n  t  w  i  valid  s  item

	# get titles
	local list=($(
		grep '^rig~[0-9]*~titl=' ${CMDrig} | \
		sed -e 's/rig~\([0-9]*\)~titl="\([^"]*\).*/\1:\2/' \
			-e 's/ /_/g' \
	))

	w=0
	for ((i = 0;  i < ${#list[@]};  i++)); do
		t="${list[$i]//*:/}"
		n=${#t}
		[[ $n -gt $w ]]  &&  w=$n
	done
	((w += 8))
	tly=$(($((24 -${#list[@]})) /2))
	tlx=$((PITx +PITw -w/2 +1))
	[[ $tlx -lt 1 ]]  &&  tlx=1

	# Display menu
	PAT $tly $tlx "${BRED}╔"
	for ((x = 1;  x < $((w -1));  x++)); do
		PAT $tly $((tlx +x)) "${BRED}═"
	done
	PAT $tly $((tlx +x)) "${BRED}╗"

	# show titles
	valid=
	for ((y = 0;  y < ${#list[@]};  y++)); do
		n=${list[$y]//:*/}
		t=${list[$y]//*:/}
		printf -v s "${BRED}║ ${BGRN}%c ${BBLK}- ${BWHT}%-*s ${BRED}║" $n $((w -8)) "${t//_/ }"
		PAT $((tly +y +1))  $tlx "${s}${BBLK}▒"
		valid="${valid}${n}"
	done

	PAT $((tly +y +1)) $tlx "${BRED}╚"
	for ((x = 1;  x < $((w -1));  x++)); do
		PAT $((tly +y +1)) $((tlx +x)) "${BRED}═"
	done
	PAT $((tly +y +1)) $((tlx +x)) "${BRED}╝${BBLK}▒"

	for ((x = 1;  x <= $w;  x++)); do
		PAT $((tly +${#list[@]} +2))  $((tlx +x)) "${BBLK}▒"
	done

	# get selection
	while : ; do
		keyGet
		if [[ ! -z $KEY  &&  "$valid" =~ "$KEY" ]] ; then
			# load selection
			item=($(
				grep -E "^rig~$KEY~(rot|tet|PIT)" ${CMDrig} | \
				sed -e 's/rig~[0-9]*~//' \
					-e 's/\[ /\[/' \
					-e 's/ /_/g' \
			))

			for ((i = 0;  i < ${#item[@]};  i++)); do
				eval ${item[$i]}
			done
			return
		fi

		# abort
		[[ "$KEY" =~ ^(BKSP|ESC)$ ]]  &&  return

		sleep 0.05
	done
}
# -MAKE:rig.s
# +MAKE:sound.s - event sounds
#!/bin/bash

#+============================================================================= ========================================
sound() {
	if   [[ "$SOUND" == "OFF" ]]; then  return
	elif [[ "$SOUND" == "BEL" ]]; then
		case "$1" in
			"test"    )  echo -en "\a"  ;;  # rotate-L on Sound select
			"levelup" )  echo -en "\a"  ;;  # speed increase
			"comboS"  )  echo -en "\a"  ;;  # silver combo
			"comboG"  )  echo -en "\a"  ;;  # gold combo
			"perfect" )  echo -en "\a"  ;;  # pit emptied
			"tetris"  )  echo -en "\a"  ;;  # tetris
			*) DBG "Missing sound: |$SOUND|$1|"
			   ;;
		esac
	else
	   DBG "Missing sound: |$SOUND|$1|"
	fi
}
# -MAKE:sound.s
# +MAKE:g_gfx.s - game graphics
#!/bin/bash

#+============================================================================= ========================================
tetSetGr() {  # (val, 0:BlankTab|1:BlankSpace|2:shadow)
	local cc  bgc

	if [[ $2 -eq 2 ]]; then
		c=9
		gr="░░"
	else
		c=4
		gr="▒▒"
	fi

	printf -v cc "%d" $(($1 & maskT))
	case "$cc" in
		"${tetiB}"  )  [[ $2 -eq 1 ]]  &&  TGR="${tetB[4]}  "  ||  TGR="\033[2C" ;;

		"${tetiO}"  )  TGR="${tetO[$c]}${gr}"   ; bgc="$((${clrFgO:2} +10))" ;;
		"${tetiI}"  )  TGR="${tetI[$c]}${gr}"   ; bgc="$((${clrFgI:2} +10))" ;;
		"${tetiT}"  )  TGR="${tetT[$c]}${gr}"   ; bgc="$((${clrFgT:2} +10))" ;;
		"${tetiL}"  )  TGR="${tetL[$c]}${gr}"   ; bgc="$((${clrFgL:2} +10))" ;;
		"${tetiJ}"  )  TGR="${tetJ[$c]}${gr}"   ; bgc="$((${clrFgJ:2} +10))" ;;
		"${tetiS}"  )  TGR="${tetS[$c]}${gr}"   ; bgc="$((${clrFgS:2} +10))" ;;
		"${tetiZ}"  )  TGR="${tetZ[$c]}${gr}"   ; bgc="$((${clrFgZ:2} +10))" ;;

		"${tetiV}"  )  TGR="${clrCBsilv}▓▓" ; bgc="$((${clrFgV:2} +10))" ;;
		"${tetiG}"  )  TGR="${clrCBgold}▓▓" ; bgc="$((${clrFgG:2} +10))" ;;
	esac

	if [[ $DEBUG -eq 1  &&  $2 -ne 2  &&  $NDRAW -eq 0 ]]; then
		printf -v cc "%d" $((${1} & maskC))
		case $cc in
			"$maskB"    )  (($2))  &&  TGR="${GRY}∙∙" ;;

			"$maskL"    )  TGR="${atPFX};${fgBLK};${bgc}${atSFX}═-"  ;;
			"$maskD"    )  TGR="${atPFX};${fgBLK};${bgc}${atSFX}╓╖"  ;;
			"$maskU"    )  TGR="${atPFX};${fgBLK};${bgc}${atSFX}╙╜"  ;;
			"$maskR"    )  TGR="${atPFX};${fgBLK};${bgc}${atSFX}-═"  ;;

			"$maskLD"   )  TGR="${atPFX};${fgBLK};${bgc}${atSFX}╦╗"  ;;
			"$maskLU"   )  TGR="${atPFX};${fgBLK};${bgc}${atSFX}╩╝"  ;;
			"$maskLR"   )  TGR="${atPFX};${fgBLK};${bgc}${atSFX}══"  ;;
			"$maskDU"   )  TGR="${atPFX};${fgBLK};${bgc}${atSFX}║║"  ;;
			"$maskDR"   )  TGR="${atPFX};${fgBLK};${bgc}${atSFX}╔╦"  ;;
			"$maskUR"   )  TGR="${atPFX};${fgBLK};${bgc}${atSFX}╚╩"  ;;

			"$maskUDL"  )  TGR="${atPFX};${fgBLK};${bgc}${atSFX}╬╣"  ;;
			"$maskLRD"  )  TGR="${atPFX};${fgBLK};${bgc}${atSFX}╦╦"  ;;
			"$maskLRU"  )  TGR="${atPFX};${fgBLK};${bgc}${atSFX}╩╩"  ;;
			"$maskUDR"  )  TGR="${atPFX};${fgBLK};${bgc}${atSFX}╠╬"  ;;

			"$maskLDUR" )  TGR="${atPFX};${fgBLK};${bgc}${atSFX}XX"  ;; #╬╬"  ;;
		esac
	fi
}

#+============================================================================= ========================================
tetDrawPit() {
	local y  x

	if [[ "$STYLE" == "NVIS" ]]; then
		((DEBUG))  &&  TGR="${GRY}∙∙"  ||  TGR="${atOFF}  "
		for ((y = $((${#PIT[@]} -2));  y >= 1;  y--)); do
			for ((x = 0;  x < PITw;  x++)); do
				PAT $((PITy +y -1))  $((PITx +1 +x*2)) "${TGR}"
			done
		done
	else
		for ((y = $((${#PIT[@]} -2));  y >= 1;  y--)); do
			for ((x = 0;  x < PITw;  x++)); do
				tetSetGr $((0x${PIT[$y]:$((x*2 +2)):2})) 1
				PAT $((PITy +y -1))  $((PITx +1 +x*2)) "${TGR}"
			done
		done
	fi

	((DEBUG)) && {
		for ((y = 0;  y < PITh;  y++)); do
			DBGF "PIT[%2d]=\"%s\"\n" $y ${PIT[$y]}
		done
	}
}

#+=============================================================================
# y,x
# off = use aligment offsets (for basket & shoulder)
# 0=undraw|1=draw
# rotation
# tetromino .. needs to be last
#
tetDrawTet() {  # (y, x, off, 0|1|2=un|draw|shadow, rot, tet)
	local h  w  offy  offx  s  z  cc

	local y=$1   ; shift
	local x=$1   ; shift
	local off=$1 ; shift
	local drw=$1 ; shift
	local rot=$1 ; shift
	local tet=("$@")

	if (($off)); then
		offy=${tet[6]}
		offx=${tet[5]}
	else
		offy=0
		offx=0
	fi

	for ((h = 0;  h < tetH;  h++)); do
		[[ $((y +h)) -lt $PITy ]]  &&  continue  # && ((PITx < x <= PITx+PITw*2))
		s=
		for ((w = 0;  w < tetW;  w++)); do
			z=$((h*tetW +w))
			cc=$((0x${tet[$rot]:$((z *2)):2}))
			if [[ $drw -eq 0 ]]; then
				if [[ $cc -eq $tetiB ]]; then
					TGR="\033[2C"
				elif [[ $DEBUG -ne 0  && $NDRAW -eq 0  &&  \
				        $x -gt $((PITx -2))  &&  $x -le $((PITx +PITw*2)) ]]; then
					TGR="${GRY}∙∙"
				else
					TGR="${atOFF}${nbsp}${nbsp}"
				fi
			elif [[ $drw -eq 2 ]]; then
				tetSetGr $cc 2
			else
				tetSetGr $cc 0
			fi
			s="${s}${TGR}"
		done
		PAT $((y +h +offy)) $((x +offx)) "${s}"
	done
}

#+=========================================================
# Redraw the basket - after adding a new piece
#
#!! a nice little scrolling up animation wouldn't go amiss here!
#
tetDrawBs() {
	local i

	# undraw the old ones
	for ((i = 0;  i <= 2 -HIDE;  i++)); do
		eval tet='$'{tet$i[@]}
		tetDrawTet $((BSy -1 +i*4)) $((BSx +3)) 1 0 0 ${tet[@]}
	done

	# draw the new ones
	for ((i = 1;  i <= 3 -HIDE;  i++)); do
		eval tet='$'{tet$i[@]}
		tetDrawTet $((BSy -5 +i*4)) $((BSx +3)) 1 1 0 ${tet[@]}
	done
}

#+=========================================================
# Draw the shoulder tet
#
tetDrawSh() {
	tetDrawTet $SHy $((SHx +3)) 1 1 0 ${tet4[@]}
}

#+=========================================================
# UN-Draw the shoulder tet
#
tetUndrawSh() {
	tetDrawTet $SHy $((SHx +3)) 1 0 0 ${tet4[@]}
}

#+=========================================================
# Work out where the shadow should be and draw it
#
tetDrawShadow() {
	shadY=$tetY
	while tetCollide $shadY $tetX ${tet0[$rot]} ; do ((shadY++)) ; done
	[[ $((--shadY)) -le $tetY ]] && return

	shadX=$tetX

	tetDrawTet $((PITy +shadY -1)) $((PITx +1 +shadX*2)) 0 2 $rot ${tet0[@]}
}

#+=========================================================
# UN-DRAW the shadow
#
tetUndrawShadow() {
	[[ $shadY -le $tetY ]] && return
	tetDrawTet $((PITy +shadY -1)) $((PITx +1 +shadX*2)) 0 0 $rot ${tet0[@]}
}

#+=============================================================================
# DRAW a tet in the pit
#
tetDraw() {
	tetDrawShadow
	tetDrawTet $((PITy +tetY -1)) $((PITx +1 +tetX*2)) 0 1 $rot ${tet0[@]}
}

#+=============================================================================
# UN-DRAW a tet in the pit
#
tetUndraw() {
	[[ "$KEY" != "DOWN" ]]  &&  tetUndrawShadow
	tetDrawTet $((PITy +tetY -1)) $((PITx +1 +tetX*2)) 0 0 $rot ${tet0[@]}
}

#+=============================================================================
introduce() {
	local slp=0.2
	local i=

	tetDrawSh
	sleep $slp
	tetUndrawSh
	sleep $slp
	tetDrawSh
	sleep $slp

	for ((i = 1;  i <= 3;  i++)); do
		tetAdd 0   # 0 = do NOT update stats
		tetDrawBs  # redraw basket tets
		sleep $slp
		tetDrawTet $(($BSy -1 +2*4)) $(($BSx +3)) 1 0 0 ${tet3[@]}
		sleep $slp
		tetDrawTet $(($BSy -1 +2*4)) $(($BSx +3)) 1 1 0 ${tet3[@]}
		sleep $slp
	done

	tetAdd 1   # 0 = do NOT update stats
	tetDrawBs  # redraw basket tets
	tetDraw
	sleep $slp
	tetUndraw
	sleep $slp
	tetDraw
}

#+============================================================================= ========================================
# Special bonus if the board is cleared
#
tetPerfect100() {
	local y  x  i  c  ch

	((DEBUG & ! NDRAW))  &&  ch="${GRY}∙∙∙∙"  ||  ch="${atOFF}    "
	c=(37 33 36 32 35 31 34)  # W,Y,C,G,M,R,B - what an interesting pattern!?
	x=$((PITx +9))
	for ((i = 0;  i < ${#c[@]};  i++)); do
		y=$((PITy +PITh -3 -i/2))
		PAT $y $x "${atPFX}${atBLD};${c[$i]}${atSFX}+100"
		sleep 0.06
		PAT $y $x "${ch}"
	done
}

#+=============================================================================
tetPerfect() {
	local i  j

	tetPerfect100 &  # +100 animation

	sound perfect

	# baloon - threads need to do things atomically
	PAT $((PITy +6)) $((PITx +5)) "${YEL},---------."
	PAT $((PITy +7)) $((PITx +4)) "${YEL}( ${txtPerfect} )"
	PAT $((PITy +8)) $((PITx +5)) "${YEL}\`---------'"

	# flashing "PERFECT"
	local sl=${#txtPerfect}
	local fg=31  # 31--> R,G,Y,B,M,C,W <--37
	for ((i = 0;  i < 6;  i++)); do
		for ((j = 0;  j < sl;  j++)); do
			PAT $((PITy +7)) $((PITx +6 +j)) "${atPFX}${atBLD};${fg}${atSFX}${txtPerfect:$j:1}"
			[[ $((++fg)) -eq 37 ]]  &&  fg=31
			sleep 0.02
		done
	done

	# clean up
	((DEBUG & ! NDRAW))  &&  ch="${GRY}∙∙∙∙∙∙∙∙∙∙∙∙∙"  ||  ch="${atOFF}             "  # 13
	PAT $((PITy +6)) $((PITx +4)) "${ch}"
	PAT $((PITy +7)) $((PITx +4)) "${ch}"
	PAT $((PITy +8)) $((PITx +4)) "${ch}"

	wait
}

#+=============================================================================
tetFlashCombo() {
	local i  h  w
	local y=$1
	local x=$2
	local c=$3

	for ((i = 0;  i < 4;  i++)); do
		for ((h = 0;  h < 4;  h++)); do
			for ((w = 0;  w < 4;  w++)); do
				local aty=$(($PITy +$y +$h -1))
				local atx=$(($PITx +$(($x +$w))*2 +1))
				local v=$((0x${PIT[$((y +h))]:$(($((x +w))*2 +2)):2}))  # I'm getting good at this :)
				local t=$((v &maskT))
				(($i & 1))  &&  ch="▒▒"  ||  ch="▓▓"
				case $t in
					"${tetiO}" )  PAT $aty $atx "${tetO[4]}${ch}" ;;
					"${tetiI}" )  PAT $aty $atx "${tetI[4]}${ch}" ;;
					"${tetiT}" )  PAT $aty $atx "${tetT[4]}${ch}" ;;
					"${tetiL}" )  PAT $aty $atx "${tetL[4]}${ch}" ;;
					"${tetiJ}" )  PAT $aty $atx "${tetJ[4]}${ch}" ;;
					"${tetiS}" )  PAT $aty $atx "${tetS[4]}${ch}" ;;
					"${tetiZ}" )  PAT $aty $atx "${tetZ[4]}${ch}" ;;
				esac
			done
		done
		sleep 0.16
	done
}

#+=============================================================================
# not thread safe
#
tetFlashLines() {
	local i  l  x

	local cnt=$1
	shift
	local list=("$@")

	if [[ $cnt -eq 4 ]]; then
		sound tetris
	fi

	# fancy animation goes here!
	for ((i = 0;  i < 3;  i++)); do
		for l in ${list[@]} ; do
			PAT $((PITy +l -1)) $((PITx +1)) "▓▓"
			for ((x = 1;  x < PITw;  x++)); do  echo -en "▓▓" ;  done
		done
		sleep 0.2
		for l in ${list[@]} ; do
			PAT $((PITy +l -1)) $((PITx +1)) "░░"
			for ((x = 1;  x < PITw; x++)); do  echo -en "░░" ;  done
		done
		sleep 0.1
	done
}

# -MAKE:g_gfx.s
# +MAKE:g_logic.s - game logic
#!/bin/bash

#------------------------------------------------------------------------------ ----------------------------------------
# the lo nybble defines the directions of contact
# LDUR is an illegal condition used to indicate a tet fragment

maskC=$((0x0F))

maskB=$((0x00))
maskL=$((0x08))
maskD=$((0x04))
maskU=$((0x02))
maskR=$((0x01))
maskLD=$((maskL |maskD))
maskLU=$((maskL |maskU))
maskLR=$((maskL |maskR))
maskDU=$((maskD |maskU))
maskDR=$((maskD |maskR))
maskUR=$((maskU |maskR))

maskLRU=$((maskL |maskR |maskU))
maskLRD=$((maskL |maskR |maskD))
maskUDL=$((maskU |maskD |maskL))
maskUDR=$((maskU |maskD |maskR))

maskLDUR=$((maskL |maskD |maskU |maskR))

# the hi nybble indicates the tet type
# 0    RESERVED
# 1..7 normal tets
# 8    empty space
# 9..A combo tets
# B..E not used
# F    pit wall
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

tetiW=$((0xF0))  # pit wall

pitWl=$((tetiW |maskL))
pitWbl=$((tetiW |maskD |maskL))
pitWb=$((tetiW |maskD))
pitWbr=$((tetiW |maskD |maskR))
pitWr=$((tetiW |maskR))

# tet colours
clrFgB="${fgBLK}"
clrFgO="${fgBWHT}"
clrFgI="${fgBCYN}"
clrFgT="${fgYEL}"
clrFgL="${fgBMAG}"
clrFgJ="${fgBRED}"
clrFgS="${fgBGRN}"
clrFgZ="${fgBBLU}"

# game tet
clrB="${atPFX}${clrFgB};${bgBLK}${atSFX}"
clrI="${atPFX}${clrFgI};${bgBLK}${atSFX}"
clrO="${atPFX}${clrFgO};${bgBLK}${atSFX}"
clrT="${atPFX}${clrFgT};${bgBLK}${atSFX}"
clrL="${atPFX}${clrFgL};${bgBLK}${atSFX}"
clrJ="${atPFX}${clrFgJ};${bgBLK}${atSFX}"
clrS="${atPFX}${clrFgS};${bgBLK}${atSFX}"
clrZ="${atPFX}${clrFgZ};${bgBLK}${atSFX}"

# mini tet (stats)
clrBm="${atPFX}${clrFgB:2};${bgBLK}${atSFX}"
clrIm="${atPFX}${clrFgI:2};${bgBLK}${atSFX}"
clrOm="${atPFX}${clrFgO:2};${bgBLK}${atSFX}"
clrTm="${atPFX}${clrFgT:2};${bgBLK}${atSFX}"
clrLm="${atPFX}${clrFgL:2};${bgBLK}${atSFX}"
clrJm="${atPFX}${clrFgJ:2};${bgBLK}${atSFX}"
clrSm="${atPFX}${clrFgS:2};${bgBLK}${atSFX}"
clrZm="${atPFX}${clrFgZ:2};${bgBLK}${atSFX}"

# tet definitions
tetName="BOITLJSZ"  # for the random selector
tetCnt=7
tetW=4
tetH=4

tetB=("80808080808080808080808080808080"  # 0    : rot_0
      "80808080808080808080808080808080"  # 1    : rot_1
      "80808080808080808080808080808080"  # 2    : rot_2
      "80808080808080808080808080808080"  # 3    : rot_3
      ${clrB} 0 0                         # 4,5,6: colour, Xoffs, Yoffs
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

#+============================================================================= ========================================
# Initialise most/all of the game logic
#
tetNew() {
	local s  i  junk  n  j  tetiX

	# empty the rows ...not the base
	for ((i = 0; i < PITh -1 -GARBAGE; i++)); do
		PIT[$i]="$EMPTY"
	done

	# build GARBAGE lines for CHAL'lenge mode
	for (( i = i; i < PITh -1; i++)); do
		while : ; do
			n=0
			junk=
			for ((j = 0;  j < PITw;  j++)); do
				RND
				if ((RNDn &1)); then
					RND ; while ((! RNDn)) ; do RND ; done
					eval tetiX='$'teti${tetName:$RNDn:1}
					((tetiX |= maskLDUR,  n++))
					printf -v junk "%s%02X" "$junk" "$tetiX"
				else
					printf -v junk "%s%02X" "$junk" "$tetiB"
				fi
			done
			((n >= 5  &&  n <= 8))  &&  break
		done
		printf -v junk "%02X%s%02X" "${pitWl}" "$junk" "${pitWr}"
		PIT[$i]="$junk"
	done

	# clear all the tetrominoes
	tet0=("${tetB[@]}")  # in play
	tet1=("${tetB[@]}")  # next in play
	tet2=("${tetB[@]}")
	tet3=("${tetB[@]}")
	tet4=("${tetB[@]}")  # shoulder

	# start position for new tets
	tetStY=0
	tetStX=3
	tetStR=0

	# pick a starting shoulder piece
	# be kind, always give a T or an I :)
	RND
	[[ $((RNDn &1)) -eq 0 ]]  &&  tet4=(${tetT[@]})  ||  tet4=(${tetI[@]})

	# zero the piece counters
#	for i in L J S Z T O I ; do
	for ((i = 0;  i < ${#tetName};  i++)); do
		eval tet${tetName:$i:1}[8]=0
	done

	# initialise score
	score=0
	scoreMul=1     # multiplier
	scoreMulMax=1  # maximum multiplier achieved
	scoreLin=0     # lines
	scoreLast=0    # last line
	scoreBest=0    # best line

	[[ -z "$CLEVEL" ]]  &&  scoreLvl=$LEVEL  ||  scoreLvl=$CLEVEL

	# combo counters
	tetGold=0
	tetSilv=0

	# status bar
	statusClear
}

#+=============================================================================
# Grab tet #1 from the basket (to the pit tet #0)
# Generate a new tet for the bottom of the basket
#
tetAdd() {  # (0|1:displayStats)
	local i

	# Start new piece at the top
	tetY=$tetStY
	tetX=$tetStX
	rot=$tetStR

	# shuffle everything up one
	tet0=(${tet1[@]})
	tet1=(${tet2[@]})
	tet2=(${tet3[@]})

	# create a new tet
	if [[ ! -z "$scoreDrp"  &&  $scoreDrp -le 3 ]]; then
		tet3=(${tetB[@]})
	else
		while : ; do
			RND  # 0..7
			[[ $RNDn -eq 0 ]]  &&  continue  # 1..7

			i=${tetName:$RNDn:1}
			eval tet3=('$'{tet$i[@]})

			# new tet must not match:
			#   tet0: tet in play
			#   tet1: tet next in play
			# although this biases the distribution, it makes the game "feel" better
			[[ "${tet3[10]}" != "${tet0[10]}" && "${tet3[10]}" != "${tet1[10]}" ]]  &&  break
		done
	fi

	# Add new/pit tet to the stats
	i=${tet0[10]}
	eval tmp='$'{tet$i[8]}
	((tmp++))
	eval tet$i[8]='$'{tmp}

	[[ "$1" == "1" ]]  &&  pfShowMtet

	if [[ ! -z "$scoreDrp" ]]; then
		if [[ $scoreDrp -eq 0 ]]; then
			RUN=3  # out of pieces
		else
			[[ "${tet0[10]}" != "B" ]]  &&  ((scoreDrp--))
			pfShowScore
		fi
	fi

	# check death
	if ((RUN != 3)); then
		tetCollide $tetY $tetX ${tet0[$rot]}
		[[ $? -ne 0 ]]  &&  RUN=2  # death
	fi

	# Clear piece settings
	tetVal=1
	tetSwap=0

	keyFlush
}

#+=============================================================================
# Put the piece in the playfield
#
tetPlace() {
	local h  w
	local cnt=0
	for ((h = 0;  h < tetH;  h++)); do
		local y=$((tetY +h))
		for ((w = 0;  w < tetW;  w++)); do
			local x=$((tetX +w +1))
			local z=$((tetW*h +w))
			local ch=${tet0[$rot]:$((z *2)):2}
			local chv=$((0x${ch}))
			if [[ "$chv" != "$tetiB" ]]; then
				PIT[$y]="${PIT[$y]:0:$((x *2))}"${ch}"${PIT[$y]:$((x*2 +2))}"
				[[ $((++cnt)) -eq 4 ]]  &&  break 2
			fi
		done
	done

	tetCheckComboAll
	tetCheckLines
}

#+============================================================================= ========================================
# Swap active-tet with shoulder-tet
#
tetSwap() {
	# undraw both
	tetUndraw
	tetUndrawSh

	# swap them over
	local tmp=("${tet4[@]}")
	tet4=("${tet0[@]}")
	tet0=("${tmp[@]}")

	# position the new piece at the top
	tetY=$tetStY
	tetX=$tetStX
	rot=$tetStR

	# draw them back in
	tetDraw
	tetDrawSh

	tetVal=1   # reset tet-value (score)
	tetSwap=1  # can only do this once per drop (except debug mode)
}

#+=============================================================================
# return:  1=Collision. 0=Not-Collision
#
tetCollide() {  # (y, x, tet[rot])
	local h  y  w  x  z

	for ((h = 0;  h < tetH;  h++)); do
		y=$(($1 +h))
		for ((w = 0;  w < tetW;  w++)); do
			x=$(($2 +w +1))
			z=$((h*tetW +w))
			[[ ($((      0x${3:$((z *2)):2})) != $tetiB) &&
			   ($((0x${PIT[$y]:$((x *2)):2})) != $tetiB) ]] && return 1
		done
	done
	return 0
}

#+=============================================================================
# ((speed = 1000 - $scoreLvl*46))
#
#         Auto-drop time
# Factor  Lvl-0 .. Lvl-20
#   45  : 1.000    0.100
#   46  : 1.000    0.080
#   47  : 1.000    0.060
#
#------------------------------------------------------------------------------
#
#	Drop Rate = (((100000 /((Speed +2) *5)) +5) /10) milliseconds
#		,----------------------------------.
#		| Level | Speed | Rate | lines/sec |
#		|=======|=======|======|===========|
#		|    0  |    0  | 1000 |    1      |
#		|    1  |    1  |  667 |    1.5    |
#		|    2  |    2  |  500 |    2      |
#		|    3  |    3  |  400 |    2.5    |
#		|    4  |    4  |  333 |    3      |
#		|    5  |    5  |  286 |    3.5    |
#		|    6  |    6  |  250 |    4      |
#		|    7  |    7  |  222 |    4.5    |
#		|    8  |    8  |  200 |    5      |
#		|    9  |    9  |  181 |    5.5    |
#		|   10  |   10  |  167 |    6      |
#		|   11  |   11  |  153 |    6.5    |
#		|   12  |   12  |  143 |    7      |
#		|   13  |   13  |  133 |    7.5    |
#		|   14  |   14  |  125 |    8      |
#		|   15  |   15  |  118 |    8.5    |
#		|   16  |   16  |  111 |    9      |
#		|   17  |   17  |  102 |    9.5    |
#		|   18  |   18  |  100 |   10      |
#		|       |       |      |           |
#		|   19  |   20  |   91 |   11      |
#		|   20  |   22  |   84 |   12      |
#		`----------------------------------'
#		local spd
#		case $scoreLvl in
#			19 )  spd=$((scoreLvl +1)) ;;
#			20 )  spd=$((scoreLvl +2)) ;;
#			*  )  spd=$scoreLvl        ;;
#		esac
#		#                v-----------------vvvvvvv-------round off
#		speed=$(( ((100000 /((spd +2) *5)) +5) /10 ))
#		#               ^---^^^^^^^^^^^^^^-------------------speed
#
tetSpeedSet() {
	# after MUCH *MUCH* playing - I'm back where I started <shrug>
	((speed = 1000 - $scoreLvl*46))
}

#+============================================================================= ========================================
# https://harddrop.com/wiki/Tetris_(Game_Boy)
#
gameboyRateCalc() {
	GBHZ=59.73
	FR=(53 49 45 41 37 33 28 22 17 11 10 9  8  7  6  6  5  5  4  4  3)
	FUDGE=1
	#rate=(887 820 753 686 619 552 469 368 285 184 167 151 134 117 100 100 84 84 67 67 50)
	
#	FR=(53 49 45 41 37 33 28 22 17 12 11 10 9  8  7  7  6  6  5  5  4)
#	FUDGE=1.127
	#rate=(1000 925 849 774 698 623 528 415 321 226 208 189 170 151 132 132 113 113 94 94 75)

#	#     rate=( 887 820 753 686 619  552 469 368 285 184  167 151 134 117 100  100  84  84  67  67  50)  # gb
#	#     rate=(1000 925 849 774 698  623 528 415 321 226  208 189 170 151 132  132 113 113  94  94  75)  # bc
#	local rate=(1000 950 900 850 800  750 700 650 600 550  500 420 380 340 300  250 210 170 130 105  80)  # magic!
#	speed=${rate[$scoreLvl]}
	
	arr="rate=("
	for ((i = 0 ;  i < ${#FR[@]};  i++)); do
		rate=$(bc <<< "scale=3; ((1000/${GBHZ}) *${FR[$i]}  *${FUDGE}) +0.5")
		rate=${rate%.*}
		echo $i: $rate
		arr="${arr}${rate} "
	done
	arr="${arr::-1})"
	echo $arr
}

#+============================================================================= ========================================
# Update the score & score stats
#
tetScoreAdd() {
	((scoreLast = tetVal *scoreMul))
	[[ $scoreLast -gt $scoreBest ]]  &&  scoreBest=$scoreLast
	((score += scoreLast))
}

#+============================================================================= ========================================
# Score this tetromino
#
tetScore() {  # (cnt, silver, gold)
	local i  j

	local cnt=$1
	local silv=$2
	local gold=$3

	# Basic score
	if [[ $cnt -eq 0 ]]; then
		tetScoreAdd
		scoreMul=1
		pfShowScore  # update scoreboard
		return
	fi

	((scoreLin += $cnt))  # tally lines

	# score ... lines*10; or lines*20 for a tetris
	[[ $cnt -ne 4 ]]  &&  ((tetVal += cnt *10))  ||  ((tetVal += cnt *15))

	# Check if board is cleared
	j=1
	for ((i = 0; i < $((PITh -1)); i++)); do  # -1 to avoid the pit floor
		[[ "${PIT[$i]}" == "$EMPTY" ]]  &&  ((j++))
	done
	if [[ j -eq $PITh ]]; then
		# an extra 100 points (pre-multiplier) for clearing :)
		statusSet "${txtPerfect// /} +100"
		((tetVal += 100))
		tetPerfect  # animation
	fi

	# +5 for each silver slice, +10 for each gold slice ...(slice = cubes/4)
	((tetval += (silv /4 *5) + (gold /4 *10)))

	tetScoreAdd  # update score - does multiplier

	((scoreMul++))  # enhance multiplier for next piece
	[[ ${scoreMul} -gt ${scoreMulMax} ]]  &&  scoreMulMax=${scoreMul}

	if [[ $scoreLvl -ne 20 ]]; then    # already at full speed
		local tmp=$scoreLvl
		if [[ -z "$CLEVEL" ]]; then
			((scoreLvl = scoreLin/LPL +LEVEL))  # calculate level
		else
			((scoreLvl = scoreLin/LPL +CLEVEL))  # calculate level
		fi
		if [[ $tmp -ne $scoreLvl ]]; then
			statusSet "Level Up!"
			sound levelup
		fi
		tetSpeedSet
	fi

	pfShowScore  # update scoreboard

	# all the animations may result in buffered keystrokes...
	keyFlush
}

#+============================================================================= ========================================
tetFragFrom() {
	local old  new
	local y=$1
	local x=$2
	local d=$3  # direction to parent

	old=$((0x${PIT[$y]:$((x*2 +2)):2}))

	[[ $((old &maskT)) -eq $tetiW    ]]  &&  return  # wall
	[[ $((old &maskC)) -eq $maskLDUR ]]  &&  return  # fragment
	[[ $((old &maskC)) -eq $maskB    ]]  &&  return  # blank

	printf -v new "%02X" $((old | maskLDUR))  # new piece (fragment)
	PIT[$y]="${PIT[$y]:0:$((x*2 +2))}"$new"${PIT[$y]:$((x*2 +4))}"

	# recurse
	[[ "$d" != "up"     &&  $((old &maskU)) -eq $maskU ]]  &&  tetFragFrom $((y -1))  $x         down
	[[ "$d" != "down"   &&  $((old &maskD)) -eq $maskD ]]  &&  tetFragFrom $((y +1))  $x         up
	[[ "$d" != "left"   &&  $((old &maskL)) -eq $maskL ]]  &&  tetFragFrom $y         $(($x -1)) right
	[[ "$d" != "right"  &&  $((old &maskR)) -eq $maskR ]]  &&  tetFragFrom $y         $(($x +1)) left
}

#+============================================================================= ========================================
tetFragDoit() {
	local x  old  new
	local y=$1

	for ((x = 0;  x < PITw;  x++)); do
		old=$((0x${PIT[$y]:$((x*2 +2)):2}))  # old piece
		printf -v new "%02X" $((old | maskLDUR))  # new piece (fragment)
		PIT[$y]="${PIT[$y]:0:$((x*2 +2))}"$new"${PIT[$y]:$((x*2 +4))}"

		[[ $((old &maskC)) -eq $maskLDUR ]]  &&  continue
		[[ $((old &maskU)) -eq $maskU    ]]  &&  tetFragFrom $((y -1))  $x  down
		[[ $((old &maskD)) -eq $maskD    ]]  &&  tetFragFrom $((y +1))  $x  up
	done
}


#+============================================================================= ========================================
# Check for complete lines
#
tetCheckLines() {
	local y  x  h  i  l  cnt  slv  gld
	local lines=()
	local silv=0
	local gold=0

	for ((h = tetH;  h > 0;  h--)); do
		slv=0  # line tally = 0
		gld=0  # ...

		((y = tetY +h -1))
		[[ $y -ge $((PITh -1)) ]]  &&  continue  # out of the pit

		for ((x = 1;  x <= PITw;  x++)); do
			case $((0x${PIT[$y]:$((x *2)):2} &maskT)) in
				$tetiB )  continue 2 ;;  # incomplete line ...next!
				$tetiV )  ((slv++))  ;;
				$tetiG )  ((gld++))  ;;
			esac
		done

		lines+=("$y")    # array of complete lines
		((silv += slv))  # add tally to cube count
		((gold += gld))  # ...
	done

	cnt=${#lines[@]}
	if [[ $cnt -ne 0 ]]; then
		tetFlashLines $cnt ${lines[@]}

		# edit the pit
		for ((i = 0;  i < $cnt;  i++)); do
			local l=$((${lines[$i]} +i))  # +i as lines will be disappearing

			tetFragDoit $l

			for ((y = l;  y > 0;  y--)); do
				PIT[$y]="${PIT[$((y -1))]}"
			done
		done

		tetDrawPit

		tetCheckComboAll
	fi

	tetScore $cnt $silv $gold  # ALWAYS called (for multiplier calculation)
}

#+=============================================================================
tetMakeCombo() {
	local cblk=()
		cblk+=("0109090C") # >--.
		cblk+=("0509090A") # ,--'
		cblk+=("0309090C") # '--.
		cblk+=("0109090A") # >--'

	local y=$1
	local x=$2
	local t=$3

	local h  w
	for (( h = 0;  h < 4;  h++)); do
		for (( w = 0;  w < 4;  w++)); do
			local yy=$((y +h))
			local xx=$(($((x +w))*2 +2))
			local cv=$(($((0x${cblk[$h]:$((w *2)):2})) |$t))
			printf -v ch "%02X" $cv
			PIT[$yy]="${PIT[$yy]:0:$xx}"$ch"${PIT[$yy]:$((xx +2))}"
		done
	done
}

#+============================================================================= ========================================
# Check for combo blocks
#
tetCheckCombo() {
	local v  t  c  g

	local y=$1
	local x=$2

	v=$((0x${PIT[$y]:$((x*2 +2)):2}))                                # note type of
	((g = v &maskT))                                                 # first piece
	for ((h = 0;  h < 4;  h++)); do
		for ((w = 0;  w < 4;  w++)); do
			v=$((0x${PIT[$((y +h))]:$(($((x +w))*2 +2)):2}))  # I'm getting good at this :)
			((t = v &maskT))                                         # tet type
			[[ $t -ge ${tetiB} ]]  &&  return 0                      # blank/combo
			[[ $t -ne $g ]]  &&  g=0                                 # different from first? -> gold=0
			((c = v &maskC))                                         # tet map
			[[ $c -eq $maskB  ||  $c -eq $maskLDUR ]]  &&  return 0  # blank/fragment
			[[ $h -eq 0  &&  $((c &maskU)) -gt 0 ]]    &&  return 0  # out of up
			[[ $w -eq 0  &&  $((c &maskL)) -gt 0 ]]    &&  return 0  # out of left
			[[ $w -eq 3  &&  $((c &maskR)) -gt 0 ]]    &&  return 0  # out of right
			[[ $h -eq 3  &&  $((c &maskD)) -gt 0 ]]    &&  return 0  # out of down
		done
	done
	[[ $g -eq 0 ]]  &&  return 1  ||  return 2  # 1=silver, 2=gold
}


#+=============================================================================
tetCheckComboAll() {
	local x  y  rv
	local cntV=0
	local cntG=0

	# this checks the entire board every time
	# would be nice to only check what we need :-/
	for ((y = 2;  y < $((PITh -4)); y++)); do
		for ((x = 0;  x < $((PITw -3)); x++)); do
			tetCheckCombo $y $x
			rv=$?
			case $rv in
				1)	sound comboS
					statusSet "${BWHT}SILVER${atOFF} COMBO!"
					tetFlashCombo $y $x &
					tetMakeCombo $y $x "${tetiV}"
					((tetSilv++))
					((cntV++))
					((tetVal += 16))
					;;
				2)	sound comboG
					statusSet "${YEL}*GOLD*${atOFF} COMBO!"
					tetFlashCombo $y $x &
					tetMakeCombo $y $x "${tetiG}"
					((tetGold++))
					((cntG++))
					((tetVal += 32))
					;;
			esac
		done
	done

	if [[ $((cntV +cntG)) -gt 1 ]]; then
		statusSet "${YEL}**${BWHT}D${BMAG}O${BGRN}U${BCYN}B${BMAG}L${BWHT}E${YEL}**${atOFF} COMBO!"
		pfShowScore
	fi
	wait

	tetDrawPit
	pfShowMtet
}

#+=============================================================================
# Timestamp last drop, and next drop
#
tetSpeedStamp() {
	timeGet speedLast
	((speedNext = speedLast +speed))
}

#+=============================================================================
# on exit RUN=0 : quit,  RUN=2 : died
tetPlay() {
	start

	[[ "$USEED" == "X" ]]  &&  SEED=$RANDOM  ||  SEED=$USEED
	statusSet "Round $SEED: Fight!"
	RND seed $((SEED +LEVEL))

	tetNew  # creates shoulder piece
	pfDrawLevel new
	pfShowScore
	tetDrawPit

	if [[ $LEVEL -lt 3  &&  $DEBUG -eq 0  &&  $STYLE == NORM ]]; then
		introduce
	else
		tetDrawSh  # draw shoulder piece - added in tetNew
		tetAdd 0   # 0 = do NOT update stats
		tetAdd 0   # 0 = do NOT update stats
		tetAdd 0   # 0 = do NOT update stats
		tetAdd 1   # 0 = do NOT update stats
		tetDrawBs  # redraw basket tets
		tetDraw
	fi

	tetSpeedSet
	tetSpeedStamp

	timeStart

	#----------------------------------------------------------
	# Main game loop
	#
	FREEZE=0  # debug mode can freeze autodrop
	RUN=1
	adj=0     # post-drop piece adjustment
	while [[ $RUN -eq 1 ]]; do
		local act   # 0/1 : action occurred
		local auto  # 0/1 : autodrop fired

		timeShow
		timeGet speedNow
		if [[ $speedNow -ge $speedNext ]]; then
			if ((FREEZE)); then
				KEY=
			else
				# auto drop
				KEY=DOWN
				auto=1
			fi
			tetSpeedStamp
		else
			# get keystroke
			keyGet
			auto=0
		fi

		act=0
		if [[ ! -z "$KEY" ]]; then
			local tety=$tetY  # these will become the target position
			local tetx=$tetX  # ..
			local trot=$rot   # ..

			#------------------------------
			# DEBUG KEYS
			#
			(($DEBUG))  &&  case ${KEY^^} in
				"DEL" | [Q] )  tetSwap ;;  # shoulder swap

				6 | "^" ) # move piece UP!!
					act=1
					tety=$(($tetY -1))
					tetSpeedStamp
					;;

				0 ) # (un)Freeze auto-drop
					(($FREEZE))  &&  FREEZE=0  ||  FREEZE=1
					;;

				"INS" ) # place the piece where it is
					tetPlace
					tetDrawPit
					tetAdd 1 ; tetDrawBs ; tetDraw
					tetSpeedStamp
					;;

				"END" ) # discard tetromino
					tetUndraw
					tetAdd 1 ; tetDrawBs ; tetDraw
					tetSpeedStamp
					;;

				"PGUP" ) # advance 1 level (score '10' lines)
					tetUndraw
					tetScore $LPL 0 0
					tetAdd 1 ; tetDrawBs ; tetDraw
					tetSpeedStamp
					;;

				"F5" ) # toggle invisible/normal
					if [[ "$STYLE" == "NVIS" ]]; then
						STYLE="NORM"
						tetDrawPit
					else
						STYLE="NVIS"
						pfDrawPit
					fi
					tetDraw
					;;

				"F6" ) # toggle normal/grid draw
					((NDRAW = ! NDRAW))
					[[ "$STYLE" != "NVIS" ]]  &&  tetDrawPit
					tetDraw
					;;

				"F12" )
					pfHideGame
					rigGame
					csDrawBackdropReveal 0
					pfDrawAll 1
					tetDrawSh
					tetDrawBs
					tetDrawPit
					;;

			esac

			case "${KEY^^}" in
				"LEFT"  | [A] )  act=1 ; ((tetx--)) ;;
				"RIGHT" | [D] )  act=1 ; ((tetx++)) ;;

				[Z,] )  act=1 ; trot=$(((rot +3) %4)) ;; # rot left
				[X.] )  act=1 ; trot=$(((rot +1) %4)) ;; # rot right

				"DEL" | [Q] )  [[ $tetSwap -eq 0 ]]  &&  tetSwap ;;  # shoulder swap

				[P] )
					Pause
					;;

				"F1" | "?" | "F2" )
					pfHideGame
					[[ "${KEY}" == "F2" ]]  &&  helpCombo  ||  helpCtrl
					csDrawBackdropReveal 0
					pfDrawAll 1
					Pause
					;;

				"DOWN" | [S] )
					act=1
					((tety++))
#					tetSpeedStamp  # restart drop timer- the gameboy does NOT do this!
					[[ $auto -eq 0 ]]  &&  ((tetVal += 1))  # speed bonus
					KEY=DOWN # known name
					;;

				"UP" | [W] )  # drop
					KEY="DOWN"  # stop shadow redraw
					for ((y = tetY;  y < shadY;  y++)); do
						tetUndraw
						((tetY++))
						((tetVal++))
						tetDraw
					done
					if ((DEBUG && FREEZE)); then  # trigger a placement
						tetx=$tetX
						trot=$rot
						tety=$((tetY +1))
						act=1
						KEY="DOWN"
					else
						((! adj)) && {
							timeGet now     # allow lateral movement after drop
							((speedNext = now +speed/8))  # ...
							adj=1
						}
					fi
					;;

				"\`" )
					pfDrawAll 1
					tetDraw
					tetDrawSh
					tetDrawBs
					tetDrawPit
					;;

				"BKSP" )
					pfHideGame
					statusSet "${txtQuitChk}"
					local timeSt  timeNd
					timeGet timeSt
					while : ; do
						keyGet
						case ${KEY^^} in
							[${txtKeyYes}] )
								RUN=0
								break ;;
							[${txtKeyNo}P] )
								pfUnhideGame
								break ;;
						esac
						sleep .05
					done
					statusClear
					timeGet timeNd
					((timePause += timeNd -timeSt))
					;;

				* ) ;;
			esac
		fi

		# Collision detection
		(($act)) && {
			tetCollide  $tety $tetx ${tet0[$trot]}
			rv=$?
			if ! (($rv)) ; then  # No collision
				tetUndraw
				tetX=$tetx
				tetY=$tety
				rot=$trot
				tetDraw
			else  # collision
#				if [[ "$KEY" == "DOWN" ]]; then  # player can place
				if [[ $auto -eq 1  ||  "$KEY" == "DOWN" ]]; then  # place only on auto-drop
					tetPlace
					tetAdd 1
					if [[ $RUN -ne 3 ]]; then
						tetDrawBs
						tetDraw
						tetSpeedStamp
						adj=0
					fi
				fi
			fi
		}

		statusUpdate

	done  # while(run)
}
# -MAKE:g_logic.s
# +MAKE:pf.s - playfield maintenance
#!/bin/bash

#------------------------------------------------------------------------------ ----------------------------------------
clrPitV="${atPFX}${fgWHT};${bgBLU}${atSFX}"                        # main pit box (vert)
clrPitH="${BLU}"                                                   # main pit box (horz)
clrPitB="${BLK}"                                                   # main pit box (body)

clrSH="${BBLU}"                                                    # shoulder box
clrSHjoin="${BBLU}"                                                # join shoulder to pit

clrBS="${BBLU}"                                                    # basket box
clrBSjoin="${BBLU}"                                                # join basket to pit

clrMT="${WHT}"                                                     # mini-tet box
clrMTscore="${BWHT}"                                               # ...

clrSCbox="${WHT}"                                                  # score box

clrSCOREbg="${bgBLU}"                                              # Score
clrSCOREh="${atPFX}${fgBWHT};${clrSCOREbg}${atSFX}"                # ..heading
clrSCOREv="${atPFX}${fgBLK};${bgWHT}${atSFX}"                      # ..value

clrMULTbg="${bgMAG}"                                               # Multiplier
clrMULTh="${atPFX}${fgBWHT};${clrMULTbg}${atSFX}"                  # ..heading
clrMULTv="${clrSCOREv}"                                            # ..value

clrLINESbg="${bgRED}"                                              # Lines
clrLINESh="${atPFX}${fgBWHT};${clrLINESbg}${atSFX}"                # ..heading
clrLINESv="${clrSCOREv}"                                           # ..value

clrLVLbg="${bgMAG}"                                                # Level
clrLVLh="${atPFX}${fgBWHT};${clrLVLbg}${atSFX}"                    # ..heading
clrLVLv="${clrSCOREv}"                                             # ..value

clrLASTbg="${bgRED}"                                               # Last tet
clrLASTh="${atPFX}${fgBWHT};${clrLASTbg}${atSFX}"                  # ..heading
clrLASTv="${clrSCOREv}"                                            # ..value

clrBESTbg="${bgGRN}"                                               # best tet
clrBESTh="${atPFX}${fgBWHT};${clrBESTbg}${atSFX}"                  # ..heading
clrBESTv="${clrSCOREv}"                                            # ..value

clrScoreMult="${atPFX}${clrSCOREbg};$((clrMULTbg -10))${atSFX}"    # div: score-mult
clrMultLast="${atPFX}${clrMULTbg};$((clrLASTbg -10))${atSFX}"      # div: mult-last
clrLastBest="${atPFX}${clrLASTbg};$((clrBESTbg -10))${atSFX}"      # div: last-best
clrBestEnd="${atPFX}${fgBLK};${clrBESTbg}${atSFX}"                 # div: best-none

clrEndLines="${atPFX}${bgBLK};$((clrLINESbg -10))${atSFX}"         # div: start-lines
clrLinesLvl="${atPFX}${clrLINESbg};$((clrLVLbg -10))${atSFX}"      # div: lines-level
clrLvlEnd="${atPFX}${fgBLK};${clrLVLbg}${atSFX}"                   # div: level-none

clrFgV="${fgWHT}"
clrFgG="${fgYEL}"

clrCBsilv="${atPFX}${atBLD};${clrFgV:2};${bgBLK}${atSFX}"          # ..silver
clrCBgold="${atPFX}${atBLD};${clrFgG:2};${bgBLK}${atSFX}"          # ..gold

clrCBbox="${BLU}"                                                  # combo box
clrCBsep="${atPFX}${fgBLU};${bgWHT}${atSFX}"                       # ..separator
clrCBv="${atPFX}${fgBLK};${bgWHT}${atSFX}"                         # ..value

#+============================================================================= ========================================
# Initialise most/all of the game logic
#
pfInit() {
	local i  s

	PITy=4
	PITx=20

	PITd=$((4*4 +2))          # depth of game pit (number of playable lines)
	PITw=$((0    +10   +0 ))  #             left, pit, right
	PITh=$((1 +1 +PITd +1 ))  # invisible, empty, pit, base

	PSy=5  # offset from PITy
	PSx=3  # offset from PITx
	PSw=15
	PSh=3

	SHh=6
	SHw=12
	SHy=$((PITy -1))
	SHx=$((PITx -SHw -3))

	SCh=9
	SCw=14
	SCy=$((SHy +SHh +2))
	SCx=$((SHx -1))

	TMy=25
	TMx=71

	BSh=13
	BSw=12
	BSy=$((PITy))
	BSx=$((PITx + PITw*2 +2 +3))

	LVLy=$((BSy +BSh))
	LVLx=$((BSx -1))
	LVLh=4
	LVLw=$((SCw))

	MTh=17
	MTw=12
	MTy=$((BSy      -1))
	MTx=$((BSx +BSw +5))

	CBy=$((MTy +MTh))
	CBx=$((MTx -1))

	PIT=()

	# build a blank line for the pit
	# 'EMPTY' is used by the tetPerfect()
	# ...the screen is kinda fixed now,
	#    but no point in binning good code where timing is irrelevant
	printf -v EMPTY "%02X" "${pitWl}"
	for ((i = 0;  i < PITw;  i++)); do
		printf -v EMPTY "%s%02X" "$EMPTY" "$tetiB"
	done
	printf -v EMPTY "%s%02X" "$EMPTY" "${pitWr}"

	# add all the empty rows ...not the base
	for ((i = 1; i < PITh; i++)); do
		PIT+=("$EMPTY")
	done

	# create and add a base to the pit
	printf -v s "%02X" "${pitWbl}"
	for ((i = 0;  i < PITw;  i++)); do
		printf -v s "%s%02X" "$s" "$pitWb"
	done
	printf -v s "%s%02X" "$s" "${pitWbr}"
	PIT+=("$s")
}

#+============================================================================= ========================================
pfDrawDebug() {
	(($DEBUG)) &&  PAT 2 $((PITx +1 +PITw -((${#txtDebugMode} +6)/2) )) "${clrCsSlogan} - ${txtDebugMode} - "
}

#+============================================================================= ========================================
pfDrawPit() {  # (slp)
	local y  x  off

	for ((y = $((${#PIT[@]} -1));  y >= 1;  y--)); do
		off=0
		for ((x = 0;  x < $((PITw +2));  x++)); do
			case "$((0x${PIT[$y]:$((x *2)):2}))" in
				"${pitWl}" | "${pitWr}" )
					PAT $((PITy +y -1)) $((PITx +off)) "${clrPitV}∙"
					((off++)) ;;
				"${pitWbl}" | "${pitWbr}" )
					PAT $((PITy +y -1)) $((PITx +off)) "${clrPitH}▀"
					((off++)) ;;
				"${pitWb}" )
					PAT $((PITy +y -1)) $((PITx +off)) "${clrPitH}▀▀"
					((off+=2)) ;;
				* )
					PAT $((PITy +y -1)) $((PITx +off)) "${clrPitB}  "
					((off+=2)) ;;
			esac
		done
		[[ ! -z $1 ]]  &&  sleep $1
	done
}

#+============================================================================= ========================================
# Draw shoulder
#
pfDrawShoulder() {  # (slp, hslp, [joints])
	local y  x

	local hslp=
	[[ ! -z $2 ]] && [[ "$1" != "0" ]]  &&  hslp=$2

	# join shoulder to pit
	for ((x = $((PITx -1));  x >= $((PITx -3));  x--)); do
		PAT ${PITy} ${x} "${clrSH}═\b\033[2B═"
		[ ! -z $hslp ]  &&  sleep $1
	done
	PAT ${PITy} ${x} "${clrSH}╠\b\033[2B╠"

	# right
	PAT $((SHy +2)) $((SHx +SHw -1)) "${clrSH}║\b\033[2B║"
	[[ ! -z $hslp ]]  &&  sleep $1

	PAT ${SHy} $((SHx +SHw -1)) "${clrSH}╗\b\033[$((SHh -1))B╝"
	[[ ! -z $hslp ]]  &&  sleep $1

	# top & bottom
	for ((x = $((SHx +SHw -2));  x >= $((SHx +1));  x--)); do
		PAT ${SHy} ${x} "${clrSH}═\b\033[$((SHh -1))B═"
		for ((y = $((SHy +1));  y < $((SHy +SHh -1));  y++)); do
			PAT ${y} ${x} "${atOFF} "
		done
		[[ ! -z $hslp ]]  &&  sleep $hslp
	done
	PAT ${SHy} ${x} "${clrSH}╔\b\033[$((SHh -1))B╚"

	[[ ! -z $3 ]] && {
		PAT $((SHy +SHh -1)) $((SHx      +2)) "${clrSH}╤"
		PAT $((SHy +SHh -1)) $((SHx +SHw -2)) "${clrSH}╤"
	}

	# left
	for ((y = 1;  y <= $(((SHh -1) /2));  y++)); do
		PAT $((SHy         +y)) ${SHx} "${clrSH}║"
		PAT $((SHy +SHh -1 -y)) ${SHx} "${clrSH}║"
		[[ ! -z $hslp ]]  &&  sleep $1
	done
}

#+============================================================================= ========================================
# Draw main scoreboard
#
pfDrawScore() {  # (slp)
	local x  ch  s

	# shoulder to score
	PAT $((SHy +SHh -1)) $((SHx      +2)) "${clrSH}╤"
	PAT $((SHy +SHh -1)) $((SHx +SHw -2)) "${clrSH}╤"
	[[ ! -z $1 ]]  &&  sleep $1

	PAT $((SHy +SHh   )) $((SHx      +2)) "${clrSH}⌡"
	PAT $((SHy +SHh   )) $((SHx +SHw -2)) "${clrSH}⌡"
	[[ ! -z $1 ]]  &&  sleep $1

	PAT $((SCy      -1)) $((SCx      +2)) "${clrSCbox}⌠"
	PAT $((SCy      -1)) $((SCx +SCw -4)) "${clrSCbox}⌠"
	[[ ! -z $1 ]]  &&  sleep $1

	PAT ${SCy}           $((SCx      +2)) "${clrSCbox}┴"
	PAT ${SCy}           $((SCx +SCw -4)) "${clrSCbox}┴"
	[[ ! -z $1 ]]  &&  sleep $1

	# score top
	for ((x = 0;  x < $(((SCw -6) /2));  x++)); do
		PAT ${SCy} $((SCx      +3 +x)) "${clrSCbox}─"
		PAT ${SCy} $((SCx +SCw -5 -x)) "${clrSCbox}─"
		[[ ! -z $1 ]]  &&  sleep $1
	done

	PAT ${SCy} $((SCx +SCw -3)) "${clrSCbox}─"
	[[ ! -z $1 ]]  &&  sleep $1

	PAT ${SCy} $((SCx      +1)) "${clrSCbox}─"
	PAT ${SCy} $((SCx +SCw -2)) "${clrSCbox}─"
	[[ ! -z $1 ]]  &&  sleep $1

	PAT ${SCy} $((SCx        )) "${clrSCbox}┌"
	PAT ${SCy} $((SCx +SCw -1)) "${clrSCbox}┐"
	[[ ! -z $1 ]]  &&  sleep $1

	# sides
	if ((FAST)); then
		s="\033[$((LVLw -2))C"
	else
		printf -v s "%*s" $((LVLw -2)) ""
	fi

	for ((y = 1;  y <= 7;  y++)); do
		if [[ $((y & 1)) -eq 1 ]]; then
			PAT $((SCy +y)) ${SCx} "${clrSCbox}│${s}│"
		else
			PAT $((SCy +y)) ${SCx} "${clrSCbox}├${s}┤"
		fi
		[[ ! -z $1 ]]  &&  sleep $1
	done
	PAT $((SCy +y)) ${SCx} "${clrSCbox}└${s}┘"

	# Score banners
	s=
	for ((i = 1;  i < $((SCw -1));  i++)) ; do  s="${s}▄"  ; done

	PAT $((SCy +1)) $((SCx +1)) "${clrSCOREh} ${txtScore}"
	[[ ! -z $1 ]]  &&  sleep $1

	PAT $((SCy +2)) $((SCx +1)) "${clrSCOREh} ${clrSCOREv}          ${clrSCOREh} "
	[[ ! -z $1 ]]  &&  sleep $1

	PAT $((SCy +3)) $((SCx +1)) "${clrScoreMult}${s}"
	[[ ! -z $1 ]]  &&  sleep $1

	PAT $((SCy +4)) $((SCx +1)) "${clrMULTh} ${txtMult} ${clrMULTv}    ${clrMULTh} "
	[[ ! -z $1 ]]  &&  sleep $1

	PAT $((SCy +5)) $((SCx +1)) "${clrMultLast}${s}"
	[[ ! -z $1 ]]  &&  sleep $1

	PAT $((SCy +6)) $((SCx +1)) "${clrLASTh} ${txtLast} ${clrLASTv}    ${clrLASTh} "
	[[ ! -z $1 ]]  &&  sleep $1

	PAT $((SCy +7)) $((SCx +1)) "${clrLastBest}${s}"
	[[ ! -z $1 ]]  &&  sleep $1

	PAT $((SCy +8)) $((SCx +1)) "${clrBESTh} ${txtBest} ${clrBESTv}    ${clrBESTh} "
	[[ ! -z $1 ]]  &&  sleep $1

	PAT $((SCy +9)) $((SCx +1)) "${clrBestEnd}${s}"
}

#+============================================================================= ========================================
# Draw shoulder - intro animation
#
pfDrawFromShoulder() {  # (slp, hslp)
	((CTRLC))  &&  trap "" INT
	pfDrawShoulder $1 $2
	pfDrawScore $1
}

#+============================================================================= ========================================
# Draw tet basket
#
pfDrawBasket() {  # (slp)
	local x  i  s

	# join shoulder to pit
	for ((i = 0;  i < 3;  i++)); do
		x=$((PITx + PITw*2 +2 +i))
		PAT ${PITy}       ${x} "${clrBSjoin}═"
		PAT $((PITy +5))  ${x} "${clrBSjoin}═"
		PAT $((PITy +11)) ${x} "${clrBSjoin}═"
		[ ! -z $1 ] && sleep $1
	done
	PAT $((BSy +BSh -2)) $((BSx -1)) "${clrBSjoin}╤"

	printf -v s "%*s" $((BSw -2)) ""
	for ((y = $BSy;  y <= $((BSy +BSh -2));  y++)); do
		PAT ${y} ${BSx} "${clrBS}█${atOFF}${s}${clrBS}█"
		[ ! -z $1 ] && sleep $1
	done

	s=
	for ((i = 0;  i <= $((BSw -1));  i++)) ; do  s="${s}▀"  ; done
	PAT $((BSy +BSh -1)) ${BSx} "${clrBS}${s}"
}

#+============================================================================= ========================================
# Draw lines/level box
#
pfDrawLevel() {  # (slp)
	local s  i  strA  strB  strS

	if [[ "$STYLE" == "CHAL" ]]; then
		strS="$txtJunk"
		strA="$txtPieces"
		strB="$txtSpeed"
	else
		strS="$txtLines"
		strA="$txtLines"
		strB="$txtLevel"
	fi

	if [[ "$1" == "start" ]]; then
		PAT $((LVLy +1)) $((LVLx +1)) "${clrLINESh} ${strS} ${clrLINESv}    ${clrLINESh} "
		PAT $((LVLy +3)) $((LVLx +1)) "${clrLVLh} ${strB} ${clrLVLv}    ${clrLVLh} "
		return
	fi

	if [[ "$1" == "new" ]]; then
		PAT $((LVLy +1)) $((LVLx +1)) "${clrLINESh} ${strA} ${clrLINESv}    ${clrLINESh} "
		PAT $((LVLy +3)) $((LVLx +1)) "${clrLVLh} ${strB} ${clrLVLv}    ${clrLVLh} "
		return
	fi

	# joinery
	PAT $((BSy +BSh -2)) $((BSx -1  )) "${clrBSjoin}╤"
	PAT $((BSy +BSh -2)) $((BSx +BSw)) "${clrBSjoin}╕"
	[[ ! -z $1 ]]  &&  sleep $1

	PAT $((BSy +BSh -1)) $((BSx -1  )) "${clrSCbox}│"
	PAT $((BSy +BSh -1)) $((BSx +BSw)) "${clrSCbox}│"
	[[ ! -z $1 ]]  &&  sleep $1

	# sides
	if ((FAST)); then
		s="\033[$((LVLw -2))C"
	else
		printf -v s "%*s" $((LVLw -2)) ""
	fi

	PAT $((LVLy   )) ${LVLx} "${clrSCbox}│${s}│"
	[[ ! -z $1 ]]  &&  sleep $1

	PAT $((LVLy +1)) ${LVLx} "${clrSCbox}├${s}┤"
	[[ ! -z $1 ]]  &&  sleep $1

	PAT $((LVLy +2)) ${LVLx} "${clrSCbox}│${s}│"
	[[ ! -z $1 ]]  &&  sleep $1

	PAT $((LVLy +3)) ${LVLx} "${clrSCbox}└${s}┘"
	[[ ! -z $1 ]]  &&  sleep $1

	# titles
	s=
	for ((i = 1;  i < $((LVLw -1));  i++)); do  s="${s}▄"  ; done

	PAT $((LVLy)) $((LVLx +1)) "${clrEndLines}${s}"
	[[ ! -z $1 ]]  &&  sleep $1

	PAT $((LVLy +1)) $((LVLx +1)) "${clrLINESh} ${strA} ${clrLINESv}    ${clrLINESh} "
	[[ ! -z $1 ]]  &&  sleep $1

	PAT $((LVLy +2)) $((LVLx +1)) "${clrLinesLvl}${s}"
	[[ ! -z $1 ]]  &&  sleep $1

	PAT $((LVLy +3)) $((LVLx +1)) "${clrLVLh} ${strB} ${clrLVLv}    ${clrLVLh} "
	[[ ! -z $1 ]]  &&  sleep $1

	PAT $((LVLy +4)) $((LVLx +1)) "${clrLvlEnd}${s}"
}

#+============================================================================= ========================================
# Draw mini-tet stats box
#
pfDrawMtets() {  # (slp)
	local y  s

	PAT $((MTy +MTh -1)) ${MTx} "${clrSCbox}└─┬──────┬─┘"
	for ((y = 2;  y < $MTh;  y++)); do
		if [[ $y -eq 3 ]]; then  s="╞==========╡"
		elif (($y & 1)); then    s="├----------┤"
		else
			local order="BIOTZSJL"
			eval tet=('$'{tet${order:$((y/2 -1)):1}[@]})
			local mtet="${tet[7]//./ }"
			s="│${tet[9]}${mtet}${clrSCbox}      │"
		fi
		PAT $((MTy +MTh -y)) ${MTx} "${clrSCbox}$s"
		[[ ! -z $1 ]]  &&  sleep $1
	done
	PAT ${MTy} ${MTx} "${clrSCbox}┌──────────┐"
}

#+============================================================================= ========================================
# Draw combo stats box
#
pfDrawCombo() {  # (slp, hslp)
	local x  y  ch

	local COMBO=()
		COMBO+=("▄▄▄█▄▄▄▄▄▄█▄▄▄▄█")
		COMBO+=("█SS▌xxx▐GG▌xxx▐I")
		COMBO+=("▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█")

	for ((x = 0;  x < ${#COMBO[1]};  x++)); do
		for ((y = 0;  y < ${#COMBO[@]};  y++)); do
			ch="${COMBO[$y]:$x:1}"
			case "$ch" in
				[█▄▀] ) PAT $((CBy +y)) $((CBx +x)) "${clrCBbox}$ch"  ;;
				[▌▐]  ) PAT $((CBy +y)) $((CBx +x)) "${clrCBsep}$ch"  ;;
				S     ) PAT $((CBy +y)) $((CBx +x)) "${clrCBsilv}▓"   ;;
				G     ) PAT $((CBy +y)) $((CBx +x)) "${clrCBgold}▓"   ;;
				x     ) PAT $((CBy +y)) $((CBx +x)) "${clrCBv} "      ;;
				I     ) PAT $((CBy +y)) $((CBx +x)) "${clrCBbox}▌"    ;;
			esac
		done
		[[ ! -z $1 ]]  &&  sleep $2
	done
}

#+============================================================================= ========================================
# Draw tet basket - intro anim
#
pfDrawFromBasket() {  # (slp, hslp)
	((CTRLC))  &&  trap "" INT
	pfDrawBasket $1
	pfDrawLevel  $1
	pfDrawCombo  $1 $2
	pfDrawMtets  $1
}

#+=============================================================================
pfDrawAll() {  # (0:slow/1:fast)
	local slp=
	local hslp=

	if ! (($1)); then
		slp=0.025
		hslp=0.0125  # $((slp /2))
	fi

	if [[ -z $slp ]]; then
		if [[ $1 -ne 2 ]]; then
			echo -en ${atOFF}
			CLS
			csDrawBackdrop
		fi
	else
		csDrawBackdropReveal
	fi

	pfDrawPit $slp

	pfDrawFromShoulder $slp $hslp &
	pfDrawFromBasket $slp $hslp &
	wait

	pfShowScore
	pfShowMtet
#	! (($1)) && TETdrawSh
}

#+=============================================================================
pfHideGame()
{
	local y  x

	# pit
	for ((y = 0;  y <= PITd;  y++)); do
		if [ $((y & 1)) -eq 1 ]; then
			for ((x = 0;  x < $(($PITw*2 -1));  x += 2)); do
				PAT $((PITy +y)) $((PITx +x +1)) "${GRY} ◘"
			done
		else
			for ((x = 0;  x < $((PITw*2 -1));  x += 2)); do
				PAT $((PITy +y)) $((PITx +x +1)) "${GRY}◘ "
			done
		fi
	done

	# basket
	for ((y = 0;  y < $((BSh -1));  y++)); do
		if [ $((y & 1)) -eq 1 ]; then
			for ((x = 0;  x < $((BSw -3));  x += 2)); do
				PAT $((BSy +y)) $((BSx +x +1)) "${GRY}◘ "
			done
		else
			for ((x = 0;  x < $((BSw -3));  x += 2)); do
				PAT $((BSy +y)) $((BSx +x +1)) "${GRY} ◘"
			done
		fi
	done

	# shoulder
	for ((y = 1;  y < $((SHh -1));  y++)); do
		if [ $((y & 1)) -eq 1 ]; then
			for ((x = 0;  x < $((SHw -3));  x += 2)); do
				PAT $((SHy +y)) $((SHx +x +1)) "${GRY} ◘"
			done
		else
			for ((x = 0;  x < $((SHw -3));  x += 2)); do
				PAT $((SHy +y)) $((SHx +x +1)) "${GRY}◘ "
			done
		fi
	done
}

#+=============================================================================
pfUnhideGame()
{
	tetDrawPit &
	pfDrawBasket &
	pfDrawShoulder 0 0 j &
	wait
	tetDrawBs
	tetDrawSh
}

#+============================================================================= ========================================
# Update mini-tet stats board
#
pfShowMtet() {
	local i  ch  tet

	local tot=0
	local y=0
	for i in L J S Z T O I ; do
		eval tet=('$'{tet$i[@]})
		printf -v ch "%3d" ${tet[8]}
		PAT $((MTy +1 + y*2))  $((MTx +7)) "${tet[4]}${ch}"  # colour (main, not mtet - for text)
		((tot += ${tet[8]}))
		((y += 1))
	done

	printf -v ch "%5d" $tot
	PAT $((MTy +1 + y*2))  $((MTx +5)) "${clrMTscore}${ch}"

	# silver counter
	printf -v ch "%3d" $tetSilv
	PAT $((CBy +1)) $((CBx +4)) "${atPFX}${fgBLK};${bgWHT}${atSFX}${ch}"

	# gold counter
	printf -v ch "%3d" $tetGold
	PAT $((CBy +1))  $((CBx +11)) "${atPFX}${fgBLK};${bgWHT}${atSFX}${ch}"
}

#+=============================================================================
# Update the scoreboard
#
pfShowScore() {
	local ch

	printf -v ch "%'10d" $score
	PAT $((SCy +2)) $((SCx +2)) "${clrSCOREv}${ch}"

	printf -v ch "%3d" $scoreMul
	PAT $((SCy +4)) $((SCx +8)) "${clrMULTv}x${ch}"

	printf -v ch "%4d" $scoreLast
	PAT $((SCy +6)) $((SCx +8)) "${clrLASTv}${ch}"

	printf -v ch "%4d" $scoreBest
	PAT $((SCy +8)) $((SCx +8)) "${clrBESTv}${ch}"

	if [[ -z "$scoreDrp"  ||  "$1" == "start" ]]; then
		printf -v ch "%4d" $scoreLin
	else
		printf -v ch "%4d" $scoreDrp
	fi
	PAT $((LVLy +1)) $((LVLx +8)) "${clrLINESv}${ch}"

	printf -v ch "%4d" $scoreLvl
	PAT $((LVLy +3)) $((LVLx +8)) "${clrLVLv}${ch}"
}

#+=============================================================================
pfBsHide(){
	local x
	for ((x = 2;  x <= HIDE*4 +1;  x++)); do
		PAT $((BSy +BSh -x))  $((BSx +1))  "${BBLU}░░░░░░░░░░"  # ░ ▒ ▓ █
	done
}

#+=============================================================================
pfBrickout() {
	local y  x  l

	local clr="${GRY}"

	local pat0="█ ████ ████ ████ ███"
	local pat1="▄▄▄ ▄▄▄▄ ▄▄▄▄ ▄▄▄▄ ▄"
	local pat2="▀▀▀ ▀▀▀▀ ▀▀▀▀ ▀▀▀▀ ▀"

#	local pat0=" █    █    █    █   " # inverse (for "bright" mortar)
#	local pat1="▀▀▀█▀▀▀▀█▀▀▀▀█▀▀▀▀█▀"
#	local pat2="▄▄▄█▄▄▄▄█▄▄▄▄█▄▄▄▄█▄"

	for ((y = 18;  y >= 0;  y--)); do
		((l = y % 3))
		case $l in
			"0" )  PAT $((PITy +y)) $((PITx +1)) "${clr}${pat0::$((PITw *2))}" ;;
			"1" )  PAT $((PITy +y)) $((PITx +1)) "${clr}${pat1::$((PITw *2))}" ;;
			"2" )  PAT $((PITy +y)) $((PITx +1)) "${clr}${pat2::$((PITw *2))}" ;;
		esac

		if [[ $y -le 11 ]]; then
			case $l in
				"0" )  PAT $((BSy +y)) $((BSx +1)) "${clr}${pat0::$((BSw -2))}" ;;
				"1" )  PAT $((BSy +y)) $((BSx +1)) "${clr}${pat1::$((BSw -2))}" ;;
				"2" )  PAT $((BSy +y)) $((BSx +1)) "${clr}${pat2::$((BSw -2))}" ;;
			esac
		fi

		if [[ $y -le 3 ]]; then
			case $l in
				"0" )  PAT $((SHy +y +1)) $((SHx +1)) "${clr}${pat0::$((SHw -2))}" ;;
				"1" )  PAT $((SHy +y +1)) $((SHx +1)) "${clr}${pat1::$((SHw -2))}" ;;
				"2" )  PAT $((SHy +y +1)) $((SHx +1)) "${clr}${pat2::$((SHw -2))}" ;;
			esac
		fi
		[[ $l -ne 2 ]]  &&  sleep 0.12
	done
}

# -MAKE:pf.s
# +MAKE:main.s - start here
#!/bin/bash

dbgStart "${NAME}" ; DEBUG=1 ; DBG "START" # reset by parseCLI

ARGS="$@"
parseCLI $@
sysSetup
!((SKIP)) && Intro
pfInit
pfDrawAll $FAST
LEVEL=0

# Run the game
RUN=1
while ((RUN)); do
	tetPlay
	((RUN))  &&  gameover
done

quit 0
# -MAKE:main.s
: << 'EOF-tris.sh'
# +MAKE:tris.sh - : makefile
#!/bin/bash

: << 'EOX'
. npp_workspace  #: notepad++ project file
. README         #: readme
. MAKE.sh        #: build system
EOX

. BREAK.s        # UNbuild system
. ID.sh          # machine ID command

. ansi.s         # ansi sequences (colour, etc)
. prng.s         # PRNG (for piece selection)
. kbd.s          # keyboard driver
. time.s         # timer system
. status.s       # status line
. sys.s          # system functions
. debug.s        # debug API & debug monitor
. cs.s           # cyborg systems fancy shit
. quit.s         # quit screen
. cli.s          # cli parser
. lang.s	     # translation file
. help.s         # help screens
. gameover.dat   # gameover sprites
. gameover.s     # gameover process
. hiscore.dat    # hiscores - last (for consistency)
. hiscore.s      # high score system
. start.s	     # start menu
. pause.s        # pause screen
. rig.dat        # rig-game setups
. rig.s          # rig-game menu & system
. sound.s        # event sounds
. g_gfx.s        # game graphics
. g_logic.s      # game logic
. pf.s           # playfield maintenance
. main.s         # start here
# -MAKE:tris.sh
EOF-tris.sh
# +MAKE:hiscore.dat - hiscores - last (for consistency)
#!/bin/bash

# we'll just wrap this in a heredoc for sanity
: << 'EOT'

# People craving social approval are encouraged to edit the hi-score table by hand

# 0  : hs_${STYLE}~${LEVEL},             level
# 1  : ${hs}                             position
# 2  : ${name[0]}${name[1]}${name[2]},   initials
# 3  : ${score},                         final score
# 4  : ${scoreLin},                      lines made
# 5  : ${scoreMulMax},                   maximum multiplier
# 6  : ${scoreBest},                     best piece score
# 7  : ${timeTotal},                     game time (excluding pauses)
# 8  : ${SEED}                           game seed
# 9  : ${tetL[8]}                        L-tet count
# 10 : ${tetJ[8]}                        J-tet count
# 11 : ${tetS[8]}                        S-tet count
# 12 : ${tetZ[8]}                        Z-tet count
# 13 : ${tetT[8]}                        T-tet count
# 14 : ${tetO[8]}                        O-tet count
# 15 : ${tetI[8]}                        I-tet count
# 16 : ${tot}                            total tets
# 17 : ${tetSilv}                        silver combos
# 18 : ${tetGold}                        gold combos

hs_NORM~0,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~0,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~0,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~1,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~1,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~1,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~2,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~2,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~2,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~3,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~3,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~3,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~4,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~4,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~4,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~5,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~5,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~5,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~6,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~6,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~6,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~7,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~7,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~7,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~8,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~8,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~8,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~9,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~9,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~9,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~10,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~10,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~10,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~11,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~11,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~11,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~12,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~12,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~12,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~13,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~13,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~13,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~14,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~14,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~14,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~15,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~15,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~15,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~16,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~16,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~16,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~17,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~17,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~17,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~18,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~18,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~18,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~19,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~19,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~19,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~20,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~20,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NORM~20,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

hs_CHAL~0,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~0,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~0,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~1,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~1,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~1,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~2,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~2,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~2,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~3,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~3,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~3,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~4,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~4,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~4,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~5,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~5,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~5,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~6,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~6,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~6,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~7,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~7,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~7,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~8,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~8,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~8,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~9,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~9,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~9,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~10,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~10,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~10,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~11,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~11,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~11,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~12,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~12,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~12,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~13,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~13,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~13,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~14,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~14,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~14,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~15,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~15,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~15,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~16,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~16,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~16,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~17,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~17,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~17,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~18,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~18,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~18,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~19,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~19,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~19,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~20,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~20,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_CHAL~20,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

hs_NVIS~0,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~0,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~0,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~1,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~1,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~1,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~2,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~2,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~2,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~3,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~3,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~3,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~4,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~4,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~4,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~5,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~5,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~5,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~6,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~6,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~6,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~7,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~7,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~7,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~8,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~8,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~8,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~9,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~9,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~9,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~10,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~10,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~10,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~11,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~11,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~11,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~12,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~12,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~12,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~13,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~13,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~13,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~14,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~14,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~14,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~15,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~15,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~15,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~16,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~16,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~16,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~17,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~17,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~17,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~18,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~18,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~18,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~19,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~19,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~19,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~20,1,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~20,2,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
hs_NVIS~20,3,∙∙∙,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

EOT
# -MAKE:hiscore.dat
