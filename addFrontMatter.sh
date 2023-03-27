#!/bin/bash

# Recurse through all HTML files in the docs directory and add Jekyll front matter

# Before you start, however, rename the following files, because we don't want
# them to have Jekyll front matter.

mv docs/scriptapi/html/index.html docs/scriptapi/html/index.html.new
mv docs/pipeletapi/html/index.html docs/pipeletapi/html/index.html.new
mv docs/compareapi/html/index.html docs/compareapi/html/index.html.new
mv docs/jobstepapi/html/index.html docs/jobstepapi/html/index.html.new
mv docs/xsd/index.html docs/xsd/index.html.new
mv docs/content/index.html docs/content/index.html.new

files=$(find docs -type f -name "*.html")

for file in $files; do

  # Remove all line-breaks from input file to treat it as a single line, save output to $file.new
  tr '\n' ' ' < "$file" > "$file.new"
  
  # Search through the new file and extract the contents between the <title> and </title> tags and place it in the $title variable
  title=$(egrep -o '<title>.*?</title>' "$file.new" | sed 's/<\/*title>//g')

  # Strip the leading and trailing spaces, if any, from the title
  title=$(echo "$title" | sed 's/^ *//;s/ *$//')

  # Add the Jekyll front matter using the $title variable for the value of title
  perl -pi -e "print \"---\nlayout: docs\ntitle: '$title'\n---\n\" if \$. == 1" "$file"
  
  # Remove the new file because it's no longer needed
  rm "$file.new"
done

mv docs/scriptapi/html/index.html.new docs/scriptapi/html/index.html
mv docs/pipeletapi/html/index.html.new docs/pipeletapi/html/index.html
mv docs/compareapi/html/index.html.new docs/compareapi/html/index.html
mv docs/jobstepapi/html/index.html.new docs/jobstepapi/html/index.html
mv docs/xsd/index.html.new docs/xsd/index.html
mv docs/content/index.html.new  docs/content/index.html
