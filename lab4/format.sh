#!/bin/bash


if [[ $# != 1 ]];
then 
  echo "Need 1 arg; Exit"
  exit 1
fi



echo $1 |
sed 's,\\,\\\\,g' |
sed 's,\$,\\$,g' |
sed 's,\*,\\*,g' |
sed 's,\",\\",g' |
sed 's,\[,\\[,g' |
sed 's,\],\\],g' |
sed 's,\:,\\:,g' |
sed 's,\;,\\;,g' |
sed 's,\?,\\?,g' |
sed 's,\^,\\^,g' |
sed 's,\.,\\.,g' |
sed 's/\,/\\,/g' |
sed 's,\>,\\>,g' |
sed 's,\<,\\<,g' |
sed 's,\#,\\#,g'
