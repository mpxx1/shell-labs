#!/bin/bash


TRASH="$HOME/.trash"
LOG="$HOME/.trash.log"


if [[ $# != 1 ]];
then
    echo "Mush have 1 arg; Exit"
    exit 1
fi


if [[ ! -d "$TRASH" || -z $(ls $TRASH) ]];
then
  echo "No files in trash! Exit"
  exit 1
fi

search=$(grep -F -- "$1" "$LOG")

if [[ -z $search ]];
then
  echo "No such file; Exit"
  exit 1
fi


IFS=$'\n'
for line in $search;
do

  IFS=' '
  full_path=$(sed 's/\(.*\)>.*$/\1/' <<< $line)
  file_link=$(awk -F'>' '{ print $NF }' <<< $line)

  IFS=$'\n'
  name2=$(basename $full_path | tr -d $'\n' | sed -E 's,_(.*)+[AP]M,,g')
  s2=$(grep -F -- "$1" <<< $name2)

  if [[ -z $s2 || $s2 == $"\n" ]];
  then
    continue 
  fi 
 
  if [[ ! -e $TRASH/$file_link ]];
  then
    continue
  fi
 
  IFS=$"\n"

  ident='file'

  if [[ -d "$TRASH/$file_link" ]];
  then
    ident='dir'
  fi
  
  read -p "Proceed with $ident $full_path? [y/n]: " ans
  IFS=" "

  case "$ans" in
  "y")

    if [[ -e $(dirname "$full_path") ]];
    then 

      if [[ -e "$full_path" ]];
      then
        read -p "File with this name already exists, make new name for it: " new_name

        if [[ -e "$(dirname $full_path)/$new_name" ]];
        then
          echo "you didn't change file name, i'll remove old one"
          rm -rf "$(dirname $full_path)/$new_name"
        fi

        if [[ -f "$TRASH/$file_link" ]];
        then
          ln "$TRASH/$file_link" "$(dirname $full_path)/$new_name"
        else
          mv "$TRASH/$file_link" "$(dirname $full_path)/$new_name" 
        fi  
      else

        if [[ -f "$TRASH/$file_link" ]];
        then
          ln "$TRASH/$file_link" "$full_path"
        else
          mv "$TRASH/$file_link" "$full_path"
        fi
      fi

      rm -rf "$TRASH/$file_link"
      
    else # use home dir

      if [[ -e $HOME/$(basename "$full_path") ]];
      then
        read -p "File with this name already exists, make new name for it: " new_name

        if [[ -e "$HOME/$new_name" ]];
        then 
          echo "you didn't change file name, i'll remove old one"
          rm -rf $HOME/$new_name
        fi
        
        if [[ -f "$TRASH/$file_link" ]];
        then
          ln "$TRASH/$file_link" "$HOME/$new_name"
        else 
          mv "$TRASH/$file_link" "$HOME/$new_name"
        fi
      
      else

        if [[ -f "$TRASH/$file_link" ]];
        then
          ln "$TRASH/$file_link" "$HOME/$(basename $full_path)"
        else
          mv "$TRASH/$file_link" "$HOME/$(basename $full_path)"
        fi
      fi

      rm -rf "$TRASH/$file_link"
    fi     
    ;;
  *)
      continue
    ;;
  esac

done
