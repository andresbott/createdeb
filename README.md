# createDebFile
Simple fast and dirty bash script to package binary files into deb files

# How to use it
1. Copy the files in this repository to a folder on your computer
2. in the same folder create a folder called files (you can chage the used folder in script config)
3. edit the files in meta folder according to your needs, all files you add here will be included in the final deb, take spetial atention to the control file sinze it's the main build file
4. run the script from the same dir. 
5. you should now have a finished deb package

# config and parameters of the script
 - config: current_patch=1 same as parameter -p => debian files usualy follow a version schema x.x.x-patch 1 is the default, but you can chage it editting the script, or using the parameter -p <patchNumber>
 
- src_dir="files" => default is files, lets you change the relatuve source dir 

- package_dir="debian-packages" => name of the folder where the packaged files will end
 
- use_src_as_dir_tree=true|false => 
    1. If true the script will asume the files folder as the root of the installed system, for example if you want to have a image in /opt/wallpapers/wall.jpg the structure would be: ~/files/opt/wallpapers/wall.jpg
    2. If False the script will use the optional file "outFileLocations" to manualy copy single files from the ~/files/ dir to the package. one file per line, # and empty lines are ignored. Line structure: relative path from | space | absolute path to | new file name.  for example one line would look like: bash/fileConversion/audio2mp3.bash /usr/bin/audio audio2mp3


