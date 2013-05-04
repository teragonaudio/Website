---
layout: default
title: Mapping MIDI buttons to control Ableton Live's tempo
category: performance
tags: [ Ableton, MIDI ]
alias: /2012/05/midi-mapping-buttons-to-control-ableton.html
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

In my opinion, *buttons* are the best way to control tempo with MIDI, ideally
one button to increase the tempo a little bit and another one to decrease it.
Live actually supports this, but it's not completely obvious how to set it up.

First, you need to reprogram your MIDI controller to have two buttons send the
same MIDI CC message. One button will _decrease_ the tempo by sending the
value 65, and another one will _increase_ it by sending 1. The exact variation
in the tempo that these buttons will send varies on the tempo range (visible
in the MIDI mapping table), and the values that you send. Sending 65/1 will
alter the tempo in the smallest possible amount. To alter the tempo with the
largest possible amount, have your controller send 127/64 instead.

Now, enter MIDI mapping mode in Live and press one of the two buttons (doesn't
matter which one) to assign this CC to the tempo. Now click on the tempo
control again after assigning it, and then at the bottom of the screen change
the mode to "Relative (Signed Bit)".

![Changing the control's mode](http://static.teragonaudio.com/ableton-live-control-tempo-midi.png)

The MIDI buttons should now increase and decrease the tempo. Hooray! This
trick is a bit non-intuitive, but it is actually documented in Live's manual
in a section titled "Mapping to Relative MIDI Controllers". The table in this
section also explains why sending 65/1 varies the tempo in smaller steps than
sending 127/64, since these values are at the minimum/maximum extremes for the
mapping ranges that Live recognizes.

This trick also means that any ranged control (ie, volume, a send knob, etc)
can also be controlled with buttons in a similar fashion.

