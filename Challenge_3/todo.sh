#!/bin/bash
find ../ -type f -name Todo*.zip -exec unzip -u '{}' \; 
tempfile=temp.txt
for Files in `find Todos -type f -path "*todos*"` ; do
 name=`echo ${Files} | awk -F"/" '{ print $2 }' `
 cat ${Files} | awk -v thisName=${name} '{ print thisName"|"$0 }'
done > ${tempfile} 
awk -F"|" '{ if ( tolower($2) ~/done/ ) 
	      { done[$1]++ } 
             else { pending[$1]++ } } 
	   END{ print "Done:" ; for(j in done) print j": " done[j] ; \
		print "\nTo Still do:" ; for(j in pending) print j": "pending[j] }' ${tempfile}
