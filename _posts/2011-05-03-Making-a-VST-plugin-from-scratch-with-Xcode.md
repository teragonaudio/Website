---
layout: default
title: Making a VST plugin from scratch with Xcode
categories: development
tags: [ VST, Xcode, Mac, Intro ]
alias: /2010/06/making-vst-plugin-from-scratch-with.html
---

Introduction
------------

Developing VST plugins under Mac OSX is in many ways simpler than other
platforms, but nonetheless there are a few "gotchas" along the way.

This guide assumes familiarity with Xcode and C++ development, and that you
are working with Mac OSX 10.5 or greater and have a relatively recent version
of Xcode (4.2 or better). This guide only covers *building VST 2.x plugins*,
as the VST3 SDK is not widely supported yet.

Also, before you start, you will obviously need the VST SDK, which can be
acquired [from Steinberg's Development
Portal](http://www.steinberg.net/en/company/3rd_party_developer.html). Note
that Steinberg's website is a bit confusing and does not label the downloads
clearly, so make sure that you get the right version of the SDK.


Creating your project
---------------------

First, create a new empty Xcode project. Now add a new target to the project,
which should use the "Bundle" template under the "Framework & Library" group
(for Mac OS X, of course). Set the product name, bundle identifier, and choose
to link it against the Cocoa Framework.


Adding resource files
---------------------

Create a new empty file in your project named "PkgInfo" with the contents
"BNDL????" (no quotes, and no newline either). You can verify that this file
will be copied to the VST bundle by clicking on your project's target in the
file browser, and then expanding the "Copy Bundle Resources" section
underneath "Build Phases".

When you created the project, Xcode should also have created a property list
(plist) file for you. Open the plist file for editing, and right click
anywhere in document body to change the view type to "Show Raw Keys/Values".
Now, set the following properties, adding new keys if necessary:

* CFBundleDevelopmentRegion: English
* CFBundleExecutable: vst
* CFBundleGetInfoString: vst
* CFBundleIconFile: (empty)
* CFBundleIdentifier: com.yourcompany.pluginname
* CFBundleInfoDictionaryVersion: 6.0
* CFBundlePackageType: BNDL
* CFBundleSignature: (A unique 4-character identifier of your choosing)
* CFBundleVersion: 1.0
* CSResourcesFileMapped: (empty)


Adding the VST SDK files
------------------------

Create a new group for the VST source files, and drag them from the Finder
into your project. Do not drag the entire vstsdk2.4 folder into your project.
Make sure that the subfolders for "pluginterfaces" and "public.sdk" (excluding
the samples) are in the project.

Now, in the project's properties, go to the "Search Paths" section and add the
vstsdk2.4 directory to the "Header Search Paths" setting. Make it recursive.


Project build settings
----------------------

Unless you have very specific requirements, I highly recommend building your
plugin as a standard 32-bit Intel binary. My reasoning for this is as follows:

- Although 64-bit Macs are widespread, there are not so many 64-bit compatible
  plugin hosts, though this is slowly changing.
- Likewise, building 64-bit VST's is sometimes a bit difficult, as Apple is 
  deprecating Carbon, which is 32-bit only.
- The number of PPC users out there is not so many anymore, so building a
  32-bit Universal Binary is probably overkill.

You can set the build type in the "Architectures" section, and again I
recommend setting this to "32-bit Intel". If anyone can get VST2.4 plugins
building as 32/64 bit UB's, please let me know so I can adapt this
documentation to include how to do this.

Next, set the Base SDK to "Current Mac OS". This will make it much less
painful when opening the project in future versions of Xcode. In the
"Deployment" section, set "Mac OS X Deployment Target" to the *oldest version
of Mac OS X you plan to support*. Setting it to "Compiler Default" is likely
to get you into trouble.

Under "Packaging", make sure that both "Executable Extension" and "Executable
Prefix" are empty. Set "Wrapper Extension" to be "vst".


Frameworks
----------

Again, in your target's settings, go to the "Build Phases" tab and expand the
"Link Binary With Libraries" section. Add the following libraries to your
project:

* QuickTime
* Carbon
* ApplicationServices

Your source code
----------------

Now you are ready to add or create files for your plugin's source code.
