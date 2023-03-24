#!/bin/bash

# Recurse through all HTML files in the docs directory and add front matter

files=$(find docs -type f -name "*.html")

for file in $files; do
  # Extract the filename without the extension
  filename=$(basename "$file" .html)

  # Use perl to add the front matter to the file
  perl -pi -e 'print "---\nlayout: docs\ntitle: '$filename'\n---\n" if $. == 1' "$file"
done
