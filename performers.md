---
layout: default
title: Resources for Performers
---

Want to improve your digital DJ skills? Or to try to fit that virtual square
peg in the round hole? Our performer guides will help you figure out how to do
just that.

All performance-related articles
--------------------------------

<ul class="posts">
  {% for post in site.categories.performance %}
    <li><a href="{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>

