#!/bin/bash


now=$(date +"%Y-%m-%d")
lastDate=$(
      ls $HOME |
      grep -E "^Backup-" | 
      sort -n | 
      tail -1 | 
      sed "s/Backup-//"
)
lastDateInSec=$(date -d "$lastDate" +"%s")
diff=$(echo "($(date +%s) - $lastDateInSec) / 60 / 60 / 24" | bc)


if [[ -z $lastDate || $diff > 7 ]]; 
then
      mkdir "$HOME/Backup-$now"
      echo "new Backup was created at $now. Files:" >> $HOME/backup-report

      for file in $(ls $HOME/source);
      do
          cp "$HOME/source/$file" "$HOME/Backup-$now"
          echo " $file" >> $HOME/backup-report
      done
else
      for file in $HOME/source/*;
      do
          file=$(echo "$file" | awk -F/ '{print $NF}')
      
          if [[ ! -f "$HOME/Backup-$lastDate/$file" ]]; 
          then
              cp "$HOME/source/$file" "$HOME/Backup-$lastDate"
              echo "New file $file was added at $now" >> $HOME/backup-report
          else
              sourceSize=$(wc -c < "$HOME/source/$file")
              backupSize=$(wc -c < "$HOME/Backup-$lastDate/$file")
                        
              if [[ "$sourceSize" -ne "$backupSize" ]];
              then
                  mv "$HOME/Backup-$lastDate/$file" "$HOME/Backup-$lastDate/$file.$now"
                  cp "$HOME/source/$file" "$HOME/Backup-$lastDate"
                  echo "New version for $file was added. Previos version was refactored to $file.$now" >> $HOME/backup-report
              fi
          fi
      done
fi

