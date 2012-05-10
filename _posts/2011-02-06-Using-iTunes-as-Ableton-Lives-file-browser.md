---
layout: default
title: How to use iTunes as Ableton Live's file browser
category: performance
tags: [ Ableton, iTunes ]
redirect: /2012/05/replacing-ableton-lives-browser-with.html
---

One of my biggest complaints with Ableton Live is the primitive and horrid
file browser. The lack of information shown and the inability to map
keys/MIDI messages to its functions make finding music a frustrating
experience. Although not many people are using Live exclusively for DJ'ing,
it is certainly a powerful tool for doing so, except for the fact that
searching for music is so difficult.

The other day I started considering using iTunes as the file browser within
Live. Fortunately, Live already supports dragging-and-dropping tracks
directly from iTunes into the session view, and iTunes has a few lesser-known
features which also would make it ideal for browsing while DJ'ing. Here I
will detail the steps which can be used to turn iTunes into a functional
music browser in Live, as well as the benefits and drawbacks of doing so.
This guide is written with the Mac in mind, and although it is probably
possible to accomplish this in Windows as well, I'm not sure if some of the
steps would work exactly the same for that platform.

The steps involved in setting up iTunes as a file browser are very easy and
non-committal. It is easy to go back to Live's file browser, particularly for
loops and samples which one may not want to store in iTunes. For loop and
sample management, tools like Snapper and Audio Finder are much better than
using iTunes or Live's built in browser. Although Live's file browser
searches ID3 metadata, it is not capable of displaying this metadata, or
allowing one to sort the browser by a metadata field (such as, say, the
artist name).

If you are using iTunes for your own music libraries, you may not necessarily
want to import all of your DJ tracks into it, particularly if you already
have organized them to your liking. If this is the case, first disable "Keep
iTunes Media folder organized" and "Copy files to iTunes Media folder when
adding to library". This will prevent iTunes from mangling your music or
renaming tracks which already have an associated asd file.


![iTunes Preferences as they (mostly) should appear](http://static.nikreiman.com/ableton_itunes_advanced_prefs.png)


Next, quit iTunes and restart it while holding down the "alt/option" key when
you re-open the program. iTunes will now prompt you to either create a new
library or to select an existing library. You will want to create a new
library somewhere on your hard drive. Now, take your existing music library
and move it to the folder you just created underneath iTunes Media/Music.
Drag all of these folders into iTunes to import them into the new library.
After importing, simply quit iTunes and re-open with the alt/option key to
switch back to your main iTunes libarary.


![Choose iTunes Library dialog](http://static.nikreiman.com/ableton_itunes_choose_library.png)


From this point, you may choose to take advantage of a special folder inside
of the iTunes library named "Automatically add to iTunes". Any tracks here
are, as the name suggests, automatically added to the iTunes library when
dropped in. However, they will be sorted under iTunes Media/Music/Artist
Name/Album Name, which may clash with any existing organizational scheme in
place. If you are planning on using this feature along with Live, add the
files first before warping them, or else iTunes will copy only the music file
and move the associated asd file behind in a directory named "Not Moved".

Software such as [Cadence][1] and [Tangerine!][2] are available to read your
iTunes library and analyze the BPM of your tracks. Other software such as
[beaTunes][3] (my personal favorite) are also capable of writing the key to
the track as well, which can be very useful in making cohesive mixes. In both
cases, these add-ons scan an iTunes library, thus making it practical to keep
multiple libraries.

Another little-known (or accidentally discovered) feature of iTunes is that
if you double-click on a playlist's icon, it will appear in a new window,
allowing you to customize the size of this window to better fit alongside
Live. [Here's a screenshot of how I am currently using Live and iTunes
together][4].


Advantages of using iTunes:
* Ability to view and sort music by fields like artist name, BPM, album, etc.
* One can create playlists for mixes, genres
* Album art and cover-flow are very nice for visually-oriented searching
* Smart playlists for recently added music, top-rated, etc.
* Can cue through separate sound interface
* Control of cue volume independent of Live's cue volume
* Third-party software allows for analyzing BPM and/or song key
* Non-binding -- one can still use Live without iTunes

Disadvantages of using iTunes:
* Cueing songs will not be at same tempo as current track (though Live also
  does not keep the tempos sync'd if you skip ahead in the song)
* Command+tabbing back and forth between iTunes & Live unless you have
  configured MIDI controls for everything you need to do
* iTunes is a well-known memory hog
* Less screen space for Live, as iTunes windows have a limit on how small
  they can be resized
* Recut tracks saved as livesets or liveclips still must be dragged these
  into the session from Live's file browser
* Fields such as "Last Played" will not save the date if you only cue part
  of the song and don't listen to it until the end. This is a bit of a
  bummer, since otherwise one could make smart playlists with recently played
  (or unplayed) tracks.
* iTunes automatically re-organizes new incoming tracks under its own file
  structure


[1]: http://cadenceapp.com/
[2]: http://www.potionfactory.com/tangerine/
[3]: http://www.beatunes.com/
[4]: http://static.nikreiman.com/ableton_live_itunes.png
