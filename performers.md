---
layout: default
title: Resources for Performers
---

All performance-related articles
--------------------------------

<ul class="posts">
  {% for post in site.categories.performance %}
    <li><a href="{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>

