---
layout: default
title: Building AudioUnits with modern Mac OSX
category: development
tags: [ AudioUnits ]
---

Introduction
------------

AudioUnits! That's Apple's shiny and awesome plugin format which is super easy
to work with and great with all things pro-audio, right? No messy SDK
downloads like with VST, and all with great examples and documentation?

But enough with the sarcasm. :) And forgive me in advance for more to follow
in this article.

Although AudioUnits always had some degree of pain, particularly for VST
programmers who grew up in a "push-based" world, they had their good points as
well. However, it pains me to say that many of these advantages, namely the
development environment and platform, have fallen into disregard by Apple. I'm
not really sure what the situation is over there (is anyone ever sure?), but
regardless, newcomers to AudioUnit programming are sure to find themselves in
a confusing world of hurt when trying to support this plugin platform.

This guide is intented to get you up and running with the most *basic*
AudioUnit possible. Preferably, you already have some AudioUnit source code
which you are merely trying to build it after updating to OSX 10.7/8. At any
rate, this guide was written for OSX 10.8.2 and Xcode 4.5.2.


Getting the AudioUnit SDK installed
-----------------------------------

The first pain in dealing with AudioUnits on a modern Mac is that Apple no
longer ships the AudioUnit SDK with Xcode. You'll need to [download it from
Apple's developer website][1] *with Safari* (seriously, you'll get weird
session timeout errors by using Chrome).

Specifically, you need to search for "Audio" on that page and download the DMG
from February 2012. The later versions *do not contain the actual SDK source
code*. Mount the DMG, and then pop open a terminal window and run the
following command:

`sudo cp -r -v "/Volumes/Audio Tools/CoreAudio" /Applications/Xcode.app/Contents/Developer/Extras/CoreAudio`

And then:

`sudo find /Applications/Xcode.app/Contents/Developer/Extras/CoreAudio -type f -exec chmod 666 {} \;`


Patching the AudioUnit SDK
--------------------------

As of Mac OS X 10.7 and above the AudioUnit SDK does *not* compile out of the
box with Xcode 4.5. You will need to alter some of the source code manually in
order to get things working again. You'll need to edit `AUMIDIEffectBase.cpp`
at line 154 to:

{% highlight cpp %}

    result = ((AUMIDIBase*)This)->MIDIEvent(inStatus, inData1, inData2, inOffsetSampleFrame);

{% endhighlight %}

Furthermore, you may need to change the compiler for your project from Apple's
LLVM to LLVM GCC 4.2. Otherwise, you'll have to change `AUCarbonViewBase.cpp`
at line 257 to:

{% highlight cpp %}

    HISize originalSize = { (CGFloat)mBottomRight.h, (CGFloat)mBottomRight.v }; 

{% endhighlight %}

However, using Apple's LLVM compiler will also give you problems while
building the VST SDK, which is a pain if you intend for your plugin to support
both. In addition to the fix above, you'll also need to edit
`audioeffectx.cpp` at line 512 to be:

{% highlight cpp %}

    char temp[2] = {(char)(digit + 0x60), '\0'};

{% endhighlight %}


Making a new AudioUnit
----------------------

Another annoyance is that Apple has removed the project templates for making
AudioUnit projects. I'm in the process of updating my [plugin templates][2],
but [Mojo Lama has also blogged about how to restore the missing
templates][3].


[1]: https://developer.apple.com/downloads/index.action
[2]: https://github.com/teragonaudio/XcodeVstTemplates
[3]: http://www.mojolama.com/restore-apples-audio-unit-templates
