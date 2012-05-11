---
layout: default
title: How to make VST plugins in Visual Studio
category: development
tags: [ VST ]
alias: /2010/02/how-to-make-vst-plugins-in-visual.html
---

Introduction
------------

Microsoft announced that it would offer Visual Studio Express free of charge
forever. Though the Express version of Visual C++ (hereafter referred to as
VC++) has some limitations, it's still a great tool and it's nice to see
Microsoft taking some steps to support the developers writing software for
their platform. This document will describe how to get VC++ installed and
building VST plugins. It assumes that you have prior experience developing VST
plugins, and are familiar with the structure and layout of the VST SDK.

If you are trying to write VST's in a language other than C++, than this guide
is not for you. There are lots of other frameworks out there for developing
VST plugins in other languages (such as [C#][1], [Java][2], [Ruby][3] and
[Python][4], just to name a few).

This tutorial will walk you through the process of installing and configuring
the tools you'll need to build your own VST plugins with Visual Studio, and
creating a simple VST plugin with optional support for a VSTGUI frontend. This
guide only covers building VST 2.x plugins, as the 3.x SDK is not very widely
supported yet.

*Note*: This guide was written for Visual Studio 2008, but I'm in the process
of updating it for VS2010. Note that some things may be slightly different.


Download required packages
--------------------------

1. [Steinberg's VST SDK][5], which requires you to make a free [Steinberg
  Developer account][6].
2. [Microsoft's Visual C++][7]. This guide uses the 2008 Express version 9, as
  was the latest at time of writing.
3. [Microsoft's Platform SDK][8]
4. [Libpng][9] and [zlib][10] (optional)


Install Visual C++
------------------

If you already have a working installation of VC++, you can skip this step.
Otherwise, download VC++ and install it. The standard installation should be
OK, but you can choose to perform a custom installation if you don't want
documentation or other stuff installed with it. Before installing VC++, you
must remove any other versions of VC++ on your computer.

Next, download and install the Platform SDK, which will provide you with the
standard header files and libraries you'll need to build software. You may
choose to install VC++ anywhere on your hard drive, but the default location
is `C:\Program Files\Microsoft Visual Studio 9`.


Creating your project
---------------------

Create a new project of type "Class Library", which we'll call
YourProjectName. In the rest of this tutorial, whenever you see
YourProjectName, replace that text with the actual name of your project.

In Visual Studio 9, you'd make a new project with the wizard found at File ->
New -> Project. Select Visual C++ ->→Win32 Console Application, and choose a
directory for your project. When the wizard opens, press "Next" and select
DLL as the Application Type. Also check the "Empty Project" box.

If you prefer not to start with an empty project, then you can remove all of
the files that VC++ creates for you, but keep the `resource.h` and
`YourProjectName.rc` files, and remove any references to these files (such as
`YourProjectName.ico` being listed in the resource file).


Add Source Code to the Project
------------------------------

If you already have source code for your plugin, simply add it to the project.
Otherwise, you need to create the following files:

* YourProjectName.cpp
* YourProjectName.h
* resource.h (Only needed if building a plugin GUI)
* YourProjectName.rc (Only needed if building a plugin GUI)

You will also need to add the files from the VST SDK, which includes
everything under the `vstsdk2.4/public.sdk/source/vst2.x` and
`vstsdk2.4/pluginterfaces/vst2.x` directories.


To start out with, the plugin's entry point header file (YourProjectName.h)
should look something like this:

{% highlight cpp %}

#include "audioeffectx.h"

#define NUM_PARAMS 0

class YourProjectName : public AudioEffectX {
public:
  YourProjectName(audioMasterCallback audioMaster);
  ~YourProjectName();

  void processReplacing(float **inputs, float **outputs, VstInt32 sampleFrames);
};

{% endhighlight %}

The accompanying class definition (YourProjectName.cpp) should look something
like this:

{% highlight cpp %}

#include "YourProjectName.h"

AudioEffect* createEffectInstance(audioMasterCallback audioMaster) {
  return new YourProjectName(audioMaster);
}

YourProjectName::YourProjectName(audioMasterCallback audioMaster) :
AudioEffectX(audioMaster, 0, NUM_PARAMS) {
}

YourProjectName::~YourProjectName() {
}

void YourProjectName::processReplacing(float **inputs, float **outputs,
VstInt32 sampleFrames) {
  // Real processing goes here
}

{% endhighlight %}

The above code samples are simply blank entry points which don't do anything
exciting. The VST SDK offers lots of methods which you can override in order
to do things like setting parameters, receiving MIDI messages, and so on.
These things are beyond the scope of this tutorial; if you don't know what
code to put inside of processReplacing, try checking out the "again" example
distributed within the VST SDK in the `public.sdk/samples/vst2.x/again`
folder.

You must also create a module definition file for your project, named
YourProjectName.def. Usually this file is placed in the same directory as the
VC++ project file, but you may place it somewhere else so long as this
definition matches the Module Definition File settings in the Linker section
of the project preferences. This is just a plain-text file which should
contain the following text:

{% highlight text %}

LIBRARY YOURPROJECTNAME
EXPORTS
VSTPluginMain 
main=VSTPluginMain

{% endhighlight %}


Configure build settings
------------------------

Go to the project settings either by double clicking on the project name in
the Property Manager or in the menu under Project -> YourProjectName
Properties. Make the following changes to the project for all build
configurations:

<ul>
<li>General<ul>
  <li>Character Set: Not Set</li>
  <li>Common Language Runtime Support: No Common Language Runtime Support</li>
</ul></li>
<li>C/C++<ul>
  <li>General:<ul>
    <li>Additional Include Directories:<ol>
      <li><pre>"$(ProjectDir)\vstsdk2.4"</pre> (or wherever you put the VST SDK)</li>
      <li><pre>"$(ProjectDir)\vstsdk2.4\public.sdk\source\vst2.x"</pre></li>
      <li>Your source code directory</li>
      <li>Any other directories which you may have header files stored in
        Global SDK directories, such as
        <pre>C:\Program Files\Microsoft Platform SDK\Include\mfc</pre></li>
    </ol></li>
  </ul></li>
  <li>Preprocessor:<ul>
    <li>Preprocessor Definitions:
      <pre>WINDOWS;_WINDOWS;WIN32;_USRDLL;_USE_MATH_DEFINES</pre>
    </li>
    <li>For <b>Debug</b> builds you may also wish to add
      <pre>DEBUG=1;_DEBUG=1</pre></li>
    <li>If you wish to use PNG graphics for a VSTGUI frontend, add
      <pre>USE_LIBPNG=1</pre></li>
    <li>To avoid lots of compiler nags and warnings, define
      <pre>_CRT_SECURE_NO_DEPRECATE</pre></li>
    <li>In some cases, you may also need to define
      <pre>VST_FORCE_DEPRECATED=0</pre></li>
  </ul></li>
  <li>Code Generation:<ul>
    <li>Runtime Library: Multi-threaded. Multi-threaded debug may be used for
      debug builds. This will build the VC++ common runtime library
      statically into your plugin, increasing its size by approximately
      200Kb. If you choose to use the CRL as a dynamic library, then you
      must also distribute a copy of the CRL with your application, which
      complicates deployment and distribution.</li>
  </ul></li>
  <li>Precompiled Headers:<ul>
    <li>Create/Use Precompiled Header: Not Using Precompiled Headers. Yeah,
      this makes rebuilding a bit slower, but will avoid a bunch of weird
      errors as you are getting your project set up.</li>
  </ul></li>
  <li>Browse Information:<ul>
    <li>Enable Browse Information: None</li>
  </ul></li>
  <li>Advanced:<ul>
    <li>Compile As: Default</li>
  </ul></li>
</ul></li>
<li>Linker<ul>
  <li>General:<ul>
    <li>Additional Library Directories: Add any other library directories
      which your project depends on.</li>
  </ul></li>
  <li>Input:<ul>
    <li>Additional Dependencies (for <b>Release</b> builds):<ul>
      <li>libcmt.lib</li>
      <li>uuid.lib</li>
      <li>shell32.lib</li>
      <li>ole32.lib</li>
      <li>gdi32.lib</li>
      <li>User32.lib</li>
      <li>advapi32.lib</li>
      <li>zlib.lib (only if you are building with a GUI)</li>
      <li>libpng.lib (only if you are building with a GUI)</li>
    </ul></li>
    <li>Additional Dependencies (for <b>Debug</b> builds):<ul>
      <li>shell32.lib</li>
      <li>msvcrtd.lib</li>
      <li>ole32.lib</li>
      <li>gdi32.lib</li>
      <li>User32.lib</li>
      <li>advapi32.lib</li>
      <li>zlib.lib (only if you are building with a GUI)</li>
      <li>libpng.lib (only if you are building with a GUI)</li>
    </ul></li>
    <li>Ignore Specific Library (for <b>Release</b> builds):<ul>
      <li>msvcrt.lib</li>
      <li>libc.lib</li>
      <li>msvcrtd.lib</li>
      <li>libcd.lib</li>
      <li>libcmtd.lib</li>
    </ul></li>
    <li>Ignore Specific Library (for <b>Debug</b> builds):<ul>
      <li>libcmt.lib</li>
      <li>libcmtd.lib</li>
      <li>msvcrt.lib</li>
    </ul></li>
    <li>Module Definition File: YourProjectName.def</li>
  </ul></li>
</ul></li>
</ul>


Adding support for VSTGUI (optional)
------------------------------------

nclude VSTGUI support in your plugin, simply add the VSTGUI files into your
project in addition to your own editor class. At a very minimum, these are:

* aeffguieditor.cpp
* vstcontrols.cpp
* vstgui.cpp


Adding support for PNG graphics (optional)
------------------------------------------

If you would like to use PNG's in your plugin instead of BMP graphics, you
will need to also build your own version of libpng and zlib. Download the
source code for both libraries from the links given in the "Requirements"
section of the document and place them in the same directory. There is a
Visual Studio project for libpng which will also build zlib for you; it is
located in the `projects\visualc71` directory. In order to get the projects to
build correctly, you'll need to rename the source code directories to simply
"libpng" and "zlib", removing the version numbers from the directory name.

When you open the project up, VC++ will run you through the project conversion
wizard. Convert the project, and change the "Runtime Library" settings in both
libpng and zlib to be Multi-Threaded, as described above. Unless this step is
performed, the dependency on the CLR will be present in your project. Next,
choose the LIB ASM Release or LIB Release build style and build the project;
if you build the libraries as DLL's, you will be unable to statically link
them into your plugin. The project should build ok, but throw a few errors
when attempting to run the pngtest files. You can ignore these problems, as
the libraries will still be correctly compiled and can now be linked to your
project.

Visual Studio doesn't need to have the libraries within your actual project.
Instead, place the libraries in a directory of your choosing and be sure to
add this path to the list of "Additional Library Directories" in the Linker
preferences for your project. You may choose to place the libraries in the
same directory as the Microsoft Platform SDK stuff, but I personally prefer to
keep them in a separate directory checked into CVS. Also be sure to add
references to `libpng.lib` and `zlib.lib` for your project in the "Additional
Dependencies" section of your Linker preferences for the project.

{% highlight text %}

IDB_BITMAP1 PNG DISCARDABLE "../resources/bmp10001.png"
IDB_BITMAP2 PNG DISCARDABLE "../resources/bmp10002.png"

{% endhighlight %}

The path must be relative to the location of the project file. Then, in
`resource.h`, add the following proprocessor definitions:

{% highlight cpp %}

#define IDB_BITMAP1 1
#define IDB_BITMAP2 2

{% endhighlight %}

Now you can use `IDB_BITMAP1` (or any other name of your choosing) in your
code when creating new CBitmap objects.


Final considerations
--------------------

VC++ ships with an optimizing compiler, but sometimes the compiler will choke
on certain files and optimization must be disabled. In particular, I have
experienced this with Laurent de Soras' FFTReal libraries, since they are
written as template classes. In general, however, optimization is a good idea,
as is Eliminating Unreferenced Data (in the linker settings). The "Whole
Program Optimization" setting appears tempting, but usually results in dozens
of build errors and problems, so it's best to avoid this. Also, be sure to use
the optimization features of this compiler and linker, as they can greatly
boost runtime performance.

If you are developing on a multi-core machine, then you should disable
parallel builds by setting the number of parallel builds to 1 under Tools ->
Options -> Projects and Solutions -> Build and Run. VS does not always link
your projects in the order which you would expect it to, and this causes
errors during linking with missing symbols. This behavior may be fixed in more
recent builds of VC++, but as of this writing, I was still having experiencing
this problem.


Troubleshooting Common Problems
===============================

Unresolved symbols when linking
-------------------------------

Sometimes you may see errors like the following:

{% highlight text %}
audioeffect.obj : error LNK2001: unresolved external symbol __imp__strncat
audioeffect.obj : error LNK2001: unresolved external symbol __imp__strncpy
{% endhighlight %}

If you are getting errors in your build about missing symbols, make sure that
you double- and triple-check the debug and release configurations for the
library configuration above, since some of the libraries which are used in one
build style are specifically excluded from the other. Also, when you close and
re-open the project's build properties, VS always "forgets" the last selected
build style, so remember to check and set this appropriately.

Also, you should check to make sure that the Platform SDK was correctly
installed on your system and that your project's include and library paths are
pointing to these directories.


Unresolved external symbols
---------------------------

If you are seeing errors like this:

{% highlight text %}
VST1.def : error LNK2001: unresolved external symbol VSTPluginMain
{% endhighlight %}

Then this most likely means that the file which contains the given symbol is
not correctly added to the VC++ solution.


Linking errors with symbols defined multiple times
--------------------------------------------------

This is undoubtably one of the most frustrating problems which can occur when
building a VST in VC++. If you are seeing error messages like this, then it
most likely means there is some problem with your library configuration:

{% highlight text %}
msvcrtd.lib(ti_inst.obj) : error LNK2005: "private: __thiscall
type_info::type_info(class type_info const &)" (??0type_info@@AAE@ABV0@@Z)
already defined in libcmt.lib(typinfo.obj) {% endhighlight %}

Most likely, the libcmt and msvcrt libraries are being included incorrectly
in your build. Double-check the library list above, keeping in mind that the
recommended configuration uses libcmt for **release** builds only, and msvcrtd
for **debug** builds only.


[1]: http://vstnet.codeplex.com/
[2]: http://jvstwrapper.sourceforge.net/
[3]: https://github.com/thbar/opaz-plugdk
[4]: https://code.launchpad.net/pyvst
[5]: http://www.steinberg.net/en/company/3rd_party_developer.html
[6]: http://www.steinberg.net/en/company/3rd_party_developer/sdk_download_portal/create_3rd_party_developer_account.html
[7]: http://msdn.microsoft.com/vstudio/express/visualc/
[8]: http://msdn.microsoft.com/windows/bb980924.aspx
[9]: http://www.libpng.org/pub/png/libpng.html
[10]: http://www.zlib.net/
