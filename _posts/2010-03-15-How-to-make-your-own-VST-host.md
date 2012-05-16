---
layout: default
title: How to make your own VST host
category: development
tags: [ VST, Intro ]
alias: /2010/03/how-to-make-your-own-vst-host.html
---

Introduction
------------

Writing VST plugins is a lot of fun, but it's even more fun to write your own
host which uses the wide variety of plugins already out there to do something
original and new. Making your own VST host is not a trivial task, but the
trickiest part is figuring out how to load the plugins and connect them to
your code's callback functions. As the VST documentation is a bit sparse on
the subject of hosting, this guide will assist you in setting up your own
host.

This guide only covers loading the plugin and basic communication, and the
language of choice here is C++. C# programmers should consider using the
[VST.NET framework][1], and I'm not sure what frameworks exist for other
languages.

Also, it's worth noting that Teragon Audio has developed an [open-source VST
host, MrsWatson][7]. Feel free to look at the code and fork it for your own
project! If you find yourself using a substantial portion of the MrsWatson
source in your own code, please let me know so I can add a link to your
project from the MrsWatson page.


Code conventions
----------------

In the course of your development, you will probably require logging, error
handling, etc. To simplify the code in this tutorial, I have simply written
"return -1" or "return NULL" statements, but you should consider expanding
this to log some info or handle the error.

Also, this tutorial is written for both Windows and Mac OSX developers. As
such, there is a lot of platform-specific code, which you will probably need
to box with #ifdef/#endif statements in the preprocessor.


Setting up your build environment
---------------------------------

You'll need to first download and install the following tools:

1. [Steinberg's VST SDK][2], which requires you to make a [free Steinberg
  Developer account][3]. This tutorial assumes you are working with the
  VST 2.4 SDK.
2. [Microsoft's Visual C++ 2010 Express][4], if you wish to support Windows.
3. [Microsoft's Platform SDK][5], again if you are developing on Windows.
4. [Xcode 4.x][6], if you are developing on Mac OS X.


Project configuration
---------------------

Aside from your project files, you need only to add the VST SDK headers into
your project's include path. This includes the following files, which are
located under the vstsdk2.4/pluginterfaces/vst2.x directory:

* aeffect.h
* aeffectx.h
* vsfxstore.h

On both Windows and Mac OSX, you should probably configure your program to
build as a 32-bit binary, simply because most VST plugins are not 64-bit
compatible yet. On the Mac, this gets to be a bit hairy because Apple is
working to deprecate Carbon, which is a 32-bit framework. If anyone out there
has example code in C (not objective-C) to load a plugin from bundle without
using Carbon, please let me know so I can update this article.


Loading the VST plugin
----------------------

After your host performs its own internal initialization routines, it is time
to load the VST plugin from source. This procedure varies a bit depending on
the platform, but the algorithm is fundamentally the same: find the plugin,
load the dynamic library into memory, acquire the plugin's main address, and
create a VST callback connection. These callbacks are defined function
pointers which you should define in one of your project's header files, and
are as follows:

{% highlight cpp %}

#include "aeffectx.h"

// C callbacks
extern "C" {
// Main host callback
  VstIntPtr VSTCALLBACK hostCallback(AEffect *effect, VstInt32 opcode,
    VstInt32 index, VstInt32 value, void *ptr, float opt);
}

// Plugin's entry point
typedef AEffect *(*vstPluginFuncPtr)(audioMasterCallback host);
// Plugin's dispatcher function
typedef VstIntPtr (*dispatcherFuncPtr)(AEffect *effect, VstInt32 opCode,
  VstInt32 index, VstInt32 value, void *ptr, float opt);
// Plugin's getParameter() method
typedef float (*getParameterFuncPtr)(AEffect *effect, VstInt32 index);
// Plugin's setParameter() method
typedef void (*setParameterFuncPtr)(AEffect *effect, VstInt32 index, float value);
// Plugin's processEvents() method
typedef VstInt32 (*processEventsFuncPtr)(VstEvents *events);
// Plugin's process() method
typedef void (*processFuncPtr)(AEffect *effect, float **inputs,
  float **outputs, VstInt32 sampleFrames);

{% endhighlight %}

On Windows, VST plugins are simply dynamically linked libraries (DLL's). The
code for opening a DLL library in Windows is fairly simple:

{% highlight cpp %}

AEffect* loadPlugin() {
  AEffect *plugin = NULL;
  char *vstPath = "c:\\wherever\\the\\plugin\\is\\located.vst";

  modulePtr = LoadLibrary(vstPath);
  if(modulePtr == NULL) {
    printf("Failed trying to load VST from '%s', error %d\n",
      vstPath, GetLastError());
    return NULL;
  }

  vstPluginFuncPtr mainEntryPoint =
    (vstPluginFuncPtr)GetProcAddress(modulePtr, "VSTPluginMain");
  // Instantiate the plugin
  plugin = mainEntryPoint(hostCallback);
  return plugin;
}

{% endhighlight %}

On Mac OSX, VST plugins are also dynamic libraries, but they are packaged as
bundles. Your host can open these bundles through the Carbon API. On Mac OS9,
VST plugins were packaged as CFM files, which has long since been deprecated,
and it is highly unlikely that any modern VST host should need to support this
format.

The procedure for opening a plugin under OSX is a bit more complex, but the
code should be fairly straightforward. Keep in mind that although a VST plugin
can be loaded from any location on disk, they are usually stored in either
`/Library/Audio/Plug-Ins/VST` or `$HOME/Library/Audio/Plug-Ins/VST`.

Anyways, to load the VST plugin on Mac OSX, that will look something like
this:

{% highlight cpp %}

AEffect* loadPlugin() {
  AEffect *plugin = NULL;
  audioMasterCallback hostCallbackFuncPtr = hostCallback;
  char *pluginPath = "/wherever/the/plugin/is/located.vst";

  // Create a path to the bundle
  CFStringRef pluginPathStringRef = CFStringCreateWithCString(NULL,
    pluginPath, kCFStringEncodingASCII);
  CFURLRef bundleUrl = CFURLCreateWithFileSystemPath(kCFAllocatorDefault,
    pluginPathStringRef, kCFURLPOSIXPathStyle, true);
  if(bundleUrl == NULL) {
    printf("Couldn't make URL reference for plugin\n");
    return NULL;
  }

  // Open the bundle
  CFBundleRef bundle;
  bundle = CFBundleCreate(kCFAllocatorDefault, bundleUrl);
  if(bundle == NULL) {
    printf("Couldn't create bundle reference\n");
    CFRelease(pluginPathStringRef);
    CFRelease(bundleUrl);
    return NULL;
  }

  vstPluginFuncPtr mainEntryPoint = NULL;
  mainEntryPoint = (vstPluginFuncPtr)CFBundleGetFunctionPointerForName(bundle,
    CFSTR("VSTPluginMain"));
  // VST plugins previous to the 2.4 SDK used main_macho for the entry point name
  if(mainEntryPoint == NULL) {
    mainEntryPoint = (vstPluginFuncPtr)CFBundleGetFunctionPointerForName(bundle,
      CFSTR("main_macho"));
  }

  if(mainEntryPoint == NULL) {
    printf("Couldn't get a pointer to plugin's main()\n");
    CFBundleUnloadExecutable(bundle);
    CFRelease(bundle);
    return NULL;
  }

  plugin = mainEntryPoint(hostCallback);
  if(plugin == NULL) {
    printf("Plugin's main() returns null\n");
    CFBundleUnloadExecutable(bundle);
    CFRelease(bundle);
    return NULL;
  }

  // Clean up
  CFRelease(pluginPathStringRef);
  CFRelease(bundleUrl);

  return plugin;
}

{% endhighlight %}

You need to keep the bundle pointer around until the host is ready to unload the
plugin. At this point, you call `CFBundleUnloadExecutable` and then `CFRelease`
on the bundle's reference.


Setting up plugin callbacks
---------------------------

At this point, you should now have successfully loaded the plugin into memory,
and you can now establish the plugin dispatcher callbacks:

{% highlight cpp %}

int initPlugin(AEffect *plugin) {
  // Check plugin's magic number
  // If incorrect, then the file either was not loaded properly, is not a
  // real VST plugin, or is otherwise corrupt.
  if(plugin->magic != kEffectMagic) {
    printf("Plugin's magic number is bad\n");
    return -1;
  }

  // Create dispatcher handle
  dispatcherFuncPtr dispatcher = (dispatcherFuncPtr)(plugin->dispatcher);

  // Set up plugin callback functions
  plugin->getParameter = (getParameterFuncPtr)plugin->getParameter;
  plugin->processReplacing = (processFuncPtr)plugin->processReplacing;
  plugin->setParameter = (setParameterFuncPtr)plugin->setParameter;

  return plugin;
}

{% endhighlight %}


Plugin initialization
---------------------

At this point, the plugin should be ready to go, so you can initialize it
through the dispatcher handle created in the previous step:

{% highlight cpp %}

void initPlugin(AEffect *plugin) {
  dispatcher(plugin, effOpen, 0, 0, NULL, 0.0f);

  // Set some default properties
  float sampleRate = 44100.0f;
  dispatcher(plugin, effSetSampleRate, 0, 0, NULL, sampleRate);
  int blocksize = 512;
  dispatcher(plugin, effSetBlockSize, 0, blocksize, NULL, 0.0f);

  resume();
}

{% endhighlight %}


Suspending and resuming
-----------------------

Calling the plugin's suspend and resume methods are a bit counter-intuitive,
and are done like this:

{% highlight cpp %}

void resumePlugin(AEffect *plugin) {
  dispatcher(plugin, effMainsChanged, 0, 1, NULL, 0.0f);
}

void suspendPlugin(AEffect *plugin) {
  dispatcher(plugin, effMainsChanged, 0, 0, NULL, 0.0f);
}

{% endhighlight %}


Plugin capabilities
-------------------

The VST protocol uses "canDo" strings to define plugin capabilities, the most
common of which are defined in audioeffectx.cpp in the PlugCanDos namespace
near the top of the file. To ask a plugin if it supports one of these
capabilities, make the following dispatcher call:

{% highlight cpp %}

bool canPluginDo(char *canDoString) {
  return (dispatcher(plugin, effCanDo, 0, 0, (void*)canDoString, 0.0f) > 0);
}

{% endhighlight %}


Host capabilities
-----------------

The plugin can also ask the host if it supports a given capability, which is
done through the hostCallback() function defined above. The implementation of
this file looks something like this:

{% highlight cpp %}

extern "C" {
VstIntPtr VSTCALLBACK hostCallback(AEffect *effect, VstInt32 opcode, VstInt32 index,
  VstInt32 value, void *ptr, float opt) {
  switch(opcode) {
    case audioMasterVersion:
      return 2400;
    case audioMasterIdle:
      effect->dispatcher(effect, effEditIdle, 0, 0, 0, 0);
    // Handle other opcodes here... there will be lots of them
    default:
      printf("Plugin requested value of opcode %d\n", opcode);
      break;
  }
}
}

{% endhighlight %}

The full list of opcodes is defined in aeffect.h (for the VST 1.x protocol)
and aeffectx.h (for VST 2.x protocol). There are a lot of opcodes, and your
application doesn't need to support them all, but you will soon figure out
which ones are the most important through trial and error. Depending on the
nature of the opcall, you will either be required to return a given integer
value, call a method in the plugin's dispatcher, or fill the `*ptr` pointer
with some type of data. The VST SDK header files have fairly good
documentation specifying what you need to do depending on the opcode.

The [MrsWatson source code][7] also contains an example implementation of this
function with the most common opcode cases.


Processing audio
----------------

In the VST SDK 2.4, `processReplacing()` became the new standard call. You may
have to add in support to your host for the old style of `process()` plugins,
though there aren't so many plugins out there which still do this. To have the
plugin process some audio:

{% highlight cpp %}

void processAudio(AEffect *plugin, float **inputs, float **outputs,
  long numFrames) {
  // Note: If you are processing an instrument, you should probably zero
  // out the input channels first to avoid any accidental noise. If you
  // are processing an effect, you should probably zero the values in the
  // output channels. See the silenceChannel() function below.
  plugin->processReplacing(plugin, inputs, outputs, numFrames);
}

void silenceChannel(float **channelData, int numChannels, long numFrames) {
  for(int channel = 0; channels < numChannels; ++channel) {
    for(long frame = 0; frame < numFrames; ++frame) {
      channelData[channel][frame] = 0.0f;
    }
  }
}

{% endhighlight %}

Note that you need to properly allocate the arrays for the audio inputs and
outputs depending on your blocksize and channel count. Like a regular VST
plugin, this structure is simply a de-interlaced array ordered by channel of
the sample block data, with the left channel being the first one. You should
also take care to properly initialize the data in both the inputs and outputs
array to zero, or else you can get static or other random noise in the
processed signal.


Sending MIDI messages
---------------------

Processing MIDI events is very similar to processing audio:

{% highlight cpp %}

void processMidi(AEffect *plugin, VstEvents *events) {
  dispatcher(plugin, effProcessEvents, 0, 0, events, 0.0f);
}

{% endhighlight %}

The above events array should be allocated and properly initialized by the
host to contain the MIDI events which the plugin will receive. The `VstEvent`
structure is defined in aeffectx.h, and there you will also find the
respective `VstEvent` types, all of which are deprecated except for
`kVstMidiType` and `kVstSysExType`.

Note that the plugin must support the `receiveVstMidiEvent` canDo in order to
process MIDI.


Final Notes
-----------

At this point, you should have a basic working host capable of loading and
communicating with a VST plugin. As you continue your development, take care
to thoroughly read the VST SDK header files and other associated
documentation, as they will provide you with further hints as to the correct
implementation. Also, you should take time to create good logging facilities
in your host, particularly in the `hostCallback()` method, as most plugin
incompatibilities are usually triggered from some miscommunication there.


[1]: http://www.codeplex.com/vstnet
[2]: http://www.steinberg.net/en/company/3rd_party_developer.html
[3]: http://www.steinberg.net/en/company/3rd_party_developer/sdk_download_portal/create_3rd_party_developer_account.html
[4]: http://msdn.microsoft.com/vstudio/express/visualc/
[5]: http://www.microsoft.com/downloads/details.aspx?FamilyId=0BAF2B35-C656-4969-ACE8-E4C0C0716ADB&displaylang=en
[6]: http://developer.apple.com/programs/mac/
[7]: http://teragonaudio.github.com/MrsWatson

