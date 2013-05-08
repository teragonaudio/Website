---
layout: default
title: Building VST plugins on Linux
category: development
tags: [ VST, Linux ]
---

While I normally prefer to use [Juce][1] for plugin development on Linux
(since it generates a nice Makefile for you which compiles cleanly on that
platform), sometimes you gotta get your hands dirty and build a VST by hand on
that platform. I recently ran into this when trying to build the Steinberg VST
examples by hand. Anyways, the compilation procedure is simple but not
obvious. Basically the source files must be compiled like so:

`g++ -fPIC -c -Ipath/to/vstsdk2.4 -D__cdecl="" file.cpp`

By redefining `__cdecl` to an empty string, one can avoid having to alter the
VST SDK sources and "trick" it into building correctly for that platform.
You'll need to build all of your own source files with the above switches
(plus any other switches you want, such as debugging, optimization, warnings,
etc), as well as `audioeffect.cpp`, `audioeffectx.cpp`, and `vstplugmain.cpp`.

Once you have built all object files, they must be linked together to create
a single shared library:

`gcc -shared -Wl=soname,myplugin.so -o myplugin.so *.o`

That's it! Now you should have a VST plugin usable on Linux.

[1]: http://www.rawmaterialsoftware.com/juce.php

