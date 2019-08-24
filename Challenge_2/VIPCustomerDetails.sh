#!/bin/bash
###########################
# explode all the ordder zip file  and get them in a folder that is related to the first challenge 
# use -u option so that if need be in another round files will be updated, if need be 
###########################
echo "Locating orders zip file and unzipping it " 
unzip -u `find ../ -type f -iname ord*.zip`

export TargetDir="AllRecords"
export VIPFolder="VIPCustomerOrders"
export tempfile="temp.txt" 
mkdir -p ${TargetDir}
echo "create ${TargetDir}" 

echo "locating all files from 201[2-7] and copy them to ${TargetDir}" 

find * -type f -path "*/201[2-7]/*" -exec cp '{}' ${TargetDir}/ \;

rm -rf ${VIPFolder}
mkdir -p ${VIPFolder} 

for Files in `find ${TargetDir} -type f ` ; do
 
 cat ${Files} | col -b | \
  awk -F"," '{ SecondLow=tolower($2) ; 
               FirstLow=tolower($1); 
               # if ( SecondLow ~/davis/ ) print SecondLow ; 
               if ( ( FirstLow ~/michael/ ) && \
                    ( ( SecondLow ~/davis|campbell/ ) ) ) print FirstLow"_"SecondLow"_orders.output|"$0 }' 
  
done > ${tempfile} 
for thisfile in `awk -F"|" '{ print $1 }' ${tempfile} | sort -u`; do
 touch ${VIPFolder}/${thisfile}
 awk -F"|" -v thisfile=${thisfile} '{ if ( $1 == thisfile ) print $2 }' ${tempfile} >> ${VIPFolder}/${thisfile}

done

find ${VIPFolder} -type f -exec wc -l '{}' \; 
