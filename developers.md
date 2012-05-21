---
layout: default
title: Developer Resources
alias: /p/developer-tools.html
---

Getting started with audio development
--------------------------------------

So you've got a great idea for a piece of audio software and don't know where
to start? Check out these guides:

<ul class="posts">
  {% for post in site.tags.Intro %}
    <li><a href="{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>

All development-related articles
--------------------------------

<ul class="posts">
  {% for post in site.categories.development %}
    <li><a href="{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>

Getting help
------------

Sometimes getting help for audio related stuff can be hard, as there are not
so many developers doing it. However, the best places to ask your questions
are generally [StackOverflow](http://stackoverflow.com) and the [KVR DSP &
Plug-In Development Forum](http://www.kvraudio.com/forum/viewforum.php?f=33).

