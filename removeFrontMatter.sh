#!/bin/bash

# Recurse through all HTML files in the docs directory and remove front matter

files=$(find docs -type f -name "*.html")

for file in $files; do
  # Use perl to remove the front matter from the file
  perl -pi -e 's/^---\nlayout: docs\ntitle: .*?---\n//' "$file"
done