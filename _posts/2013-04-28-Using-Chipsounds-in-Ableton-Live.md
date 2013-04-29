---
layout: default
title: Using Chipsounds in Ableton Live
category: performance
tags: [ Ableton, Chipsounds ]
---

Introduction
------------

[Chipsounds][1] is an incredible softsynth plugin, offering emulation of 15
classic chips (including several variants of each one) and faithful
recreations of the hardware down to the bugs found in the original chips. I've
been using it in combination with Ableton Live for performing 8-bit remixes
at [Syntax Error clubnight in Stockholm][2].

Although using VST instruments uses more processing power than playing audio
files (even when warped with Complex Pro), the sound quality is unquestionably
better. Live's warping engine tends to take a lot of the "bite" out of 8-bit
and chiptunes music, especially the Complex & Complex Pro warping modes
introduce very audible artifacts due to the increased presence of raw PCM
sounds in this type of music.

For this reason, I set up a liveset which contains large amounts of MIDI files
for most classic games and several Chipsounds instances to play them. During
the construction of this set, I learned a lot about making Chipsounds play
nicely with Live.


Parameter Automation
--------------------

For plugins which have more than 128 parameters, Live does not show all the
parameters. Instead, it shows a small text stating "To add plug-in parameters
to this panel, click the "Configure" button." However, one can exploit a bug
in Live to see all parameters by doing the following:

1. Click "Configure"
2. Open the Chipsounds GUI
3. Load a new chip into the active part
4. Unclick "Configure"

Now Live will display all possible parameters for the plugin. Shhhh, nobody
report this bug to Ableton, let's just keep it our little secret for future
versions of Live. ;)


Changing Chips on the Fly
-------------------------

Since Chipsounds only exposes parameters for a single part at a time, enabling
or disabling parts in on the fly (for instance, in a live performance) or
automating multiple parts can be difficult. The easist way around this is to
instead create an Instrument Rack with multiple single-part instances of
Chipsounds. From here, one can map common parameters to single knobs.

To disable or enable specific instruments, be sure to map the "device on"
button (ie, the one in the upper left-hand corner of the device) to the
respective control. If you map to the volume button in the Instrument Rack,
this will still deliver MIDI notes to Chipsounds, causing your liveset to use
much more CPU than necessary.


Dealing with CC Data
--------------------

Chipsounds persists some parameters in the plugin as saved state, such as the
expression pedal. This means that one can get stuck notes or other weird
behavior from Chipsounds when switching MIDI clips within Live. The behavior
can be seen by doing the following:

1. Create a clip that is 2 bars long, on the first beat send a CC message to
the expression pedal, and on the last beat unsets the value to 0.
2. Create another clip which has some MIDI notes in it and nothing else
3. Play the first clip, but before it finishes switch to the second one.

Now the expression pedal will be "stuck", and even worse if you save your
document this state will be persisted in the plugin so that when you reopen
the set, the notes are still stuck.

I had a friendly debate with one of the Chipsounds engineers, and their
opinion is that plugin state should be persisted, as this is the desired
behavior for most users. With this in mind, Live users need to be aware of
this behavior and construct solutions to this behavior.

One solution (and the one I've been using in my liveset) is to remove any CC
automation from your MIDI clips, just to be on the safe side. So for each
clip, select the "Envelopes" section (if not shown, click the small "E" in the
lower left hand corner of the clip properties), and look for any red squares
which mark automation for the clip. MIDI CC data is represented in live
alongside clip automation envelopes, such as clip volume level and panning. To
clear the envelope, select the given CC and then right click anywhere in the
clip data and select clear automation envelope.

[image]

Another solution is to use a "panic" clip to clear out any automation data. I
have [created a MIDI clip which will turn off all CC automations by setting
them all to 0][3]. Simply drag this clip into your set, turn of looping for
it, and fire it to reset any stuck CC state in Chipsounds.


Applying FX
-----------

Ableton has several effects which compliment Chipsounds very nicely, at the
moment my liveset has [an effect rack with the following plugins][4]:

* Vinyl distortion, to add a bit of hiss and crackle
* Erosion, to add a touch of distortion to the high end
* Reverb, but just a tiny bit in order to add some "space" to the sound

And for more dramatic effects, usually ones you'd want to control with a knob:

* Bit reduction (soft)
* Grain delay
* One of the excellent [one-knob effects][5]


[1]: http://www.plogue.com/products/chipsounds/
[2]: http://www.syntax-error.se/
[3]: MAKEIT
[4]: SAVEIT
[5]: http://4live.me/tagged/oneknob#.UX4qcKDmpIM
