#!/bin/bash
/bin/rm -rf _site
jekyll --no-server
outDir="_out"
/bin/cp -r -v _site/* "${outDir}"
#(cd "${outDir}" && git add -A . && git commit -m "Sync website content" && git push)
