#!/usr/bin/env bash
# check if dh-make is installed


command -v basename >/dev/null 2>&1 || { echo >&2 "basename program is required but it's not installed.  Aborting."; exit 1; }



## clean the stage for generating a deb file
if [ "$1" == "clean" ]
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

finalName="$package_name"_"$current_major_version.$current_minor_version-$current_patch"_"$architecture.deb"

ar r $finalName debian-binary control.tar.gz data.tar.gz

mv $finalName ../$package_dir


cd ..
echo "Cleaning stage"
rm -rf ./build_temp

echo "Done creating Debian package";

exit 1