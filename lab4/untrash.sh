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

  IFS=$' '
  full_path=$(sed 's/\(.*\)>.*$/\1/' <<< $line)
  file_link=$(awk -F'>' '{ print $NF }' <<< $line)

  if [[ -e $TRASH/$file_link ]];
  then
  
  IFS=$"\n"
  read -p "Proceed with file $full_path? [y/n]: " ans
  IFS=" "

  case "$ans" in
  "y")

    if [[ -e $(dirname "$full_path") ]];
    then 

      if [[ -e "$full_path" ]];
      then
        read -p "File with this name already exists, make new name for it: " new_name

        if [[ -f "$TRASH/$file_link" ]];
        then
          ln "$TRASH/$file_link" "$(dirname $full_path)/$new_name"
        else
          rm -rf "$(dirname $full_path)/$new_name"
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
        
        if [[ -f "$TRASH/$file_link" ]];
        then
          ln "$TRASH/$file_link" "$HOME/$new_name"
        else
          rm -rf "$HOME/$new_name" 
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

#    sed -i "s,$full_path>$file_link_extra,,g" $LOG     
    ;;
  *)
      continue
    ;;
  esac

  fi
done
