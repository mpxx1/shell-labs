#!/bin/bash

./mem.sh&
pid=$!
rm -rf info
rm -rf graphic_data
echo "$pid"
echo "$0"
echo "VIRT RES SHR %CPU %MEM TIME+ USED_MEM USED_SWAP" >> info

while kill -0 "$pid" 2>/dev/null;
do
  scriptData=$(
          top -p $pid -b -n 1 | 
          tail -n 1 | 
          awk '{print $5 " " $6 " " $7 " " $9 " " $10 " " $11}'
  )
  usedMem=$(
          free | 
          tail -n 2 | 
          head -n 1 | 
          awk '{print $3}'
  )
  usedSwap=$(
          free | 
          tail -n 1 | 
          awk '{print $3}'
  )
  
  echo -e "$scriptData $usedMem $usedSwap\n" >> info
  echo "$usedMem $usedSwap" >> graphic_data
  sleep 1
done

echo "Done"

