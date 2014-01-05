#!/bin/bash
PROJECT_BASE="$HOME/Code/teragon"

function appendChangelog() {
  local productDir="$1"
  local outputFile="$2"
  local dash="-"
  local sort="sort"
  if [ $(uname) == "Darwin" ] ; then
    sort="gsort"
  fi

  printf "\n---\nChangelog:\n" >> "$outputFile"
  (
    cd "$productDir"
    for i in $(git tag --list | $sort --version-sort --reverse) ; do
      printf "\nVersion %s:\n" $i
      # If it's an unsigned commit, then generate a generic message
      git tag --verify $i > /dev/null
      if [ $? -ne 0 ] ; then
        printf "%s Bugfixes\n" "$dash" # Heh
      else
        git tag --verify $i | tail +7
      fi
    done
  ) >> "$outputFile"
}

function generateProductPage() {
  local productDir="$1"
  local dashes="---"
  if [ -e "$productDir/README.md" ] ; then
    local productName=$(basename $productDir)
    local outputFile="${productName}.md"
    echo "Generating product page for $productName"
    printf "%s\nlayout: product\ntitle: %s\nalias: /p/%s.html\n%s\n\n" "$dashes" "$productName" "$productName" "$dashes" > "$outputFile"
    cat "$productDir/README.md" >> "$outputFile"
    appendChangelog "$productDir" "$outputFile"
  fi
}

if [ "$1" ] ; then
  generateProductPage "$PROJECT_BASE/$1"
else
  for i in $PROJECT_BASE/* ; do
    generateProductPage "$i"
  done
fi
