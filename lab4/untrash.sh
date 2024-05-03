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


search=$(grep $1 "$LOG")

if [[ -z $search ]];
then
  echo "No such file; Exit"
  exit 1
fi


for line in $search;
do 
  echo $line
done
