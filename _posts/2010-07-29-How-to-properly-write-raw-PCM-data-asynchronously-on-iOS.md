---
layout: default
title: How to properly write raw PCM data asynchronously on iOS
category: development
tags: [ iOS, iPhone ]
alias: /2012/05/how-to-properly-write-pcm-data-in.html
---

My colleagues just fixed a huge show-stopper bug having to do with writing PCM
data on the iPhone. We had an application which needed to write raw audio
samples to disk from the microphone input, and it was causing audio playback
to stutter approximately once every 30 seconds.

The problem: our app performs DSP algorithms on the iPhone's microphone
signal, which we achieved by passing the incoming signal to an AudioUnit and
then converting the raw samples from 16-bit integer to floating-point, which
allowed us to directly adapt code from our VST plugins to the iPhone. Note
that although the iPhone documentation allows you to create an
AudioStreamBasicDescription with the kAudioFormatFlagIsFloat flag, this
doesn't actually work on the iPhone, probably because it lacks a native FPU.
So you need to use the kAudioFormatFlagIsSignedInteger flag instead and
convert the samples by hand.

After processing the samples, we wanted to write them to a CAF file using the
AudioFileWritePackets() call, which is part of the [Audio File Services
API][1]. This code worked fine on the iPhone Simulator, but on the actual
hardware caused stuttering during playback. Our app is simultaneously playing
and recording audio, and one would hear a bit of static caused by audio
dropouts in the output stream. The first dropout occurred within the first 10
seconds of playback, and each subsequent dropout occurred almost exactly every
30 seconds thereafter. The dropouts occurred every 30 seconds on an iPhone 3G,
where they were also most severe, but on the iPhone 3GS and iPhone 4, the
dropouts were small (but nonetheless noticeable) and occurring in 30 second
multiples but not necessarily every 30 seconds.

Naturally we thought the problem was due to the iPhone's limited I/O
capabilities, and started using Instruments and other performance testing
tools to try to diagnose the problem. However, it soon became clear that disk
I/O was not causing the dropouts, since we ran a test where the output signal
was synthesized using a basic sawtooth signal, which didn't touch the disk at
all. And yet, the dropouts still occurred.

Although the AudioFileWritePackets() call has a flag to cache the audio, this
has no effect on performance. Instead, the solution is to ditch the Audio File
Services API and instead use the [Extended Audio File Services API][2]. This
API contains a function called [ExtAudioFileWriteAsync()][3], which as the
name suggests, writes data to the given file asynchronously. This function
allows for simultaneous audio playback and dumping PCM data without dropouts
or other audio glitches, even on the iPhone 3G! Also, it spares the programmer
the headache of having to make their program multi-threaded in order to have a
low-priority thread to dump audio.


[1]: http://developer.apple.com/iphone/library/documentation/musicaudio/Reference/AudioFileConvertRef/Reference/reference.html
[2]: http://developer.apple.com/iphone/library/documentation/MusicAudio/Reference/ExtendedAudioFileServicesReference/Reference/reference.html
[3]: http://developer.apple.com/iphone/library/documentation/MusicAudio/Reference/ExtendedAudioFileServicesReference/Reference/reference.html#//apple_ref/c/func/ExtAudioFileWriteAsync
