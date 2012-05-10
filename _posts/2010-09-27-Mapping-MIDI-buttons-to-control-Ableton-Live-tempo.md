---
layout: default
title: Mapping MIDI buttons to control Ableton Live's tempo
category: performance
tags: [ Ableton, MIDI ]
redirect: /2012/05/midi-mapping-buttons-to-control-ableton.html
---

A friend of mine recently tipped me off to a nice trick in Ableton Live. For a
long time I've been searching for a nice way to control tempo via a MIDI
controller, and have found it amazingly difficult to do this. Fortunately,
there is an easy (but non-intuitive) trick you can use to map two MIDI buttons
such that pressing each button will increase or decrease the global tempo by a
small-ish amount.

In the past, I tried using the following methods to map MIDI tempo, each with
its own pitfalls:

* Using a keyboard mapping. Doesn't work, since Live simply sets the tempo to
  the maximum/minimum value.
* Using a continuous controller. Behaves erratically, difficult to increase
  tempo in smaller amounts, and too easy to hit the wheel by accident and
  screw up the whole set.
* Using a knob. Very difficult to increase the tempo in small amounts,
  especially with a large tempo range.
* Using a fader. Impractical, since I need my faders for other mappings.

To use buttons, first program your MIDI controller to have the two buttons send
out the same MIDI CC message. Then, map one of the buttons to the tempo by
entering Live's mapping mode, clicking on the tempo box, and then pressing the
button. Finally, program your MIDI controller such that the increase button
always sends 1 sends as its value, and the decrease button always sends 127.
Now, when you press a button, the tempo will increase/decrease by a small
amount (usually ~.75 BPM, though it varies on your tempo range).

This may seem a bit counter-intuitive due to the 1/127 values, but at least
it's documented. See the Ableton manual's section on "Mapping to Relative MIDI
Controllers" for the full scoop. This means, btw, that you can also use the
button trick to increase or decrease other controls as well, not just tempo.

