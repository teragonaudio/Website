---
layout: product
title: Arooo
redirect_from:
  - /p/Arooo.html
---

Arooo
=====

Arooo is a quick-and-dirty project done for Music Hack Day Stockholm 2013. It
runs on Mac OSX and requires [Midiflower][1] to be installed. Arooo has been
described as "a very high-tech solution to a very low-tech problem", the
problem being that our dog tends to howl when she is home alone. Since I'm not
at home when it happens, I can't be there to correct the behavior, which is
where Arooo comes in.

![Sally][sally]

Given that the dog tends to howl at the same pitches, I analyzed recordings of
some previous howls and isolated the strongest frequencies. Then, using
[FFTReal][2] and [JUCE][3], I set up a basic application to look for those
frequencies.

When Arooo detects that a howl is occurring, it sends a MIDI note to
Midiflower. The idea is that this note can be routed to a synthesizer to play
a horrible noise, which in turn I can train the dog to react to.


License
-------

Arooo, in accordance with JUCE's licensing terms, is released under the GPL.
Please see the file `LICENSE.txt` for more details.





[sally]: http://24.media.tumblr.com/dedc95a587ba2fbbff1f096ddb1192ea/tumblr_mgq89dn02k1rw3kevo1_500.jpg

- - -

Changelog:

Version 0.9.0:
(No comment)


[1]: http://github.com/teragonaudio/Midiflower
[2]: http://ldesoras.free.fr/prod.html
[3]: http://rawmaterialsoftware.com/juce
