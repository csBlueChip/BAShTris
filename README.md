# Why?

So, after chatting with Gerbil one day, it dawned on me: I've never written a Tetris clone and my BASh scripting could probably do with a work-out ...It's late 2020, so that'll give me something to do while pr0nhub restock...

This is the point where I consider it to be "a playable game". The whole thing grew organically, and the code is an utter mess. But it works!

# Support

You will need an 80x25 (24 + status line) terminal window which supports the UTF-8 character set.
* If the terminal window is the wrong size, the program will either (if too small) refuse to run, or (if too big) warn you that there may well be rendering errors ...if it goes bad mid-game, press "backtick"/"grave accent" to force a redraw.

Obviously I cannot check the character set, so if it looks bad on your system, that is probably the source of the problem.
* The Windows Courier New "font" looks good ...if it doesn't try a slightly bigger or smaller pt size - font scaling errors are pretty obvious here!
* On Kali, I think Bitstream Vera Sans Mono looks pretty good, and make sure you set your Colour Scheme to "Linux" (or not, as you prefer).

It relies on a few gnutils: 
* which, sed, grep, date, stty, tput
* It did rely on `head`, but OSX put an end to that!

Using PuTTY for an SSH shell has worked quite reliably, but each native system has needed some tweaks:

OSX is the worst, as they cannot get infected with GPL3 (and continue to sign their OS), so they have to run an ancient version of BASh which lacks a whole bunch of stuff I originally used ...I've got it working to some degree, but I don't own a Mac, so all help appreciated.

The WSL (the Windows BASh thing) did a surprisingly good job. However it needed a different keyboard driver, so:
* Use:  `bashtris.sh -k1`
* Again: Font choice can be the difference between "nice job" and "pass the bucket"

# Roadmap:
* Review the scoring system
* Add other game modes {Challenge; Invisible, ...}
* De-uglify the code
* Implement machine DIPs
* Implement network play

If you want to help port this, start a second terminal and run `bashtris.sh -m` to start a debug monitor; and run the game `bashtris.sh -d` to enable the DBG and DBGF commands ...then you can send text to the debug console whenever you like :)
