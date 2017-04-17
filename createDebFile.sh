#!/usr/bin/env bash

ORIGIN=`readlink -f "$0"`
BASE=`dirname $ORIGIN`

source createDebFile.conf

CONTROLFILE="$BASE/meta/control"
version=` awk -F ':' '{if (! ($0 ~ /^;/) && $0 ~ /Version/) print $2}' $CONTROLFILE`
version=${version//[[:blank:]]/}
version1="${version%.*}.$((${version##*.}+1))"
sed -i "/Version:/c\Version: $version1" $CONTROLFILE

echo "increasing minor Release to: $version1"
echo "Create deb File: "
echo "$BASE/createDebFile.sh"



## clean the stage for generating a deb file
if [ "$1" == "clean" ]
then
  echo "Cleaning stage"
  rm -rf ./build_temp
  exit 1
fi


## check for parameter patch version -p
if [ "$1" == "-p" ]
then
  echo "patch version : $2"
  current_patch=$2;
fi


echo "Reading data from meta/control file"

current_version=$(awk -F ":" '/^Version: / {print $2}' ./meta/control)
current_version=${current_version//[[:blank:]]/}
if [ "$current_version" == "" ]
then
  echo "Error: Version not defined in control file, exiting"
  exit 0;
fi


architecture=$(awk -F ":" '/^Architecture: / {print $2}' ./meta/control)
architecture=${architecture//[[:blank:]]/}
if [ "$architecture" == "" ]
then
  echo "Error: Architecture not defined in control file, exiting"
  exit 0;
fi

package_name=$(awk -F ":" '/^Package: / {print $2}' ./meta/control)
package_name=${package_name//[[:blank:]]/}
if [ "$package_name" == "" ]
then
  echo "Error: Package not defined in control file, exiting"
  exit 0;
fi



echo "Starting build of Version $current_version"


# deleting old Build if it exists
rm -rf ./build_temp


# creating the folder again
mkdir ./build_temp

# create the data folder to put binaries in
mkdir ./build_temp/data



if [ "$use_src_as_dir_tree" == "true" ];
    then
        echo "Copying source files";
        # use src dir as absolute path locations
        cp -R ./$src_dir/* ./build_temp/data
    else
        # only use files defined in outFileLocatons
        echo "reading files to copy Lines from";

        while IFS='' read -r line || [[ -n "$line" ]]; do
            if [[ ${line:0:1} != "#" ]] && [[ $line != "" ]] ;   then

                    line_part=($line)

                    inFile="./$src_dir/${line_part[0]}";
                    outDir="./build_temp/data${line_part[1]}";


                    if [[ ${line_part[2]} == "" ]]; then
                            fileName=$(basename $inFile);
                        else
                            fileName=${line_part[2]};
                    fi

                    outFile="$outDir/$fileName";

                    echo "coying $inFile to $outFile";
                    test -d "$outDir" || mkdir -p "$outDir" && cp $inFile "$outFile"
            fi

        done < "./outFileLocations"


fi

# create data.tar.gz
cd ./build_temp/data
tar czf ../data.tar.gz [a-z]*
cd ../../
rm -R ./build_temp/data



# create the control file
echo "creating Cotrol File";
cd meta
tar czf ../build_temp/control.tar.gz *
cd ..

cd build_temp

echo 2.0 > ./debian-binary

finalName=$package_name'_'$current_version'-'$current_patch'_'$architecture.deb;

ar r $finalName debian-binary control.tar.gz data.tar.gz

test -d "../$package_dir" || mkdir -p "../$package_dir"

mv $finalName ../$package_dir


cd ..
echo "Cleaning stage"
rm -rf ./build_temp

echo "Done creating Debian package: $finalName";




if [ $UPLOAD == True ]; then



ORIGIN=`readlink -f "$0"`
BASE=`dirname $ORIGIN`

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



fi


exit 1


