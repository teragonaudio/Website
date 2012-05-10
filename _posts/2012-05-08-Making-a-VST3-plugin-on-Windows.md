---
layout: default
published: false
---

Sascha Hennig has left a new comment on your post "How to make VST
Plugins in Visual Studio":

For people like fsteff and that Anonymous guy/gal, trying to get to
compile a VST dll with VS10 and/or version 3 of the VST SDK:

Add the files from "VST3 SDK\public.sdk\source\vst2.x" to the project
(right click the project in the solution explorer, add existing files
- best create a filter/folder just for those files as one would
usually not need to mess around with them anyway). Also have a look at
the tutorial solution the SDK comes with (VST3
SDK\vstgui4\vstgui\tutorial\win). It is a solution for VS9, but
converts without problems and you can look at the project settings and
compare with your own to be skeleton project. Obviously also perform
all those steps Nik has mentioned in his guide :) Also, first try to
get the bare bones to work - ie do not add libpng etc.

@Nik: Thanks a lot for this great guide. As I am just switching from
C# to C++ myself, it helped cut down the time I would have needed to
do the same thing immensily and I also did learn a few things in the
progress.

Edit: obviously I meant version 2.4 of the ASIO SDK (which is included
in the V3 download). Also I meant "in the process", well it's been a
long day.
