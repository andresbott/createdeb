#!/usr/bin/env bash
# check if dh-make is installed
command -v dh_make >/dev/null 2>&1 || { echo >&2 "dh-make package is required but it's not installed.  Aborting."; exit 1; }
command -v debuild >/dev/null 2>&1 || { echo >&2 "devscripts package is required but it's not installed.  Aborting."; exit 1; }
command -v basename >/dev/null 2>&1 || { echo >&2 "basename program is required but it's not installed.  Aborting."; exit 1; }



## clean the stage for generating a deb file
if [ $1 == "clean" ]
then
  echo "Cleaning stage"
  rm -rf ./build_temp
  exit 1
fi



echo "Reading config from \"createDebFile.conf\"" >&2
source ./createDebFile.conf

current_minor_version=$((current_minor_version + 1));

echo "Starting build of Version $current_major_version.$current_minor_version"


# deleting old Build if it exists
rm -rf ./build_temp


# creating the folder again
mkdir ./build_temp
cd ./build_temp


DEBFOLDERNAME=$package_name-$current_major_version.$current_minor_version

# Create your scripts source dir
mkdir $DEBFOLDERNAME



cd ..
# recursively scan src, find files and copy to build stage
#find ./src -type f -exec EE={} \;  echo $(basename "$EE") \;

find ./src -type f -exec echo "Copying file: {} " \; -exec cp {} ./build_temp/$DEBFOLDERNAME \;

cd ./build_temp/$DEBFOLDERNAME


# Create the packaging skeleton (debian/*)
export DEBFULLNAME=$package_maintaner;
dh_make -i -c lgpl -e $package_mail --createorig -y

### arrange, delete and modify some files;

# Remove make calls
#grep -v makefile debian/rules > debian/rules.new
#mv debian/rules.new debian/rules
#rm debian/rules;
#rm -rf debian/source
#rm debian/*.ex
#rm debian/*.EX

#rm debian/README.source
#rm debian/README.Debian


find ../../meta -type f -exec echo "Copying file: {} " \; -exec cp {} ./debian \;

## define the files location
find ./ -not -path "./debian" -type f -exec sh -c 'echo $(basename {}) $0' $script_location > debian/install  \;

cd ../..

cd build_temp/$DEBFOLDERNAME

ls -l

debuild

echo "Done Creating package";
exit;






# Build the package.
# You  will get a lot of warnings and ../somescripts_0.1-1_i386.deb
debuild

