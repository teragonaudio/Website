---
layout: default
title: What language should I learn to write audio plugins
category: development
tags: [ Intro ]
---

So perhaps you've grown tired with all your synths and want to dive in and
make your own. Or you've got a killer idea for a new slicer plugin with extra
coolness. Or maybe you just want to kick the tires a bit and see how VST's
work from the inside. What should you learn?


Going non-native
----------------

Before talking about different programming languages, I'd like to mention that
*programming is hard*. If you don't have any previous experience writing code,
then any inspiration you might have is likely to get burned away during hours
of frustrating debugging. If your goal is to make a cool plugin, it's
important to realize that you don't necessarily need to write code to do it.
There are, in fact, numerous frameworks which will help you to create a plugin
by using visual drag-and-drop techniques, including:

* [Max (formerly called Max/MSP)][1]
* [SynthEdit][2]
* [SonicBirth][3]
* [Reaktor][4]

These frameworks allow one to design a plugin within a graphical environment
and then export it as a plugin which can be used in your favorite sequencer.
Each of the above programs differs a bit in their cost, supported platforms,
and support plugin formats. But if you are just looking to have a specific
type of plugin for your own music or experiment with synthesizer construction,
this is probably the best starting point.

It's important to note that lots of serious software has been programmed or
prototyped in frameworks like these. Many beginner plugin coders scoff off
non-native frameworks because they are not commercially viable option.
However, it's important to remember that *software development takes a lot of
time*, and using a higher-level tool can be a great tool to test out your
ideas. For example, [most of the devices in Ableton Live were prototyped in
Max][5] (though not Live itself, as the story is sometimes retold).


Enter the code
--------------

So perhaps a non-native framework isn't best for your project. Maybe you can't
find one that suits your needs or you have a programming itch you need to
scratch. If you have previous experience with Java or C# (or conversely, don't
have any previous experience with C/C++), then you should check out these
frameworks:

* [jVSTwRapper][6]
* [VST.NET][7]
* [noisevst][8]

Although again, each of these frameworks has limitations for platforms or
performance, they should be enough to get you up and running. Developing
software in higher-level languages is significantly faster than lower-level
languages like C/C++, the importance of which should not be underestimated if
your time is limited.


Down to the next level
----------------------

The next logical step down the abstraction layer is C++. If you don't already
know C++, I would advise at least **trying** some of the above frameworks and
other languages first. Really. C++ is quite a frustrating language to deal
with sometimes, and the complexity and primitive tools mean many hours of hard
work just to get stuff working. This goes double (maybe even triple or
quadruple) if you insist on having a GUI window for your plugin.

But enough beating around the bush, C++ is what it is. One strong advantage of
C and C++ is that they are *fast*. Compiled C code is generally considered to
be one of the fastest executing languages out there, thanks to the fact that
modern compilers can optimize for all sorts of chips and under conditions
which mere mortals could spend years learning themselves. That said, the speed
tradeoff is not often necessary for most plugins.

Generally speaking, it's better to develop software in higher-level languages
and then gradually move to lower ones as the speed is needed. How will you
know if the speed is needed? Well, start your development in a high-level
language and go down as necessary. The algorithms which you develop in order
to shape a plugin's sound are much harder to develop than the actual code, and
thus translating that code to lower languages is not as difficult as the
initial cost of development.

Though I realize that this article may come across as a giant anti-C++ rant, I
promise you that this is not my opinion. It's just that most newcomers tend to
underestimate the difficulty and time required to write good software in C++,
and they jump in too eagerly and get burned out. So rather than bashing the
language itself, I simply want to caution the reader not to underestimate the
amount of time and energy required to write audio software in C++.

That said, many great plugin frameworks also exist for C++. My favorite of
them is [Juce][9]. You might be wondering why a framework might be necessary
if you are already doing C++, and the answer is that with Juce, a lot of stuff
comes "for free", including cross-platform support, GUI generator, etc. The
Juce framework is incredibly sophisticated and mature, and it handles a lot of
the plugin implementation details for you. Speaking as someone who has also
developed plugin cross-platform frameworks, this is not a trivial task and one
which will save you countless hours of busywork and let you focus on the fun
parts of plugin development.

Juce is GPL'd, which means that if you want to use it in a commercial context
you will need to pay for a license to do so. However, if your plugin is
open-source, Juce is free for you to use, assuming that your plugin is also
open-sourced. If you consider this to be a big disadvantage, read on.


Considering framework costs
---------------------------

In this article, I have linked to several plugin frameworks and toolkits, some
free and some paid. It seems that many beginning developers are scared off by
paid frameworks and tools, but they shouldn't be. If you really need the
functionality provided by a framework or tool, do the math to see if it'll pay
off.

Consider your hourly rate. What's your hourly rate? Well, consider how much
you make per month/year, and figure out what that is in hours. If you don't
have a 9-5 job, then just consider what you'd like to get paid for an 8-hour
contracting gig. The number doesn't need to be exact; you only need a ballpark
figure here. Now consider the price of the software divided by your hourly
rate. Can you write the same functionality yourself in roughly the same amount
of time? If not, you should consider the fact that being cheap now will cost
you *serious money later*. Yes, 800$ (for example) may seem like a lot, but
you could just as easily burn 4x that amount of money in your time spent with
the end result being a much worse product.

It used to be that programming was about being clever and smart with
algorithms and such. Modern programming is more about leveraging the tools and
frameworks out there and bringing them together to make a great product.

However, it is understandable that not everyone has the cash upfront to invest
in those types of tools. If that's the case, then start out open-source until
you've built up a bit of a war chest, and then invest in good tools.
Everybody's gotta start somewhere!


No Juce for me, thanks
----------------------

But back to the original topic at hand. If you decide that you want to go it
alone, there are certainly ample resources for doing this as well. The VST and
AU frameworks are not impossible to code with by hand, but definitely require
a bit more patience. So take the next step and get your tools set up, and
start programming!

* [How to make a VST plugin with Visual Studio][10]
* [How to make a VST plugin with Xcode][11]


[1]: http://cycling74.com/products/max/
[2]: http://www.synthedit.com/
[3]: http://sonicbirth.sourceforge.net/
[4]: http://www.native-instruments.com/#/en/products/producer/reaktor-55/
[5]: http://www.musicradar.com/tuition/tech/a-brief-history-of-ableton-live-357837/2
[6]: http://jvstwrapper.sourceforge.net/
[7]: http://vstnet.codeplex.com/
[8]: http://code.google.com/p/noisevst/
[9]: http://www.rawmaterialsoftware.com/juce.php
[10]: http://teragonaudio.com/article/How-to-make-VST-plugins-in-Visual-Studio.html
[11]: http://teragonaudio.com/article/Making-a-VST-plugin-from-scratch-with-Xcode.html

