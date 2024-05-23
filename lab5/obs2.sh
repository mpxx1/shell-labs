#!/bin/bash

./mem.sh&
pid1=$!
./mem2.sh&
pid2=$!

rm -rf graphic_data1
rm -rf top5
echo "$pid1"
echo "$pid2"
echo "$0"
echo "VIRT RES SHR %CPU %MEM TIME+ USED_MEM USED_SWAP" > info1
echo "VIRT RES SHR %CPU %MEM TIME+ USED_MEM USED_SWAP" > info2

while kill -0 "$pid1" 2>/dev/null || kill -0 "$pid2" 2>/dev/null;
do
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
  
  echo "$usedMem $usedSwap" >> graphic_data1
  
  if kill -0 "$pid1" 2>/dev/null;
  then
    scriptData1=$(
            top -p $pid1 -b -n 1 | 
            tail -n 1 | 
            awk '{print $5 " " $6 " " $7 " " $9 " " $10 " " $11}'
    )
    
    echo -e "$scriptData1 $usedMem $usedSwap\n" >> info1
  fi

  if kill -0 "$pid2" 2>/dev/null;
  then
    scriptData2=$(
            top -p $pid2 -b -n 1 | 
            tail -n 1 | 
            awk '{print $5 " " $6 " " $7 " " $9 " " $10 " " $11}'
    )
    
    echo -e "$scriptData2 $usedMem $usedSwap\n" >> info2
  fi
  
  top -b -n 1 | head -n 12 | tail -n 6 >> top5
  sleep 1
done

echo "Done"

