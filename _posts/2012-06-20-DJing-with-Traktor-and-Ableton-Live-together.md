---
layout: default
title: DJing with Traktor and Ableton Live together
category: performance
tags: [ Ableton, Traktor ]
---

Introduction
------------

I write a lot about Ableton Live, and looking through my performance-related
posts, I guess I sound a bit like a Live fanboy. But in truth, there as many
things which bug me about Live as things which I love. Top among these
complaints is that DJ'ing with Live is very time-consuming, especially when it
comes to preparation. Also, [Live's file browser is rather terrible][1],
making it difficult to hunt for the perfect track to play next.

I have recently started playing a bit more with Traktor, mostly because
several other DJ's I collaborate with use it. If we want to play together,
well, I'd need to meet them halfway. But I wasn't really ready to give up on
Live altogether, and there are several things about DJ'ing with Live which I
missed right away. So instead of making the full switch from Live to Traktor,
I figured I'd rather have my cake and eat it, too. Now I run both Traktor and
Live side-by-side, and I get (mostly) the best of both worlds.


Why both?
---------

So, why not just pick a platform and go with it? Why go through all the extra
trouble of running two rather heavy apps at the same time? Well, running Live
with Traktor has a number of advantages which are hard to do with either one
alone:

* Traktor's browser can be completely controlled via MIDI, making your
  performance more handsfree.
* Preparing tracks for playback in Traktor is a bit easier than in Live, which
  saves many hours of work.
* Live is much more flexible when it comes to filters and effects, opening up
  possibilities far beyond the standard 3-band EQ and out-of-the-box effects
  Traktor offers.
* Live supports audio plugins, and Traktor obviously does not. Again, more
  possibilities.
* Traktor's remix decks (introduced in 2.5) are quite limited compared to
  looping in Live.
* Within Live you can build drum machines, samplers, etc.

However, using Traktor and Live together still allows one to play warped
tracks within Live, or to use the 3-band EQ within Traktor (for example).
Using both together combines the strengths of each platform, but with very few
disadvantages. One disadvantage is that this setup is a bit complex, so bear
with me as we get down to the details...


Overview of the setup
---------------------

To combine Traktor with Live, we will be using an external mixer within
Traktor and routing the audio to Live for post-processing. Live will in turn
be responsible for cueing audio both from itself and Traktor.

Tempo syncing Live and Traktor is optional and may or may not be needed,
depending on your setup. It is a bit tricky to do, and is only necessary if
you want to do any of the following:

* Play warped tracks or loops from Live
* Have time sync'd effects in Live

Otherwise, it's probably easier to use Live just for processing audio and skip
the MIDI sync entirely.


Transporting audio
------------------

The first and most important step is getting audio from Traktor to Live for
processing. This can be done either virtually or in hardware, though if you
have a soundcard which has enough I/O ports, I find that it works much better
in hardware.

First, set up Traktor to use an external mixer, and route each deck to a
separate output channel, as pictured below:

![Traktor External Output Routing](http://static.teragonaudio.com/ta-djsync-traktor-output-routing.png)

Even if you use an external mixer, you will still be able to use Traktor's own
filters and effects.

In this example, we are routing audio via the [Soundflower][2] virtual
interface. On Windows, there is no free Soundflower-like software (at least
not that I could find), but [Virtual Audio Cable][3] seems to do the same
thing and is rather cheap.

Then, set up Live to record from the same channels:

[![Ableton Live Input Routings](http://static.teragonaudio.com/ta-djsync-live-audio-inputs-thumb.png)][10]

Finally, create audio tracks in Live to route the audio from Traktor:

[![Ableton Live Track Routings](http://static.teragonaudio.com/ta-djsync-live-traktor-routing-tracks-thumb.png)][11]

Assuming that you have a multi-channel soundcard, you can now cue and route
these output tracks as you would other tracks within Live.


Syncing MIDI
------------

There are two ways to do MIDI sync: the totally unreliable way with MIDI
clock, or the more tedious old-school manual way. MIDI clock is only
recommended if you are not playing any tracks from Live and only using it for
tempo sync'd effects. If you are playing any loops or musical material from
Live, you will find MIDI clock to be vastly disappointing. Due to the nature
of the MIDI protocol, there is a very noticeable amount of jitter and
achieving perfect sync is impossible. Sorry!

If you plan on playing loops or other material from Live, you'll need a
separate MIDI controller with a few buttons, and your beatmatching skills.
Assuming that you have both of those, manually syncing the two isn't hard once
you get the hang of it.


Sync via MIDI clock
-------------------

MIDI clock is the sync mechanism described in most [other blogs and
tutorials][6], and assuming that you don't need a tight or accurate sync, it
works ok (with a few caveats). To set this up, first go to Traktor's
preferences and enable sending MIDI clock:

![Traktor Enable MIDI Clock](http://static.teragonaudio.com/ta-djsync-traktor-send-midi-clock.png)

For some reason, this isn't actually enough to get Traktor to send the clock
signal. You also need to create a virtual output device by going to the
"Controller Manager" section and adding a new Generic MIDI Device. Now set the
output of this device to be Traktor Virtual Output:

![Traktor Controller Manager](http://static.teragonaudio.com/ta-djsync-traktor-controller-manager-1.png)
![Traktor Controller Manager](http://static.teragonaudio.com/ta-djsync-traktor-controller-manager-2.png)

Just creating the device is enough; you don't need to make any mappings. You
should now see MIDI clock messages in a utility like [MIDI Monitor][4] or
[MIDI-OX][5]. Now within Live, go to the MIDI preference pane and sync Live to
Traktor's virtual MIDI output:

![Ableton Live MIDI clock sync](http://static.teragonaudio.com/ta-djsync-live-midi-config.png)

You will also need to enable the "EXT" button in Live to get it to slave its
transport to Traktor. When you start playing, you will see that Live starts
and will roughly match its BPM to Traktor's.

![Ableton Live External Sync](http://static.teragonaudio.com/ta-djsync-live-ext-button.png)

The next step is to tighten the sync up as much as possible. To do this, turn
on the metronome in Traktor by switching to the "Extended" layout and enabling
the "TICK" button. You will also need to cue at least one deck (doesn't matter
which one) to hear the tick within Live.

[![Traktor metronome](http://static.teragonaudio.com/ta-djsync-traktor-tick-thumb.png)][14]

Start playing a song in Traktor, but mute it by keeping the volume fader at
zero. Switch back to Live and enable the metronome. You should now hear the
two metronomes ticking side by side. In Live's preferences, you can now adjust
the MIDI sync delay to make it so that the two ticks fall directly on top of
each other. In my experience, most computers will line up with a pre-delay of
about -40ms, though obviously this value will vary depending on your hardware.

If the sync starts to drift (and it will!), you can realign the sync by
pressing the "SYNC" button in Traktor. In my experience, this will cause Live
to jump rather dramatically, and sometimes drop audio. Not really perfect, but
again, this is part of the downside of MIDI sync. If you need something more
exact, you'll need to take matters in your own hands...


Syncing MIDI Manually
---------------------

If you don't know how to beatmatch records, then you should probably stop
reading here and [first learn how to do that][7], otherwise this method will
be very difficult for you.

You will need to have a MIDI controller with buttons; the keyboard is not
going to work very well as you will need to flip back to Live in order to
fine-adjust the sync, and small adjustments will be needed throughout the mix,
just like mixing records.

First, set up MIDI mappings in Live for the following:

* Metronome on/off (the metronome is definitely needed for sync, but it will
  get annoying after awhile).
* Tap BPM
* Nudge tempo forwards
* Nudge tempo backwards
* The play button in the transport section
* Optionally, the nudge tempo controls in Traktor as well

Now, for the fun stuff. Say you are starting in Traktor and want to play some
loops in Live. Start by turning *off* the metronome and tapping the BPM for
awhile. Then turn the metronome on. Live's tap BPM function starts making
tempo adjustments on the first press (why, I have no idea), so it can be very
confusing and hard to start tapping BPM with the metronome on.

At this point, the two should be roughly in sync. However, you may find that
they start to drift or the first downbeat doesn't match up. To fix this, wait
until your song in Traktor hits the first beat, and then hit the play button
in Live.

The secret behind the play button is that if you restart Live's transport (ie,
by pressing stop/start or the spacebar), Live has a tendency to briefly drop
audio. But if you press the play button during playback, Live will simply
start playback again without dropping audio. Neat!

However, this is a bit impractical if you are planning on playing a warped
track within Live, but in that case you can at least start the track out on
the right tempo.

As you start mixing between the two, the two tracks will start to drift. You
can use the nudge function to push Live (or Traktor, as desired) a bit forward
or backwards, just like a record. Also, you can cheat a bit by looking at the
tempo of the master deck in Traktor and manually entering it into Live instead
of tapping BPM, but this approach involves a bit more fiddling around with the
keyboard. Once you get used to syncing in this manner, it's actually quite
comfortable.

So say you now want to mix from looped material in Live back to Traktor. The
reverse mixing process is a bit different but fundamentally the same idea.
Check out the tempo in Live and then adjust your song in Traktor to be the
same. Disable sync for that deck in Traktor just to avoid any potential
problems (you can always enable it once you get playback started). Now,
fine-adjust the two tracks using the nudge feature, preferably from Traktor as
not to disrupt Live's tempo.

I find that it helps here to turn on the metronome again, but that may not be
needed. Also, I generally prefer to nudge the less dominant of the two tracks,
meaning that as you are *mixing in* a new track, that is the one to be nudged
until it is louder than the other one. Likewise, when *mixing out* a track,
that one should be nudged when it starts to become quieter than the one you've
just mixed in.


Performance considerations
--------------------------

I have managed to get the above setup working on a somewhat old Macbook Pro
(a 2x2.66Ghz Core 2 Duo with 8Gb RAM) and a MOTU Ultralite MK3 using a buffer
size of 256 samples at a sample rate of 44.1kHz). CPU usage is a constant ~40%
per core, and I get no audio dropouts at all:

[![Screenshot of Traktor + Live](http://static.teragonaudio.com/ta-djsync-runtime-performance-thumb.png)][12]

As my processor has only two cores, I found that disabling multiprocessor
support in both Live and Traktor provides a bit better performance. However,
I'm not sure if this would also be the case on newer 4+ core laptops, so your
mileage may vary.

However, I had problems with Soundflower dropping audio after some hours of
playback. [Apparently this is a rather common problem][8] and I'm not sure if
there is a good solution here. Likewise, I've not tried this in Windows with
Virtual Audio Cable, so I can't speak to the performance there. But if you
have a soundcard which has enough inputs and outputs to do the routing there,
that approach might work better for you. In my case, I literally patched 4
outputs of my soundcard back into the inputs and recorded them directly from
Live. Again, this seems a bit impractical but it is actually quite stable, and
as noted, even on my aging laptop this works with quite low latency.

*Update*: After it seems that [Jack for Mac OSX][9] is also capable of routing
sound in the same way as Soundflower, so if you are having problems with
Soundflower then give Jack a try.


[1]: http://teragonaudio.com/article/Using-iTunes-as-Ableton-Lives-file-browser.html
[2]: http://cycling74.com/products/soundflower/
[3]: http://software.muzychenko.net/eng/vac.htm
[4]: http://www.snoize.com/MIDIMonitor/
[5]: http://www.midiox.com/
[6]: http://www.youtube.com/watch?v=4xzldehIsCE&feature=youtube_gdata
[7]: http://www.beginnerdj.com/how-to-beat-match
[8]: https://code.google.com/p/soundflower/issues/detail?id=24
[9]: http://jackosx.com/
[10]: http://static.teragonaudio.com/ta-djsync-live-audio-inputs.png
[11]: http://static.teragonaudio.com/ta-djsync-live-traktor-routing-tracks.png
[12]: http://static.teragonaudio.com/ta-djsync-runtime-performance.png
[13]: http://static.teragonaudio.com/ta-djsync-hardware-routing.jpg
[14]: http://static.teragonaudio.com/ta-djsync-traktor-tick.png
