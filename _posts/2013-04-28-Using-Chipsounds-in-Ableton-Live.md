---
layout: default
title: Using Chipsounds in Ableton Live
category: performance
tags: [ Ableton, Chipsounds ]
---

Introduction
------------

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


Applying FX
-----------

