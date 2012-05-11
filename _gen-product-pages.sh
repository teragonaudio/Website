#!/bin/bash
dashes="---"
for productDir in $HOME/Code/teragon/* ; do
  productName=$(basename $productDir)
  printf "%s\nlayout: product\ntitle: %s\n%s\n\n" "$dashes" "$productName" "$dashes" > ${productName}.md
  cat $productDir/README.md >> ${productName}.md
done
