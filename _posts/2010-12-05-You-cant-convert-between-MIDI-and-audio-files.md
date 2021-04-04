---
layout: default
title: Why you can't convert between MIDI and audio files
category: development
tags: [ MIDI, rant ]
redirect_from:
  - /2012/05/just-for-record-why-you-cant-convert.html
---

This is a little rant that has been brewing inside of me for some while now.
From time to time I get asked or see questions asked as to how one goes about
converting MIDI to audio, and vice-versa. If you search on StackOverflow, you
can [find][1] [literally][2] [dozens][3] [of][4] [questions][5] [asking][6]
[this][7] for practically every programming language out there. And it's easy
to see why. Lots of people want to make some type of music-based software
thing, and they need to generate or save some content, and the easiest way to
do that is with MIDI files.

There are also [tons][8] [of][9] [half][10]-[baked][11] [shareware][12]
[utilities][13] which attempt to do this task (*note*: at the time of writing,
all of these links work, but as most of these products are scams or otherwise
dodgy, those links may be broken by the time you read this). Executive summary
for the impatient: those programs don't work, so don't waste your money on
them.

But my point is: **you don't convert MIDI to audio**. I'm going to explain
why, and what to do instead if you need to do this task. If you already know
why, then please kindly bookmark this blog entry and send it to your boss/best
friend/grandma the next time you get asked this question.


First of all, let's start out with some definitions.

**MIDI** is a protocol. The [MIDI protocol][14] defines how music hardware or
software, such as computers, synthesizers, controllers, keyboards, drum
machines, etc., can talk to each other. MIDI data, when streamed to such a
device, allows it to play the notes that make music (among other things). So
when people talk about "converting" MIDI to audio, they actually mean
converting MIDI files to audio files. MIDI files are simply a way of saving a
stream of MIDI data to disk so it can be played back later.

**Audio files**, such as WAV, MP3, OGG, etc., contain sampled audio data,
which is basically a series of digital values which make up the waveform of a
sound signal. This raw data is commonly referred to as PCM (pulse code
modulation), which is the stuff that makes up WAV and AIFF files. This data
can be compressed to MP3 or OGG or some other format via a codec, but that's a
discussion for another day. The point is, everybody knows what an MP3 file is,
but it's not the same thing as MIDI data.

So why do people think that they can convert MIDI data to audio, and
vice-versa? Well, that's simple. You have a MIDI file on your computer, and
you can double-click it, and you hear some sounds come out of your speaker.
Audio files make sounds, too, and you can easily covert between MP3, WAV, OGG,
FLAC, or whatever. So since MIDI files also make sounds, why can't they just
be converted to MP3?

And therein lies the rub. MIDI files are not sounds, they contain protocol
data. When you "play" MIDI files back, you are actually synthesizing this
protocol data to an audio stream (hence the term "synthesizer"). So you can
synthesize MIDI data to audio, and capture the resulting audio, but it's not
the same thing as converting it. Just to make that point blazingly clear: it's
synthesizing, not converting. Converting is to take the same data and save it
in a different format, but synthesizing is to take a set of instructions and
to create new output data based on them.

Here's a not-so-distant analogy which should make sense: text-to-speech
engines. Writing is kind of similar to speaking; both are ways of expressing
thoughts through the vehicle of language. A written sentence is like MIDI
data, because a single sentence will sound different when spoken by a dozen
people. Each person has a different voice, accent, pace, intonation, etc.

It's not terribly hard to write a text-to-speech engine, though certainly not
trivial either. They've been around for years, and everybody recognizes them
from the robotic sound. Recently, the technology has improved a bit to make
them more lifelike, which proves that this is not an impossible problem.
However, converting speech-to-text is much harder in comparison. There is a
lot of good software out there for dictation and voice commands, but it's not
100% reliable which is why we're all still typing to each other.

Which brings me to my main point. How does one get audio data from a MIDI
file, or MIDI data from an audio file? Well, because you cannot convert
between the two formats, these processes are very different, and as in the
above example, one of them is very easy and the other is very hard.

First, let's talk about the easier one: MIDI to audio. To do this, you need a
synthesizer, which is a special program that synthesizes MIDI data to an audio
stream as the name would suggest. There are lots of great, free synthesizers
out there, but most of them run as plugins within a larger audio environment
called a sequencer. Some of them run as standalone applications, but most
don't. You can also use a hardware synthesizer, but that's overkill for this
task.

Basically, to get an audio file from MIDI data, you open up a sequencer, load
the MIDI file, drop in a synthesizer, and then bounce the audio to disk.
That's it. Actually, that's a vast simplification of the process... there are
a ton of extra steps in there, mostly in how you set configure the
synthesizer.

If you are a Mac OSX user, you should try using Apple's own GarageBand
program. If you're on Windows, try using [Reaper][15] (which also runs on Mac).
There's a bit of a learning curve here, so be patient. If you need some free
synthesizers, check out the [plugin database at KVR audio][16].

If you have 10,000 MIDI files to batch-convert to MP3's, I am sorry to say
that there is no easy solution for you. All of the shareware you'll when
Googling for "convert MIDI to MP3" is terrible. If these programs can even
manage to bounce a MIDI file to audio (and many of them can't even do this),
it will sound absolutely horrid, because the synthesizers built into such
software are generally very low-quality. Imagine what you would hear in a
karaoke bar in Thailand somewhere, except much worse. You could perhaps set up
a shell script and use [MrsWatson][17] to convert them, but you'll still need
a good synth to do it.

Now, let's talk about getting audio data from MIDI. In the analogy above, this
would be like converting speech to written text. It's a hard problem to solve,
but it's not impossible and some people have written tools which can do it,
though they are error-prone and by no means perfect. By far, the most advanced
technology around to do this is a piece of software called [Melodyne][18] by
Celemony.

Before I discuss Melodyne further, I should shed a little more light on what
makes this such a hard problem. In the world of synthesis, a musical
arrangement is either monophonic or polyphonic. A monophonic arrangement is
one in which only one note is playing at a time, whereas a polyphonic
arrangement can contain multiple notes playing at once (ie, chords). A
monophonic arrangement is a bit boring, but is much easier to process from a
signal processing perspective. So if your only goal is to make MIDI files from
MP3's of yourself playing "Jingle Bells" on the piano with one finger, it will
be very easy to detect the individual notes which can be subsequently used to
construct MIDI protocol data.

However, most music is significantly more complex, because it contains chords
and often multiple instruments. It's very difficult to find the exact notes
which compose a single chord only by looking at the raw audio data. To make
another cheap analogy, it's like having four people read aloud four different
sentences at the same time. It's very easy to write down the sentences and
then read them aloud, but it's much more difficult for a listener to separate
them and then write down each one correctly.

Melodyne has come a long way in the last few years, and it can handle both
monophonic and polyphonic data. Go ahead, download the demo and give it a
shot. However, you'll find that it's not 100% perfect, so don't be
disappointed. More precisely, you'll find that it does a great job with your
one-finger "Jingle Bells" piece, a bit worse with a ten-finger "Jingle Bells"
piece, and significantly worse with your "Jingle Bells" arrangement where you
and grandma sing along, your brother plays the drums, and your sister is
accompanying on the tuba.

Most people who want to "convert" MP3 to MIDI data are those that have a whole
bunch of MP3's, and want to find a tool which will whip through a whole folder
and generate MIDI files which they can use for some other purpose. I hope that
I've explained in enough detail here why that simply isn't going to happen, at
least not with the current level of technology. Maybe one day in the future,
but even then the output will still need to be hand-checked by a human.

So what about tools for getting MIDI data from an audio file? Well, as I have
already mentioned, Melodyne is basically the only serious contender, and yes,
it's a bit expensive. But that's because it (mostly) works. Any piece of
shareware out there which costs 20$ and claims to convert audio to MIDI will
not work. Don't waste your money, and moreover, don't give these guys your
money. They are dishonestly marketing software to uninformed people who simply
don't know any better.

If you've made it this far, then hopefully you have a better understanding of
MIDI and audio data, and you are probably still serious about wanting to
accomplish whatever task you need to do that involves the two of them. Great.
So what now?

Go out, find a good synthesizer, play around with some plugins, and wire
something up that works for you. Don't expect that it will be easy to automate
all of this, nor should you expect the result to sound like the original song.
But in either case, best of luck!


[1]: http://stackoverflow.com/questions/2321881/need-a-library-that-generates-wave-from-midi
[2]: http://stackoverflow.com/questions/2307932/generate-mp3-from-midi
[3]: http://stackoverflow.com/questions/4354963/python-midi-to-audio-stream
[4]: http://stackoverflow.com/questions/1185392/how-to-convert-midi-to-wav-mp3-in-c
[5]: http://stackoverflow.com/questions/3890459/converting-midi-byte-array-to-mp3-byte-array
[6]: http://stackoverflow.com/questions/3279946/how-to-convert-sound-wave-to-midi-in-c
[7]: http://stackoverflow.com/questions/2237574/play-midi-file-on-the-iphone
[8]: http://www.hamienet.com/midi2mp3
[9]: http://www.pistonsoft.com/omvandla-midi-till-mp3.html
[10]: http://download.cnet.com/Direct-MIDI-to-MP3-Converter/3000-2170_4-10388970.html
[11]: http://midconverter.com/
[12]: http://midi-to-mp3.com/
[13]: http://www.widisoft.com/
[14]: http://home.roadrunner.com/~jgglatt/
[15]: http://reaper.fm
[16]: http://www.kvraudio.com/get.php
[17]: https://teragonaudio.github.com/MrsWatson
[18]: http://www.celemony.com/cms/
