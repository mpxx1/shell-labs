#!/bin/bash


if [[ $# != 1 ]];
then 
  echo "Must have 1 arg; Exit"
  exit 1
fi


if [[ ! -f $1 ]]; 
then
    echo "File not found; Exit"
    exit 1
fi


TRASH="$HOME/.trash"
LOG="$HOME/.trash.log"


if [[ ! -e "$TRASH" ]];
then
  mkdir $TRASH
fi


value=$(
  find "$TRASH" -type f -name "[[:alnum:]]" |
  sort |
  tail -n 1 |
  awk '{ split($0, a, ".trash/"); print a[2] }'
)


if [[ -z $value ]];
then 
  rm -rf $LOG
  touch $LOG
  value=0
else
  value=$(( ++value ))
fi

name=$1


file_names=$(
  cat $LOG |
  cut -d '>' -f1 |
  sed 's/.*\///'
)


if grep -wq "$(./format.sh $1)" <<< "$file_names";
then 
  name=$(echo $1_$(date | sed 's, ,_,g'))
fi


ln $1 "$TRASH/"$value > /dev/null

echo "$PWD/${name}>$value" >> $LOG

rm $1 
