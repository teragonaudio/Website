---
layout: default
title: A brief comparison of Android audio frameworks
category: development
tags: [ Android ]
redirect: /2012/05/few-words-on-android-audio-programming.html
---

I wanted to offer a quick bit of advice regarding playing sounds in Android.
First, most developers will find that the MediaPlayer and SoundPool widgets
are equally frustrating to work with. MediaPlayer is too high-level, and
SoundPool isn't low enough.

Anyways, my experience in audio is such that as an app increases in
complexity, one rapidly descends the ladder of audio frameworks to arrive at
the lowest one. So just get used to working with both MediaPlayer and
SoundPool, as you'll probably need to use both for separate purposes.

One big disadvantage of SoundPool is that it is not capable of keeping large
samples in memory as it decodes them to raw PCM. Even so, an activity that is
graphically rich with sound tends to hit the memory limit pretty quickly. Be
sure to release() and null references to either SoundPool or MediaPlayer
objects after you are finished with them (and preferably before the activity
finishes).

Also, with both MediaPlayer and SoundPool, one should be ultra-paranoid about
failed initialization and NullPointerExceptions. This is especially true if
you need the sound player in the Activity as a member field. If this is the
case, you will almost certainly need to override onPause() and onResume() to
re-initialize the sound resources if necessary.

Audio performance varies widely between Android vendors, so you run a high
risk of "works for me" unless you aggressively try/catch most audio
operations, as you'll find that many phones will return null references when
trying to create new references.
