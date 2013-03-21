#!/bin/bash
dashes="---"
for productDir in $HOME/Code/teragon/* ; do
  if [ -e "$productDir/README.md" ] ; then
    productName=$(basename $productDir)
    printf "%s\nlayout: product\ntitle: %s\nalias: /p/%s.html\n%s\n\n" "$dashes" "$productName" "$productName" "$dashes" > ${productName}.md
    cat $productDir/README.md >> ${productName}.md
  fi
done
