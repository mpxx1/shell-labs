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
  echo "" > $LOG
  value=0
else
  value=$(( ++value ))
fi

name=$1

if grep -q $1 "$TRASH";
then 
  name=$(echo $name $(date))
fi


ln "$PWD/"$1 "$TRASH/"$value > /dev/null

echo "$(readlink -f $1) > $value" >> $LOG
