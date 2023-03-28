#!/bin/bash

# Recurse through all HTML files in the docs directory and add Jekyll front matter

# Before you start, however, rename the following files, because we don't want
# them to have Jekyll front matter.

# Current release
mv docs/current/scriptapi/html/index.html docs/current/scriptapi/html/index.html.new
mv docs/current/pipeletapi/html/index.html docs/current/pipeletapi/html/index.html.new
mv docs/current/compareapi/html/index.html docs/current/compareapi/html/index.html.new
mv docs/current/jobstepapi/html/index.html docs/current/jobstepapi/html/index.html.new
mv docs/current/xsd/index.html docs/current/xsd/index.html.new
mv docs/current/content/index.html docs/current/content/index.html.new

# Upcoming release
mv docs/upcoming/scriptapi/html/index.html docs/upcoming/scriptapi/html/index.html.new
mv docs/upcoming/pipeletapi/html/index.html docs/upcoming/pipeletapi/html/index.html.new
mv docs/upcoming/compareapi/html/index.html docs/upcoming/compareapi/html/index.html.new
mv docs/upcoming/jobstepapi/html/index.html docs/upcoming/jobstepapi/html/index.html.new
mv docs/upcoming/xsd/index.html docs/upcoming/xsd/index.html.new
mv docs/upcoming/content/index.html docs/upcoming/content/index.html.new

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

# Now that the front matter was added to all of the html files, 
# move the ".new" files to effectively strip off the file extension 

mv docs/scriptapi/html/index.html.new docs/scriptapi/html/index.html
mv docs/pipeletapi/html/index.html.new docs/pipeletapi/html/index.html
mv docs/compareapi/html/index.html.new docs/compareapi/html/index.html
mv docs/jobstepapi/html/index.html.new docs/jobstepapi/html/index.html
mv docs/xsd/index.html.new docs/xsd/index.html
mv docs/content/index.html.new  docs/content/index.html
mv docs/upcoming/scriptapi/html/index.html.new docs/upcoming/scriptapi/html/index.html
mv docs/upcoming/pipeletapi/html/index.html.new docs/upcoming/pipeletapi/html/index.html
mv docs/upcoming/compareapi/html/index.html.new docs/upcoming/compareapi/html/index.html
mv docs/upcoming/jobstepapi/html/index.html.new docs/upcoming/jobstepapi/html/index.html
mv docs/upcoming/xsd/index.html.new docs/upcoming/xsd/index.html
mv docs/upcoming/content/index.html.new  docs/upcoming/content/index.html

# TODO: For a set of specific files, replace "layout: default" with "layout: default_no_home"

#docs/compareapi/html/whatsnew/toc.html
#docs/current/compareapi/html/whatsnew/toc.html
#docs/upcoming/compareapi/html/whatsnew/toc.html

# TODO: Fix title problem in jekyll front matter with single quotes 

# TODO: Strip all instances of dwscriptlarge.gif.

# TODO: Strip all copyright stuff from ecom files. For example:
# © Copyright 2000-2023, salesforce.com inc. All rights reserved. Various trademarks held by their respective owners.