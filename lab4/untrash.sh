#!/bin/bash


TRASH="$HOME/.trash"
LOG="$HOME/.trash.log"


if [[ $# != 1 ]];
then
    echo "Mush have 1 arg; Exit"
    exit 1
fi


if [[ ! -d "$TRASH" ]];
then
  echo "No files in trash! Exit"
  exit 1
fi


file_names=$(
  cat $LOG |
  cut -d '>' -f1
)

search=$(grep $1 <<< "$file_names")

if [[ -z $search ]];
then
  echo "No such file; Exit"
  exit 1
fi


for line in $search;
do
  read -p "Proceed with file $line? [y/n]: " ans

  case "$ans" in
  "y")
    echo "case yes"
    ;;
  *)
    echo "case skip"
    ;;
  esac
done
