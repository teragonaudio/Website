---
layout: default
title: Old-school syncing Ableton Live to other software
category: performance
tags: [ Ableton, MIDI ]
---

Introduction
------------

There are lots of blog posts, forum arguments, and youtube videos that will
explain to you how to use MIDI sync to synchronize Ableton Live with other
music software. This is not one of those posts; instead, I will try to
convince you why you should *not* try to do this, and recommend a better,
albeit tougher alternative.


Why MIDI Sync?
--------------

There are lots of reasons why you'd want to sync Ableton Live against another
piece of music software. Maybe you're using Live to add a few loops or
time-sync'd effects to your DJ set, but you want to DJ with Traktor instead of
Live. Maybe you've got multiple laptops and multiple performers and you want
to use the same MIDI clock to make sure that Live is on time. And so forth.

Normally, the conventional wisdom is that you'd set up MIDI synchronization
and slave Live to some other external MIDI sync source. On Mac OSX, the
Network MIDI interface provides a convenient way to create an ad-hoc sync
between two Macs. Throw a PC into the mix, and things get a bit tougher, so
usually the solution is to send MIDI between two soundcards. If both apps are
running on the same computer (ie, syncing between Traktor and Live), then
sometimes a loopback device can be used. In the case of Traktor, it provides a
loopback device capable of sending MIDI clock.


Sounds great, why shouldn't I?
------------------------------

In a nutshell, MIDI is too unreliable for tight synchronization. MIDI is a very
slow protocol, and it simply was not designed to transport large amounts of
streaming data which is required here. Among the problems which you will
encounter here are:

* Drift, which occurs when the two hosts are no longer in tight sync. Programs
  like Traktor can force a resync, but this usually causes Live to drop audio
  and jitter for a split second while it resyncs. Not good.
* Packet loss, which occurs when the MIDI sync stream is broken. In this case,
  the only way to re-establish sync is to stop the master host and restart
  playbak. Also not good.
* Slow follow, which occurs when (God forbid) you want to change the tempo of
  the master host. The slave will eventually catch up to the tempo changes,
  but there is a noticeable lag, and sync will probably be totally off by the
  time the tempo stabilizes.
* Networking and complexity. Murphy's law states that if something can go
  wrong, *it will*. If something is tedious and hard to set up in the safety
  of your studio, you can pretty much guarantee that it's going to go
  completely pear-shaped when you try to take it on stage.


So what to do?
--------------

Over the years (since Live 4, specifically), I have experimented with MIDI
sync of multiple laptops or multiple hosts on the same machine. For the
reasons mentioned above, it just doesn't work that well. At least, not nearly
well enough that I would trust to go onstage with such a setup.

So, in my experience it is better to assume that sync is not a viable option,
and instead I prefer to run it old-school. First, start the master host, and
then type the tempo into Live. If you don't know the tempo, then tap it in. It
really helps to assign a MIDI button to tap BPM, as well as [assign buttons to
increase/decrease the tempo][1]. If you can peek at the screen on the other
laptop, then you are pretty much guaranteed to get an exact tempo, which is
far easier than regular beat-matching.

Next, turn on the metronome and get ready to start Live. Wait until the "1"
downbeat and start Live's playback *slightly before* the 1 is hit. Use the
"nudge" buttons to fine-tune the sync. Again, it makes sense to map the nudge
buttons to MIDI. I also usually map the "m" key or a MIDI button to the
metronome, as it can get annoying after sync is established.

If there are tempo changes you will need to use the MIDI keys to change Live's
tempo, but you will find that this actually works much better than MIDI sync
would. However, if you are doing some ultra-crazy breakdown with the tempo,
then usually it makes sense to break sync and mute Live until thing settle
down.


Final thoughts
--------------

If you are using a setup with multiple laptops, then think of Live like a big
turntable, not a magic host. I've heard that some hosts, namely BitWig (not
yet released at time of writing) will support their own high-bandwidth sync
protocol. I, for one, greatly welcome this feature.


[1]: http://teragonaudio.com/article/Mapping-MIDI-buttons-to-control-Ableton-Live-tempo.html

