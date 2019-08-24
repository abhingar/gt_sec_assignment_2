#!/bin/bash

###########################
# explode all the pictures and get them in a folder that is related to the first challenge 
# use -u option so that if need be in another round files will be updated, if need be 
###########################
echo "Locating pictures zip file and unzipping it " 
unzip -u `find ../ -type f -iname pict*.zip`

# at this stage picture files are exploded and proper structure 

# create required folder structure for JPG PNG  and TIFF
echo "Creating 'empty' JPG PNG TIFF folder"
rm -rf JPG/ PNG/ TIFF/
mkdir -p JPG PNG TIFF

echo "Locating picture types and copying them to appropriate folder" 
for TargettedFiles in `find Pictures/ -type f  -regextype posix-extended  -iregex ".*.(tiff|jpg|png)" -exec echo '{}' \; `
do
 # get extension of targetted file
 Ext=${TargettedFiles#*.} 
 
 #change the extension to uppercase 
 upperCaseExt=${Ext^^}
 
# copy the file to necessary folder that is already created 

 cp ${TargettedFiles} ${upperCaseExt} 
 
done

echo "Counting original picture files" 
TotalFilesSource=`find Pictures -type f | wc -l `
echo "Counting copied picture files in PNG TIFF JPG folders" 
TotalFilesTarget=`find PNG TIFF JPG -type f | wc -l `
 
echo "Total files in source dir ${TotalFilesSource} "
echo "Total files in target dir PNG TIFF JPG ${TotalFilesTarget} "

echo "preparing summary report for different types of picture files" 
echo " and displaying the result" 
# find all files in PNG TIFF and JPG directory 

find PNG TIFF JPG -type f | \

# find their extension and update the count in associate array
# we are using "." for finding extension using "." as a delimiter and last with that delimeter is an extension of 
# the file, we are also changing the case to lower so that count is case insensitive 

awk -F"." '{ Extension[tolower($NF)]++ } \
             END{ for ( ThisExtension in Extension ) printf("count of extension %10s is %06i\n",ThisExtension,Extension[ThisExtension]) }'
