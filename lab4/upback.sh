#!/bin/bash


lastDate=$(
    ls $HOME | 
    grep -E "^Backup-" | 
    sort -n | 
    tail -1 | 
    sed 's/^Backup-//'
)

if [[ -z "$lastDate" ]];
then
        echo "Not found"
        exit 1
fi

for file in $(ls "$HOME/Backup-$lastDate");
do
        if [[ ! "$file" =~ ^.*\.[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]];
        then
                rm -rf "$HOME/restore/$file"
                cat "$HOME/Backup-$lastDate/$file" > "$HOME/restore/$file"
        fi
done
