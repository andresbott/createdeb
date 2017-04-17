#!/bin/bash



ORIGIN=`readlink -f "$0"`
BASE=`dirname $ORIGIN`

source createDebFile.conf


CONTROLFILE="$BASE/meta/control"
version=` awk -F ':' '{if (! ($0 ~ /^;/) && $0 ~ /Version/) print $2}' $CONTROLFILE`
version=${version//[[:blank:]]/}


package=` awk -F ':' '{if (! ($0 ~ /^;/) && $0 ~ /Package/) print $2}' $CONTROLFILE`
package=${package//[[:blank:]]/}

arch=` awk -F ':' '{if (! ($0 ~ /^;/) && $0 ~ /Architecture/) print $2}' $CONTROLFILE`
arch=${arch//[[:blank:]]/}

NAME="$package""_""$version-1""_""$arch.deb"

FULLFILE="$BASE/debian-packages/$NAME"

echo $FULLFILE

FULLREMOTE="$DESTREPO/$NAME"

#echo "scp $FULLFILE $USER@$HOST:$FULLREMOTE"
#
#scp $FULLFILE $USER@$HOST:$FULLREMOTE
#
#
### bettir with ssh key

sftp $USER@$HOST  << SOMEDELIMITER
  put $FULLFILE $DESTREPO
  quit
SOMEDELIMITER

