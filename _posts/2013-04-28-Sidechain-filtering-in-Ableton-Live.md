---
layout: default
title: Sidechain filtering in Ableton Live
category: performance
tags: [ Ableton ]
---

Introduction
------------

Sidechain filtering is a very powerful (and mostly unknown) technique which
can be used to surgically replace the bassline of one track with another. The
result is a much cleaner sounding mix, especially when mixing between two
tracks with strong basslines or kicks.

On a standard 3-band equalizer, most DJ's would simply turn the lower knob
down for the track which they want to remove bass frequencies from. This
results in the track losing *all* low frequencies, whereas sidechain filtering
removes only *the exact* frequencies in the other track. Most conventional DJ
software isn't able to do sidechain filtering at all, but in Ableton Live it's
very easy to build a custom filterchain for DJ'ing, which is exactly what is
needed here.

It's easier to show sidechain filtering in action than to explain it.  Here's
a sample mix, where song A plays (in full) for 32 beats, then song B for 32
beats. Then for 32 beats, song A & B play together, but only with the bass
frequencies from song B. For the last 32 beats, the sidechain filters flip and
only the bass frequencies from song A are heard.

[Sidechain filtering example mix][1]


Setting Up Filtering
--------------------

To get started, let's build a sidechain filter for an arbitrary number of
decks. This is a bit simpler than a 2-deck setup and can support an unlimited
number of tracks, but also has a few other drawbacks which will be discussed
later.

First, set up a return track named "sidechain" (always label your tracks!) and
set the output to "Sends Only". Route all tracks to this one by turning the
send knob up to the maximum.

![Setting up return tracks for sidechaining](http://static.teragonaudio.com/sidechain-filtering-basic-setup.png)

Next, put an EQ Eight in the sidechain return track. Configure it to be a
lowpass filter with a cutoff frequency of around 650Hz and set the Q to 1.0.

![Lowpass filter configuration](http://static.teragonaudio.com/sidechain-filtering-lowpass-filter.png)

Now, in each deck track, add a Compressor. Expand it by clicking the small
downward-pointing arrow in the top left-hand corner, and enable sidechaining.
Set "Audio From" to be "A-Sidechain", Post FX.

![Sidechain compressor configuration](http://static.teragonaudio.com/sidechain-flitering-sidechain-compressor.png)

To actually apply the sidechain filter, MIDI map the "Gain" knob with a range
of 0.00 dB - 24.0 dB. At 0.00 dB, no filtering is applied. At 24.0 dB, the
bass frequencies of all *other* tracks will be subtracted from this one,
meaning that their basslines will punch through those of this track.

That's the basic idea for sidechain filtering. However, this particular setup
has a few disadvantages. First, it uses a return track, and Ableton Live has a
hard-coded limitation of 12 return tracks in a liveset. If your set has a lot
of return tracks, you may not have room for an extra one just for sidechain
filtering.

The other problem is that when only one track is playing and the Gain is
turned up to 24.0 dB, the bass of this track will be subtracted from itself.
Because the sidechain routing applies a small latency, the bass is not
completely removed but instead softened. So if you are mixing and forget to
set this knob back to 0.00 dB, the kick and bassline will be softer than
expected.


An Improved Setup
-----------------

To get around the two problems above, one can set up two sidechain filters
which subtract cleanly from each other's basslines. While solving these
problems, this configuration also has another limitation, which is that it
only works for 2 decks. Again, there is a workaround for this, which will be
discussed later. First, remove the sidechain return track from the set and
create two new audio tracks, named "Sidechain 1" and "Sidechain 2". Set their
outputs to "Sends Only" and have them pull audio from "Deck 1" and "Deck 2",
respectively. Also set monitoring to "In" for both sidechain tracks.

![Setting up tracks for sidechaining](http://static.teragonaudio.com/sidechaing-filtering-tracks-setup.png)

In each sidechain track, add the same EQ Eight as was described above. Now,
for both Deck 1 & 2, set the compressor's sidechain input to be the output of
the other's sidechain track, so that in Deck 1 the compressor pulls audio from
Sidechain 2, and vice versa.

![Sidechain compressor for tracks](http://static.teragonaudio.com/sidechain-filtering-pull-from-track.png)

Now the sidechain setup involves no return tracks, and leaving the Gain up
will have no effect if only one track is playing. The result is an even
cleaner sidechain filter, but again, the limitation of 2 decks is a bit
irritating.


An Improved Setup For More Decks
--------------------------------

To have the cleaner version of sidechain filtering with 3+ decks, a bit more
work is needed. First, add another track which will grab the output of Deck 3
and apply a lowpass filter to it, just like for Decks 1 & 2. For each of the
decks, duplicate the compressor and set input to pull audio from the new
source. So Deck 1 will have sidechain filters for Decks 2 & 3, Deck 2 will
have them for 1 & 3, and Deck 3 will have them for 1 & 2.

This can start to become difficult to manage, so group the two compressors
into an audio effect rack. Turn on mapping mode, and set the Gain of *both*
compressors to a knob in the rack. Now when this knob is turned, it will
subtract bass from all other tracks.

![Filtering from mulitple tracks](http://static.teragonaudio.com/sidechain-filtering-multiple-tracks.png)

For 4 decks, just repeat this procedure and add an extra compressor to the
rack. Finally, I like to group the sidechain audio tracks and fold it away;
it's not necessary to see the output of these tracks and they can simply be
tucked away in the liveset.

Happy mixing!


[1]: http://static.teragonaudio.com/sidechain-filtering-example.mp3
