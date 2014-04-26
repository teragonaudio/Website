---
layout: default
title: Exporting channel strips from Logic Pro to Mainstage
category: performance
tags: [ Logic, Mainstage ]
---

Just a quick tip here as to how to "correctly" export entire channel strips
from Logic Pro to Mainstage, since it seems to be secretly (or possibly not at
all) documented. Anyways, one can save channel strip settings in Logic Pro and
open them in Mainstage through the usual mechanism, however the problem is
that this only works for an individual channel. If you have an instrument such
as Ultrabeat and have placed effects on several individual instruments, then
it seems you cannot directly import these into Mainstage.

In Logic Pro X, plugins with multiple output channels (like Ultrabeat) show
the individual outputs in a group, and each one of the channels in the group
can have their own channel EQ settings and effects, which is extremely useful
especially for doing drums. However, these files get exported into a special
folder in Logic's default preference location, and such files don't show up in
Mainstage when loading channel strip settings.

It turns out that it is possible to import an entire instrument and all of its
grouped channels, however this cannot be done by saving channel strip
settings. Instead, one must create a patch.

To do this, select the instrument you want to export in Logic Pro, and make
sure that the instrument channel is selected (and not one of the individual
channels in the group). Then open the Library by clicking the button in the
upper left-hand corner of the screen, and click "Save" in the lower right-hand
part of the Library panel.

Now in Mainstage don't create a new channel, instead click the gear icon to
the right of the "+" at the top of the "Patch List" panel. At the bottom of
this menu there is an option named "Load Patch/Set". When you select this
option, you can now load your saved patch from Logic, with almost all channel
settings correctly saved!

I say "almost" because the one thing that's not saved is volume settings. This
is a bit sad though understandable, however it means that if you are mixing
drums in Logic and want to set exact levels which should be respected by
Mainstage, then you are better off using the Channel EQ's "Gain" feature
rather than the mixer volume.

