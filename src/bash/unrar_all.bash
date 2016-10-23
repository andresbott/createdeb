#!/bin/bash


# for f in *.rar
# do
#       echo "Processing $f file..."
#       rar e $f
# 
# done

# files=(*.rar)
# for f in “${files[@]}”; do rar e “$f”; done




find . -type f|grep .rar |while read file
do
      echo "Processing $file file..."
      rar x -o- "$file"
done











