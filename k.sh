#!/bin/bash
for TargettedFiles in `find * -type f  -regextype posix-extended  -regex ".*.(tiff|jpg|png)" -exec echo '{}' \; `
do
 hh=${TargettedFiles#*.}
 echo ${hh^^}
 
 #echo ${TargettedFiles##*/}
 #echo ${TargettedFiles%}
done
#find . -name '*.*' -type f -exec bash -c 'base=${0%.*} ext=${0##*.} a=$base.${ext,,}; [ "$a" != "$0" ] && mv -- "$0" "$a"' {} \;

