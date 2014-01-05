---
layout: product
title: BeatCounter
alias: /p/BeatCounter.html
---

BeatCounter
===========
BeatCounter is a simple plugin designed to facilitate beatmatching software
and turntables. It displays the current tempo in beats per minute (BPM), while
the bottom window displays an accumulated average over the last few seconds.
BeatCounter is the perfect tool for DJ's that want to integrate computer
effects or elements with turntables.

![BeatCounter Screenshot](http://static.teragonaudio.com/ta_beatcounter.jpg)

Sending MIDI Sync
-----------------
BeatCounter cannot send MIDI clock sync to a plugin host. Since BeatCounter
is merely an effect plugin, it is not capable of controlling the tempo of a
sequencer such as Ableton Live. This is a restriction of the AudioUnit/VST
plugin frameworks.


- - -

Changelog:

Version 2.1:
- New GUI built with TeragonGuiComponents 1.4.2
- Changing license to GPL2 to match Juce
- Fix AU validation problem
- Migrate to PluginParameters 3.x API

Version 2.0:
- Improved accuracy of BPM calculation algorithm
- New GUI with more controls, clearer button names
- 64-bit Universal Binary on Mac OSX
- Linux binary (32 & 64-bit)
- Now using JUCE for plugin wrapper, graphics, etc.
- Minor performance improvements

Version 1.3:
- Bugfixes


