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

  printf "\n- - -\n\nChangelog:\n" >> "$outputFile"
  (
    cd "$productDir"
    for i in $(git tag --list | $sort --version-sort --reverse) ; do
      printf "\nVersion %s:\n" $i
      # If it's an unsigned commit, then generate a generic message
      git tag --verify $i > /dev/null
      if [ $? -ne 0 ] ; then
        printf "%s Bugfixes\n" "$dash" # Heh
      else
        local numLines=$(git tag --verify $i | tail +7 | wc -l)
        if [ $numLines -eq 0 ] ; then
          printf "(No comment)\n"
        elif [ $numLines -eq 1 ] ; then
          local line=$(git tag --verify $i | tail +7 | cut -d '-' -f 2-)
          printf "<ul><li>%s</li></ul>\n" "$line"
        else
          git tag --verify $i | tail +7
        fi
      fi
    done
  ) >> "$outputFile"
  printf "\n\n" >> "$outputFile"
}

function generateProductPage() {
  local productDir="$1"
  local dashes="---"
  if [ -e "$productDir/README.md" ] ; then
    local productName=$(basename $productDir)
    local outputFile="${productName}.md"
    echo "Generating product page for $productName"
    printf "%s\nlayout: product\ntitle: %s\nalias: /p/%s.html\n%s\n\n" "$dashes" "$productName" "$productName" "$dashes" > "$outputFile"
    cat "$productDir/README.md" | sed -e 's/```c++/\{% highlight cpp %\}/' | sed -e 's/```/\{% endhighlight %\}/' | sed -e 's/^\[[0-9]*\]:.*$//' >> "$outputFile"
    appendChangelog "$productDir" "$outputFile"
    cat "$productDir/README.md" | grep -e '^\[[0-9]*\]:.*$' >> "$outputFile"
  fi
}

if [ "$1" ] ; then
  generateProductPage "$PROJECT_BASE/$1"
else
  for i in $PROJECT_BASE/* ; do
    generateProductPage "$i"
  done
fi
