#!/bin/bash


if [[ $# != 1 ]];
then 
  echo "Must have 1 arg; Exit"
  exit 1
fi


if [[ ! -f $1 && ! -d $1 ]]; 
then
    echo "File/Directory not found; Exit"
    exit 1
fi


TRASH="$HOME/.trash"
LOG="$HOME/.trash.log"


if [[ ! -e "$TRASH" ]];
then
  mkdir $TRASH
fi


if [[ ! -e "$LOG" ]];
then 
  touch $LOG
fi

value=$(uuid)
name=$1


file_names=$(
  cat $LOG |
  cut -d '>' -f1 |
  sed 's/.*\///'
)


if grep -Fwq -- "$1" <<< "$file_names";
then 
  name=$(echo $1_$(date '+%X' | sed 's, ,,g'))
fi


if [[ -f $1 ]];
then 
  ln -- "$1" "$TRASH/"$value > /dev/null
else
  mv -- "$1" "$TRASH/"$value 
fi

echo "$PWD/${name}>$value" >> $LOG

rm -rf -- "$1" 
