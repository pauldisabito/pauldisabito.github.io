#!/bin/bash



files=$(find docs/current/sfrajsdoc -type f -name "*.html")

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

files=$(find docs/current/jsdoc -type f -name "*.html")

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