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

  full_path=$(sed 's/\(.*\)>.*$/\1/' <<< $line)
  file_link=$(awk -F'>' '{ print $NF }' <<< $line)
  read -p "Proceed with file $full_path? [y/n]: " ans

  case "$ans" in
  "y")

    if [[ -d $(dirname "$full_path") ]];
    then 

      if [[ -f "$full_path" ]];
      then
        read -p "File with this name already exists, make new name for it: " new_name
        ln "$TRASH/$file_link" "$(dirname $full_path)/$new_name"
        rm "$TRASH/$file_link" 
      else
        ln "$TRASH/$file_link" "$full_path"
        rm "$TRASH/$file_link"
      fi
      
    else # use home dir

      if [[ -f $HOME/$(basename "$full_path") ]];
      then
        read -p "File with this name already exists, make new name for it: " new_name
        ln "$TRASH/$file_link" "$HOME/$new_name"
        rm "$TRASH/$file_link" 
      else
        ln "$TRASH/$file_link" "$HOME/$(basename $full_path)"
        rm "$TRASH/$file_link"
      fi
    fi  
    ;;
  *)
      continue
    ;;
  esac
done
