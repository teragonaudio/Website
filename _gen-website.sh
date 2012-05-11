#!/bin/bash
jekyll --no-server
/bin/cp -r -v _site/* ../teragonaudio.github.com
(cd ../teragonaudio.github.com && git add -A . && git commit -m "Sync website content" && git push)
