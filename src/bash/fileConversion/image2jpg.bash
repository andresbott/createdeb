#!/bin/bash
# check if dependient executable eyeD3 is pressent
command -v mogrify >/dev/null 2>&1 || { echo >&2 "mogrify is required but it's not installed.  Aborting."; exit 1; }

IMAGE=$1
#transform png to jpg
if [ "jpg" = "$IMAGE_EXTENSION" ]; 

then
    echo "imagen already jpg"
else 

  mogrify -quality 95 -format jpg "$IMAGE";
  echo "imagen:  "$IMAGE" convertida a jpg"
fi