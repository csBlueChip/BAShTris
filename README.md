# Why?

So it dawned on me: I've never written a Tetris clone and my BASh scripting could probably do with a work-out ...It's late 2020, so that'll give me something to do while pr0nhub restock... [add. What were the odds they would delete "millions of videos" a few weeks after my saying that? LOL!]

Well, it's reached version 1.0 <cue fireworks>
* Full Russian translation thanks to sbot
* Full Hi-Score game statistics table 
* ...with Export, Import and MERGE functionality 
* ...Keep your scores over an upgrade [Export/Import] 
* ...Share Hi-Score tables with a friend [Export/Merge]
* Game replay by supplying a seed (noted in the Hi-Score records)
* I've settled on a (slightly less generous) points system
* Challenge Mode - survive a set number of pieces amongst detritus
* Invisible Mode - like Classic Mode, but pieces become invisible when they land
* Lots of minor tweaks here and there
* Lots of fun "debug" options
* A major rewrite of the piece drawing code, "debug" "geometry mode" looks pretty cool (IMHO)
* Nicer code. It's still a first attempt at a new language, but it's fairly readable :/

# Support

You will need an 80x25 (24 + status line) terminal window which supports the UTF-8 character set.
* If the terminal window is the wrong size, the program will either (if too small) refuse to run, or (if too big) warn you that there may be rendering errors ...if it goes bad mid-game, press "backtick"/"grave accent" to force a redraw - and report the bug!

Obviously I cannot check the character set, so if it looks bad on your system, that is probably the source of the problem.
* The Windows Courier New "font" looks good ...if it doesn't try a slightly bigger or smaller pt size - font scaling errors are pretty obvious here!
* On Kali, I think Bitstream Vera Sans Mono looks pretty good, and make sure you set your Colour Scheme to "Linux" (or not, as you prefer).

It relies on a few core utils: 
* which, sed, grep, date, stty, tput

Using PuTTY for an SSH shell has worked quite reliably, but each native system has needed some tweaks:

OSX is the worst, as they cannot get infected with GPL3 (and continue to sign their OS), so they have to run an ancient version of BASh which lacks a whole bunch of stuff I originally used ...I've got it working to some degree, but I don't own a Mac, so all help appreciated. [At this point I have given up as I could not work out how to get a millisecond timer, esp. without a Mac]

The WSL (the Windows BASh thing) did a surprisingly good job. However it needed a different keyboard driver. It should auto-detect, but in case of emergencies:
* Use:  `bashtris.sh -k1`
* Again: Font choice can be the difference between "nice job" and "pass the bucket"

# Roadmap:
* Machine DIPs
* Network play
...Let's be real, unless this game takes off, or people bother to report bugs, this is probably the last release.

If you want to help port this, start a second terminal and run `bashtris.sh -m` to start a debug monitor; and run the game `bashtris.sh -d` to enable the DBG and DBGF commands ...then you can send text to the debug console whenever you like :)

You can also run `bashtris.sh -b` to break the program in to cohesive modules; `tris.sh` to run in this condition; and `MAKE.sh` to recombine it in to 'bashtris.sh' ...Additional notes in the full readme `bashtris.sh -H` (capital H)
