#!/bin/bash
###########################
# explode all the ordder zip file  and get them in a folder that is related to the first challenge 
# use -u option so that if need be in another round files will be updated, if need be 
###########################
echo "Locating orders zip file and unzipping it " 
unzip -u `find ../ -type f -iname ord*.zip` > /dev/null 2>&1 
# set some constants 

export TargetDir="AllRecords"
export VIPFolder="VIPCustomerOrders"
export tempfile="temp.txt" 

# create diretory for holding files
mkdir -p ${TargetDir}
echo "create ${TargetDir}" 

echo "locating all files from 2012 to 2017 and copy them to ${TargetDir}" 

find * -type f -path "*/201[2-7]/*" -exec cp '{}' ${TargetDir}/ \;

# create empty VIPFolder 
rm -rf ${VIPFolder}
mkdir -p ${VIPFolder} 

# for all files in ${TergetDoir} that we created just now

for Files in `find ${TargetDir} -type f ` ; do

 # check content of the file and strip off some unvisisble characters from the content 
 cat ${Files} | col -b | \
  # locate all files orders that are either for "Michael davis" or "Michael campbell" 
  awk -F"," '{ \
               # set the first and and second field to lower case so that matching will not be an issue
               # also use same for creating temporary file name
               SecondLow=tolower($2) ; 
               FirstLow=tolower($1); 
               # select all records that have first field as michael and second as davis or campbell
               if ( ( FirstLow ~/michael/ ) && \
                    ( ( SecondLow ~/davis|campbell/ ) ) ) print FirstLow"_"SecondLow"_orders.output|"$0 }' 
 # redirecting the output to temporary file   
done > ${tempfile} 

# process all the records in tempfile and redirect second part of each line to respective file
for thisfile in `awk -F"|" '{ print $1 }' ${tempfile} | sort -u`; do
 touch ${VIPFolder}/${thisfile}
 awk -F"|" -v thisfile=${thisfile} '{ if ( $1 == thisfile ) print $2 }' ${tempfile} >> ${VIPFolder}/${thisfile}

done

#now the file for each individual is prepared do line count

find ${VIPFolder} -type f -exec wc -l '{}' \; 
