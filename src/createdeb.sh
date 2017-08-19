#!/usr/bin/env bash

#############################################################################################################################
## FUNCTIONS
#############################################################################################################################
function createMeta() {
    DIR=$1
    meta=$2

    # check if meta dir is present
    if [ ! -d "$DIR/$meta" ]; then
        echo "Creating dorectory \"$meta\""
        mkdir "$DIR/$meta"
    fi


    # chek if control file is present
    if [ ! -f "$DIR/$meta/control" ]; then
        echo "Control file not present, creating default template"
        echo "please answer this questions, you can change this later"
        echo ""

        #PKG name

        read -p "Package Name: " PKG_NAME
        echo "Package: $PKG_NAME" >> "$DIR/$meta/control"

        #Version
        echo "Version: 0.0.1" >> "$DIR/$meta/control"

        #Maintainer
        read -p "Maintainer Name: " PKG_MAINTAINER

        #Email
        read -p "Maintainer email: " PKG_MAINTAINER_MAIL

        echo "Maintainer: $PKG_MAINTAINER <$PKG_MAINTAINER_MAIL>" >> "$DIR/$meta/control"

        #HOMEPAGE
        read -p "Projects homepage: " PKG_MAINTAINER_PAGE

        echo "Homepage: $PKG_MAINTAINER_PAGE" >> "$DIR/$meta/control"


        #Priority
        while true; do
_PKG_PRIO="Select package priority:
1) required   - Packages which are necessary for the proper functioning of the system.
2) important  - Packages which one would expect to find on any Unix-like system.
3) standard  - These packages provide a reasonably small but not too limited character-mode system.
4) optional  - This is the default priority for the majority of the archive.
"
            read -p "$_PKG_PRIO" num
            case $num in
                [1]* )
                    echo "Priority: required" >> "$DIR/$meta/control"
                    break
                ;;

                [2]* )
                    echo "Priority: important" >> "$DIR/$meta/control"
                    break
                ;;
                [3]* )
                    echo "Priority: standard" >> "$DIR/$meta/control"
                    break
                ;;
                [4]* )
                    echo "Priority: optional" >> "$DIR/$meta/control"
                    break
                ;;
                * ) echo "Please select a number";;
            esac
        done

        #Depends
        echo "Depends: " >> "$DIR/$meta/control"

        #Recommends
        echo "Recommends: " >> "$DIR/$meta/control"

        #Recommends
        echo "Architecture: all" >> "$DIR/$meta/control"

        #Description
        echo "Description: On This line goes a small description" >> "$DIR/$meta/control"
        echo " On the next lines, at the end of the file" >> "$DIR/$meta/control"
        echo " You must put a more elavorate description of your package." >> "$DIR/$meta/control"
        echo " Every line in this description block always begins with a space" >> "$DIR/$meta/control"

    fi

    echo ""
    # chek if changlog file is present
    if [ ! -f "$DIR/$meta/changelog" ]; then
        echo "changelog file not present, creating default template"

        echo "## Remove this line - the changelog is a set of entries like this one ##" >> "$DIR/$meta/changelog"
        echo "" >> "$DIR/$meta/changelog"
        echo "$PKG_NAME (0.0.1) <distribution>; urgency=<urgency>" >> "$DIR/$meta/changelog"
        echo "" >> "$DIR/$meta/changelog"
        echo "  * change details" >> "$DIR/$meta/changelog"
        echo "   - more change details" >> "$DIR/$meta/changelog"
        echo "  * even more change details" >> "$DIR/$meta/changelog"
        echo "" >> "$DIR/$meta/changelog"
        echo "-- $PKG_MAINTAINER <$PKG_MAINTAINER_MAIL>[two spaces]  date" >> "$DIR/$meta/changelog"
        echo "" >> "$DIR/$meta/changelog"
        echo "" >> "$DIR/$meta/changelog"
        echo "Sample:" >> "$DIR/$meta/changelog"
        echo "" >> "$DIR/$meta/changelog"
        echo "" >> "$DIR/$meta/changelog"
        echo "hello (2.8-0ubuntu1) trusty; urgency=low" >> "$DIR/$meta/changelog"
        echo "" >> "$DIR/$meta/changelog"
        echo "  * New upstream release with lots of bug fixes and feature improvements." >> "$DIR/$meta/changelog"
        echo "" >> "$DIR/$meta/changelog"
        echo "-- Jane Doe <packager@example.com>  Thu, 21 Oct 2013 11:12:00 -0400" >> "$DIR/$meta/changelog"
        echo "" >> "$DIR/$meta/changelog"
    fi



    echo ""
    # chek if copyright file is present
    if [ ! -f "$DIR/$meta/copyright" ]; then
        echo "copyright file not present, creating default template"


        while true; do
license="Select a license:
1) LGPL-2
2) GPL-3
"
            read -p "$license" num
            case $num in
                [1]* )
                echo "creating LGPL-2 License template, please edit and update"

                echo "Format: http://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Upstream-Name: $PKG_NAME
Source: $PKG_MAINTAINER_PAGE

Files: *
Copyright: <year or years> $PKG_MAINTAINER <$PKG_MAINTAINER_MAIL>
           (optional line) <year or years> <name> <email>
License: LGPL-2.0+

Files: debian/*
Copyright: <year or years> $PKG_MAINTAINER <$PKG_MAINTAINER_MAIL>
           (optional line) <year or years> <name> <email>
License: LGPL-2.0+


License: LGPL-2.0+
 This package is free software; you can redistribute it and/or
 modify it under the terms of the GNU Lesser General Public
 License as published by the Free Software Foundation; either
 version 2 of the License, or (at your option) any later version.
 .
 This package is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 Lesser General Public License for more details.
 .
 You should have received a copy of the GNU Lesser General Public License
 along with this program. If not, see <https://www.gnu.org/licenses/>.
 .
 On Debian systems, the complete text of the GNU Lesser General
 Public License can be found in \"/usr/share/common-licenses/LGPL-2\".

# Please also look if there are files or directories which have a
# different copyright/license attached and list them here.
# Please avoid picking licenses with terms that are more restrictive than the
# packaged work, as it may make Debian's contributions unacceptable upstream." >>  "$DIR/$meta/copyright"

                break
                ;;



                [2]* )
                echo "creating GPL-3 License template, please edit and update"

                echo "Format: http://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Upstream-Name: $PKG_NAME
Source: $PKG_MAINTAINER_PAGE

Files: *
Copyright: <year or years> $PKG_MAINTAINER <$PKG_MAINTAINER_MAIL>
           (optional line) <year or years> <name> <email>
License: GPL-3.0+

Files: debian/*
Copyright: <year or years> $PKG_MAINTAINER <$PKG_MAINTAINER_MAIL>
           (optional line) <year or years> <name> <email>
License: GPL-3.0+


License: GPL-3.0+
 This package is free software; you can redistribute it and/or
 modify it under the terms of the GNU General Public License
 License as published by the Free Software Foundation; either
 version 2 of the License, or (at your option) any later version.
 .
 This package is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 General Public License for more details.
 .
 You should have received a copy of the GNU General Public License
 along with this program. If not, see <https://www.gnu.org/licenses/>.
 .
 On Debian systems, the complete text of the GNU General
 Public License can be found in \"/usr/share/common-licenses/GPL-3\".

# Please also look if there are files or directories which have a
# different copyright/license attached and list them here.
# Please avoid picking licenses with terms that are more restrictive than the
# packaged work, as it may make Debian's contributions unacceptable upstream." >>  "$DIR/$meta/copyright"

                break

                ;;
                * ) echo "Please select a number";;
            esac
        done


    fi




    echo ""
    # check if crateDebFile config file exists
    if [ ! -f "$DIR/createdeb.conf" ]; then
        echo "createdeb.conf file not present, creating default template"

        _PKG_SRC="Source Folder:
type the name of the folder containing the compiled binaries to be packaged
as a relative path, i.e. \"src\"
"
        read -p "$_PKG_SRC" PKG_SRC


        echo ""
        while true; do
_PKG_SRC_TREE="Use origin as finished system tree(y/n)?
 if select YES, the script assumes that the origin is the root directory tree to the debian system
    for example a executable tree would look like: ./src/usr/bin/executable

 if you select NO the relation between files and final location has to be defined in file:createdebFileLocations.conf
"
            read -p "$_PKG_SRC_TREE" num
            case $num in
                [yY]* )
                    PKG_SRC_TREE="true"
                    PKG_SRC_TREE="true"
                break
                ;;

                [nN]* )
                    PKG_SRC_TREE="false"
                break

                ;;
                * ) echo "Please select \"y\" or \"n\" ";;
            esac
        done

echo "# define the default patch version, this version will be increased every time you build a package
# to increase the version, you need to do it in $meta dir
current_patch=0

# if you want to place your compiled binaries, or scripts in another folder change this
src_dir=\"$PKG_SRC\"

# use src as finished system tree
#
# if set to true assumes that src is the output directory tree to the debian system
# for example a executable tree would look like: ./src/usr/bin/executable
# if set to false the relation between files and final location has to be defined in file: createdebFileLocations.conf
use_src_as_dir_tree=$PKG_SRC_TREE


# name of the output folder
package_dir=\"debian-packages\"

# if you want to upload automaticaly after each create
UPLOAD=False
#upload data
DESTREPO=\"/public_html/pool\"
USER=debian_repository
HOST=amelia.rivervps.com" >> "$DIR/createdeb.conf"

    fi



    echo ""
    # check if crateDebFile config file exists
    if [ ! -f "$DIR/createdebFileLocations.conf" ]; then
        echo "createdebFileLocations.conf file not present, creating default template"


echo "# each line defines the install dir of the files in src all relative to origin
# for example:
# somefile.bash /usr/bin
# the previous line will copy ./origin/somefile.bash into /usr/bin
# subdir/file.bash /usr/sbin
# the previous line will copy ./origin/subdir/file.bash into /usr/sbin
# bash/amazonCopy.bash /usr/local/bin amazonCopy
# the previous line will copy ./origin/bash/amazonCopy.bash into /usr/bin and name it \"amazonCopy\"
#
# \" # \" and empty lines are ignored
" >> "$DIR/createdebFileLocations.conf"

    fi




    # final notice
    echo ""
    echo ""
    echo "IMPORTANT :
you just created a template to package your files in debian packages.
Now you need to review and adapt the content of the files in \"$meta\" folder.
if you need to add files to the debian package meta (like the postinst script)
put it inside of \"$meta\" "

}
# end of createMeta()


function readDataFromControlFile(){
    DIR=$1
    meta=$2

    echo ""
    echo "Reading data from $meta/control file:"

    package_name=$(awk -F ":" '/^Package: / {print $2}' ./$meta/control)
    package_name=${package_name//[[:blank:]]/}
    if [ "$package_name" == "" ]
    then
      echo "Error: Package not defined in control file, exiting"
      exit 0;
    fi
    echo "  Package name: $package_name"


    current_version=$(awk -F ":" '/^Version: / {print $2}' ./$meta/control)
    current_version=${current_version//[[:blank:]]/}
    if [ "$current_version" == "" ]
    then
      echo "Error: Version not defined in control file, exiting"
      exit 0;
    fi

    echo "  Version: $current_version"

    architecture=$(awk -F ":" '/^Architecture: / {print $2}' ./$meta/control)
    architecture=${architecture//[[:blank:]]/}
    if [ "$architecture" == "" ]
    then
      echo "Error: Architecture not defined in control file, exiting"
      exit 0;
    fi
    echo "  Architecture: $architecture"
}

function createPackage() {
    DIR=$1
    meta=$2
    UPLOAD_AFTER_CREATE=$3
    CONFFILE="$DIR/createdeb.conf"

    source $CONFFILE

#    CONTROLFILE="$BASE/$meta/control"
#    version=` awk -F ':' '{if (! ($0 ~ /^;/) && $0 ~ /Version/) print $2}' $CONTROLFILE`
#    version=${version//[[:blank:]]/}
#    version1="${version%.*}.$((${version##*.}+1))"
#    sed -i "/Version:/c\Version: $version1" $CONTROLFILE
#
#    echo "increasing minor Release to: $version1"


    patch1=$((current_patch + 1))
    sed -i "/current_patch=/c\current_patch=$patch1" $CONFFILE

    echo "increasing patch version to: $patch1"

    readDataFromControlFile $DIR $meta

    echo ""
    echo "Starting build of Version $current_version"


    # deleting old Build if it exists
    rm -rf ./build_temp


    # creating the folder again
    mkdir ./build_temp


    # create the data folder to put binaries in
    mkdir ./build_temp/data



    if [ "$use_src_as_dir_tree" == "true" ];
        then
            echo " Copying source files";
            # use src dir as absolute path locations
            cp -R ./$src_dir/* ./build_temp/data
        else
            # only use files defined in outFileLocatons
            echo "  Reading lines from \"createdebFileLocations.conf\"";

            while IFS='' read -r line || [[ -n "$line" ]]; do
                if [[ ${line:0:1} != "#" ]] && [[  ! -z "${line// }"  ]] ;   then

                        line_part=($line)

                        inFile="./$src_dir/${line_part[0]}";
                        outDir="./build_temp/data${line_part[1]}";


                        if [[ ${line_part[2]} == "" ]]; then
                                fileName=$(basename $inFile);
                            else
                                fileName=${line_part[2]};
                        fi

                        outFile="$outDir/$fileName";

                        echo "  copying \"$inFile\" to \"$outFile";
                        test -d "$outDir" || mkdir -p "$outDir" && cp "$inFile" "$outFile"
                fi

            done < "./createdebFileLocations.conf"
    fi

    # create data.tar.gz
    cd ./build_temp/data
    tar czf ../data.tar.gz [a-z]*
    cd ../../
    rm -R ./build_temp/data


    # create the control file
    echo ""
    echo "Creating Control File";
    cd "$DIR/$meta"
    tar czf ../build_temp/control.tar.gz *
    cd ..

    cd build_temp

    echo 2.0 > ./debian-binary

    finalName=$package_name'_'$current_version'-'$current_patch'_'$architecture.deb;
    echo ""
    echo "Creating Package file";

    ar r $finalName debian-binary control.tar.gz data.tar.gz
    test -d "../$package_dir" || mkdir -p "../$package_dir"
    mv $finalName ../$package_dir
    cd ..
    echo "  cleaning stage"
    rm -rf ./build_temp

    echo ""
    echo "Done creating Debian package: $finalName";

    if [ $UPLOAD_AFTER_CREATE == True ]; then
        echo ""
        echo "Uploading package"

        uploadPackage $DIR $meta
    fi


    exit


}
# end of cratePackage()


function uploadPackage() {
    DIR=$1
    meta=$2
    CONFFILE="$DIR/createdeb.conf"

    source $CONFFILE

    if [ $UPLOAD == True ]; then

    ORIGIN=`readlink -f "$0"`
    BASE=`dirname $ORIGIN`

    readDataFromControlFile $DIR $meta

    patch1=$((current_patch - 1))
    NAME="$package_name""_""$current_version""-""$patch1""_""$architecture.deb"

    FULLFILE="$DIR/debian-packages/$NAME"


#FULLREMOTE="$DESTREPO/$NAME"

#echo "scp $FULLFILE $USER@$HOST:$FULLREMOTE"
#
#scp $FULLFILE $USER@$HOST:$FULLREMOTE
#
#
### bettir with ssh key

    echo "  Uploading File: $NAME using SFTP to $DESTREPO"
    echo ""

sftp $USER@$HOST  << SOMEDELIMITER
  put $FULLFILE $DESTREPO
  quit
SOMEDELIMITER

    echo "Done"
    exit
else
    echo " Upload is disabled, probably not properly configured"
    echo " change this in createdeb.conf and execute again"
    exit 0
fi


}
# end of uploadPackage()


#############################################################################################################################
## END of FUNCTIONS
#############################################################################################################################


echo "  = Debian Packager = "

DIR=$(pwd)
meta=debian
cd $DIR

if [ "$2" == "upload" ]; then
    UPLOAD_AFTER_CREATE=True
else
    UPLOAD_AFTER_CREATE=False
fi

# check if meta dir is present
if [ ! -d "$DIR/$meta" ]; then

    if [ "$1" == "init" ]; then
        createMeta $DIR $meta
    else
        echo "It looks like this project is not configuret yet."
        echo "run \"`basename $0` init\" to initialize a project"
        exit
    fi
else
    if [ "$1" == "init" ]; then
        echo "This project is already configured."
        echo "ignoring init"
        exit
    fi
fi

if [ "$1" == "create" ]; then
    echo "Creating new build of package"
    createPackage $DIR $meta $UPLOAD_AFTER_CREATE
fi


if [ "$1" == "upload" ]; then
    echo "Uploading the last package to server"
    uploadPackage $DIR $meta
fi


echo ""
echo "* init            Initialize a new project to be packaged"
echo "* create          Create a new package"
echo "* create upload   Create and upload a new package"
echo "* upload          Upload the last created package to repository"



exit 1







