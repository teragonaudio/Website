---
layout: default
title: Why you can't just remove vocals or make an A Capella of an audio file
category: development
tags: [ rant, mastering ]
alias: /2012/05/just-for-record-why-you-cant-remove.html
---

In a similar vein to my previous rant about why you can't convert between
MIDI and audio data, I thought I'd address another question I see a lot. This
question comes in two forms, but it's basically the same thing:

* Can I make an A Capella version an MP3 so I can remix the vocals with a
  different beat?
* Can I remove the vocals from an MP3 so I can make a karaoke version of a
  song?

The answer to both questions is "no". More precisely, it's "technically yes,
but not really, and if you are asking this question, then you don't have
access to the data which would give you what you wanted or else you wouldn't
be asking". Hopefully this guide will explain why.

The reason that both of the above questions are fundamentally the same thing
because they involve two opposite processes that are used when working with
audio data: mixing and filtering.

*Mixing* is the process of taking two or more audio streams and combining
them to make a single stream. So when a band goes to the studio to make an
album, all of the instruments are recorded separately and then mixed down to
make a single track. This is done so that each instrument can be processed
with effects to improve the sound, and then its volume is adjusted
accordingly so that it sounds nice with the other instruments (note: this is
a vast simplification of the entire process).

*Filtering* is the process of removing or boosting particular frequencies of
an audio signal. There are lots of different types of filters each designed
to do something different. Since we are talking about vocals today, it's
worth noting that the [average human voice has a frequency range of 80 Hz -
1100 Hz][1]. (The range of human hearing is approximately 50 Hz - 20,000
Hz).  When most people think about removing vocals (or the other instruments)
from a song, they think that they can filter them out. Unfortunately, it's
not that easy.

Why not? So the band went to the studio, recorded a song, and mixed it down.
Why can you "unmix" it? Well, since the tracks are already mixed together,
you would need to remove just the frequencies of the song which contain the
singer's voice (or the other instruments, if you want to make an A Capella
version). The problem is, a [piano has a frequency range of 27.5 Hz - 4186
Hz][2].  The guitar has a frequency range of 80 Hz - 5000 Hz. [And so on][3].

So basically, you can remove the vocals from a song by filtering them out,
but not without removing parts from a bunch of other instruments as well. And
precisely because you'd be removing only parts of the other instruments, the
resulting song would sound very weird and not at all like the original. So
not very much fun to remix or to sing along to. Likewise, if you want to
remove all of the other instruments to make the A Capella version, you'll
find that there will always be some traces of the other instruments along
with the voice, so it wouldn't sound very "clean".

This is simply because a lot of the musical instruments we use occupy the
same frequencies as the human voice.


But maybe it's possible to construct a filter which just takes out the exact
frequency of the particular note being sung at a given moment and not the
entire vocal range? Unfortunately, no, this is not possible. Doing this by
hand would take ages. And machines simply do not hear audio in the same way
as humans do. It is not possible to tell a computer to recognize and separate
the human voice apart from all the other instruments, just like [most people
probably couldn't correctly put the labels on a full box of crayons][4]. And
especially if they had to identify which ones were used in a particular
drawing.

But, even if you could get a computer to recognize the particular frequency
fingerprint of a singer, it still wouldn't work because once again, parts of
the sound from the other instruments will bleed into the singer's frequency
range. And the resulting output, whether you are considering the karaoke
version or the A Capella version, would sound weird.

What about all that shareware software which claims to extract vocals from
MP3's or make A Capella versions from your favorite songs? Simply put, it
will not work. Save your money and your time, because this software applies a
simple filter to the audio data, and **you will be disappointed when you hear
the result**. Trust me on this one. The people that make these things are
dishonest, and sometimes simply repackage open-source audio editing software
and re-label it as their own.


So I said that the long answer to this question is, "technically yes, but not
really, and if you are asking this question, then you don't have access to
the data which would give you what you wanted or else you wouldn't be
asking." Why is that? Well, the "not really" part is what I have just
explained above.

But let's think back to the mixdown. Say you recorded a band, and you still
had the original recordings of each instrument which was used to make the
final version of a song. Then you could easily take just the vocal tracks and
save them to a separate file to make the A Capella version. Or you could mute
the vocals and mix the track with all of the other instruments to make the
karaoke version. But either way, if you already had access to the original
recording session, then you'd realize that you could make an A Capella or
karaoke version if you wanted to, and in that case, you wouldn't be asking. :)


[1]: http://en.wikipedia.org/wiki/Vocal_range
[2]: http://en.wikipedia.org/wiki/Piano_key_frequencies
[3]: http://terrydownsmusic.com/technotes/Frequencies/FREQ.HTM
[4]: http://people.cs.ubc.ca/~brehmer/proj/543.pdf
